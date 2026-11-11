// Unit and widget tests for AppSettings, SettingsDialog, and AppAboutDialog.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cat/color.dart';
import 'package:cat/settings.dart';
import 'package:cat/widgets/about_dialog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppSettings unit tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Initial default settings values', () {
      final settings = AppSettings();
      expect(settings.themeMode, ThemeMode.dark);
      expect(settings.colormap, AppColormap.classic);
      expect(settings.resolution, 50);
      expect(settings.p, 50);
      expect(settings.q, 50);
      expect(settings.showGuides, isTrue);
    });

    test('Theme mode persistence and notification', () async {
      final settings = AppSettings();
      await settings.loadPreferences();

      int notifyCount = 0;
      settings.addListener(() => notifyCount++);

      await settings.setThemeMode(ThemeMode.light);
      expect(settings.themeMode, ThemeMode.light);
      expect(notifyCount, 1);

      // Verify persisted in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('cat_theme_mode'), 'light');
    });

    test('Colormap persistence and notification', () async {
      final settings = AppSettings();
      await settings.loadPreferences();

      int notifyCount = 0;
      settings.addListener(() => notifyCount++);

      await settings.setColormap(AppColormap.viridis);
      expect(settings.colormap, AppColormap.viridis);
      expect(notifyCount, 1);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('cat_colormap'), 'viridis');
    });

    test('Resolution clamping and persistence', () async {
      final settings = AppSettings();
      await settings.loadPreferences();

      int notifyCount = 0;
      settings.addListener(() => notifyCount++);

      await settings.setResolution(75);
      expect(settings.resolution, 75);
      expect(settings.p, 75);
      expect(settings.q, 75);
      expect(notifyCount, 1);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('cat_grid_resolution'), 75);

      // Clamping
      await settings.setResolution(150);
      expect(settings.resolution, 100);

      await settings.setResolution(10);
      expect(settings.resolution, 25);
    });

    test('Guides toggle and reset defaults', () async {
      final settings = AppSettings();
      await settings.setShowGuides(false);
      expect(settings.showGuides, isFalse);

      await settings.setThemeMode(ThemeMode.light);
      await settings.setColormap(AppColormap.inferno);
      await settings.setResolution(75);

      await settings.resetDefaults();
      expect(settings.themeMode, ThemeMode.dark);
      expect(settings.colormap, AppColormap.classic);
      expect(settings.resolution, 50);
      expect(settings.showGuides, isTrue);
    });
  });

  group('SettingsDialog & AboutDialog widget tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('SettingsDialog renders options and triggers changes', (
      WidgetTester tester,
    ) async {
      final settings = AppSettings();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SettingsDialog(settings: settings)),
        ),
      );

      expect(find.text('Settings & Display'), findsOneWidget);
      expect(find.text('Sinogram Colormap'), findsOneWidget);
      expect(find.text('Sampling Resolution (P × Q)'), findsOneWidget);

      // Tap Light theme segment
      await tester.tap(find.text('Light'));
      await tester.pumpAndSettle();
      expect(settings.themeMode, ThemeMode.light);

      // Tap Grayscale colormap chip
      await tester.tap(find.text('Grayscale (Medical CT)'));
      await tester.pumpAndSettle();
      expect(settings.colormap, AppColormap.grayscale);

      // Scroll and tap 75 resolution segment
      await tester.ensureVisible(find.text('75 (150×150)'));
      await tester.tap(find.text('75 (150×150)'));
      await tester.pumpAndSettle();
      expect(settings.resolution, 75);
    });

    testWidgets('AppAboutDialog displays version and copyright info', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppAboutDialog(version: '2.0.0+7')),
        ),
      );

      expect(find.text('CAT Scan Demonstration'), findsOneWidget);
      expect(find.text('Version 2.0.0+7'), findsOneWidget);
      expect(
        find.text(
          'Original Java Applet presented as a talk at Ball State University February 26, 1998 by Fred Gylys-Colwell',
        ),
        findsOneWidget,
      );
      expect(find.text('More Info'), findsOneWidget);
      expect(find.text('View HTML Doc'), findsNothing);
      expect(find.text('Original Talk'), findsNothing);
      expect(find.text('Close'), findsOneWidget);
    });

    testWidgets('AppAboutDialog opens Privacy Policy and Terms dialogs', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppAboutDialog(version: '2.0.0+7')),
        ),
      );

      // Open Privacy Policy
      await tester.ensureVisible(find.text('Privacy Policy'));
      await tester.tap(find.text('Privacy Policy'));
      await tester.pumpAndSettle();

      expect(find.text('Privacy Policy'), findsAtLeast(1));
      // Close Privacy Policy dialog
      await tester.tap(find.text('Close').last);
      await tester.pumpAndSettle();

      // Open Terms of Service
      await tester.ensureVisible(find.text('Terms of Service'));
      await tester.tap(find.text('Terms of Service'));
      await tester.pumpAndSettle();

      expect(find.text('Terms of Service'), findsAtLeast(1));
      // Close Terms of Service dialog
      await tester.tap(find.text('Close').last);
      await tester.pumpAndSettle();
    });
  });
}
