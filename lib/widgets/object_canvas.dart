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

import 'package:flutter/material.dart';

import '../l10n/l10n_extension.dart';
import '../models/radon_engine.dart';

/// Interactive canvas representing Object Space (x, y) in [-1.0, 1.0] x [-1.0, 1.0].
///
/// Features:
/// - Coordinate plane with unit circle FOV and Cartesian axes.
/// - Circular phantom disk (draggable when [showPhantom] is true).
/// - Probe markers and X-ray line visualizations according to [engine.probeMode].
class ObjectCanvas extends StatefulWidget {
  final RadonEngine engine;
  final bool showPhantom;
  final bool interactive;
  final bool showGuides;

  /// Inset margin in pixels from the canvas square edge to the unit circle.
  /// Leaves room in the top corners for mode selection controls.
  static const double unitMargin = 38.0;

  const ObjectCanvas({
    super.key,
    required this.engine,
    this.showPhantom = true,
    this.interactive = true,
    this.showGuides = true,
  });

  @override
  State<ObjectCanvas> createState() => _ObjectCanvasState();
}

class _ObjectCanvasState extends State<ObjectCanvas> {
  bool _isDraggingPhantom = false;
  double _dragOffsetNormX = 0.0;
  double _dragOffsetNormY = 0.0;

  void _handlePointerDown(Offset localPosition, Size size) {
    if (!widget.interactive) return;

    final double side = math.min(size.width, size.height);
    final double unitRadius = side * 0.5 - ObjectCanvas.unitMargin;
    final Offset center = Offset(side * 0.5, side * 0.5);

    // Convert pixel coordinates to normalized [-1.0, 1.0]
    final double normX = ((localPosition.dx - center.dx) / unitRadius).clamp(
      -1.0,
      1.0,
    );
    final double normY = (-(localPosition.dy - center.dy) / unitRadius).clamp(
      -1.0,
      1.0,
    );

    // When in phantom mode, clicks or drags select and reposition/move phantoms
    if (widget.showPhantom &&
        widget.engine.objectInteractionMode == ObjectInteractionMode.phantom) {
      int hitIndex = -1;
      double closestDist = double.infinity;
      for (int i = widget.engine.phantoms.length - 1; i >= 0; i--) {
        final disk = widget.engine.phantoms[i];
        final Offset phantomCenter = Offset(
          center.dx + disk.x * unitRadius,
          center.dy - disk.y * unitRadius,
        );
        final double phantomPixelRadius = disk.radius * unitRadius;
        final double distPx = (localPosition - phantomCenter).distance;
        final double hitRadius = math.max(phantomPixelRadius + 24.0, 40.0);
        if (distPx <= hitRadius && distPx < closestDist) {
          closestDist = distPx;
          hitIndex = i;
        }
      }

      _isDraggingPhantom = true;
      if (hitIndex != -1) {
        widget.engine.selectPhantom(hitIndex);
        final disk = widget.engine.phantoms[hitIndex];
        _dragOffsetNormX = disk.x - normX;
        _dragOffsetNormY = disk.y - normY;
      } else {
        _dragOffsetNormX = 0.0;
        _dragOffsetNormY = 0.0;
        widget.engine.setPhantomPosition(
          normX.clamp(-0.8, 0.8),
          normY.clamp(-0.8, 0.8),
        );
      }
      return;
    }

    // When in probe mode, clicks and drags always reposition the probe point
    _isDraggingPhantom = false;
    _dragOffsetNormX = 0.0;
    _dragOffsetNormY = 0.0;
    widget.engine.setProbePoint(normX, normY);
  }

  void _handlePointerMove(Offset localPosition, Size size) {
    if (!widget.interactive) return;

    final double side = math.min(size.width, size.height);
    final double unitRadius = side * 0.5 - ObjectCanvas.unitMargin;
    final Offset center = Offset(side * 0.5, side * 0.5);

    final double normX = ((localPosition.dx - center.dx) / unitRadius).clamp(
      -1.0,
      1.0,
    );
    final double normY = (-(localPosition.dy - center.dy) / unitRadius).clamp(
      -1.0,
      1.0,
    );

    if (_isDraggingPhantom && widget.showPhantom) {
      widget.engine.setPhantomPosition(
        (normX + _dragOffsetNormX).clamp(-0.8, 0.8),
        (normY + _dragOffsetNormY).clamp(-0.8, 0.8),
      );
    } else {
      widget.engine.setProbePoint(normX, normY);
    }
  }

  void _handlePointerUp() {
    _isDraggingPhantom = false;
    _dragOffsetNormX = 0.0;
    _dragOffsetNormY = 0.0;
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
              label: context.l10n.objectCanvasSemantics,
              child: Center(
                child: SizedBox(
                  width: size,
                  height: size,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTapDown: (details) => _handlePointerDown(
                          details.localPosition,
                          Size(size, size),
                        ),
                        onPanStart: (details) => _handlePointerDown(
                          details.localPosition,
                          Size(size, size),
                        ),
                        onPanUpdate: (details) => _handlePointerMove(
                          details.localPosition,
                          Size(size, size),
                        ),
                        onPanEnd: (_) => _handlePointerUp(),
                        onPanCancel: () => _handlePointerUp(),
                        child: ClipRect(
                          child: CustomPaint(
                            size: Size(size, size),
                            painter: ObjectCanvasPainter(
                              engine: widget.engine,
                              showPhantom: widget.showPhantom,
                              showGuides: widget.showGuides,
                              isLight: isLight,
                            ),
                          ),
                        ),
                      ),
                      if (widget.showPhantom)
                        Positioned(
                          top: 6,
                          left: 6,
                          child: SegmentedButton<ObjectInteractionMode>(
                            showSelectedIcon: false,
                            segments: const [
                              ButtonSegment(
                                value: ObjectInteractionMode.probe,
                                icon: Icon(Icons.colorize, size: 12),
                                label: Text(
                                  'Probe',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                              ButtonSegment(
                                value: ObjectInteractionMode.phantom,
                                icon: Icon(
                                  Icons.circle,
                                  size: 12,
                                  color: Colors.redAccent,
                                ),
                                label: Text(
                                  'Phantom',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ],
                            selected: {widget.engine.objectInteractionMode},
                            onSelectionChanged: (selection) {
                              widget.engine.setObjectInteractionMode(
                                selection.first,
                              );
                            },
                            style: ButtonStyle(
                              visualDensity: const VisualDensity(
                                horizontal: -4,
                                vertical: -4,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (widget.showPhantom)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton.filledTonal(
                                onPressed: widget.interactive
                                    ? () => widget.engine.addPhantom()
                                    : null,
                                icon: const Icon(Icons.add, size: 16),
                                tooltip: 'Add phantom disk',
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints.tightFor(
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                              const SizedBox(width: 4),
                              IconButton.outlined(
                                onPressed:
                                    widget.interactive &&
                                        widget.engine.phantoms.length > 1
                                    ? () =>
                                          widget.engine.removeSelectedPhantom()
                                    : null,
                                icon: const Icon(
                                  Icons.delete_outline,
                                  size: 16,
                                ),
                                tooltip: 'Delete selected phantom',
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints.tightFor(
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
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

/// Custom painter for the Object Space viewport.
class ObjectCanvasPainter extends CustomPainter {
  final RadonEngine engine;
  final bool showPhantom;
  final bool showGuides;
  final bool isLight;

  ObjectCanvasPainter({
    required this.engine,
    required this.showPhantom,
    this.showGuides = true,
    this.isLight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double side = math.min(size.width, size.height);
    final Rect bounds = Rect.fromLTWH(0, 0, side, side);

    canvas.save();
    canvas.clipRect(bounds);

    // Background
    final Paint bgPaint = Paint()
      ..color = isLight ? Colors.white : const Color(0xFF0F0F14);
    canvas.drawRect(bounds, bgPaint);

    final Paint borderPaint = Paint()
      ..color = isLight ? const Color(0xFFD0D0D0) : Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(bounds, borderPaint);

    final Offset center = Offset(side * 0.5, side * 0.5);
    final double unitRadius = side * 0.5 - ObjectCanvas.unitMargin;

    // Helper functions to map from normalized [-1, 1] to screen pixels
    Offset toScreen(double x, double y) {
      return Offset(center.dx + x * unitRadius, center.dy - y * unitRadius);
    }

    if (showGuides) {
      // Draw coordinate axes & circles
      final Paint axisPaint = Paint()
        ..color = isLight
            ? Colors.black.withValues(alpha: 0.20)
            : Colors.white24
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      // Field of view circles
      canvas.drawCircle(center, unitRadius, axisPaint);
      canvas.drawCircle(center, unitRadius * 0.5, axisPaint);

      // Coordinate crosshairs
      canvas.drawLine(
        Offset(center.dx, center.dy - unitRadius),
        Offset(center.dx, center.dy + unitRadius),
        axisPaint,
      );
      canvas.drawLine(
        Offset(center.dx - unitRadius, center.dy),
        Offset(center.dx + unitRadius, center.dy),
        axisPaint,
      );

      // Axis Labels
      final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);
      void drawText(
        String text,
        Offset pos, {
        Color? color,
        double fontSize = 11,
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

      drawText('+y', Offset(center.dx + 4, center.dy - unitRadius + 4));
      drawText('+x', Offset(center.dx + unitRadius - 18, center.dy + 4));
      drawText('(0,0)', Offset(center.dx + 4, center.dy + 4), fontSize: 9);
    }

    // Draw Phantom Disks (if visible in current stage)
    if (showPhantom) {
      for (int i = 0; i < engine.phantoms.length; i++) {
        final disk = engine.phantoms[i];
        final bool isSelected = i == engine.selectedPhantomIndex;
        final Offset phantomCenter = toScreen(disk.x, disk.y);
        final double phantomPixelRadius = disk.radius * unitRadius;

        // Outer touch halo for clear visual affordance
        final Paint haloPaint = Paint()
          ..color = isSelected
              ? const Color(0xFFE53935).withValues(alpha: 0.22)
              : const Color(0xFFE53935).withValues(alpha: 0.08)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(
          phantomCenter,
          phantomPixelRadius + (isSelected ? 6.0 : 3.0),
          haloPaint,
        );

        // Fill disk
        final Paint phantomFill = Paint()
          ..color = isSelected
              ? const Color(0xFFE53935).withValues(alpha: 0.88)
              : const Color(0xFFD32F2F).withValues(alpha: 0.70)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(phantomCenter, phantomPixelRadius, phantomFill);

        // Outline
        final Paint phantomOutline = Paint()
          ..color = isSelected
              ? (isLight ? const Color(0xFFC62828) : const Color(0xFFFF8A80))
              : (isLight ? const Color(0xFFE57373) : const Color(0xFFFFCDD2))
          ..style = PaintingStyle.stroke
          ..strokeWidth = isSelected ? 2.5 : 1.5;
        canvas.drawCircle(phantomCenter, phantomPixelRadius, phantomOutline);

        // Center crosshair for selected disk
        if (isSelected) {
          final Paint crossPaint = Paint()
            ..color = isLight ? Colors.black87 : Colors.white70
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5;
          canvas.drawLine(
            Offset(phantomCenter.dx - 4, phantomCenter.dy),
            Offset(phantomCenter.dx + 4, phantomCenter.dy),
            crossPaint,
          );
          canvas.drawLine(
            Offset(phantomCenter.dx, phantomCenter.dy - 4),
            Offset(phantomCenter.dx, phantomCenter.dy + 4),
            crossPaint,
          );
        }

        // If multiple phantoms exist, draw disk number index
        if (engine.phantoms.length > 1) {
          final TextPainter labelPainter = TextPainter(
            text: TextSpan(
              text: '${i + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            textDirection: TextDirection.ltr,
          )..layout();
          labelPainter.paint(
            canvas,
            Offset(
              phantomCenter.dx - labelPainter.width / 2,
              phantomCenter.dy - labelPainter.height / 2,
            ),
          );
        }
      }
    }

    // Draw active lines according to probe mode
    final Paint linePaint = Paint()
      ..color = isLight
          ? const Color(0xFF2E7D32) // Forest green on white
          : const Color(0xFFC8FFC8) // Original Java light green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Paint normalPaint = Paint()
      ..color = isLight
          ? const Color(0xFF1565C0) // Deep blue on white
          : const Color(0xFF64B5F6) // Perpendicular blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    void drawXRayLine(double r, double cosT, double sinT) {
      // Line equation: x * cosT + y * sinT = r
      // Two points on the line: (r*cosT - 2*sinT, r*sinT + 2*cosT) and (r*cosT + 2*sinT, r*sinT - 2*cosT)
      final Offset p1 = toScreen(r * cosT - 2.0 * sinT, r * sinT + 2.0 * cosT);
      final Offset p2 = toScreen(r * cosT + 2.0 * sinT, r * sinT - 2.0 * cosT);
      canvas.drawLine(p1, p2, linePaint);
    }

    switch (engine.probeMode) {
      case ProbeMode.none:
        break;

      case ProbeMode.point:
        // Draw probe dot in object space
        final Offset probePos = toScreen(engine.probeX, engine.probeY);
        final Paint probePaint = Paint()
          ..color = isLight
              ? const Color(0xFF00C853)
              : const Color(0xFF69F0AE)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(probePos, 4.5, probePaint);

        final Paint probeRing = Paint()
          ..color = isLight ? Colors.black87 : Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
        canvas.drawCircle(probePos, 6.5, probeRing);
        break;

      case ProbeMode.line:
        final double r = engine.rForIndex(engine.probeRIndex);
        final double cosT = engine.cosTable[engine.probeThetaIndex];
        final double sinT = engine.sinTable[engine.probeThetaIndex];

        // Draw normal vector from origin to line foot (r*cosT, r*sinT)
        final Offset foot = toScreen(r * cosT, r * sinT);
        canvas.drawLine(center, foot, normalPaint);
        canvas.drawCircle(foot, 3.0, normalPaint);

        // Draw the X-ray line
        drawXRayLine(r, cosT, sinT);
        break;

      case ProbeMode.theta:
        // Family of parallel lines at fixed theta across all radial offsets
        final double cosT = engine.cosTable[engine.probeThetaIndex];
        final double sinT = engine.sinTable[engine.probeThetaIndex];
        for (double s = -1.0; s <= 1.0; s += 0.2) {
          drawXRayLine(s, cosT, sinT);
        }
        break;

      case ProbeMode.sline:
        // Family of lines tangent to circle of radius |r|
        final double r = engine.rForIndex(engine.probeRIndex);
        final double rAbs = r.abs();

        // Draw tangent circle
        final Paint circlePaint = Paint()
          ..color = isLight
              ? const Color(0xFF0288D1).withValues(alpha: 0.5)
              : const Color(0xFF81D4FA).withValues(alpha: 0.4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;
        canvas.drawCircle(center, rAbs * unitRadius, circlePaint);

        // Draw tangent lines around the circle
        for (
          int t = 0;
          t < engine.numAngles;
          t += (engine.p ~/ 5).clamp(1, 10)
        ) {
          drawXRayLine(r, engine.cosTable[t], engine.sinTable[t]);
        }
        break;
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ObjectCanvasPainter oldDelegate) {
    return true;
  }
}
