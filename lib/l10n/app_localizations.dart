import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('lt'),
    Locale('pt'),
    Locale('zh'),
  ];

  /// Historical author attribution in the about dialog
  ///
  /// In en, this message translates to:
  /// **'Original Java Applet presented as a talk at Ball State University February 26, 1998 by Fred Gylys-Colwell'**
  String get aboutAuthor;

  /// Summary description shown in the about dialog
  ///
  /// In en, this message translates to:
  /// **'An interactive visualization of the Radon Transform, line integrals, sinogram duality, and Frank Natterer’s Filtered Backprojection (FBP).'**
  String get aboutSummary;

  /// Tooltip for the About action button in the app bar
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTooltip;

  /// Title displayed on the application header
  ///
  /// In en, this message translates to:
  /// **'CAT Scan Demonstration'**
  String get appTitle;

  /// Generic close button label
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Tooltip on the collapse narrative chevron
  ///
  /// In en, this message translates to:
  /// **'Collapse main text'**
  String get collapseMainTextTooltip;

  /// Display name for the 1998 Java applet colormap
  ///
  /// In en, this message translates to:
  /// **'Classic (1998 Java)'**
  String get colormapClassic;

  /// Display name for the medical CT grayscale colormap
  ///
  /// In en, this message translates to:
  /// **'Grayscale (Medical CT)'**
  String get colormapGrayscale;

  /// Display name for the Inferno colormap
  ///
  /// In en, this message translates to:
  /// **'Inferno'**
  String get colormapInferno;

  /// Section header for colormap selector in settings dialog
  ///
  /// In en, this message translates to:
  /// **'Sinogram Colormap'**
  String get colormapSection;

  /// Display name for the Viridis colormap
  ///
  /// In en, this message translates to:
  /// **'Viridis'**
  String get colormapViridis;

  /// Button label to close settings dialog
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Tooltip on the expand narrative chevron
  ///
  /// In en, this message translates to:
  /// **'Expand main text'**
  String get expandMainTextTooltip;

  /// Short label for filter toggle checkbox in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filteredCheckbox;

  /// Checkbox label with shortcut key hint for filtered sinogram in wide layout
  ///
  /// In en, this message translates to:
  /// **'Filtered Sinogram [F]'**
  String get filteredCheckboxWide;

  /// Button link to GitHub repository
  ///
  /// In en, this message translates to:
  /// **'GitHub (fredgc/cat)'**
  String get githubButton;

  /// Accessibility semantic label for the 1D profile plot canvas
  ///
  /// In en, this message translates to:
  /// **'1D profile plot showing cross sections and backprojection integral.'**
  String get graphCanvasSemantics;

  /// Prefix in graph header when filtered reconstruction is active
  ///
  /// In en, this message translates to:
  /// **'Filtered wb * g: '**
  String get graphFilteredPrefix;

  /// Graph header text for line probe
  ///
  /// In en, this message translates to:
  /// **'Ray Absorption (Green) | Line (r = {r}, θ = {theta}) | Total Absorption: {val}'**
  String graphLineTrajectory(String r, String theta, String val);

  /// Graph header text for point probe trajectory
  ///
  /// In en, this message translates to:
  /// **'{prefix}Point Trajectory ({x}, {y}) | Integral over θ: {val} {status}'**
  String graphPointTrajectory(
    String prefix,
    String x,
    String y,
    String val,
    String status,
  );

  /// Prompt displayed in graph header when no probe is active
  ///
  /// In en, this message translates to:
  /// **'Select a point or line to display 1D cross section.'**
  String get graphSelectPrompt;

  /// Graph header text for tangent radius probe
  ///
  /// In en, this message translates to:
  /// **'{prefix}Tangent slice at radius r = {r} | Integral: {val}'**
  String graphSlineTrajectory(String prefix, String r, String val);

  /// Graph header text for fixed theta projection probe
  ///
  /// In en, this message translates to:
  /// **'{prefix}Projection slice at θ = {theta} rad | Integral: {val}'**
  String graphThetaTrajectory(String prefix, String theta, String val);

  /// Prefix in graph header when unfiltered backprojection is active
  ///
  /// In en, this message translates to:
  /// **'Unfiltered: '**
  String get graphUnfilteredPrefix;

  /// Status suffix indicating the probe point lies within the phantom disk
  ///
  /// In en, this message translates to:
  /// **'(inside phantom)'**
  String get insidePhantom;

  /// Button link to report GitHub issues
  ///
  /// In en, this message translates to:
  /// **'Issues'**
  String get issuesButton;

  /// List of available keyboard shortcuts in the about dialog
  ///
  /// In en, this message translates to:
  /// **'• [Enter]: Advance instruction step or next stage\n• [N] / [→]: Next stage\n• [P] / [←]: Previous stage\n• [1] - [7]: Jump to stage 1 through 7\n• [Space]: Play / Pause angle sweep rotation\n• [F]: Toggle filtered reconstruction mode'**
  String get keyboardShortcutsList;

  /// Title preceding keyboard shortcuts list in the about dialog
  ///
  /// In en, this message translates to:
  /// **'Keyboard Shortcuts:'**
  String get keyboardShortcutsTitle;

  /// Menu option to automatically follow system or browser locale
  ///
  /// In en, this message translates to:
  /// **'Auto (System)'**
  String get languageAuto;

  /// Menu option for English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Menu option for Spanish language
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// Button label to navigate to the next stage
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Tooltip on the chevron to advance to next instruction step
  ///
  /// In en, this message translates to:
  /// **'Next instruction step'**
  String get nextStepTooltip;

  /// Accessibility semantic label for the Object Space coordinate canvas
  ///
  /// In en, this message translates to:
  /// **'Object space viewport. Interactive coordinate plane showing X-ray projection lines and phantom.'**
  String get objectCanvasSemantics;

  /// Status suffix indicating the probe point lies outside the phantom disk
  ///
  /// In en, this message translates to:
  /// **'(outside phantom)'**
  String get outsidePhantom;

  /// Button label to navigate to the previous stage
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// Tooltip on the chevron to return to previous instruction step
  ///
  /// In en, this message translates to:
  /// **'Previous instruction step'**
  String get previousStepTooltip;

  /// Button link opening the privacy policy
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyButton;

  /// Accessibility semantic label for the Sinogram / Radon canvas
  ///
  /// In en, this message translates to:
  /// **'Sinogram radon space viewport. 2D projection data display with angle theta on vertical axis and radial offset r on horizontal axis.'**
  String get radonCanvasSemantics;

  /// Tooltip on button to replay the visual interaction gesture cue
  ///
  /// In en, this message translates to:
  /// **'Replay animation cue'**
  String get replayAnimationCueTooltip;

  /// Segment label for 100 resolution (200x200 grid)
  ///
  /// In en, this message translates to:
  /// **'100 (200×200)'**
  String get res100Label;

  /// Tooltip for 100 resolution segment
  ///
  /// In en, this message translates to:
  /// **'Ultra resolution'**
  String get res100Tooltip;

  /// Segment label for 25 resolution (50x50 grid)
  ///
  /// In en, this message translates to:
  /// **'25 (50×50)'**
  String get res25Label;

  /// Tooltip for 25 resolution segment
  ///
  /// In en, this message translates to:
  /// **'Fast performance'**
  String get res25Tooltip;

  /// Segment label for 50 resolution (100x100 grid)
  ///
  /// In en, this message translates to:
  /// **'50 (100×100)'**
  String get res50Label;

  /// Tooltip for 50 resolution segment
  ///
  /// In en, this message translates to:
  /// **'Standard resolution'**
  String get res50Tooltip;

  /// Segment label for 75 resolution (150x150 grid)
  ///
  /// In en, this message translates to:
  /// **'75 (150×150)'**
  String get res75Label;

  /// Tooltip for 75 resolution segment
  ///
  /// In en, this message translates to:
  /// **'High resolution'**
  String get res75Tooltip;

  /// Button label in settings to reset all preferences
  ///
  /// In en, this message translates to:
  /// **'Reset Defaults'**
  String get resetDefaults;

  /// Section header for sampling resolution in settings dialog
  ///
  /// In en, this message translates to:
  /// **'Sampling Resolution (P × Q)'**
  String get resolutionSection;

  /// Dialog title for user settings and preferences
  ///
  /// In en, this message translates to:
  /// **'Settings & Display'**
  String get settingsTitle;

  /// Tooltip on the settings action button in the app bar
  ///
  /// In en, this message translates to:
  /// **'Settings & Display'**
  String get settingsTooltip;

  /// Subtitle description under coordinate guides switch in settings
  ///
  /// In en, this message translates to:
  /// **'Display axes and circular bounds on canvases'**
  String get showGuidesSubtitle;

  /// Title label for coordinate guides switch in settings
  ///
  /// In en, this message translates to:
  /// **'Show Coordinate Guides'**
  String get showGuidesTitle;

  /// Full description text for Stage 1 in wide layout
  ///
  /// In en, this message translates to:
  /// **'An X-Ray CAT scan (Computed Axial Tomography) non-invasively reconstructs the 2D interior of an object by transmitting X-ray beams through it from all angles θ. Detectors measure transmitted intensity, which by the Beer-Lambert law yields the mathematical line integral of the absorption coefficient f(x, y) along each line L: g(L) = ∫_L f ds. The core tomography challenge is inverting these line integrals to recover the interior.'**
  String get stage1Description;

  /// Interaction prompt for Stage 1 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Click or drag in Object Space to see all lines passing through that point. Click \"Next\" or Stage 2 above to continue.'**
  String get stage1Instruction1;

  /// Concise description text for Stage 1 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'A CAT scan reconstructs the 2D interior of an object non-invasively by transmitting X-rays through it at many angles θ. Detectors measure absorbed intensity, yielding the line integral of absorption f(x, y) along each line L: g(L) = ∫_L f ds.'**
  String get stage1NarrowDescription;

  /// Interaction prompt for Stage 1 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Tap or drag in Object Space to see lines through that point. Tap \"Next\" or Stage 2 above to continue.'**
  String get stage1NarrowInstruction1;

  /// Subtitle for Stage 1 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Overview & Radon Transform'**
  String get stage1NarrowSubtitle;

  /// Short title for Stage 1 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Tomography Overview'**
  String get stage1NarrowTitle;

  /// Subtitle for Stage 1 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Overview & The Radon Transform'**
  String get stage1Subtitle;

  /// Title for Stage 1 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Computed Axial Tomography'**
  String get stage1Title;

  /// Full description text for Stage 2 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Every straight line in 2D space is parameterized by two variables: its signed perpendicular distance r from the origin, and its normal angle θ: x·cos(θ) + y·sin(θ) = r. The left viewport displays physical Object Space (x, y), and the right viewport displays Sinogram Space (r, θ). Each individual point (r, θ) in sinogram space represents a complete straight X-ray line traversing object space.'**
  String get stage2Description;

  /// Step 1 interaction prompt for Stage 2 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 3: Click or drag anywhere in the Sinogram on the right to see the corresponding line x·cos(θ) + y·sin(θ) = r and normal on the left.'**
  String get stage2Instruction1;

  /// Step 2 interaction prompt for Stage 2 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 3: Drag left and right in the Sinogram to vary radial distance r (-1 to 1). Notice how the line translates in Object Space.'**
  String get stage2Instruction2;

  /// Step 3 interaction prompt for Stage 2 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 3 of 3: Drag up and down in the Sinogram to vary angle θ (0 to 2π). Notice how the line rotates in Object Space.'**
  String get stage2Instruction3;

  /// Concise description text for Stage 2 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Every straight line in the plane is parameterized by its signed perpendicular distance r from the origin and normal angle θ: x·cos(θ) + y·sin(θ) = r. A single point (r, θ) in the bottom canvas represents a complete line traversing object space on the top.'**
  String get stage2NarrowDescription;

  /// Step 1 interaction prompt for Stage 2 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 3: Click or drag in the Sinogram on the bottom to see the corresponding line and normal on the top.'**
  String get stage2NarrowInstruction1;

  /// Step 2 interaction prompt for Stage 2 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 3: Drag left and right in the Sinogram to vary radial distance r (-1 to 1). Notice the line translation.'**
  String get stage2NarrowInstruction2;

  /// Step 3 interaction prompt for Stage 2 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 3 of 3: Drag up and down in the Sinogram to vary angle θ (0 to 2π). Notice the line rotation.'**
  String get stage2NarrowInstruction3;

  /// Subtitle for Stage 2 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Line Equation: x·cos(θ) + y·sin(θ) = r'**
  String get stage2NarrowSubtitle;

  /// Short title for Stage 2 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Object on Top, Data on Bottom'**
  String get stage2NarrowTitle;

  /// Subtitle for Stage 2 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Line Parameterization: x·cos(θ) + y·sin(θ) = r'**
  String get stage2Subtitle;

  /// Title for Stage 2 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Object on Left, Data on Right'**
  String get stage2Title;

  /// Full description text for Stage 3 in wide layout
  ///
  /// In en, this message translates to:
  /// **'All lines passing through a single fixed point (x, y) satisfy r(θ) = x·cos(θ) + y·sin(θ). As the projection angle θ varies from 0 to 2π, this family of lines forms an exact sinusoidal wave in (r, θ) sinogram space. This duality is fundamental: a point in object space maps to a sinusoid in sinogram space, while a point in sinogram space maps to a line in object space. Clicking the border bars shows lines with constant θ or constant r.'**
  String get stage3Description;

  /// Step 1 interaction prompt for Stage 3 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 3: Click or drag in Object Space on the left to move the probe point and watch its sinusoidal dual curve on the right.'**
  String get stage3Instruction1;

  /// Step 2 interaction prompt for Stage 3 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 3: Click the right border bar in the Sinogram to display a family of parallel lines across all r at fixed angle θ.'**
  String get stage3Instruction2;

  /// Step 3 interaction prompt for Stage 3 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 3 of 3: Click the bottom border bar in the Sinogram to view lines tangent to a concentric circle of radius |r|.'**
  String get stage3Instruction3;

  /// Concise description text for Stage 3 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Every line passing through a fixed point (x, y) satisfies r(θ) = x·cos(θ) + y·sin(θ). As θ varies from 0 to 2π, this family of lines forms an exact sinusoidal wave in (r, θ) space.'**
  String get stage3NarrowDescription;

  /// Step 1 interaction prompt for Stage 3 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 3: Click or drag in Object Space on the top to move the probe point and watch its sinusoidal dual curve on the bottom.'**
  String get stage3NarrowInstruction1;

  /// Step 2 interaction prompt for Stage 3 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 3: Click the right border bar in the Sinogram to display a family of parallel lines at fixed angle θ.'**
  String get stage3NarrowInstruction2;

  /// Step 3 interaction prompt for Stage 3 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 3 of 3: Click the bottom border bar in the Sinogram to view lines tangent to a circle of radius |r|.'**
  String get stage3NarrowInstruction3;

  /// Subtitle for Stage 3 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Points Trace Sinusoids in Sinogram'**
  String get stage3NarrowSubtitle;

  /// Subtitle for Stage 3 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Points in Object Space Trace Sinusoids in Sinogram Space'**
  String get stage3Subtitle;

  /// Title for Stage 3 in wide and narrow layouts
  ///
  /// In en, this message translates to:
  /// **'Point Duality'**
  String get stage3Title;

  /// Full description text for Stage 4 in wide layout
  ///
  /// In en, this message translates to:
  /// **'A phantom object—a circular disk simulating interior structure—is placed in object space. Its X-ray attenuation creates a 2D shadow dataset g(r, θ) called a sinogram. There is faint intensity when an X-ray only skims the disk edge, and strong intensity when it passes through the diameter. Dragging the phantom shifts the amplitude and phase of its sinusoidal shadow band.'**
  String get stage4Description;

  /// Step 1 interaction prompt for Stage 4 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 2: Drag the red phantom disk in Object Space on the left to reposition it.'**
  String get stage4Instruction1;

  /// Step 2 interaction prompt for Stage 4 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 2: Observe how the phantom’s 2D sinogram shadow immediately shifts on the right, encoding its location.'**
  String get stage4Instruction2;

  /// Concise description text for Stage 4 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'A phantom object (circular disk) is placed in object space. Its X-ray projections form a 2D shadow dataset g(r, θ) known as a sinogram. Dragging the phantom shifts its shadow band.'**
  String get stage4NarrowDescription;

  /// Step 1 interaction prompt for Stage 4 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 2: Drag the red phantom disk in Object Space on the top to reposition it.'**
  String get stage4NarrowInstruction1;

  /// Step 2 interaction prompt for Stage 4 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 2: Observe how the phantom’s sinogram shadow shifts on the bottom as you drag.'**
  String get stage4NarrowInstruction2;

  /// Subtitle for Stage 4 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Phantom & 2D Sinogram Shadow'**
  String get stage4NarrowSubtitle;

  /// Short title for Stage 4 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Object Shadow'**
  String get stage4NarrowTitle;

  /// Subtitle for Stage 4 in wide layout
  ///
  /// In en, this message translates to:
  /// **'The Phantom Object & Its 2D Sinogram Shadow'**
  String get stage4Subtitle;

  /// Title for Stage 4 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Object Produces Shadow'**
  String get stage4Title;

  /// Full description text for Stage 5 in wide layout
  ///
  /// In en, this message translates to:
  /// **'The bottom graph displays 1D cross-sections of the sinogram g(r, θ). In particular, examining projections along the sinusoidal curve of a point (x, y) and summing them over all angles θ is called backprojection: ∫₀²π g(x·cos θ + y·sin θ, θ) dθ. If the point lies inside the phantom disk, the integral is large; if outside, it is small. However, unfiltered backprojection blurs features by a 1/|r| point-spread function.'**
  String get stage5Description;

  /// Step 1 interaction prompt for Stage 5 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 3: Click inside the phantom disk on the left. Notice the large backprojection integral value on the bottom graph.'**
  String get stage5Instruction1;

  /// Step 2 interaction prompt for Stage 5 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 3: Click outside the phantom disk. Observe how the 1D profile values drop and the backprojection integral becomes small.'**
  String get stage5Instruction2;

  /// Step 3 interaction prompt for Stage 5 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 3 of 3: Click the sinogram border bars on the right to examine 1D cross sections along constant θ or r.'**
  String get stage5Instruction3;

  /// Concise description text for Stage 5 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'The bottom graph displays the 1D cross section of g(r, θ) along the probe trajectory. Summing these projections over all angles (backprojection) yields a large integral inside the phantom and a smaller integral outside, but unfiltered backprojection produces a blurry 1/|r| image.'**
  String get stage5NarrowDescription;

  /// Step 1 interaction prompt for Stage 5 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 3: Click inside the phantom disk on the top. Notice the large backprojection integral on the bottom graph.'**
  String get stage5NarrowInstruction1;

  /// Step 2 interaction prompt for Stage 5 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 3: Click outside the phantom disk. Observe how profile values drop and the integral becomes small.'**
  String get stage5NarrowInstruction2;

  /// Step 3 interaction prompt for Stage 5 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 3 of 3: Click the sinogram border bars on the bottom to examine 1D cross sections along constant θ or r.'**
  String get stage5NarrowInstruction3;

  /// Subtitle for Stage 5 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'1D Profiles & Backprojection'**
  String get stage5NarrowSubtitle;

  /// Short title for Stage 5 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Cross Section'**
  String get stage5NarrowTitle;

  /// Subtitle for Stage 5 in wide layout
  ///
  /// In en, this message translates to:
  /// **'1D Profiles & Unfiltered Backprojection'**
  String get stage5Subtitle;

  /// Title for Stage 5 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Cross Section of Data'**
  String get stage5Title;

  /// Full description text for Stage 6 in wide layout
  ///
  /// In en, this message translates to:
  /// **'To remove the 1/|r| blur, projections are filtered before backprojection (Filtered Backprojection, FBP). Convolving each projection with Frank Natterer’s discrete ramp filter kernel w_b(l) = b² / (π⁴(1 - 4l²)) acts like an edge-sharpening derivative filter that adds negative side lobes. When backprojected, these negative lobes cancel the smearing exactly, yielding precise interior attenuation: ≈ 1.0 inside the phantom disk and ≈ 0.0 outside.'**
  String get stage6Description;

  /// Step 1 interaction prompt for Stage 6 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 2: Click inside the phantom disk. Observe the sharp edge lobes in the 1D profile and the reconstructed integral ≈ 1.0.'**
  String get stage6Instruction1;

  /// Step 2 interaction prompt for Stage 6 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 2: Click outside the phantom disk. Notice how the negative side lobes cancel the smearing, yielding integral ≈ 0.0.'**
  String get stage6Instruction2;

  /// Concise description text for Stage 6 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'High-pass filtering the projections with Frank Natterer’s discrete filter kernel w_b(l) = b² / (π⁴(1 - 4l²)) sharpens the sinogram. Backprojecting the filtered data reconstructs the exact interior attenuation values: ≈ 1.0 inside the phantom and ≈ 0.0 outside.'**
  String get stage6NarrowDescription;

  /// Step 1 interaction prompt for Stage 6 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 2: Click inside the phantom disk. Observe the sharp edge lobes in the 1D profile and integral ≈ 1.0.'**
  String get stage6NarrowInstruction1;

  /// Step 2 interaction prompt for Stage 6 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 2: Click outside the phantom disk. Negative side lobes cancel smearing, yielding integral ≈ 0.0.'**
  String get stage6NarrowInstruction2;

  /// Subtitle for Stage 6 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Filtered Backprojection (FBP)'**
  String get stage6NarrowSubtitle;

  /// Short title for Stage 6 in narrow layout
  ///
  /// In en, this message translates to:
  /// **'Filtered Reconstruction'**
  String get stage6NarrowTitle;

  /// Subtitle for Stage 6 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Filtered Backprojection (FBP) with Natterer Ramp Kernel'**
  String get stage6Subtitle;

  /// Title for Stage 6 in wide layout
  ///
  /// In en, this message translates to:
  /// **'Filtered Data Reconstruction'**
  String get stage6Title;

  /// Stage number pill indicator in narrative card
  ///
  /// In en, this message translates to:
  /// **'Stage {stageNumber} of 6'**
  String stageIndicator(int stageNumber);

  /// AppBar title combining stage number and title
  ///
  /// In en, this message translates to:
  /// **'Stage {stageNumber}: {title}'**
  String stageTitle(int stageNumber, String title);

  /// Tooltip for language switcher popup menu in app bar
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get switchLanguageTooltip;

  /// Button linking to info.html documentation
  ///
  /// In en, this message translates to:
  /// **'More Info'**
  String get moreInfoButton;

  /// Button link opening terms of service
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfServiceButton;

  /// Segment label for dark theme mode
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Segment label for light theme mode
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Section header for theme selector in settings dialog
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeSection;

  /// Segment label for system theme mode
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// Version string display in about dialog
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(String version);

  /// Button link to GC House homepage
  ///
  /// In en, this message translates to:
  /// **'www.gchouse.org'**
  String get websiteButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'lt',
    'pt',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'lt':
      return AppLocalizationsLt();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
