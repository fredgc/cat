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

/// Target UI element or canvas region intended for the user's interaction.
enum InstructionTarget {
  none,
  objectCanvas,
  radonCanvas,
  phantomDisk,
  radonThetaBar,
  radonRBar,
  playButton,
}

/// Gesture type demonstrated by the visual cue.
enum InstructionGesture { none, tap, drag }

/// A single interactive instruction step within a stage.
class StageInstruction {
  final String text;
  final String? narrowText;
  final InstructionTarget target;
  final InstructionGesture gesture;
  final Offset? normalizedPosition;
  final Axis? dragAxis;

  const StageInstruction({
    required this.text,
    this.narrowText,
    this.target = InstructionTarget.none,
    this.gesture = InstructionGesture.tap,
    this.normalizedPosition,
    this.dragAxis,
  });

  String textFor({required bool isWide}) =>
      isWide ? text : (narrowText ?? text);
}

/// Metadata definition for each stage of the demonstration narrative.
class StageData {
  final int number;
  final String title;
  final String? narrowTitle;
  final String subtitle;
  final String? narrowSubtitle;
  final String description;
  final String? narrowDescription;
  final List<StageInstruction> instructions;

  const StageData({
    required this.number,
    required this.title,
    this.narrowTitle,
    required this.subtitle,
    this.narrowSubtitle,
    required this.description,
    this.narrowDescription,
    required this.instructions,
  });

  String titleFor({BuildContext? context, required bool isWide}) {
    final canonical = isWide ? title : (narrowTitle ?? title);
    if (context == null ||
        Localizations.localeOf(context).languageCode == 'en') {
      return canonical;
    }
    final l10n = context.l10n;
    switch (number) {
      case 1:
        return isWide ? l10n.stage1Title : l10n.stage1NarrowTitle;
      case 2:
        return isWide ? l10n.stage2Title : l10n.stage2NarrowTitle;
      case 3:
        return l10n.stage3Title;
      case 4:
        return isWide ? l10n.stage4Title : l10n.stage4NarrowTitle;
      case 5:
        return isWide ? l10n.stage5Title : l10n.stage5NarrowTitle;
      case 6:
        return isWide ? l10n.stage6Title : l10n.stage6NarrowTitle;
      default:
        return canonical;
    }
  }

  String subtitleFor({BuildContext? context, required bool isWide}) {
    final canonical = isWide ? subtitle : (narrowSubtitle ?? subtitle);
    if (context == null ||
        Localizations.localeOf(context).languageCode == 'en') {
      return canonical;
    }
    final l10n = context.l10n;
    switch (number) {
      case 1:
        return isWide ? l10n.stage1Subtitle : l10n.stage1NarrowSubtitle;
      case 2:
        return isWide ? l10n.stage2Subtitle : l10n.stage2NarrowSubtitle;
      case 3:
        return isWide ? l10n.stage3Subtitle : l10n.stage3NarrowSubtitle;
      case 4:
        return isWide ? l10n.stage4Subtitle : l10n.stage4NarrowSubtitle;
      case 5:
        return isWide ? l10n.stage5Subtitle : l10n.stage5NarrowSubtitle;
      case 6:
        return isWide ? l10n.stage6Subtitle : l10n.stage6NarrowSubtitle;
      default:
        return canonical;
    }
  }

  String descriptionFor({BuildContext? context, required bool isWide}) {
    final canonical = isWide ? description : (narrowDescription ?? description);
    if (context == null ||
        Localizations.localeOf(context).languageCode == 'en') {
      return canonical;
    }
    final l10n = context.l10n;
    switch (number) {
      case 1:
        return isWide ? l10n.stage1Description : l10n.stage1NarrowDescription;
      case 2:
        return isWide ? l10n.stage2Description : l10n.stage2NarrowDescription;
      case 3:
        return isWide ? l10n.stage3Description : l10n.stage3NarrowDescription;
      case 4:
        return isWide ? l10n.stage4Description : l10n.stage4NarrowDescription;
      case 5:
        return isWide ? l10n.stage5Description : l10n.stage5NarrowDescription;
      case 6:
        return isWide ? l10n.stage6Description : l10n.stage6NarrowDescription;
      default:
        return canonical;
    }
  }

  String interactionHintFor({
    BuildContext? context,
    required bool isWide,
    int stepIndex = 0,
  }) {
    final int safeStep = instructions.isEmpty
        ? 0
        : stepIndex.clamp(0, instructions.length - 1);
    final canonical = instructions.isEmpty
        ? ''
        : instructions[safeStep].textFor(isWide: isWide);
    if (context == null ||
        Localizations.localeOf(context).languageCode == 'en') {
      return canonical;
    }
    final l10n = context.l10n;
    switch (number) {
      case 1:
        return isWide ? l10n.stage1Instruction1 : l10n.stage1NarrowInstruction1;
      case 2:
        switch (stepIndex) {
          case 0:
            return isWide
                ? l10n.stage2Instruction1
                : l10n.stage2NarrowInstruction1;
          case 1:
            return isWide
                ? l10n.stage2Instruction2
                : l10n.stage2NarrowInstruction2;
          case 2:
            return isWide
                ? l10n.stage2Instruction3
                : l10n.stage2NarrowInstruction3;
          default:
            return isWide
                ? l10n.stage2Instruction1
                : l10n.stage2NarrowInstruction1;
        }
      case 3:
        switch (stepIndex) {
          case 0:
            return isWide
                ? l10n.stage3Instruction1
                : l10n.stage3NarrowInstruction1;
          case 1:
            return isWide
                ? l10n.stage3Instruction2
                : l10n.stage3NarrowInstruction2;
          case 2:
            return isWide
                ? l10n.stage3Instruction3
                : l10n.stage3NarrowInstruction3;
          default:
            return isWide
                ? l10n.stage3Instruction1
                : l10n.stage3NarrowInstruction1;
        }
      case 4:
        switch (stepIndex) {
          case 0:
            return isWide
                ? l10n.stage4Instruction1
                : l10n.stage4NarrowInstruction1;
          case 1:
            return isWide
                ? l10n.stage4Instruction2
                : l10n.stage4NarrowInstruction2;
          default:
            return isWide
                ? l10n.stage4Instruction1
                : l10n.stage4NarrowInstruction1;
        }
      case 5:
        switch (stepIndex) {
          case 0:
            return isWide
                ? l10n.stage5Instruction1
                : l10n.stage5NarrowInstruction1;
          case 1:
            return isWide
                ? l10n.stage5Instruction2
                : l10n.stage5NarrowInstruction2;
          case 2:
            return isWide
                ? l10n.stage5Instruction3
                : l10n.stage5NarrowInstruction3;
          case 3:
            return canonical;
          default:
            return canonical;
        }
      case 6:
        switch (stepIndex) {
          case 0:
            return isWide
                ? l10n.stage6Instruction1
                : l10n.stage6NarrowInstruction1;
          case 1:
            return isWide
                ? l10n.stage6Instruction2
                : l10n.stage6NarrowInstruction2;
          default:
            return isWide
                ? l10n.stage6Instruction1
                : l10n.stage6NarrowInstruction1;
        }
      default:
        return canonical;
    }
  }
}

/// The 6 pedagogical stages of the demonstration.
const List<StageData> demoStages = [
  StageData(
    number: 1,
    title: 'Computed Axial Tomography',
    narrowTitle: 'Tomography Overview',
    subtitle: 'Overview & The Radon Transform',
    narrowSubtitle: 'Overview & Radon Transform',
    description:
        'An X-Ray CAT scan (Computed Axial Tomography) non-invasively reconstructs '
        'the 2D interior of an object by transmitting X-ray beams through it from all '
        'angles θ. Detectors measure transmitted intensity, which by the Beer-Lambert '
        'law yields the mathematical line integral of the absorption coefficient f(x, y) '
        'along each line L: g(L) = ∫_L f ds. The core tomography challenge is inverting '
        'these line integrals to recover the interior.',
    narrowDescription:
        'A CAT scan reconstructs the 2D interior of an object non-invasively by '
        'transmitting X-rays through it at many angles θ. Detectors measure absorbed '
        'intensity, yielding the line integral of absorption f(x, y) along each line L: '
        'g(L) = ∫_L f ds.',
    instructions: [
      StageInstruction(
        text: "Click 'Next' above to continue to the next stage.",
        narrowText: "Tap 'Next' above to continue to the next stage.",
        target: InstructionTarget.none,
        gesture: InstructionGesture.none,
      ),
    ],
  ),
  StageData(
    number: 2,
    title: 'Object on Left, Data on Right',
    narrowTitle: 'Object on Top, Data on Bottom',
    subtitle: 'Line Parameterization: x·cos(θ) + y·sin(θ) = r',
    narrowSubtitle: 'Line Equation: x·cos(θ) + y·sin(θ) = r',
    description:
        'Every straight line in 2D space is parameterized by two variables: its signed '
        'perpendicular distance r from the origin, and its normal angle θ: '
        'x·cos(θ) + y·sin(θ) = r. The left viewport displays physical Object Space (x, y), '
        'and the right viewport displays Sinogram Space (r, θ). Each individual point '
        '(r, θ) in sinogram space represents a complete straight X-ray line traversing '
        'object space.',
    narrowDescription:
        'Every straight line in the plane is parameterized by its signed perpendicular distance '
        'r from the origin and normal angle θ: x·cos(θ) + y·sin(θ) = r. A single point (r, θ) '
        'in the bottom canvas represents a complete line traversing object space on the top.',
    instructions: [
      StageInstruction(
        text: 'Step 1 of 3: Click or drag anywhere in the Sinogram on the right to see the corresponding line x·cos(θ) + y·sin(θ) = r and normal on the left.',
        narrowText: 'Step 1 of 3: Click or drag in the Sinogram on the bottom to see the corresponding line and normal on the top.',
        target: InstructionTarget.radonCanvas,
        gesture: InstructionGesture.tap,
      ),
      StageInstruction(
        text: 'Step 2 of 3: Drag left and right in the Sinogram to vary radial distance r (-1 to 1). Notice how the line translates in Object Space.',
        narrowText: 'Step 2 of 3: Drag left and right in the Sinogram to vary radial distance r (-1 to 1). Notice the line translation.',
        target: InstructionTarget.radonCanvas,
        gesture: InstructionGesture.drag,
        dragAxis: Axis.horizontal,
      ),
      StageInstruction(
        text: 'Step 3 of 3: Drag up and down in the Sinogram to vary angle θ (0 to 2π). Notice how the line rotates in Object Space.',
        narrowText: 'Step 3 of 3: Drag up and down in the Sinogram to vary angle θ (0 to 2π). Notice the line rotation.',
        target: InstructionTarget.radonCanvas,
        gesture: InstructionGesture.drag,
        dragAxis: Axis.vertical,
      ),
    ],
  ),
  StageData(
    number: 3,
    title: 'Point Duality',
    subtitle: 'Points in Object Space Trace Sinusoids in Sinogram Space',
    narrowSubtitle: 'Points Trace Sinusoids in Sinogram',
    description:
        'All lines passing through a single fixed point (x, y) satisfy r(θ) = x·cos(θ) + y·sin(θ). '
        'As the projection angle θ varies from 0 to 2π, this family of lines forms an exact sinusoidal '
        'wave in (r, θ) sinogram space. This duality is fundamental: a point in object space maps to a '
        'sinusoid in sinogram space, while a point in sinogram space maps to a line in object space. '
        'Clicking the border bars shows lines with constant θ or constant r.',
    narrowDescription:
        'Every line passing through a fixed point (x, y) satisfies r(θ) = x·cos(θ) + y·sin(θ). '
        'As θ varies from 0 to 2π, this family of lines forms an exact sinusoidal wave in (r, θ) space.',
    instructions: [
      StageInstruction(
        text: 'Step 1 of 3: Click or drag in Object Space on the left to move the probe point and watch its sinusoidal dual curve on the right.',
        narrowText: 'Step 1 of 3: Click or drag in Object Space on the top to move the probe point and watch its sinusoidal dual curve on the bottom.',
        target: InstructionTarget.objectCanvas,
        gesture: InstructionGesture.drag,
      ),
      StageInstruction(
        text: 'Step 2 of 3: Click the right border bar in the Sinogram to display a family of parallel lines across all r at fixed angle θ.',
        narrowText: 'Step 2 of 3: Click the right border bar in the Sinogram to display a family of parallel lines at fixed angle θ.',
        target: InstructionTarget.radonThetaBar,
        gesture: InstructionGesture.tap,
      ),
      StageInstruction(
        text: 'Step 3 of 3: Click the bottom border bar in the Sinogram to view lines tangent to a concentric circle of radius |r|.',
        narrowText: 'Step 3 of 3: Click the bottom border bar in the Sinogram to view lines tangent to a circle of radius |r|.',
        target: InstructionTarget.radonRBar,
        gesture: InstructionGesture.tap,
      ),
    ],
  ),
  StageData(
    number: 4,
    title: 'Object Produces Shadow',
    narrowTitle: 'Object Shadow',
    subtitle: 'The Phantom Object & Its 2D Sinogram Shadow',
    narrowSubtitle: 'Phantom & 2D Sinogram Shadow',
    description:
        'A phantom object—a circular disk simulating interior structure—is placed in object space. '
        'Its X-ray attenuation creates a 2D shadow dataset g(r, θ) called a sinogram. There is faint '
        'intensity when an X-ray only skims the disk edge, and strong intensity when it passes through '
        'the diameter. Dragging the phantom shifts the amplitude and phase of its sinusoidal shadow band.',
    narrowDescription:
        'A phantom object (circular disk) is placed in object space. Its X-ray projections form a 2D '
        'shadow dataset g(r, θ) known as a sinogram. Dragging the phantom shifts its shadow band.',
    instructions: [
      StageInstruction(
        text: 'Step 1 of 2: Drag the red phantom disk in Object Space on the left to reposition it.',
        narrowText: 'Step 1 of 2: Drag the red phantom disk in Object Space on the top to reposition it.',
        target: InstructionTarget.phantomDisk,
        gesture: InstructionGesture.drag,
      ),
      StageInstruction(
        text: 'Step 2 of 2: Observe how the phantom’s 2D sinogram shadow immediately shifts on the right, encoding its location.',
        narrowText: 'Step 2 of 2: Observe how the phantom’s sinogram shadow shifts on the bottom as you drag.',
        target: InstructionTarget.radonCanvas,
        gesture: InstructionGesture.none,
      ),
    ],
  ),
  StageData(
    number: 5,
    title: 'Cross Section of Data',
    narrowTitle: 'Cross Section',
    subtitle: '1D Profiles & Unfiltered Backprojection',
    narrowSubtitle: '1D Profiles & Backprojection',
    description:
        'The bottom graph displays 1D cross-sections of the sinogram g(r, θ). In particular, examining '
        'projections along the sinusoidal curve of a point (x, y) and summing them over all angles θ '
        'is called backprojection: ∫₀²π g(x·cos θ + y·sin θ, θ) dθ. If the point lies inside the phantom '
        'disk, the integral is large; if outside, it is small. However, unfiltered backprojection '
        'blurs features by a 1/|r| point-spread function.',
    narrowDescription:
        'The bottom graph displays the 1D cross section of g(r, θ) along the probe trajectory. '
        'Summing these projections over all angles (backprojection) yields a large integral inside '
        'the phantom and a smaller integral outside, but unfiltered backprojection produces a blurry 1/|r| image.',
    instructions: [
      StageInstruction(
        text:
            'Step 1 of 4: Drag the probe inside the phantom disk on the left. '
            'Notice how the backprojection integral on the bottom graph increases.',
        narrowText:
            'Step 1 of 4: Drag the probe inside the phantom disk on the top. '
            'Notice how the backprojection integral increases.',
        target: InstructionTarget.objectCanvas,
        gesture: InstructionGesture.drag,
        normalizedPosition: Offset(-0.4, -0.4),
      ),
      StageInstruction(
        text:
            'Step 2 of 4: Click anywhere in the Sinogram to select a single X-ray ray. '
            'Notice the green pulse showing absorption intensity along that ray.',
        narrowText:
            'Step 2 of 4: Click in the Sinogram to select a single ray. '
            'Notice the green pulse showing absorption intensity along that ray.',
        target: InstructionTarget.radonCanvas,
        gesture: InstructionGesture.tap,
      ),
      StageInstruction(
        text:
            'Step 3 of 4: Click the right border bar in the Sinogram to view '
            'a parallel family of X-rays across all r at fixed angle θ (cyan curve).',
        narrowText:
            'Step 3 of 4: Click the right border bar in the Sinogram to view '
            'a parallel family of X-rays at fixed angle θ (cyan curve).',
        target: InstructionTarget.radonThetaBar,
        gesture: InstructionGesture.tap,
      ),
      StageInstruction(
        text:
            'Step 4 of 4: Click "Play Scan" or press [Space] to sweep the parallel family '
            'across all angles θ, animating the live 1D projection curve.',
        narrowText:
            'Step 4 of 4: Tap "Play Scan" to sweep the parallel family '
            'across all angles θ, animating the live 1D projection curve.',
        target: InstructionTarget.playButton,
        gesture: InstructionGesture.tap,
      ),
    ],
  ),
  StageData(
    number: 6,
    title: 'Filtered Data Reconstruction',
    narrowTitle: 'Filtered Reconstruction',
    subtitle: 'Filtered Backprojection (FBP) with Natterer Ramp Kernel',
    narrowSubtitle: 'Filtered Backprojection (FBP)',
    description:
        'To remove the 1/|r| blur, projections are filtered before backprojection (Filtered Backprojection, FBP). '
        'Convolving each projection with Frank Natterer’s discrete ramp filter kernel w_b(l) = b² / (π⁴(1 - 4l²)) '
        'acts like an edge-sharpening derivative filter that adds negative side lobes. When backprojected, '
        'these negative lobes cancel the smearing exactly, yielding precise interior attenuation: '
        '≈ 1.0 inside the phantom disk and ≈ 0.0 outside.',
    narrowDescription:
        'High-pass filtering the projections with Frank Natterer’s discrete filter kernel w_b(l) = b² / (π⁴(1 - 4l²)) '
        'sharpens the sinogram. Backprojecting the filtered data reconstructs the exact interior attenuation values: '
        '≈ 1.0 inside the phantom and ≈ 0.0 outside.',
    instructions: [
      StageInstruction(
        text:
            'Step 1 of 3: Check the bottom graph for the parallel family: '
            'the orange curve shows the filtered result with sharp negative lobes that cancel blur.',
        narrowText:
            'Step 1 of 3: The bottom graph displays the orange filtered curve '
            'with sharp negative lobes that cancel out blur.',
        target: InstructionTarget.radonThetaBar,
        gesture: InstructionGesture.tap,
      ),
      StageInstruction(
        text:
            'Step 2 of 3: Click "Play Scan" or press [Space] to watch the filtered projections '
            'dynamically sweep as the projection angle rotates.',
        narrowText:
            'Step 2 of 3: Tap "Play Scan" to watch the filtered projections '
            'dynamically sweep as the projection angle rotates.',
        target: InstructionTarget.playButton,
        gesture: InstructionGesture.tap,
      ),
      StageInstruction(
        text:
            'Step 3 of 3: Click probe points in Object Space. '
            'Notice that filtered backprojection reconstructs exact interior attenuation: ≈ 1.0 inside and ≈ 0.0 outside.',
        narrowText:
            'Step 3 of 3: Tap probe points in Object Space. '
            'Filtered backprojection reconstructs exact attenuation: ≈ 1.0 inside and ≈ 0.0 outside.',
        target: InstructionTarget.objectCanvas,
        gesture: InstructionGesture.tap,
        normalizedPosition: Offset(0.2, 0.3),
      ),
    ],
  ),
  StageData(
    number: 7,
    title: 'Free Play & Custom Phantoms',
    narrowTitle: 'Free Play',
    subtitle: 'Construct Multi-Phantom Scenes and Explore Reconstruction',
    narrowSubtitle: 'Multi-Phantom Sandbox',
    description:
        'In Free Play mode, design your own scenes using multiple phantom disks. '
        'Add disks with "+", drag them into position, and observe how each disk '
        'contributes an additive sinusoidal band to the sinogram. '
        'Use Filtered Backprojection to reconstruct your custom scenes and verify interior densities.',
    narrowDescription:
        'Design custom scenes with multiple phantom disks. '
        'Use "+" to add disks, drag them into position, and explore their additive sinograms '
        'and filtered backprojection reconstruction.',
    instructions: [
      StageInstruction(
        text:
            'Step 1 of 3: Tap "+ Add" in the top-right of Object Space to create additional phantom disks. '
            'Select and drag disks to position them anywhere inside the circle.',
        narrowText:
            'Step 1 of 3: Tap "+ Add" in Object Space to create phantom disks. '
            'Drag them into position inside the circle.',
        target: InstructionTarget.objectCanvas,
        gesture: InstructionGesture.tap,
      ),
      StageInstruction(
        text:
            'Step 2 of 3: Inspect the Sinogram. Notice how each phantom generates its own sinusoidal trace, '
            'and overlapping areas sum linearly.',
        narrowText: 'Step 2 of 3: Inspect the Sinogram to see how multiple phantoms sum linearly in Radon space.',
        target: InstructionTarget.radonCanvas,
        gesture: InstructionGesture.tap,
      ),
      StageInstruction(
        text:
            'Step 3 of 3: Switch to "Probe" mode in Object Space to test point backprojections. '
            'Toggle the Filter [F] to observe how negative lobes reconstruct each individual phantom.',
        narrowText: 'Step 3 of 3: Switch to "Probe" mode and toggle Filter [F] to reconstruct your custom phantoms.',
        target: InstructionTarget.objectCanvas,
        gesture: InstructionGesture.tap,
      ),
    ],
  ),
];

/// Stage navigation stepper widget with interactive buttons, indicators, and shortcuts hints.
class StageStepper extends StatefulWidget {
  final int currentStageIndex;
  final ValueChanged<int> onStageSelected;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  final bool? isWide;
  final int currentInstructionStep;
  final ValueChanged<int>? onInstructionStepChanged;
  final VoidCallback? onReplayCue;

  const StageStepper({
    super.key,
    required this.currentStageIndex,
    required this.onStageSelected,
    this.onPrev,
    this.onNext,
    this.isWide,
    this.currentInstructionStep = 0,
    this.onInstructionStepChanged,
    this.onReplayCue,
  });

  @override
  State<StageStepper> createState() => _StageStepperState();
}

class _StageStepperState extends State<StageStepper> {
  bool _isExpanded = true;
  int _localInstructionIndex = 0;

  int get _activeStepIndex => widget.onInstructionStepChanged != null
      ? widget.currentInstructionStep
      : _localInstructionIndex;

  void _setStepIndex(int newIndex) {
    if (widget.onInstructionStepChanged != null) {
      widget.onInstructionStepChanged!(newIndex);
    } else {
      setState(() {
        _localInstructionIndex = newIndex;
      });
    }
  }

  @override
  void didUpdateWidget(covariant StageStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStageIndex != widget.currentStageIndex) {
      _localInstructionIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stage = demoStages[widget.currentStageIndex];
    final wide = widget.isWide ?? (MediaQuery.sizeOf(context).width > 700);
    final int instructionCount = stage.instructions.length;
    final int activeInstructionIndex = _activeStepIndex.clamp(
      0,
      math.max(0, instructionCount - 1),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Navigation toolbar
        Container(
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.35,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              FilledButton.tonalIcon(
                icon: const Icon(Icons.arrow_back, size: 16),
                label: Text(context.l10n.previous),
                onPressed: widget.onPrev,
              ),
              const SizedBox(width: 8),
              FilledButton.tonalIcon(
                icon: const Icon(Icons.arrow_forward, size: 16),
                label: Text(context.l10n.next),
                onPressed: widget.onNext,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(demoStages.length, (idx) {
                      final isSelected = idx == widget.currentStageIndex;
                      final stg = demoStages[idx];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: ChoiceChip(
                          label: Text('${stg.number}'),
                          selected: isSelected,
                          onSelected: (_) => widget.onStageSelected(idx),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Narrative card with stage subtitle, main text explanation, and interactive action prompt
        Card(
          margin: const EdgeInsets.fromLTRB(10, 8, 10, 4),
          elevation: 0,
          color: theme.colorScheme.surfaceContainerHigh,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: wide ? double.infinity : (_isExpanded ? 180 : 90),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              context.l10n.stageIndicator(stage.number),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              stage.subtitleFor(context: context, isWide: wide),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: theme.colorScheme.primary,
                              ),
                              softWrap: true,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Tooltip(
                            message: _isExpanded
                                ? context.l10n.collapseMainTextTooltip
                                : context.l10n.expandMainTextTooltip,
                            child: Icon(
                              _isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              size: 20,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isExpanded) ...[
                    const SizedBox(height: 6),
                    Text(
                      stage.descriptionFor(context: context, isWide: wide),
                      style: const TextStyle(fontSize: 13, height: 1.35),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.touch_app,
                              size: 16,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                stage.interactionHintFor(
                                  context: context,
                                  isWide: wide,
                                  stepIndex: activeInstructionIndex,
                                ),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                            if (instructionCount > 1) ...[
                              const SizedBox(width: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 24,
                                      minHeight: 24,
                                    ),
                                    iconSize: 18,
                                    tooltip: context.l10n.previousStepTooltip,
                                    icon: const Icon(Icons.chevron_left),
                                    onPressed: activeInstructionIndex > 0
                                        ? () => _setStepIndex(
                                            activeInstructionIndex - 1,
                                          )
                                        : null,
                                  ),
                                  Text(
                                    '${activeInstructionIndex + 1}/$instructionCount',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 24,
                                      minHeight: 24,
                                    ),
                                    iconSize: 18,
                                    tooltip: context.l10n.nextStepTooltip,
                                    icon: const Icon(Icons.chevron_right),
                                    onPressed:
                                        activeInstructionIndex <
                                            instructionCount - 1
                                        ? () => _setStepIndex(
                                            activeInstructionIndex + 1,
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ],
                            if (widget.onReplayCue != null) ...[
                              const SizedBox(width: 4),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 24,
                                  minHeight: 24,
                                ),
                                iconSize: 18,
                                tooltip: context.l10n.replayAnimationCueTooltip,
                                icon: const Icon(Icons.play_circle_outline),
                                onPressed: widget.onReplayCue,
                              ),
                            ],
                          ],
                        ),
                        if (instructionCount > 1) ...[
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(instructionCount, (dotIdx) {
                              final bool isCurrent =
                                  dotIdx == activeInstructionIndex;
                              return GestureDetector(
                                onTap: () => _setStepIndex(dotIdx),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 3.0,
                                  ),
                                  width: isCurrent ? 14.0 : 6.0,
                                  height: 5.0,
                                  decoration: BoxDecoration(
                                    color: isCurrent
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.primary.withValues(
                                            alpha: 0.3,
                                          ),
                                    borderRadius: BorderRadius.circular(2.5),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
