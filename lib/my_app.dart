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

import 'l10n/l10n_extension.dart';
import 'main.dart';
import 'settings.dart';

/// The root widget of the CAT Scan demonstration application.
///
/// Listens to [AppSettings] to reactively update application theme (Light, Dark, System)
/// and [LocaleController] to update language.
class CatApp extends StatefulWidget {
  final AppSettings? settings;

  const CatApp({super.key, this.settings});

  @override
  State<CatApp> createState() => _CatAppState();
}

class _CatAppState extends State<CatApp> {
  late final AppSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.settings ?? AppSettings();
    LocaleController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _settings,
      builder: (context, _) {
        return ValueListenableBuilder<Locale?>(
          valueListenable: LocaleController.currentLocale,
          builder: (context, locale, _) {
            return MaterialApp(
              locale: locale,
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                if (deviceLocale != null) {
                  for (final supported in supportedLocales) {
                    if (supported.languageCode == deviceLocale.languageCode) {
                      return supported;
                    }
                  }
                }
                return const Locale('en');
              },
              onGenerateTitle: (context) => context.l10n.appTitle,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              themeMode: _settings.themeMode,
              theme: ThemeData(
                brightness: Brightness.light,
                colorSchemeSeed: Colors.blue,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                colorSchemeSeed: Colors.blue,
                scaffoldBackgroundColor: const Color(0xFF121212),
                useMaterial3: true,
              ),
              home: CatScanHomePage(settings: _settings),
            );
          },
        );
      },
    );
  }
}
