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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n_extension.dart';

/// Modal dialog displaying a localized markdown/HTML document.
void showDocumentDialog(
  BuildContext context, {
  required String assetName,
  required String title,
  IconData icon = Icons.description_outlined,
}) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      final theme = Theme.of(dialogContext);
      final size = MediaQuery.sizeOf(dialogContext);
      final dialogWidth = (size.width * 0.85).clamp(320.0, 600.0);
      final dialogHeight = (size.height * 0.75).clamp(300.0, 600.0);

      return AlertDialog(
        title: Row(
          children: [
            Icon(icon, size: 22, color: theme.colorScheme.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: dialogWidth,
          height: dialogHeight,
          child: FutureBuilder<String>(
            future: loadLocalizedHtmlAsset(context, assetName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final raw = snapshot.data ?? '';
              if (raw.isEmpty) {
                return Center(
                  child: Text('Unable to load $title document.'),
                );
              }
              final formattedText = formatDocumentHtml(raw);
              return SingleChildScrollView(
                child: SelectableText(
                  formattedText,
                  style: const TextStyle(fontSize: 13, height: 1.45),
                ),
              );
            },
          ),
        ),
        actions: [
          if (kIsWeb)
            TextButton.icon(
              icon: const Icon(Icons.open_in_new, size: 14),
              label: const Text('Open in browser'),
              onPressed: () {
                final locale = Localizations.localeOf(context).languageCode;
                final file = locale != 'en'
                    ? '${assetName}_$locale.html'
                    : '$assetName.html';
                final uri = Uri.base.resolve(file);
                launchUrl(uri, mode: LaunchMode.platformDefault);
              },
            ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.close),
          ),
        ],
      );
    },
  );
}

/// Displays the Privacy Policy document modal dialog.
void showPrivacyPolicyDialog(BuildContext context) {
  showDocumentDialog(
    context,
    assetName: 'privacy',
    title: context.l10n.privacyPolicyButton,
    icon: Icons.privacy_tip_outlined,
  );
}

/// Displays the Terms of Service document modal dialog.
void showTermsOfServiceDialog(BuildContext context) {
  showDocumentDialog(
    context,
    assetName: 'terms',
    title: context.l10n.termsOfServiceButton,
    icon: Icons.gavel_outlined,
  );
}

/// Shows the rich About Dialog for the CAT Scan demonstration application.
void showAppAboutDialog(BuildContext context, {String? version}) async {
  String resolvedVersion = version ?? '';
  if (resolvedVersion.isEmpty) {
    try {
      final info = await PackageInfo.fromPlatform();
      resolvedVersion = info.buildNumber.isNotEmpty
          ? '${info.version}+${info.buildNumber}'
          : info.version;
    } catch (_) {}
  }

  if (!context.mounted) return;

  showDialog(
    context: context,
    builder: (context) => AppAboutDialog(version: resolvedVersion),
  );
}

class AppAboutDialog extends StatelessWidget {
  final String version;

  const AppAboutDialog({super.key, this.version = ''});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _openPrivacy(BuildContext context) {
    showPrivacyPolicyDialog(context);
  }

  void _openTerms(BuildContext context) {
    showTermsOfServiceDialog(context);
  }

  void _openMoreInfo(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final file = locale != 'en' ? 'info_$locale.html' : 'info.html';
    final uri = kIsWeb
        ? Uri.base.resolve(file)
        : Uri.parse('https://www.gchouse.org/cat/$file');
    launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Row(
        children: [
          Image.asset(
            'assets/icons/icon.png',
            width: 32,
            height: 32,
            errorBuilder: (_, _, _) =>
                const Icon(Icons.blur_circular, size: 32),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.appTitle, style: const TextStyle(fontSize: 18)),
              Text(
                context.l10n.versionLabel(version),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.aboutSummary,
                style: const TextStyle(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  context.l10n.aboutAuthor,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                context.l10n.keyboardShortcutsTitle,
                style: theme.textTheme.titleSmall?.copyWith(fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.keyboardShortcutsList,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.code, size: 14),
                    label: Text(context.l10n.githubButton),
                    onPressed: () =>
                        _launchUrl('https://github.com/fredgc/cat'),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.bug_report_outlined, size: 14),
                    label: Text(context.l10n.issuesButton),
                    onPressed: () =>
                        _launchUrl('https://github.com/fredgc/cat/issues'),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.privacy_tip_outlined, size: 14),
                    label: Text(context.l10n.privacyPolicyButton),
                    onPressed: () => _openPrivacy(context),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.gavel_outlined, size: 14),
                    label: Text(context.l10n.termsOfServiceButton),
                    onPressed: () => _openTerms(context),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.info_outline, size: 14),
                    label: Text(context.l10n.moreInfoButton),
                    onPressed: () => _openMoreInfo(context),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.public, size: 14),
                    label: Text(context.l10n.websiteButton),
                    onPressed: () => _launchUrl('https://www.gchouse.org'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.close),
        ),
      ],
    );
  }
}
