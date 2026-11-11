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

import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../color.dart';
import '../l10n/l10n_extension.dart';
import '../models/radon_engine.dart';

/// Interactive canvas representing Sinogram / Radon Space (r, θ).
///
/// Features:
/// - Real-time cached heatmap image (ui.Image) of the 2D projection data.
/// - Border sliders on right (θ) and bottom (r) for selecting slice families.
/// - Sinusoidal curve overlays for point probes in object space.
/// - Crosshair indicator for single line probe.
class RadonCanvas extends StatefulWidget {
  final RadonEngine engine;
  final bool showSinogram;
  final bool interactive;
  final AppColormap colormap;

  const RadonCanvas({
    super.key,
    required this.engine,
    this.showSinogram = true,
    this.interactive = true,
    this.colormap = AppColormap.classic,
  });

  @override
  State<RadonCanvas> createState() => _RadonCanvasState();
}

class _RadonCanvasState extends State<RadonCanvas> {
  ui.Image? _cachedImage;
  bool _isGeneratingImage = false;
  bool _isDirty = true;

  // Track version and colormap to invalidate cache only when necessary
  int _lastVersion = -1;
  AppColormap _lastColormap = AppColormap.classic;

  @override
  void initState() {
    super.initState();
    widget.engine.addListener(_onEngineChanged);
    _checkAndRegenerateHeatmap();
  }

  @override
  void didUpdateWidget(covariant RadonCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.engine != widget.engine) {
      oldWidget.engine.removeListener(_onEngineChanged);
      widget.engine.addListener(_onEngineChanged);
      _isDirty = true;
    }
    if (oldWidget.colormap != widget.colormap ||
        oldWidget.showSinogram != widget.showSinogram) {
      _isDirty = true;
    }
    _checkAndRegenerateHeatmap();
  }

  @override
  void dispose() {
    widget.engine.removeListener(_onEngineChanged);
    _cachedImage?.dispose();
    super.dispose();
  }

  void _onEngineChanged() {
    if (widget.engine.version != _lastVersion ||
        widget.colormap != _lastColormap) {
      _isDirty = true;
      _checkAndRegenerateHeatmap();
    } else {
      if (mounted) setState(() {});
    }
  }

  void _checkAndRegenerateHeatmap() {
    if (!widget.showSinogram) {
      if (_cachedImage != null) {
        _cachedImage?.dispose();
        _cachedImage = null;
        if (mounted) setState(() {});
      }
      return;
    }

    if (!_isDirty && _cachedImage != null) return;
    if (_isGeneratingImage) return;

    _isGeneratingImage = true;
    final int width = widget.engine.numRadialSamples;
    final int height = widget.engine.numAngles;
    final Uint8List pixels = Uint8List(width * height * 4);

    int byteIdx = 0;
    // Render from top row (y=0 => theta=2P-1) to bottom row (y=height-1 => theta=0)
    for (int y = 0; y < height; y++) {
      final int thetaIdx = height - 1 - y;
      for (int x = 0; x < width; x++) {
        final double val = widget.engine.getSinogramValue(x, thetaIdx);
        final Color c = ColorPalettes.getColor(val, widget.colormap);
        pixels[byteIdx++] = (c.r * 255.0).round().clamp(0, 255);
        pixels[byteIdx++] = (c.g * 255.0).round().clamp(0, 255);
        pixels[byteIdx++] = (c.b * 255.0).round().clamp(0, 255);
        pixels[byteIdx++] = 255;
      }
    }

    ui.decodeImageFromPixels(pixels, width, height, ui.PixelFormat.rgba8888, (
      ui.Image image,
    ) {
      if (!mounted) {
        image.dispose();
        return;
      }
      _cachedImage?.dispose();
      _cachedImage = image;
      _isGeneratingImage = false;
      _isDirty = false;

      _lastVersion = widget.engine.version;
      _lastColormap = widget.colormap;

      setState(() {});
    });
  }

  void _handlePointerEvent(Offset localPosition, Size totalSize) {
    if (!widget.interactive) return;

    const double scrollbarThickness = 14.0;
    final double dataWidth = totalSize.width - scrollbarThickness;
    final double dataHeight = totalSize.height - scrollbarThickness;

    if (dataWidth <= 0 || dataHeight <= 0) return;

    final double x = localPosition.dx;
    final double y = localPosition.dy;

    // Check if clicked in right margin (theta scrollbar)
    if (x >= dataWidth) {
      final double normY = (1.0 - (y / dataHeight)).clamp(0.0, 1.0);
      final int thetaIdx = (normY * (widget.engine.numAngles - 1)).round();
      widget.engine.setProbeTheta(thetaIdx);
      return;
    }

    // Check if clicked in bottom margin (r scrollbar)
    if (y >= dataHeight) {
      final double normX = (x / dataWidth).clamp(0.0, 1.0);
      final int rIdx = (normX * (widget.engine.numRadialSamples - 1)).round();
      widget.engine.setProbeR(rIdx);
      return;
    }

    // Clicked inside main sinogram data area
    final double normX = (x / dataWidth).clamp(0.0, 1.0);
    final double normY = (1.0 - (y / dataHeight)).clamp(0.0, 1.0);
    final int rIdx = (normX * (widget.engine.numRadialSamples - 1)).round();
    final int thetaIdx = (normY * (widget.engine.numAngles - 1)).round();

    widget.engine.setProbeSinogram(rIdx, thetaIdx);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return ListenableBuilder(
      listenable: widget.engine,
      builder: (context, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final double size = math.min(
              constraints.maxWidth,
              constraints.maxHeight,
            );
            if (size <= 0) return const SizedBox.shrink();

            return Semantics(
              label: context.l10n.radonCanvasSemantics,
              child: Center(
                child: SizedBox(
                  width: size,
                  height: size,
                  child: GestureDetector(
                    onTapDown: (d) =>
                        _handlePointerEvent(d.localPosition, Size(size, size)),
                    onPanStart: (d) =>
                        _handlePointerEvent(d.localPosition, Size(size, size)),
                    onPanUpdate: (d) =>
                        _handlePointerEvent(d.localPosition, Size(size, size)),
                    child: ClipRect(
                      child: CustomPaint(
                        size: Size(size, size),
                        painter: RadonCanvasPainter(
                          engine: widget.engine,
                          cachedImage: _cachedImage,
                          showSinogram: widget.showSinogram,
                          isLight: isLight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// Custom painter for the Sinogram (Radon Space) canvas.
class RadonCanvasPainter extends CustomPainter {
  final RadonEngine engine;
  final ui.Image? cachedImage;
  final bool showSinogram;
  final bool isLight;

  const RadonCanvasPainter({
    required this.engine,
    required this.cachedImage,
    required this.showSinogram,
    this.isLight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double barSize = 14.0;
    final double dataWidth = size.width - barSize;
    final double dataHeight = size.height - barSize;

    final Rect dataRect = Rect.fromLTWH(0, 0, dataWidth, dataHeight);
    final Rect rightBarRect = Rect.fromLTWH(dataWidth, 0, barSize, dataHeight);
    final Rect bottomBarRect = Rect.fromLTWH(0, dataHeight, dataWidth, barSize);

    // Background
    final Paint bgPaint = Paint()
      ..color = isLight ? Colors.white : const Color(0xFF0F0F14);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Scrollbar backgrounds
    final Paint barBgPaint = Paint()
      ..color = isLight ? const Color(0xFFE8E8EC) : const Color(0xFF1E1E28);
    canvas.drawRect(rightBarRect, barBgPaint);
    canvas.drawRect(bottomBarRect, barBgPaint);

    // Render sinogram heatmap
    if (showSinogram && cachedImage != null) {
      final Rect srcRect = Rect.fromLTWH(
        0,
        0,
        cachedImage!.width.toDouble(),
        cachedImage!.height.toDouble(),
      );
      final Paint imgPaint = Paint()..filterQuality = FilterQuality.none;
      canvas.drawImageRect(cachedImage!, srcRect, dataRect, imgPaint);
    }

    // Coordinate grid lines on sinogram
    final Paint gridPaint = Paint()
      ..color = isLight ? Colors.black26 : Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 4; i++) {
      final double x = i * dataWidth / 4.0;
      canvas.drawLine(Offset(x, 0), Offset(x, dataHeight), gridPaint);
      final double y = i * dataHeight / 4.0;
      canvas.drawLine(Offset(0, y), Offset(dataWidth, y), gridPaint);
    }

    // Scrollbar border outlines
    canvas.drawRect(rightBarRect, gridPaint);
    canvas.drawRect(bottomBarRect, gridPaint);
    canvas.drawRect(dataRect, gridPaint);

    // Axis labels
    final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);
    void drawText(
      String text,
      Offset pos, {
      Color? color,
      double fontSize = 10,
    }) {
      final Color textColor =
          color ?? (isLight ? Colors.black54 : Colors.white54);
      tp.text = TextSpan(
        text: text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontFamily: 'monospace',
        ),
      );
      tp.layout();
      tp.paint(canvas, pos);
    }

    drawText('r: -1', const Offset(4, 4));
    drawText('0', Offset(dataWidth * 0.5 - 4, 4));
    drawText('+1', Offset(dataWidth - 22, 4));

    drawText('θ: 2π', const Offset(4, 18));
    drawText('π', Offset(4, dataHeight * 0.5 - 6));
    drawText('0', Offset(4, dataHeight - 16));

    // Draw active probe overlays
    final Paint highlightPaint = Paint()
      ..color = isLight
          ? const Color(0xFF00796B)
          : const Color(0xFFC8FFC8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final Paint sliderPaint = Paint()
      ..color = isLight
          ? const Color(0xFF00897B)
          : const Color(0xFF69F0AE)
      ..style = PaintingStyle.fill;

    switch (engine.probeMode) {
      case ProbeMode.none:
        break;

      case ProbeMode.point:
        // Sinusoid: r(theta) = probeX * cos(theta) + probeY * sin(theta)
        canvas.save();
        canvas.clipRect(dataRect);
        final Path sinusoidPath = Path();
        for (int j = 0; j < engine.numAngles; j++) {
          final double theta = engine.thetaTable[j];
          final double r =
              engine.probeX * engine.cosTable[j] +
              engine.probeY * engine.sinTable[j];
          final double px = ((r + 1.0) * 0.5) * dataWidth;
          final double py = (1.0 - (theta / (2.0 * math.pi))) * dataHeight;

          if (j == 0) {
            sinusoidPath.moveTo(px, py);
          } else {
            sinusoidPath.lineTo(px, py);
          }
        }
        canvas.drawPath(sinusoidPath, highlightPaint);
        canvas.restore();
        break;

      case ProbeMode.line:
        final double rNorm =
            (engine.probeRIndex / (engine.numRadialSamples - 1.0));
        final double thetaNorm =
            (engine.probeThetaIndex / (engine.numAngles - 1.0));
        final double px = rNorm * dataWidth;
        final double py = (1.0 - thetaNorm) * dataHeight;

        // Target crosshair
        canvas.save();
        canvas.clipRect(dataRect);
        final Paint crossPaint = Paint()
          ..color = isLight
              ? const Color(0xFF1565C0)
              : const Color(0xFF64B5F6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
        canvas.drawLine(Offset(px - 6, py), Offset(px + 6, py), crossPaint);
        canvas.drawLine(Offset(px, py - 6), Offset(px, py + 6), crossPaint);
        canvas.drawCircle(Offset(px, py), 4.0, crossPaint);
        canvas.restore();
        break;

      case ProbeMode.theta:
        final double thetaNorm =
            (engine.probeThetaIndex / (engine.numAngles - 1.0));
        final double py = (1.0 - thetaNorm) * dataHeight;

        // Horizontal line across sinogram
        canvas.drawLine(Offset(0, py), Offset(dataWidth, py), highlightPaint);

        // Right slider indicator
        canvas.drawRect(
          Rect.fromLTWH(dataWidth, py - 3, barSize, 6),
          sliderPaint,
        );
        break;

      case ProbeMode.sline:
        final double rNorm =
            (engine.probeRIndex / (engine.numRadialSamples - 1.0));
        final double px = rNorm * dataWidth;

        // Vertical line down sinogram
        canvas.drawLine(Offset(px, 0), Offset(px, dataHeight), highlightPaint);

        // Bottom slider indicator
        canvas.drawRect(
          Rect.fromLTWH(px - 3, dataHeight, 6, barSize),
          sliderPaint,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(covariant RadonCanvasPainter oldDelegate) {
    return true;
  }
}
