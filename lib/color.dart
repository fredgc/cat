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

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Available colormaps for rendering the Radon sinogram heatmap.
enum AppColormap {
  classic('Classic (1998 Java)'),
  grayscale('Grayscale (Medical CT)'),
  viridis('Viridis'),
  inferno('Inferno');

  final String displayName;
  const AppColormap(this.displayName);
}

/// Utility class providing color palettes and pixel conversion for the sinogram.
class ColorPalettes {
  static const int numColors = 256;

  /// Classic 1998 Java applet palette:
  /// For r >= 0: transition from dark purple/blue to vibrant red/orange.
  /// For r < 0: transition from dark green/teal to bright yellow/cyan.
  static Color getClassicColor(double value) {
    if (value.isNaN) return Colors.black;

    // Value scaling: typical filtered sinogram values range within [-0.25, 0.25].
    // Scale factor 4.0 matches the original Java applet implementation.
    final double scaled = value * 4.0;
    final double mag = (scaled * scaled).clamp(0.0, 1.0);

    if (scaled >= 0.0) {
      // Positive: (255 * t, 0, 100 - 100 * t)
      final int r = (255 * mag).round().clamp(0, 255);
      final int b = (100 * (1.0 - mag)).round().clamp(0, 255);
      return Color.fromARGB(255, r, 0, b);
    } else {
      // Negative: (200 * t, 255 * t, 100 - 100 * t)
      final int r = (200 * mag).round().clamp(0, 255);
      final int g = (255 * mag).round().clamp(0, 255);
      final int b = (100 * (1.0 - mag)).round().clamp(0, 255);
      return Color.fromARGB(255, r, g, b);
    }
  }

  /// Grayscale palette (standard in medical radiology and CT scans).
  static Color getGrayscaleColor(double value) {
    if (value.isNaN) return Colors.black;
    // Map [-0.25, 0.25] to [0.0, 1.0] with 0.0 at center 0.5
    final double norm = (value * 2.0 + 0.5).clamp(0.0, 1.0);
    final int lum = (norm * 255).round().clamp(0, 255);
    return Color.fromARGB(255, lum, lum, lum);
  }

  /// Viridis perceptually uniform colormap interpolation.
  static Color getViridisColor(double value) {
    if (value.isNaN) return Colors.black;
    final double norm = (value * 2.0 + 0.5).clamp(0.0, 1.0);

    // 5 anchor control points for Viridis approximation
    if (norm < 0.25) {
      final double t = norm / 0.25;
      return Color.lerp(const Color(0xFF440154), const Color(0xFF3B528B), t)!;
    } else if (norm < 0.5) {
      final double t = (norm - 0.25) / 0.25;
      return Color.lerp(const Color(0xFF3B528B), const Color(0xFF21918C), t)!;
    } else if (norm < 0.75) {
      final double t = (norm - 0.5) / 0.25;
      return Color.lerp(const Color(0xFF21918C), const Color(0xFF5EC962), t)!;
    } else {
      final double t = (norm - 0.75) / 0.25;
      return Color.lerp(const Color(0xFF5EC962), const Color(0xFFFDE725), t)!;
    }
  }

  /// Inferno colormap interpolation.
  static Color getInfernoColor(double value) {
    if (value.isNaN) return Colors.black;
    final double norm = (value * 2.0 + 0.5).clamp(0.0, 1.0);

    if (norm < 0.25) {
      final double t = norm / 0.25;
      return Color.lerp(const Color(0xFF000004), const Color(0xFF420A68), t)!;
    } else if (norm < 0.5) {
      final double t = (norm - 0.25) / 0.25;
      return Color.lerp(const Color(0xFF420A68), const Color(0xFF932667), t)!;
    } else if (norm < 0.75) {
      final double t = (norm - 0.5) / 0.25;
      return Color.lerp(const Color(0xFF932667), const Color(0xFFDD513A), t)!;
    } else {
      final double t = (norm - 0.75) / 0.25;
      return Color.lerp(const Color(0xFFDD513A), const Color(0xFFFCFFA4), t)!;
    }
  }

  /// Returns the corresponding [Color] for given [value] using [colormap].
  static Color getColor(double value, AppColormap colormap) {
    switch (colormap) {
      case AppColormap.classic:
        return getClassicColor(value);
      case AppColormap.grayscale:
        return getGrayscaleColor(value);
      case AppColormap.viridis:
        return getViridisColor(value);
      case AppColormap.inferno:
        return getInfernoColor(value);
    }
  }

  /// Returns 32-bit RGBA pixel int (for fast ui.decodeImageFromPixels buffer filling).
  static int getRgbaPixel(double value, AppColormap colormap) {
    final ui.Color color = getColor(value, colormap);
    final int r = (color.r * 255.0).round().clamp(0, 255);
    final int g = (color.g * 255.0).round().clamp(0, 255);
    final int b = (color.b * 255.0).round().clamp(0, 255);
    // In RGBA format: (R << 24) | (G << 16) | (B << 8) | A
    return (r << 24) | (g << 16) | (b << 8) | 0xFF;
  }
}
