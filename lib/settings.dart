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
import 'package:shared_preferences/shared_preferences.dart';

import 'color.dart';
import 'l10n/l10n_extension.dart';

/// Manages persistent user preferences using [SharedPreferences].
class AppSettings extends ChangeNotifier {
  static const String _keyThemeMode = 'cat_theme_mode';
  static const String _keyColormap = 'cat_colormap';
  static const String _keyResolution = 'cat_grid_resolution';
  static const String _keyShowGuides = 'cat_show_guides';

  ThemeMode _themeMode = ThemeMode.dark;
  AppColormap _colormap = AppColormap.classic;
  int _resolution = 50; // P = Q = 50 by default (100x100 grid)
  bool _showGuides = true;

  AppSettings() {
    loadPreferences();
  }

  ThemeMode get themeMode => _themeMode;
  AppColormap get colormap => _colormap;
  int get resolution => _resolution;
  int get p => _resolution;
  int get q => _resolution;
  bool get showGuides => _showGuides;

  /// Loads preferences asynchronously from [SharedPreferences].
  Future<void> loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool changed = false;

      final themeStr = prefs.getString(_keyThemeMode);
      if (themeStr != null) {
        final mode = ThemeMode.values.firstWhere(
          (m) => m.name == themeStr,
          orElse: () => ThemeMode.dark,
        );
        if (_themeMode != mode) {
          _themeMode = mode;
          changed = true;
        }
      }

      final colormapStr = prefs.getString(_keyColormap);
      if (colormapStr != null) {
        final cmap = AppColormap.values.firstWhere(
          (c) => c.name == colormapStr,
          orElse: () => AppColormap.classic,
        );
        if (_colormap != cmap) {
          _colormap = cmap;
          changed = true;
        }
      }

      final resVal = prefs.getInt(_keyResolution);
      if (resVal != null && resVal >= 25 && resVal <= 100) {
        if (_resolution != resVal) {
          _resolution = resVal;
          changed = true;
        }
      }

      final guidesVal = prefs.getBool(_keyShowGuides);
      if (guidesVal != null) {
        if (_showGuides != guidesVal) {
          _showGuides = guidesVal;
          changed = true;
        }
      }

      if (changed) {
        notifyListeners();
      }
    } catch (_) {
      // Gracefully fall back to defaults if storage is unavailable
    }
  }

  /// Sets the application theme mode and persists it.
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_keyThemeMode, mode.name);
      } catch (_) {}
    }
  }

  /// Sets the sinogram colormap and persists it.
  Future<void> setColormap(AppColormap cmap) async {
    if (_colormap != cmap) {
      _colormap = cmap;
      notifyListeners();
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_keyColormap, cmap.name);
      } catch (_) {}
    }
  }

  /// Sets the grid sampling resolution (P = Q) and persists it.
  Future<void> setResolution(int res) async {
    if (_resolution != res) {
      _resolution = res.clamp(25, 100);
      notifyListeners();
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(_keyResolution, _resolution);
      } catch (_) {}
    }
  }

  /// Toggles visibility of coordinate axes and guides.
  Future<void> setShowGuides(bool show) async {
    if (_showGuides != show) {
      _showGuides = show;
      notifyListeners();
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(_keyShowGuides, show);
      } catch (_) {}
    }
  }

  /// Resets all preferences back to default values.
  Future<void> resetDefaults() async {
    _themeMode = ThemeMode.dark;
    _colormap = AppColormap.classic;
    _resolution = 50;
    _showGuides = true;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyThemeMode);
      await prefs.remove(_keyColormap);
      await prefs.remove(_keyResolution);
      await prefs.remove(_keyShowGuides);
    } catch (_) {}
  }
}

/// Dialog allowing users to customize theme, sinogram colormap, resolution, and guides.
class SettingsDialog extends StatelessWidget {
  final AppSettings settings;

  const SettingsDialog({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final theme = Theme.of(context);

        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.tune),
              const SizedBox(width: 8),
              Text(context.l10n.settingsTitle),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 440,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Theme Mode Selection
                  Text(
                    context.l10n.themeSection,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 6),
                  SegmentedButton<ThemeMode>(
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: const Icon(Icons.dark_mode, size: 16),
                        label: Text(context.l10n.themeDark),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: const Icon(Icons.light_mode, size: 16),
                        label: Text(context.l10n.themeLight),
                      ),
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: const Icon(Icons.brightness_auto, size: 16),
                        label: Text(context.l10n.themeSystem),
                      ),
                    ],
                    selected: {settings.themeMode},
                    onSelectionChanged: (selected) {
                      settings.setThemeMode(selected.first);
                    },
                  ),
                  const Divider(height: 24),

                  // Colormap Selection
                  Text(
                    context.l10n.colormapSection,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: AppColormap.values.map((cmap) {
                      final isSelected = settings.colormap == cmap;
                      String colormapName;
                      switch (cmap) {
                        case AppColormap.classic:
                          colormapName = context.l10n.colormapClassic;
                          break;
                        case AppColormap.grayscale:
                          colormapName = context.l10n.colormapGrayscale;
                          break;
                        case AppColormap.viridis:
                          colormapName = context.l10n.colormapViridis;
                          break;
                        case AppColormap.inferno:
                          colormapName = context.l10n.colormapInferno;
                          break;
                      }
                      return ChoiceChip(
                        avatar: _buildColormapPreviewSwatch(cmap),
                        label: Text(colormapName),
                        selected: isSelected,
                        onSelected: (_) => settings.setColormap(cmap),
                      );
                    }).toList(),
                  ),
                  const Divider(height: 24),

                  // Sampling Resolution Selection
                  Text(
                    context.l10n.resolutionSection,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 6),
                  SegmentedButton<int>(
                    segments: [
                      ButtonSegment(
                        value: 25,
                        label: Text(context.l10n.res25Label),
                        tooltip: context.l10n.res25Tooltip,
                      ),
                      ButtonSegment(
                        value: 50,
                        label: Text(context.l10n.res50Label),
                        tooltip: context.l10n.res50Tooltip,
                      ),
                      ButtonSegment(
                        value: 75,
                        label: Text(context.l10n.res75Label),
                        tooltip: context.l10n.res75Tooltip,
                      ),
                      ButtonSegment(
                        value: 100,
                        label: Text(context.l10n.res100Label),
                        tooltip: context.l10n.res100Tooltip,
                      ),
                    ],
                    selected: {settings.resolution},
                    onSelectionChanged: (selected) {
                      settings.setResolution(selected.first);
                    },
                  ),
                  const Divider(height: 24),

                  // Coordinate Guides Toggle
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(context.l10n.showGuidesTitle),
                    subtitle: Text(context.l10n.showGuidesSubtitle),
                    value: settings.showGuides,
                    onChanged: (val) => settings.setShowGuides(val),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => settings.resetDefaults(),
              child: Text(context.l10n.resetDefaults),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.l10n.done),
            ),
          ],
        );
      },
    );
  }

  Widget _buildColormapPreviewSwatch(AppColormap cmap) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            ColorPalettes.getColor(-0.2, cmap),
            ColorPalettes.getColor(0.0, cmap),
            ColorPalettes.getColor(0.2, cmap),
          ],
        ),
      ),
    );
  }
}
