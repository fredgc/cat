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
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cat/l10n/l10n_extension.dart';
import 'package:cat/my_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    LocaleController.currentLocale.value = null;
  });

  group('Internationalization & Accessibility Tests', () {
    testWidgets('App renders in English by default', (tester) async {
      await tester.pumpWidget(const CatApp());
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Stage 1: Computed Axial Tomography'),
        findsOneWidget,
      );
      expect(find.text('Next'), findsOneWidget);
      expect(find.text('Previous'), findsOneWidget);
      expect(find.byIcon(Icons.language_rounded), findsOneWidget);
    });

    testWidgets('App renders in Spanish when Locale is es', (tester) async {
      LocaleController.currentLocale.value = const Locale('es');
      await tester.pumpWidget(const CatApp());
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Etapa 1: Tomografía axial computarizada'),
        findsOneWidget,
      );
      expect(find.text('Siguiente'), findsOneWidget);
      expect(find.text('Anterior'), findsOneWidget);
      expect(find.text('Etapa 1 de 7'), findsOneWidget);
    });

    testWidgets('Language switcher switches between English and Spanish', (
      tester,
    ) async {
      await tester.pumpWidget(const CatApp());
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Stage 1: Computed Axial Tomography'),
        findsOneWidget,
      );

      // Open language popup menu
      await tester.tap(find.byIcon(Icons.language_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Auto (System)'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
      expect(find.text('Español'), findsOneWidget);

      // Select Español
      await tester.tap(find.text('Español'));
      await tester.pumpAndSettle();

      expect(LocaleController.currentLocale.value, const Locale('es'));
      expect(
        find.textContaining('Etapa 1: Tomografía axial computarizada'),
        findsOneWidget,
      );

      // Verify persisted in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('app_locale'), 'es');

      // Switch back to English (in Spanish menu, it is labeled 'Inglés')
      await tester.tap(find.byIcon(Icons.language_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Automático (del sistema)'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
      expect(find.text('Español'), findsOneWidget);

      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();

      expect(LocaleController.currentLocale.value, const Locale('en'));
      expect(
        find.textContaining('Stage 1: Computed Axial Tomography'),
        findsOneWidget,
      );
      expect(prefs.getString('app_locale'), 'en');

      // Switch to Auto
      await tester.tap(find.byIcon(Icons.language_rounded));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Auto (System)'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(LocaleController.currentLocale.value, isNull);
      expect(prefs.getString('app_locale'), isNull);
    });

    testWidgets('App renders across all supported locales', (tester) async {
      for (final locale in LocaleController.supportedLocales) {
        LocaleController.currentLocale.value = locale;
        await tester.pumpWidget(const CatApp());
        await tester.pumpAndSettle();
        expect(find.byType(CatApp), findsOneWidget);
      }
    });

    testWidgets('Stage 7 renders localized text in all non-English locales', (
      tester,
    ) async {
      for (final locale in LocaleController.supportedLocales.where(
        (l) => l.languageCode != 'en',
      )) {
        final l10n = lookupAppLocalizations(locale);
        LocaleController.currentLocale.value = locale;
        await tester.pumpWidget(const CatApp());
        await tester.pumpAndSettle();

        await tester.sendKeyEvent(LogicalKeyboardKey.digit7);
        await tester.pumpAndSettle();

        expect(
          find.textContaining('Free Play & Custom Phantoms'),
          findsNothing,
          reason: 'Stage 7 title should be translated for ${locale.languageCode}',
        );
        expect(
          find.textContaining(l10n.stage7Title),
          findsOneWidget,
          reason: 'Expected localized Stage 7 title for ${locale.languageCode}',
        );
        expect(
          find.text(l10n.stageIndicator(7)),
          findsOneWidget,
          reason: 'Expected localized Stage 7 of 7 indicator for ${locale.languageCode}',
        );
        expect(
          find.text(l10n.modeProbe),
          findsOneWidget,
          reason: 'Expected localized Probe label for ${locale.languageCode}',
        );
        expect(
          find.text(l10n.modePhantom),
          findsOneWidget,
          reason: 'Expected localized Phantom label for ${locale.languageCode}',
        );
      }
    });

    test('LocaleController initializes persisted locale', () async {
      SharedPreferences.setMockInitialValues({'app_locale': 'es'});
      await LocaleController.initialize();
      expect(LocaleController.currentLocale.value, const Locale('es'));

      await LocaleController.setLocale(const Locale('en'));
      expect(LocaleController.currentLocale.value, const Locale('en'));

      await LocaleController.setLocale(null);
      expect(LocaleController.currentLocale.value, isNull);
    });

    testWidgets(
      'Localized More Info reference doc loads and formats cleanly in all locales',
      (tester) async {
        final expectedHeadings = <String, String>{
          'en': 'Mathematical Reference',
          'es': 'Referencia matemática',
          'de': 'Mathematische Referenz',
          'fr': 'Référence mathématique',
          'ja': '数学リファレンス',
          'lt': 'Matematinis žinynas',
          'pt': 'Referência matemática',
          'zh': '数学参考',
        };

        for (final locale in LocaleController.supportedLocales) {
          late String loadedHtml;
          await tester.pumpWidget(
            MaterialApp(
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: Builder(
                builder: (context) {
                  return FutureBuilder<String>(
                    future: loadLocalizedHtmlAsset(context, 'info'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        loadedHtml = snapshot.data!;
                        return Text(formatDocumentHtml(loadedHtml));
                      }
                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
          );
          await tester.pumpAndSettle();

          final formatted = formatDocumentHtml(loadedHtml);
          expect(
            formatted,
            contains(expectedHeadings[locale.languageCode]!),
            reason: 'Expected localized heading for ${locale.languageCode}',
          );
          if (locale.languageCode != 'en') {
            expect(
              formatted,
              isNot(contains('Mathematical Reference')),
              reason: '${locale.languageCode} should not fall back to English',
            );
          }
          expect(
            formatted,
            isNot(contains(r'\int_L')),
            reason:
                'Raw TeX annotation should be stripped for ${locale.languageCode}',
          );
        }
      },
    );
  });
}
