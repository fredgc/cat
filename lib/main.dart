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

import 'l10n/l10n_extension.dart';
import 'models/radon_engine.dart';
import 'my_app.dart';

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'settings.dart';
import 'web_cache.dart';
import 'widgets/about_dialog.dart';
import 'widgets/graph_canvas.dart';
import 'widgets/interaction_cue_overlay.dart';
import 'widgets/object_canvas.dart';
import 'widgets/radon_canvas.dart';
import 'widgets/stage_stepper.dart';

export 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    unawaited(() async {
      try {
        final info = await PackageInfo.fromPlatform();
        final ver = info.buildNumber.isNotEmpty
            ? '${info.version}+${info.buildNumber}'
            : info.version;
        await checkServerVersionAndReload(ver);
      } catch (_) {}
    }());
  }
  await LocaleController.initialize();
  runApp(const CatApp());
}

class CatScanHomePage extends StatefulWidget {
  final AppSettings? settings;

  const CatScanHomePage({super.key, this.settings});

  @override
  State<CatScanHomePage> createState() => _CatScanHomePageState();
}

class _CatScanHomePageState extends State<CatScanHomePage>
    with SingleTickerProviderStateMixin {
  int _currentStageIndex = 0;
  int _currentInstructionStep = 0;
  bool _cueDismissed = false;
  bool _filtered = false;
  late final AppSettings _settings;
  late RadonEngine _engine;
  late final AnimationController _rotationController;
  int _lastResolution = 50;

  @override
  void initState() {
    super.initState();
    _settings = widget.settings ?? AppSettings();
    _lastResolution = _settings.resolution;
    _engine = RadonEngine(p: _settings.p, q: _settings.q);
    _settings.addListener(_onSettingsChanged);
    _rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 12))
          ..addListener(() {
            if (_rotationController.isAnimating) {
              final int thetaIdx =
                  (_rotationController.value * _engine.numAngles).floor() %
                  _engine.numAngles;
              if (thetaIdx != _engine.probeThetaIndex) {
                _engine.setProbeTheta(thetaIdx);
              }
            }
          });
    _applyStageConfig(_currentStageIndex);
  }

  void _onSettingsChanged() {
    if (_settings.resolution != _lastResolution) {
      _lastResolution = _settings.resolution;
      final oldMode = _engine.probeMode;
      final oldX = _engine.probeX;
      final oldY = _engine.probeY;
      final phantoms = _engine.phantoms;
      _engine.dispose();
      _engine = RadonEngine(
        p: _settings.p,
        q: _settings.q,
        phantoms: phantoms,
        initialFiltered: _filtered,
        initialProbeMode: oldMode,
      );
      if (oldMode == ProbeMode.point) {
        _engine.setProbePoint(oldX, oldY);
      }
      setState(() {});
    } else {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _settings.removeListener(_onSettingsChanged);
    _rotationController.dispose();
    _engine.dispose();
    super.dispose();
  }

  StageData get currentStage => demoStages[_currentStageIndex];

  void _applyStageConfig(int index) {
    final int stageNum = index + 1;
    switch (stageNum) {
      case 1:
        _filtered = false;
        _engine.setProbeMode(ProbeMode.none);
        _engine.setFiltered(false);
        _engine.setObjectInteractionMode(ObjectInteractionMode.probe);
        break;
      case 2:
        _filtered = false;
        _engine.setProbeSinogram(_engine.q, 0);
        _engine.setFiltered(false);
        _engine.setObjectInteractionMode(ObjectInteractionMode.probe);
        break;
      case 3:
        _filtered = false;
        _engine.setProbePoint(0.2, 0.3);
        _engine.setFiltered(false);
        _engine.setObjectInteractionMode(ObjectInteractionMode.probe);
        break;
      case 4:
        _filtered = false;
        _engine.setProbeMode(ProbeMode.none);
        _engine.setFiltered(false);
        _engine.setObjectInteractionMode(ObjectInteractionMode.phantom);
        break;
      case 5:
        _filtered = false;
        _engine.setProbePoint(-0.4, -0.4);
        _engine.setFiltered(false);
        _engine.setObjectInteractionMode(ObjectInteractionMode.probe);
        break;
      case 6:
        _filtered = true;
        _engine.setProbePoint(0.2, 0.3);
        _engine.setFiltered(true);
        _engine.setObjectInteractionMode(ObjectInteractionMode.probe);
        break;
      case 7:
        _filtered = true;
        _engine.setProbePoint(0.2, 0.3);
        _engine.setFiltered(true);
        _engine.setObjectInteractionMode(ObjectInteractionMode.phantom);
        break;
    }
  }

  void _nextStage() {
    if (_currentStageIndex < demoStages.length - 1) {
      _setStage(_currentStageIndex + 1);
    }
  }

  void _prevStage() {
    if (_currentStageIndex > 0) {
      _setStage(_currentStageIndex - 1);
    }
  }

  void _advanceStepOrStage() {
    final int instructionCount = currentStage.instructions.length;
    if (_currentInstructionStep < instructionCount - 1) {
      setState(() {
        _currentInstructionStep++;
        _cueDismissed = false;
      });
    } else {
      _nextStage();
    }
  }

  void _setStage(int index) {
    if (index >= 0 && index < demoStages.length) {
      if (_rotationController.isAnimating) {
        _rotationController.stop();
      }
      setState(() {
        _currentStageIndex = index;
        _currentInstructionStep = 0;
        _cueDismissed = false;
        _applyStageConfig(index);
      });
    }
  }

  void _toggleRotation() {
    setState(() {
      if (_rotationController.isAnimating) {
        _rotationController.stop();
      } else {
        if (_engine.probeMode != ProbeMode.theta) {
          _engine.setProbeTheta(_engine.probeThetaIndex);
        }
        _rotationController.repeat();
        _cueDismissed = true;
      }
    });
  }

  void _toggleFiltered() {
    setState(() {
      _filtered = !_filtered;
      _engine.setFiltered(_filtered);
    });
  }

  @override
  Widget build(BuildContext context) {
    final stage = currentStage;
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.arrowLeft): _prevStage,
        const SingleActivator(LogicalKeyboardKey.arrowRight): _nextStage,
        const SingleActivator(LogicalKeyboardKey.keyP): _prevStage,
        const SingleActivator(LogicalKeyboardKey.keyN): _nextStage,
        const SingleActivator(LogicalKeyboardKey.enter): _advanceStepOrStage,
        const SingleActivator(LogicalKeyboardKey.numpadEnter):
            _advanceStepOrStage,
        const SingleActivator(LogicalKeyboardKey.digit1): () => _setStage(0),
        const SingleActivator(LogicalKeyboardKey.digit2): () => _setStage(1),
        const SingleActivator(LogicalKeyboardKey.digit3): () => _setStage(2),
        const SingleActivator(LogicalKeyboardKey.digit4): () => _setStage(3),
        const SingleActivator(LogicalKeyboardKey.digit5): () => _setStage(4),
        const SingleActivator(LogicalKeyboardKey.digit6): () => _setStage(5),
        const SingleActivator(LogicalKeyboardKey.digit7): () => _setStage(6),
        const SingleActivator(LogicalKeyboardKey.numpad1): () => _setStage(0),
        const SingleActivator(LogicalKeyboardKey.numpad2): () => _setStage(1),
        const SingleActivator(LogicalKeyboardKey.numpad3): () => _setStage(2),
        const SingleActivator(LogicalKeyboardKey.numpad4): () => _setStage(3),
        const SingleActivator(LogicalKeyboardKey.numpad5): () => _setStage(4),
        const SingleActivator(LogicalKeyboardKey.numpad6): () => _setStage(5),
        const SingleActivator(LogicalKeyboardKey.numpad7): () => _setStage(6),
        const SingleActivator(LogicalKeyboardKey.space): _toggleRotation,
        const SingleActivator(LogicalKeyboardKey.keyF): _toggleFiltered,
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: AppBar(
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                context.l10n.stageTitle(
                  stage.number,
                  stage.titleFor(context: context, isWide: isWide),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            actions: [
              Row(
                children: [
                  Checkbox(
                    value: _filtered,
                    onChanged: (val) {
                      final bool newVal = val ?? false;
                      setState(() {
                        _filtered = newVal;
                        _engine.setFiltered(newVal);
                      });
                    },
                  ),
                  Text(
                    isWide
                        ? context.l10n.filteredCheckboxWide
                        : context.l10n.filteredCheckbox,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
              PopupMenuButton<Locale>(
                icon: const Icon(Icons.language_rounded),
                tooltip: context.l10n.switchLanguageTooltip,
                initialValue:
                    LocaleController.currentLocale.value ??
                    LocaleController.autoLocale,
                onSelected: (loc) => LocaleController.setLocale(loc),
                itemBuilder: (context) => [
                  CheckedPopupMenuItem<Locale>(
                    value: LocaleController.autoLocale,
                    checked: LocaleController.currentLocale.value == null,
                    child: Text(context.l10n.languageAuto),
                  ),
                  ...LocaleController.supportedLocales.map(
                    (locale) => CheckedPopupMenuItem<Locale>(
                      value: locale,
                      checked:
                          LocaleController.currentLocale.value?.languageCode ==
                          locale.languageCode,
                      child: Text(LocaleController.languageDisplayName(locale)),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                tooltip: context.l10n.settingsTooltip,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => SettingsDialog(settings: _settings),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip: context.l10n.aboutTooltip,
                onPressed: () {
                  showAppAboutDialog(context);
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: Builder(
              builder: (context) {
                final activeInstruction = stage.instructions.isNotEmpty
                    ? stage.instructions[_currentInstructionStep.clamp(
                        0,
                        stage.instructions.length - 1,
                      )]
                    : null;
                final currentTarget =
                    activeInstruction?.target ?? InstructionTarget.none;
                final currentGesture =
                    activeInstruction?.gesture ?? InstructionGesture.tap;
                final targetPos =
                    activeInstruction?.normalizedPosition ??
                    (currentTarget == InstructionTarget.phantomDisk
                        ? Offset(_engine.phantom.x, _engine.phantom.y)
                        : null);

                return Column(
                  children: [
                    // Stage navigation stepper and narrative card
                    StageStepper(
                      currentStageIndex: _currentStageIndex,
                      onStageSelected: _setStage,
                      onPrev: _currentStageIndex > 0 ? _prevStage : null,
                      onNext: _currentStageIndex < demoStages.length - 1
                          ? _nextStage
                          : null,
                      isWide: isWide,
                      currentInstructionStep: _currentInstructionStep,
                      onInstructionStepChanged: (step) {
                        setState(() {
                          _currentInstructionStep = step;
                          _cueDismissed = false;
                        });
                      },
                      onReplayCue: () {
                        setState(() {
                          _cueDismissed = false;
                        });
                      },
                    ),

                    // Canvases viewports
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final showPhantom = stage.number >= 4;
                          final showSinogram = stage.number >= 4;

                          final objectView = Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InteractionCueOverlay(
                              currentTarget: currentTarget,
                              matchingTargets: const {
                                InstructionTarget.objectCanvas,
                                InstructionTarget.phantomDisk,
                              },
                              gesture: currentGesture,
                              isDismissed: _cueDismissed,
                              targetNormalizedPos: targetPos,
                              dragAxis: activeInstruction?.dragAxis,
                              onDismiss: () =>
                                  setState(() => _cueDismissed = true),
                              child: ObjectCanvas(
                                engine: _engine,
                                showPhantom: showPhantom,
                                showGuides: _settings.showGuides,
                              ),
                            ),
                          );

                          final radonView = Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InteractionCueOverlay(
                              currentTarget: currentTarget,
                              matchingTargets: const {
                                InstructionTarget.radonCanvas,
                                InstructionTarget.radonThetaBar,
                                InstructionTarget.radonRBar,
                              },
                              gesture: currentGesture,
                              isDismissed: _cueDismissed,
                              dragAxis: activeInstruction?.dragAxis,
                              onDismiss: () =>
                                  setState(() => _cueDismissed = true),
                              child: RadonCanvas(
                                engine: _engine,
                                showSinogram: showSinogram,
                                colormap: _settings.colormap,
                              ),
                            ),
                          );

                          // In Stage 1, display only Object Space diagram. Sinogram is introduced in Stage 2.
                          if (stage.number == 1) {
                            return Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 600,
                                  maxHeight: 600,
                                ),
                                child: objectView,
                              ),
                            );
                          }

                          if (isWide) {
                            return Row(
                              children: [
                                Expanded(child: objectView),
                                const VerticalDivider(width: 1),
                                Expanded(child: radonView),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                Expanded(child: objectView),
                                const Divider(height: 1),
                                Expanded(child: radonView),
                              ],
                            );
                          }
                        },
                      ),
                    ),

                    // Bottom 1D profile graph (visible in stages 5 and 6)
                    if (stage.number >= 5)
                      GraphCanvas(
                        engine: _engine,
                        height: 130,
                        isRotating: _rotationController.isAnimating,
                        onToggleRotation: _toggleRotation,
                        currentTarget: currentTarget,
                        isCueDismissed: _cueDismissed,
                        onDismissCue: () =>
                            setState(() => _cueDismissed = true),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
