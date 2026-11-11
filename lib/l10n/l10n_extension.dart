// Copyright 2026 Fred Gylys-Colwell.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localizations.dart';

export 'app_localizations.dart';

/// Manages application-wide locale preference and persistence.
class LocaleController {
  static const String _keyLocale = 'app_locale';
  static const Locale autoLocale = Locale('auto');
  static final ValueNotifier<Locale?> currentLocale = ValueNotifier<Locale?>(
    null,
  );

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('es'),
    Locale('de'),
    Locale('fr'),
    Locale('ja'),
    Locale('lt'),
    Locale('pt'),
    Locale('zh'),
  ];

  static String languageDisplayName(Locale? locale) {
    if (locale == null) return 'System Default';
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'de':
        return 'Deutsch';
      case 'fr':
        return 'Français';
      case 'ja':
        return '日本語';
      case 'lt':
        return 'Lietuvių';
      case 'pt':
        return 'Português';
      case 'zh':
        return '中文 (简体)';
      default:
        return locale.toLanguageTag();
    }
  }

  /// Loads stored locale preference from [SharedPreferences].
  static Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_keyLocale);
      if (code != null && code.isNotEmpty) {
        currentLocale.value = Locale(code);
      }
    } catch (_) {
      // Gracefully continue with system default
    }
  }

  /// Sets the application locale and persists it. Pass `null` or Locale('auto') for system default.
  static Future<void> setLocale(Locale? locale) async {
    final effective =
        (locale == null ||
            locale.languageCode == 'auto' ||
            locale.languageCode.isEmpty)
        ? null
        : locale;
    currentLocale.value = effective;
    try {
      final prefs = await SharedPreferences.getInstance();
      if (effective == null) {
        await prefs.remove(_keyLocale);
      } else {
        await prefs.setString(_keyLocale, effective.languageCode);
      }
    } catch (_) {
      // Gracefully ignore persistence errors
    }
  }
}

/// Helper to load a localized HTML asset from `assets/` with language fallback.
///
/// Searches for `assets/{baseName}_{locale}.html` (e.g. `assets/about_es.html`),
/// and falls back to `assets/{baseName}.html` if the localized file is not available.
Future<String> loadLocalizedHtmlAsset(
  BuildContext context,
  String baseName,
) async {
  final cleanName = baseName.endsWith('.html')
      ? baseName.substring(0, baseName.length - 5)
      : baseName;
  final locale = Localizations.localeOf(context).languageCode;
  if (locale != 'en') {
    try {
      return await rootBundle.loadString('assets/${cleanName}_$locale.html');
    } catch (_) {
      // Fall back to default document
    }
  }
  try {
    return await rootBundle.loadString('assets/$cleanName.html');
  } catch (_) {
    return '';
  }
}

/// Converts raw compiled document HTML into cleanly formatted, human-readable
/// plain text suitable for SelectableText. Strips head/title/style blocks,
/// converts headings, paragraphs, and list items into structured text with
/// line breaks, unwraps intra-paragraph lines, and decodes HTML entities.
String formatDocumentHtml(String html) {
  var text = html;
  text = text.replaceAll(
    RegExp(r'<head[\s\S]*?</head>', caseSensitive: false),
    '',
  );
  text = text.replaceAll(
    RegExp(r'<style[\s\S]*?</style>', caseSensitive: false),
    '',
  );
  text = text.replaceAll(
    RegExp(r'<script[\s\S]*?</script>', caseSensitive: false),
    '',
  );

  text = text.replaceAll(
    RegExp(r'<li[^>]*>\s*(?:<p[^>]*>)?', caseSensitive: false),
    '\n\n• ',
  );
  text = text.replaceAll(RegExp(r'</p>\s*</li>', caseSensitive: false), '\n');
  text = text.replaceAll(RegExp(r'</li>', caseSensitive: false), '\n');

  text = text.replaceAll(
    RegExp(
      r'<(h[1-6]|p|div|section|article|header|footer)[^>]*>',
      caseSensitive: false,
    ),
    '\n\n',
  );
  text = text.replaceAll(
    RegExp(
      r'</(h[1-6]|p|div|section|article|header|footer)>',
      caseSensitive: false,
    ),
    '\n\n',
  );
  text = text.replaceAll(
    RegExp(r'<(hr|br)[^>]*>', caseSensitive: false),
    '\n\n',
  );

  text = text.replaceAll(RegExp(r'<[^>]*>'), '');

  text = text
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&quot;', '"')
      .replaceAll('&apos;', "'")
      .replaceAll('&#39;', "'")
      .replaceAll('&ldquo;', '"')
      .replaceAll('&rdquo;', '"')
      .replaceAll('&lsquo;', "'")
      .replaceAll('&rsquo;', "'")
      .replaceAll('&mdash;', '—')
      .replaceAll('&ndash;', '–')
      .replaceAll('&nbsp;', ' ');

  final paragraphs = text.split(RegExp(r'\n\s*\n'));
  final cleaned = <String>[];
  for (final p in paragraphs) {
    final lines = p
        .split('\n')
        .map((l) => l.replaceAll(RegExp(r'[ \t]+'), ' ').trim())
        .where((l) => l.isNotEmpty);
    if (lines.isNotEmpty) {
      cleaned.add(lines.join(' '));
    }
  }
  return cleaned.join('\n\n').trim();
}

/// Convenience extension for easy access to [AppLocalizations].
extension L10nX on BuildContext {
  AppLocalizations get l10n =>
      AppLocalizations.of(this) ?? lookupAppLocalizations(const Locale('en'));
}
