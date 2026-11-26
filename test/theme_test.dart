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

import 'package:cat/my_app.dart';
import 'package:cat/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  for (final mode in [ThemeMode.dark, ThemeMode.light]) {
    final brightness =
        mode == ThemeMode.dark ? Brightness.dark : Brightness.light;

    testWidgets('CatApp reflects $mode theme and button contrast',
        (WidgetTester tester) async {
      final settings = AppSettings();
      await settings.loadPreferences();
      await settings.setThemeMode(mode);

      await tester.pumpWidget(CatApp(settings: settings));
      await tester.pumpAndSettle();

      final scaffoldFinder = find.byType(Scaffold);
      expect(scaffoldFinder, findsOneWidget);

      final expectedScheme = ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: brightness,
      );
      final theme = Theme.of(tester.element(scaffoldFinder));
      expect(theme.brightness, brightness);
      expect(theme.colorScheme.surface, expectedScheme.surface);
      expect(theme.scaffoldBackgroundColor, expectedScheme.surface);

      final buttonStyle = theme.elevatedButtonTheme.style!;
      expect(
        buttonStyle.backgroundColor?.resolve({}),
        theme.colorScheme.primaryContainer,
      );
      expect(
        buttonStyle.foregroundColor?.resolve({}),
        theme.colorScheme.onPrimaryContainer,
      );
    });
  }
}
