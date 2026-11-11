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
import 'stage_stepper.dart';

/// 1D Profile Plot widget displaying cross-sections and the backprojection integral.
///
/// Features:
/// - Plots g(r, θ) or (w_b * g)(r, θ) values along the active probe trajectory.
/// - Zero-baseline and coordinate grid lines.
/// - Live readout of the backprojection integral (evaluating to ≈ 1.0 inside phantom
///   and ≈ 0.0 outside when filtered).
class GraphCanvas extends StatelessWidget {
  final RadonEngine engine;
  final double height;
  final bool isRotating;
  final VoidCallback? onToggleRotation;
  final InstructionTarget currentTarget;
  final bool isCueDismissed;
  final VoidCallback? onDismissCue;

  const GraphCanvas({
    super.key,
    required this.engine,
    this.height = 140.0,
    this.isRotating = false,
    this.onToggleRotation,
    this.currentTarget = InstructionTarget.none,
    this.isCueDismissed = false,
    this.onDismissCue,
  });

  Color _headerColor(bool isLight) {
    switch (engine.probeMode) {
      case ProbeMode.line:
        return isLight
            ? const Color(0xFF00796B)
            : const Color(0xFF69F0AE); // Green (matches single X-ray line)
      case ProbeMode.point:
        return engine.filtered
            ? (isLight
                ? const Color(0xFFE65100)
                : const Color(0xFFFFB74D))
            : (isLight
                ? const Color(0xFFC25E00)
                : const Color(0xFFFFD54F));
      case ProbeMode.theta:
        return engine.filtered
            ? (isLight
                ? const Color(0xFFE65100)
                : const Color(0xFFFFB74D))
            : (isLight
                ? const Color(0xFF00838F)
                : const Color(0xFF00E5FF));
      case ProbeMode.sline:
        return isLight
            ? const Color(0xFF8E24AA)
            : const Color(0xFFE040FB); // Purple (matches tangent family)
      case ProbeMode.none:
        return isLight ? Colors.black54 : Colors.white54;
    }
  }

  String _formatTrajectoryInfo(BuildContext context) {
    final bool filt = engine.filtered;
    final String prefix = filt
        ? context.l10n.graphFilteredPrefix
        : context.l10n.graphUnfilteredPrefix;

    switch (engine.probeMode) {
      case ProbeMode.none:
        return context.l10n.graphSelectPrompt;

      case ProbeMode.point:
        final bool inside = engine.isInsideAnyPhantom(
          engine.probeX,
          engine.probeY,
        );
        final String status = inside
            ? context.l10n.insidePhantom
            : context.l10n.outsidePhantom;
        final String val = engine.filtered
            ? '${engine.filteredBackprojectionValue.toStringAsFixed(3)} '
                '[Raw: ${engine.unfilteredBackprojectionValue.toStringAsFixed(3)}]'
            : engine.backprojectionValue.toStringAsFixed(3);
        return context.l10n.graphPointTrajectory(
          prefix,
          engine.probeX.toStringAsFixed(2),
          engine.probeY.toStringAsFixed(2),
          val,
          status,
        );

      case ProbeMode.line:
        final double r = engine.rForIndex(engine.probeRIndex);
        final double t = engine.thetaForIndex(engine.probeThetaIndex);
        final String val = engine.backprojectionValue.toStringAsFixed(3);
        return context.l10n.graphLineTrajectory(
          r.toStringAsFixed(2),
          t.toStringAsFixed(2),
          val,
        );

      case ProbeMode.theta:
        final double t = engine.thetaForIndex(engine.probeThetaIndex);
        final String val = engine.backprojectionValue.toStringAsFixed(3);
        return context.l10n.graphThetaTrajectory(
          prefix,
          t.toStringAsFixed(2),
          val,
        );

      case ProbeMode.sline:
        final double r = engine.rForIndex(engine.probeRIndex);
        final String val = engine.backprojectionValue.toStringAsFixed(3);
        return context.l10n.graphSlineTrajectory(
          prefix,
          r.toStringAsFixed(2),
          val,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return ListenableBuilder(
      listenable: engine,
      builder: (context, _) {
        final Color headerColor = _headerColor(isLight);

        return Semantics(
          label: context.l10n.graphCanvasSemantics,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: isLight ? Colors.white : const Color(0xFF0F0F14),
              border: Border(
                top: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header description, integral readout, and play/pause button
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _formatTrajectoryInfo(context),
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: headerColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (onToggleRotation != null) ...[
                      const SizedBox(width: 8),
                      _PlayButtonWithCue(
                        isRotating: isRotating,
                        onToggleRotation: onToggleRotation,
                        showCue:
                            currentTarget == InstructionTarget.playButton &&
                            !isCueDismissed &&
                            !isRotating,
                        onDismissCue: onDismissCue,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),

                // Canvas plot
                Expanded(
                  child: CustomPaint(
                    painter: GraphCanvasPainter(
                      engine: engine,
                      curveColor: headerColor,
                      isLight: isLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Custom painter for plotting the 1D profile array.
class GraphCanvasPainter extends CustomPainter {
  final RadonEngine engine;
  final Color curveColor;
  final bool isLight;

  GraphCanvasPainter({
    required this.engine,
    this.curveColor = const Color(0xFF69F0AE),
    this.isLight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = Rect.fromLTWH(0, 0, size.width, size.height);

    // Clip to bounds
    canvas.clipRect(bounds);

    // Grid lines & Zero-axis
    final Paint gridPaint = Paint()
      ..color = isLight ? Colors.black12 : Colors.white12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final Paint zeroAxisPaint = Paint()
      ..color = isLight ? Colors.black45 : Colors.white38
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Determine value domain according to probe mode
    final double minY;
    final double maxY;
    final String xAxisLabel;

    switch (engine.probeMode) {
      case ProbeMode.line:
        minY = -0.1;
        maxY = 1.2;
        xAxisLabel = 'Path along ray s ∈ [-1, 1]';
        break;
      case ProbeMode.theta:
        if (engine.filtered) {
          minY = -0.3;
          maxY = 0.7;
        } else {
          minY = -0.1;
          maxY = 0.7;
        }
        xAxisLabel = 'Radial offset r ∈ [-1, 1]';
        break;
      case ProbeMode.point:
        if (engine.filtered) {
          minY = -0.3;
          maxY = 0.8;
        } else {
          minY = -0.1;
          maxY = 0.8;
        }
        xAxisLabel = 'Angle θ ∈ [0, 2π)';
        break;
      case ProbeMode.sline:
        minY = -0.3;
        maxY = 0.3;
        xAxisLabel = 'Angle θ ∈ [0, 2π)';
        break;
      case ProbeMode.none:
        minY = -0.3;
        maxY = 0.3;
        xAxisLabel = '';
        break;
    }

    final double rangeY = maxY - minY;

    double toScreenY(double val) {
      final double norm = (val - minY) / rangeY;
      return size.height * (1.0 - norm);
    }

    // Horizontal grid lines
    if (engine.probeMode == ProbeMode.line) {
      for (double yVal = 0.0; yVal <= 1.05; yVal += 0.5) {
        final double py = toScreenY(yVal);
        canvas.drawLine(
          Offset(0, py),
          Offset(size.width, py),
          yVal == 0.0 ? zeroAxisPaint : gridPaint,
        );
      }
    } else {
      for (double yVal = -0.2; yVal <= 0.25; yVal += 0.1) {
        final double py = toScreenY(yVal);
        if (yVal.abs() < 1e-4) {
          canvas.drawLine(Offset(0, py), Offset(size.width, py), zeroAxisPaint);
        } else {
          canvas.drawLine(Offset(0, py), Offset(size.width, py), gridPaint);
        }
      }
    }

    // Vertical grid lines (5 vertical divisions)
    for (int i = 0; i <= 4; i++) {
      final double px = i * (size.width - 1) / 4.0;
      canvas.drawLine(Offset(px, 0), Offset(px, size.height), gridPaint);
    }

    // Draw scale labels
    final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);
    void drawText(
      String text,
      Offset pos, {
      Color? color,
      double fontSize = 9,
    }) {
      final Color textColor =
          color ?? (isLight ? Colors.black54 : Colors.white38);
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

    if (engine.probeMode == ProbeMode.line) {
      drawText('1.0', Offset(2, toScreenY(1.0) - 10));
      drawText('0.0', Offset(2, toScreenY(0.0) - 10));
    } else {
      drawText('+0.2', Offset(2, toScreenY(0.2) - 10));
      drawText(' 0.0', Offset(2, toScreenY(0.0) - 10));
      drawText('-0.2', Offset(2, toScreenY(-0.2) - 10));
    }

    if (xAxisLabel.isNotEmpty) {
      drawText(
        xAxisLabel,
        Offset(size.width - 170, size.height - 12),
        color: isLight ? Colors.black38 : Colors.white24,
      );
    }

    // When viewing filtered data (parallel family or point trajectory),
    // also draw the unfiltered curve in background.
    final bool showDualCurves = engine.filtered &&
        (engine.probeMode == ProbeMode.theta ||
            engine.probeMode == ProbeMode.point);

    if (showDualCurves) {
      final List<double> unfilt = engine.unfilteredProfile;
      if (unfilt.isNotEmpty) {
        final Paint unfiltPaint = Paint()
          ..color = isLight
              ? const Color(0xFF00838F).withValues(alpha: 0.60)
              : const Color(0xFF00E5FF).withValues(alpha: 0.40)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

        final Path unfiltPath = Path();
        for (int i = 0; i < unfilt.length; i++) {
          final double px = (i / (unfilt.length - 1.0)) * size.width;
          final double py = toScreenY(unfilt[i]).clamp(0.0, size.height);
          if (i == 0) {
            unfiltPath.moveTo(px, py);
          } else {
            unfiltPath.lineTo(px, py);
          }
        }
        canvas.drawPath(unfiltPath, unfiltPaint);
      }

      drawText(
        '— Filtered (Ramp kernel)',
        Offset(size.width - 165, 4),
        color: isLight ? const Color(0xFFE65100) : const Color(0xFFFFB74D),
      );
      final String unfiltLegend = engine.probeMode == ProbeMode.point
          ? '— Unfiltered g(θ)'
          : '— Unfiltered P_θ(r)';
      drawText(
        unfiltLegend,
        Offset(size.width - 165, 16),
        color: isLight
            ? const Color(0xFF00838F)
            : const Color(0xFF00E5FF).withValues(alpha: 0.7),
      );
    }

    // Plot active profile curve
    final List<double> f = engine.profile;
    if (f.isEmpty) return;

    final Paint curvePaint = Paint()
      ..color = curveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final Path path = Path();
    final int count = f.length;

    for (int i = 0; i < count; i++) {
      final double px = (i / (count - 1.0)) * size.width;
      final double py = toScreenY(f[i]).clamp(0.0, size.height);

      if (i == 0) {
        path.moveTo(px, py);
      } else {
        path.lineTo(px, py);
      }
    }

    canvas.drawPath(path, curvePaint);
  }

  @override
  bool shouldRepaint(covariant GraphCanvasPainter oldDelegate) {
    return true;
  }
}

class _PlayButtonWithCue extends StatefulWidget {
  final bool isRotating;
  final VoidCallback? onToggleRotation;
  final bool showCue;
  final VoidCallback? onDismissCue;

  const _PlayButtonWithCue({
    required this.isRotating,
    required this.onToggleRotation,
    required this.showCue,
    this.onDismissCue,
  });

  @override
  State<_PlayButtonWithCue> createState() => _PlayButtonWithCueState();
}

class _PlayButtonWithCueState extends State<_PlayButtonWithCue>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    if (widget.showCue) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _PlayButtonWithCue oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showCue != oldWidget.showCue) {
      if (widget.showCue) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final primary = theme.colorScheme.primary;
    final Color cueColor = isLight
        ? const Color(0xFF42A5F5)
        : primary;

    final Widget button = InkWell(
      onTap: () {
        widget.onDismissCue?.call();
        widget.onToggleRotation?.call();
      },
      borderRadius: BorderRadius.circular(4),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final double t = _controller.value;
          final double pulse = widget.showCue
              ? 0.5 + 0.5 * math.sin(t * 2 * math.pi)
              : 0.0;

          final Color borderColor = widget.isRotating
              ? Colors.redAccent
              : (widget.showCue
                  ? Color.lerp(cueColor, Colors.white, 0.4 * pulse)!
                  : primary);

          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: widget.isRotating
                  ? Colors.redAccent.withValues(alpha: 0.2)
                  : (widget.showCue
                      ? cueColor.withValues(alpha: 0.15 + 0.2 * pulse)
                      : theme.colorScheme.primaryContainer
                          .withValues(alpha: 0.4)),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: borderColor,
                width: widget.showCue ? 1.5 + 0.5 * pulse : 1.0,
              ),
              boxShadow: widget.showCue
                  ? [
                      BoxShadow(
                        color: cueColor.withValues(alpha: 0.4 * pulse),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: child,
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.isRotating ? Icons.pause : Icons.play_arrow,
              size: 13,
              color: widget.isRotating
                  ? Colors.redAccent
                  : theme.colorScheme.primary,
            ),
            const SizedBox(width: 4),
            Text(
              widget.isRotating
                  ? 'Pause [Space]'
                  : 'Play Scan [Space]',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: widget.isRotating
                    ? Colors.redAccent
                    : theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );

    if (!widget.showCue) {
      return button;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final double t = _controller.value;
        final double tapOffset = math.sin(t * math.pi) * 5.0;
        final double rippleScale = 8.0 + 14.0 * t;
        final double rippleOpacity = (1.0 - t).clamp(0.0, 1.0);

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            button,

            // Ripple expanding from the play button
            Positioned(
              left: 14.0 - rippleScale,
              top: 10.0 - rippleScale,
              child: IgnorePointer(
                child: Container(
                  width: rippleScale * 2,
                  height: rippleScale * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: cueColor.withValues(alpha: 0.6 * rippleOpacity),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),

            // Hovering / tapping hand icon over the play button
            Positioned(
              top: -14.0 + tapOffset,
              left: 4.0,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 4,
                        offset: const Offset(1, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.touch_app,
                    size: 22,
                    color: cueColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
