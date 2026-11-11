// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get aboutAuthor =>
      'Original Java Applet presented as a talk at Ball State University February 26, 1998 by Fred Gylys-Colwell';

  @override
  String get aboutSummary =>
      'An interactive visualization of the Radon Transform, line integrals, sinogram duality, and Frank Natterer’s Filtered Backprojection (FBP).';

  @override
  String get aboutTooltip => 'About';

  @override
  String get appTitle => 'CAT Scan Demonstration';

  @override
  String get close => 'Close';

  @override
  String get collapseMainTextTooltip => 'Collapse main text';

  @override
  String get colormapClassic => 'Classic (1998 Java)';

  @override
  String get colormapGrayscale => 'Grayscale (Medical CT)';

  @override
  String get colormapInferno => 'Inferno';

  @override
  String get colormapSection => 'Sinogram Colormap';

  @override
  String get colormapViridis => 'Viridis';

  @override
  String get done => 'Done';

  @override
  String get expandMainTextTooltip => 'Expand main text';

  @override
  String get filteredCheckbox => 'Filter';

  @override
  String get filteredCheckboxWide => 'Filtered Sinogram [F]';

  @override
  String get githubButton => 'GitHub (fredgc/cat)';

  @override
  String get graphCanvasSemantics =>
      '1D profile plot showing cross sections and backprojection integral.';

  @override
  String get graphFilteredPrefix => 'Filtered wb * g: ';

  @override
  String graphLineTrajectory(String r, String theta, String val) {
    return 'Ray Absorption (Green) | Line (r = $r, θ = $theta) | Total Absorption: $val';
  }

  @override
  String graphPointTrajectory(
    String prefix,
    String x,
    String y,
    String val,
    String status,
  ) {
    return '${prefix}Point Trajectory ($x, $y) | Integral over θ: $val $status';
  }

  @override
  String get graphSelectPrompt =>
      'Select a point or line to display 1D cross section.';

  @override
  String graphSlineTrajectory(String prefix, String r, String val) {
    return '${prefix}Tangent slice at radius r = $r | Integral: $val';
  }

  @override
  String graphThetaTrajectory(String prefix, String theta, String val) {
    return '${prefix}Projection slice at θ = $theta rad | Integral: $val';
  }

  @override
  String get graphUnfilteredPrefix => 'Unfiltered: ';

  @override
  String get insidePhantom => '(inside phantom)';

  @override
  String get issuesButton => 'Issues';

  @override
  String get keyboardShortcutsList =>
      '• [Enter]: Advance instruction step or next stage\n• [N] / [→]: Next stage\n• [P] / [←]: Previous stage\n• [1] - [7]: Jump to stage 1 through 7\n• [Space]: Play / Pause angle sweep rotation\n• [F]: Toggle filtered reconstruction mode';

  @override
  String get keyboardShortcutsTitle => 'Keyboard Shortcuts:';

  @override
  String get languageAuto => 'Auto (System)';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get next => 'Next';

  @override
  String get nextStepTooltip => 'Next instruction step';

  @override
  String get objectCanvasSemantics =>
      'Object space viewport. Interactive coordinate plane showing X-ray projection lines and phantom.';

  @override
  String get outsidePhantom => '(outside phantom)';

  @override
  String get previous => 'Previous';

  @override
  String get previousStepTooltip => 'Previous instruction step';

  @override
  String get privacyPolicyButton => 'Privacy Policy';

  @override
  String get radonCanvasSemantics =>
      'Sinogram radon space viewport. 2D projection data display with angle theta on vertical axis and radial offset r on horizontal axis.';

  @override
  String get replayAnimationCueTooltip => 'Replay animation cue';

  @override
  String get res100Label => '100 (200×200)';

  @override
  String get res100Tooltip => 'Ultra resolution';

  @override
  String get res25Label => '25 (50×50)';

  @override
  String get res25Tooltip => 'Fast performance';

  @override
  String get res50Label => '50 (100×100)';

  @override
  String get res50Tooltip => 'Standard resolution';

  @override
  String get res75Label => '75 (150×150)';

  @override
  String get res75Tooltip => 'High resolution';

  @override
  String get resetDefaults => 'Reset Defaults';

  @override
  String get resolutionSection => 'Sampling Resolution (P × Q)';

  @override
  String get settingsTitle => 'Settings & Display';

  @override
  String get settingsTooltip => 'Settings & Display';

  @override
  String get showGuidesSubtitle =>
      'Display axes and circular bounds on canvases';

  @override
  String get showGuidesTitle => 'Show Coordinate Guides';

  @override
  String get stage1Description =>
      'An X-Ray CAT scan (Computed Axial Tomography) non-invasively reconstructs the 2D interior of an object by transmitting X-ray beams through it from all angles θ. Detectors measure transmitted intensity, which by the Beer-Lambert law yields the mathematical line integral of the absorption coefficient f(x, y) along each line L: g(L) = ∫_L f ds. The core tomography challenge is inverting these line integrals to recover the interior.';

  @override
  String get stage1Instruction1 =>
      'Click or drag in Object Space to see all lines passing through that point. Click \"Next\" or Stage 2 above to continue.';

  @override
  String get stage1NarrowDescription =>
      'A CAT scan reconstructs the 2D interior of an object non-invasively by transmitting X-rays through it at many angles θ. Detectors measure absorbed intensity, yielding the line integral of absorption f(x, y) along each line L: g(L) = ∫_L f ds.';

  @override
  String get stage1NarrowInstruction1 =>
      'Tap or drag in Object Space to see lines through that point. Tap \"Next\" or Stage 2 above to continue.';

  @override
  String get stage1NarrowSubtitle => 'Overview & Radon Transform';

  @override
  String get stage1NarrowTitle => 'Tomography Overview';

  @override
  String get stage1Subtitle => 'Overview & The Radon Transform';

  @override
  String get stage1Title => 'Computed Axial Tomography';

  @override
  String get stage2Description =>
      'Every straight line in 2D space is parameterized by two variables: its signed perpendicular distance r from the origin, and its normal angle θ: x·cos(θ) + y·sin(θ) = r. The left viewport displays physical Object Space (x, y), and the right viewport displays Sinogram Space (r, θ). Each individual point (r, θ) in sinogram space represents a complete straight X-ray line traversing object space.';

  @override
  String get stage2Instruction1 =>
      'Step 1 of 3: Click or drag anywhere in the Sinogram on the right to see the corresponding line x·cos(θ) + y·sin(θ) = r and normal on the left.';

  @override
  String get stage2Instruction2 =>
      'Step 2 of 3: Drag left and right in the Sinogram to vary radial distance r (-1 to 1). Notice how the line translates in Object Space.';

  @override
  String get stage2Instruction3 =>
      'Step 3 of 3: Drag up and down in the Sinogram to vary angle θ (0 to 2π). Notice how the line rotates in Object Space.';

  @override
  String get stage2NarrowDescription =>
      'Every straight line in the plane is parameterized by its signed perpendicular distance r from the origin and normal angle θ: x·cos(θ) + y·sin(θ) = r. A single point (r, θ) in the bottom canvas represents a complete line traversing object space on the top.';

  @override
  String get stage2NarrowInstruction1 =>
      'Step 1 of 3: Click or drag in the Sinogram on the bottom to see the corresponding line and normal on the top.';

  @override
  String get stage2NarrowInstruction2 =>
      'Step 2 of 3: Drag left and right in the Sinogram to vary radial distance r (-1 to 1). Notice the line translation.';

  @override
  String get stage2NarrowInstruction3 =>
      'Step 3 of 3: Drag up and down in the Sinogram to vary angle θ (0 to 2π). Notice the line rotation.';

  @override
  String get stage2NarrowSubtitle => 'Line Equation: x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2NarrowTitle => 'Object on Top, Data on Bottom';

  @override
  String get stage2Subtitle => 'Line Parameterization: x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2Title => 'Object on Left, Data on Right';

  @override
  String get stage3Description =>
      'All lines passing through a single fixed point (x, y) satisfy r(θ) = x·cos(θ) + y·sin(θ). As the projection angle θ varies from 0 to 2π, this family of lines forms an exact sinusoidal wave in (r, θ) sinogram space. This duality is fundamental: a point in object space maps to a sinusoid in sinogram space, while a point in sinogram space maps to a line in object space. Clicking the border bars shows lines with constant θ or constant r.';

  @override
  String get stage3Instruction1 =>
      'Step 1 of 3: Click or drag in Object Space on the left to move the probe point and watch its sinusoidal dual curve on the right.';

  @override
  String get stage3Instruction2 =>
      'Step 2 of 3: Click the right border bar in the Sinogram to display a family of parallel lines across all r at fixed angle θ.';

  @override
  String get stage3Instruction3 =>
      'Step 3 of 3: Click the bottom border bar in the Sinogram to view lines tangent to a concentric circle of radius |r|.';

  @override
  String get stage3NarrowDescription =>
      'Every line passing through a fixed point (x, y) satisfies r(θ) = x·cos(θ) + y·sin(θ). As θ varies from 0 to 2π, this family of lines forms an exact sinusoidal wave in (r, θ) space.';

  @override
  String get stage3NarrowInstruction1 =>
      'Step 1 of 3: Click or drag in Object Space on the top to move the probe point and watch its sinusoidal dual curve on the bottom.';

  @override
  String get stage3NarrowInstruction2 =>
      'Step 2 of 3: Click the right border bar in the Sinogram to display a family of parallel lines at fixed angle θ.';

  @override
  String get stage3NarrowInstruction3 =>
      'Step 3 of 3: Click the bottom border bar in the Sinogram to view lines tangent to a circle of radius |r|.';

  @override
  String get stage3NarrowSubtitle => 'Points Trace Sinusoids in Sinogram';

  @override
  String get stage3Subtitle =>
      'Points in Object Space Trace Sinusoids in Sinogram Space';

  @override
  String get stage3Title => 'Point Duality';

  @override
  String get stage4Description =>
      'A phantom object—a circular disk simulating interior structure—is placed in object space. Its X-ray attenuation creates a 2D shadow dataset g(r, θ) called a sinogram. There is faint intensity when an X-ray only skims the disk edge, and strong intensity when it passes through the diameter. Dragging the phantom shifts the amplitude and phase of its sinusoidal shadow band.';

  @override
  String get stage4Instruction1 =>
      'Step 1 of 2: Drag the red phantom disk in Object Space on the left to reposition it.';

  @override
  String get stage4Instruction2 =>
      'Step 2 of 2: Observe how the phantom’s 2D sinogram shadow immediately shifts on the right, encoding its location.';

  @override
  String get stage4NarrowDescription =>
      'A phantom object (circular disk) is placed in object space. Its X-ray projections form a 2D shadow dataset g(r, θ) known as a sinogram. Dragging the phantom shifts its shadow band.';

  @override
  String get stage4NarrowInstruction1 =>
      'Step 1 of 2: Drag the red phantom disk in Object Space on the top to reposition it.';

  @override
  String get stage4NarrowInstruction2 =>
      'Step 2 of 2: Observe how the phantom’s sinogram shadow shifts on the bottom as you drag.';

  @override
  String get stage4NarrowSubtitle => 'Phantom & 2D Sinogram Shadow';

  @override
  String get stage4NarrowTitle => 'Object Shadow';

  @override
  String get stage4Subtitle => 'The Phantom Object & Its 2D Sinogram Shadow';

  @override
  String get stage4Title => 'Object Produces Shadow';

  @override
  String get stage5Description =>
      'The bottom graph displays 1D cross-sections of the sinogram g(r, θ). In particular, examining projections along the sinusoidal curve of a point (x, y) and summing them over all angles θ is called backprojection: ∫₀²π g(x·cos θ + y·sin θ, θ) dθ. If the point lies inside the phantom disk, the integral is large; if outside, it is small. However, unfiltered backprojection blurs features by a 1/|r| point-spread function.';

  @override
  String get stage5Instruction1 =>
      'Step 1 of 3: Click inside the phantom disk on the left. Notice the large backprojection integral value on the bottom graph.';

  @override
  String get stage5Instruction2 =>
      'Step 2 of 3: Click outside the phantom disk. Observe how the 1D profile values drop and the backprojection integral becomes small.';

  @override
  String get stage5Instruction3 =>
      'Step 3 of 3: Click the sinogram border bars on the right to examine 1D cross sections along constant θ or r.';

  @override
  String get stage5NarrowDescription =>
      'The bottom graph displays the 1D cross section of g(r, θ) along the probe trajectory. Summing these projections over all angles (backprojection) yields a large integral inside the phantom and a smaller integral outside, but unfiltered backprojection produces a blurry 1/|r| image.';

  @override
  String get stage5NarrowInstruction1 =>
      'Step 1 of 3: Click inside the phantom disk on the top. Notice the large backprojection integral on the bottom graph.';

  @override
  String get stage5NarrowInstruction2 =>
      'Step 2 of 3: Click outside the phantom disk. Observe how profile values drop and the integral becomes small.';

  @override
  String get stage5NarrowInstruction3 =>
      'Step 3 of 3: Click the sinogram border bars on the bottom to examine 1D cross sections along constant θ or r.';

  @override
  String get stage5NarrowSubtitle => '1D Profiles & Backprojection';

  @override
  String get stage5NarrowTitle => 'Cross Section';

  @override
  String get stage5Subtitle => '1D Profiles & Unfiltered Backprojection';

  @override
  String get stage5Title => 'Cross Section of Data';

  @override
  String get stage6Description =>
      'To remove the 1/|r| blur, projections are filtered before backprojection (Filtered Backprojection, FBP). Convolving each projection with Frank Natterer’s discrete ramp filter kernel w_b(l) = b² / (π⁴(1 - 4l²)) acts like an edge-sharpening derivative filter that adds negative side lobes. When backprojected, these negative lobes cancel the smearing exactly, yielding precise interior attenuation: ≈ 1.0 inside the phantom disk and ≈ 0.0 outside.';

  @override
  String get stage6Instruction1 =>
      'Step 1 of 2: Click inside the phantom disk. Observe the sharp edge lobes in the 1D profile and the reconstructed integral ≈ 1.0.';

  @override
  String get stage6Instruction2 =>
      'Step 2 of 2: Click outside the phantom disk. Notice how the negative side lobes cancel the smearing, yielding integral ≈ 0.0.';

  @override
  String get stage6NarrowDescription =>
      'High-pass filtering the projections with Frank Natterer’s discrete filter kernel w_b(l) = b² / (π⁴(1 - 4l²)) sharpens the sinogram. Backprojecting the filtered data reconstructs the exact interior attenuation values: ≈ 1.0 inside the phantom and ≈ 0.0 outside.';

  @override
  String get stage6NarrowInstruction1 =>
      'Step 1 of 2: Click inside the phantom disk. Observe the sharp edge lobes in the 1D profile and integral ≈ 1.0.';

  @override
  String get stage6NarrowInstruction2 =>
      'Step 2 of 2: Click outside the phantom disk. Negative side lobes cancel smearing, yielding integral ≈ 0.0.';

  @override
  String get stage6NarrowSubtitle => 'Filtered Backprojection (FBP)';

  @override
  String get stage6NarrowTitle => 'Filtered Reconstruction';

  @override
  String get stage6Subtitle =>
      'Filtered Backprojection (FBP) with Natterer Ramp Kernel';

  @override
  String get stage6Title => 'Filtered Data Reconstruction';

  @override
  String stageIndicator(int stageNumber) {
    return 'Stage $stageNumber of 6';
  }

  @override
  String stageTitle(int stageNumber, String title) {
    return 'Stage $stageNumber: $title';
  }

  @override
  String get switchLanguageTooltip => 'Switch language';

  @override
  String get moreInfoButton => 'More Info';

  @override
  String get termsOfServiceButton => 'Terms of Service';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSection => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get websiteButton => 'www.gchouse.org';
}
