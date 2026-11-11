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

import 'object_canvas.dart';
import 'stage_stepper.dart';

/// Wraps a viewport canvas to display animated visual cues and gesture hints
/// demonstrating how to interact with the target control.
class InteractionCueOverlay extends StatefulWidget {
  final Widget child;
  final InstructionTarget currentTarget;
  final Set<InstructionTarget> matchingTargets;
  final InstructionGesture gesture;
  final bool isDismissed;
  final VoidCallback? onDismiss;
  final Offset? targetNormalizedPos;
  final Axis? dragAxis;

  const InteractionCueOverlay({
    super.key,
    required this.child,
    required this.currentTarget,
    required this.matchingTargets,
    this.gesture = InstructionGesture.tap,
    this.isDismissed = false,
    this.onDismiss,
    this.targetNormalizedPos,
    this.dragAxis,
  });

  @override
  State<InteractionCueOverlay> createState() => _InteractionCueOverlayState();
}

class _InteractionCueOverlayState extends State<InteractionCueOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _cycles = 0;
  static const int _maxCycles = 8;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _cycles++;
        });
        if (_cycles < _maxCycles && _shouldShow) {
          _controller.forward(from: 0.0);
        }
      }
    });
    if (_shouldShow) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void didUpdateWidget(covariant InteractionCueOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentTarget != widget.currentTarget ||
        oldWidget.isDismissed != widget.isDismissed ||
        oldWidget.gesture != widget.gesture) {
      if (_shouldShow) {
        setState(() {
          _cycles = 0;
        });
        _controller.forward(from: 0.0);
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

  bool get _shouldShow =>
      !widget.isDismissed &&
      widget.gesture != InstructionGesture.none &&
      widget.matchingTargets.contains(widget.currentTarget);

  bool get _isActive => _shouldShow && _cycles < _maxCycles;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final Color cueColor = isLight
        ? const Color(0xFF42A5F5)
        : theme.colorScheme.primary;

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) {
        if (_isActive) {
          widget.onDismiss?.call();
        }
      },
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          widget.child,

          if (_isActive)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final double t = _controller.value;
                    final double pulse = 0.5 + 0.5 * math.sin(t * 2 * math.pi);

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final double width = constraints.maxWidth;
                        final double height = constraints.maxHeight;
                        if (width <= 0 || height <= 0) {
                          return const SizedBox.shrink();
                        }

                        final double squareSize = math.min(width, height);
                        final Offset center = Offset(width * 0.5, height * 0.5);
                        final Rect canvasRect = Rect.fromCenter(
                          center: center,
                          width: squareSize,
                          height: squareSize,
                        );

                        Rect? targetBarRect;
                        if (widget.currentTarget ==
                            InstructionTarget.radonThetaBar) {
                          const double barThickness = 14.0;
                          final double dataHeight = squareSize - barThickness;
                          targetBarRect = Rect.fromLTWH(
                            canvasRect.right - barThickness,
                            canvasRect.top,
                            barThickness,
                            dataHeight,
                          );
                        } else if (widget.currentTarget ==
                            InstructionTarget.radonRBar) {
                          const double barThickness = 14.0;
                          final double dataWidth = squareSize - barThickness;
                          targetBarRect = Rect.fromLTWH(
                            canvasRect.left,
                            canvasRect.bottom - barThickness,
                            dataWidth,
                            barThickness,
                          );
                        }

                        // Border glow or specific bar highlight
                        final Widget highlightWidget = targetBarRect != null
                            ? Positioned.fromRect(
                                rect: targetBarRect.inflate(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: cueColor.withValues(
                                      alpha: 0.25 + 0.35 * pulse,
                                    ),
                                    border: Border.all(
                                      color: cueColor.withValues(
                                        alpha: 0.7 + 0.3 * pulse,
                                      ),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: cueColor.withValues(
                                          alpha: 0.4 * pulse,
                                        ),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Positioned.fromRect(
                                rect: canvasRect,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: cueColor.withValues(
                                        alpha: 0.3 + 0.45 * pulse,
                                      ),
                                      width: 2.5,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              );

                        // Calculate cue pointer location & ripple center
                        Offset pointerPos = center;
                        Offset rippleCenter = center;
                        Offset dragDelta = Offset.zero;

                        if (widget.targetNormalizedPos != null) {
                          final double unitRadius =
                              squareSize * 0.5 - ObjectCanvas.unitMargin;
                          pointerPos = Offset(
                            center.dx +
                                widget.targetNormalizedPos!.dx * unitRadius,
                            center.dy -
                                widget.targetNormalizedPos!.dy * unitRadius,
                          );

                          if (widget.gesture == InstructionGesture.drag) {
                            final double dragProgress = math.sin(
                              t * 2 * math.pi,
                            );
                            dragDelta = Offset(
                              dragProgress * 30.0,
                              -dragProgress * 25.0,
                            );
                            rippleCenter = pointerPos + dragDelta;
                          } else {
                            final double tapProgress = math.sin(t * math.pi);
                            dragDelta = Offset(0, -tapProgress * 6.0);
                            rippleCenter = pointerPos;
                          }
                        } else if (widget.currentTarget ==
                            InstructionTarget.radonThetaBar) {
                          pointerPos = targetBarRect!.center;
                          rippleCenter = targetBarRect.center;
                          if (widget.gesture == InstructionGesture.drag) {
                            dragDelta = Offset(
                              0,
                              math.sin(t * 2 * math.pi) * 35.0,
                            );
                            rippleCenter = pointerPos + dragDelta;
                          } else {
                            final double tapProgress = math.sin(t * math.pi);
                            dragDelta = Offset(-tapProgress * 5.0, 0);
                          }
                        } else if (widget.currentTarget ==
                            InstructionTarget.radonRBar) {
                          pointerPos = targetBarRect!.center;
                          rippleCenter = targetBarRect.center;
                          if (widget.gesture == InstructionGesture.drag) {
                            dragDelta = Offset(
                              math.sin(t * 2 * math.pi) * 35.0,
                              0,
                            );
                            rippleCenter = pointerPos + dragDelta;
                          } else {
                            final double tapProgress = math.sin(t * math.pi);
                            dragDelta = Offset(0, -tapProgress * 5.0);
                          }
                        } else if (widget.gesture == InstructionGesture.drag) {
                          if (widget.dragAxis == Axis.vertical) {
                            dragDelta = Offset(
                              0,
                              math.sin(t * 2 * math.pi) * 30.0,
                            );
                          } else {
                            dragDelta = Offset(
                              math.sin(t * 2 * math.pi) * 30.0,
                              0,
                            );
                          }
                          rippleCenter = pointerPos + dragDelta;
                        } else {
                          final double tapProgress = math.sin(t * math.pi);
                          dragDelta = Offset(0, -tapProgress * 6.0);
                          rippleCenter = pointerPos;
                        }

                        final Offset currentPos = pointerPos + dragDelta;

                        // Tap ripple wave
                        final double rippleScale = 10.0 + 18.0 * t;
                        final double rippleOpacity = (1.0 - t).clamp(0.0, 1.0);

                        return Stack(
                          children: [
                            highlightWidget,

                            // Ripple circle
                            Positioned(
                              left: rippleCenter.dx - rippleScale,
                              top: rippleCenter.dy - rippleScale,
                              child: Container(
                                width: rippleScale * 2,
                                height: rippleScale * 2,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: cueColor.withValues(
                                      alpha: 0.6 * rippleOpacity,
                                    ),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),

                            // Pointer hand icon
                            Positioned(
                              left: currentPos.dx - 12.0,
                              top: currentPos.dy - 12.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.4,
                                      ),
                                      blurRadius: 6,
                                      offset: const Offset(1, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  widget.gesture == InstructionGesture.drag
                                      ? Icons.pan_tool_alt
                                      : Icons.touch_app,
                                  size: 26,
                                  color: cueColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
