// Widget tests for CatApp and viewport canvases.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cat/color.dart';
import 'package:cat/main.dart';
import 'package:cat/models/radon_engine.dart';
import 'package:cat/settings.dart';
import 'package:cat/widgets/graph_canvas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cat/widgets/interaction_cue_overlay.dart';
import 'package:cat/widgets/object_canvas.dart';
import 'package:cat/widgets/radon_canvas.dart';

void main() {
  testWidgets('CAT Scan app smoke test and 6-stage navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CatApp());

    // Verify Stage 1 title is visible
    expect(
      find.textContaining('Stage 1: Computed Axial Tomography'),
      findsOneWidget,
    );
    expect(find.byType(ObjectCanvas), findsOneWidget);
    // In Stage 1 only ObjectCanvas is shown; RadonCanvas is introduced in Stage 2
    expect(find.byType(RadonCanvas), findsNothing);
    // Graph canvas should NOT be visible in Stage 1
    expect(find.byType(GraphCanvas), findsNothing);

    // Advance to Stage 2
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Stage 2: Object on Left, Data on Right'),
      findsOneWidget,
    );
    expect(find.byType(RadonCanvas), findsOneWidget);

    // Advance to Stage 3
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Stage 3: Point Duality'), findsOneWidget);

    // Advance to Stage 4 (phantom and sinogram become visible)
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Stage 4: Object Produces Shadow'),
      findsOneWidget,
    );
    expect(find.byType(GraphCanvas), findsNothing);

    // Advance to Stage 5 (GraphCanvas appears, probe starts outside phantom)
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Stage 5: Cross Section of Data'),
      findsOneWidget,
    );
    expect(find.byType(GraphCanvas), findsOneWidget);
    expect(
      find.textContaining('Drag the probe inside the phantom disk'),
      findsOneWidget,
    );

    // Advance to Stage 6 (Filtered reconstruction)
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Stage 6: Filtered Data Reconstruction'),
      findsOneWidget,
    );
    expect(find.byType(GraphCanvas), findsOneWidget);

    // Advance to Stage 7 (Free Play)
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Stage 7: Free Play'), findsOneWidget);
    expect(find.byType(GraphCanvas), findsOneWidget);

    // Test chip jump back to Stage 1
    await tester.tap(find.widgetWithText(ChoiceChip, '1'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Stage 1: Computed Axial Tomography'),
      findsOneWidget,
    );
    expect(find.byType(GraphCanvas), findsNothing);
  });

  testWidgets('Keyboard shortcuts navigate stages and toggle filter', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CatApp());

    // Stage 1 initial
    expect(
      find.textContaining('Stage 1: Computed Axial Tomography'),
      findsOneWidget,
    );

    // Arrow right advances to Stage 2
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Stage 2: Object on Left, Data on Right'),
      findsOneWidget,
    );

    // Arrow left returns to Stage 1
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Stage 1: Computed Axial Tomography'),
      findsOneWidget,
    );

    // Digit 6 jumps directly to Stage 6
    await tester.sendKeyEvent(LogicalKeyboardKey.digit6);
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Stage 6: Filtered Data Reconstruction'),
      findsOneWidget,
    );
    expect(find.byType(GraphCanvas), findsOneWidget);

    // Key F toggles filter checkbox
    final checkboxFinder = find.byType(Checkbox);
    expect(tester.widget<Checkbox>(checkboxFinder).value, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyF);
    await tester.pumpAndSettle();
    expect(tester.widget<Checkbox>(checkboxFinder).value, isFalse);

    // Digit 3 jumps to Stage 3
    await tester.sendKeyEvent(LogicalKeyboardKey.digit3);
    await tester.pumpAndSettle();
    expect(find.textContaining('Stage 3: Point Duality'), findsOneWidget);

    // Key 'n' advances to Stage 4
    await tester.sendKeyEvent(LogicalKeyboardKey.keyN);
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Stage 4: Object Produces Shadow'),
      findsOneWidget,
    );

    // Key 'p' returns to Stage 3
    await tester.sendKeyEvent(LogicalKeyboardKey.keyP);
    await tester.pumpAndSettle();
    expect(find.textContaining('Stage 3: Point Duality'), findsOneWidget);

    // Enter advances instruction step (Step 1 -> Step 2 -> Step 3)
    expect(find.text('1/3'), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.text('2/3'), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.text('3/3'), findsOneWidget);

    // Enter on last step advances to next stage (Stage 4)
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Stage 4: Object Produces Shadow'),
      findsOneWidget,
    );

    // In Stage 4, SegmentedButton is present and starts with Phantom selected
    expect(find.byType(SegmentedButton<ObjectInteractionMode>), findsOneWidget);
    expect(
      tester
          .widget<SegmentedButton<ObjectInteractionMode>>(
            find.byType(SegmentedButton<ObjectInteractionMode>),
          )
          .selected,
      {ObjectInteractionMode.phantom},
    );

    // Digit 5 jumps to Stage 5: SegmentedButton starts with Probe selected
    await tester.sendKeyEvent(LogicalKeyboardKey.digit5);
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Stage 5: Cross Section of Data'),
      findsOneWidget,
    );
    expect(
      tester
          .widget<SegmentedButton<ObjectInteractionMode>>(
            find.byType(SegmentedButton<ObjectInteractionMode>),
          )
          .selected,
      {ObjectInteractionMode.probe},
    );
  });

  testWidgets(
    'Narrow screen uses Top and Bottom wording instead of Left and Right',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const CatApp());

      // Stage 1 instruction
      expect(
        find.textContaining("Tap 'Next' above to continue to the next stage."),
        findsOneWidget,
      );
      expect(find.text('Overview & Radon Transform'), findsOneWidget);

      // Advance to Stage 2
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Stage 2: Object on Top, Data on Bottom'),
        findsOneWidget,
      );
      expect(
        find.textContaining(
          'bottom canvas represents a complete line traversing object space on the top.',
        ),
        findsOneWidget,
      );
      expect(
        find.text('Line Equation: x·cos(θ) + y·sin(θ) = r'),
        findsOneWidget,
      );

      // Advance to Stage 3
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text('Points Trace Sinusoids in Sinogram'), findsOneWidget);

      // Advance to Stage 6 by scrolling to ChoiceChip 6 and tapping
      await tester.ensureVisible(find.widgetWithText(ChoiceChip, '6'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ChoiceChip, '6'));
      await tester.pumpAndSettle();
      expect(find.text('Filtered Backprojection (FBP)'), findsOneWidget);
    },
  );

  testWidgets('Narrative card collapses and expands main text', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CatApp());

    // Initially description text is visible
    expect(
      find.textContaining('An X-Ray CAT scan (Computed Axial Tomography)'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.expand_less), findsOneWidget);

    // Tap collapse button/header
    await tester.tap(find.byIcon(Icons.expand_less));
    await tester.pumpAndSettle();

    // Main text description is hidden, expand_more is shown
    expect(
      find.textContaining('An X-Ray CAT scan (Computed Axial Tomography)'),
      findsNothing,
    );
    expect(find.byIcon(Icons.expand_more), findsOneWidget);

    // Tap expand button/header
    await tester.tap(find.byIcon(Icons.expand_more));
    await tester.pumpAndSettle();

    // Main text description is visible again
    expect(
      find.textContaining('An X-Ray CAT scan (Computed Axial Tomography)'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.expand_less), findsOneWidget);
  });

  testWidgets('Multi-step instructions navigate and reset on stage change', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CatApp());

    // In Stage 1 there is 1 instruction step
    expect(
      find.textContaining("Click 'Next' above to continue to the next stage"),
      findsOneWidget,
    );

    // Advance to Stage 2 which has 3 instruction steps
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('1/3'), findsOneWidget);
    expect(
      find.textContaining(
        'Step 1 of 3: Click or drag anywhere in the Sinogram',
      ),
      findsOneWidget,
    );

    // Tap next instruction step
    await tester.tap(find.byTooltip('Next instruction step'));
    await tester.pumpAndSettle();

    // Now showing 2/3 and Step 2 text
    expect(find.text('2/3'), findsOneWidget);
    expect(
      find.textContaining('Step 2 of 3: Drag left and right in the Sinogram'),
      findsOneWidget,
    );

    // Tap next instruction step
    await tester.tap(find.byTooltip('Next instruction step'));
    await tester.pumpAndSettle();

    // Now showing 3/3 and Step 3 text
    expect(find.text('3/3'), findsOneWidget);
    expect(
      find.textContaining('Step 3 of 3: Drag up and down in the Sinogram'),
      findsOneWidget,
    );

    // Tap previous instruction step
    await tester.tap(find.byTooltip('Previous instruction step'));
    await tester.pumpAndSettle();

    expect(find.text('2/3'), findsOneWidget);
    expect(
      find.textContaining('Step 2 of 3: Drag left and right in the Sinogram'),
      findsOneWidget,
    );

    // Advance stage to Stage 3 -> instruction step resets to 1 (1/3)
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('1/3'), findsOneWidget);
    expect(
      find.textContaining('Step 1 of 3: Click or drag in Object Space'),
      findsOneWidget,
    );
  });

  testWidgets('ObjectCanvas tap updates engine probe point', (
    WidgetTester tester,
  ) async {
    final engine = RadonEngine();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: ObjectCanvas(engine: engine, showPhantom: true),
            ),
          ),
        ),
      ),
    );

    // Tap in lower left quadrant (-x, -y) away from the phantom at (0.2, 0.3)
    final center = tester.getCenter(find.byType(ObjectCanvas));
    await tester.tapAt(center + const Offset(-70, 70));
    await tester.pumpAndSettle();

    expect(engine.probeMode, ProbeMode.point);
    expect(engine.probeX, lessThan(0.0));
    expect(engine.probeY, lessThan(0.0));
  });

  testWidgets('ObjectCanvas drag near phantom updates phantom position', (
    WidgetTester tester,
  ) async {
    final engine = RadonEngine();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: ObjectCanvas(engine: engine, showPhantom: true),
            ),
          ),
        ),
      ),
    );

    // Initial phantom position is (0.2, 0.3)
    expect(engine.phantom.x, 0.2);
    expect(engine.phantom.y, 0.3);

    final canvasCenter = tester.getCenter(find.byType(ObjectCanvas));
    final double unitRadius = 150.0 - ObjectCanvas.unitMargin;
    final phantomScreenPos =
        canvasCenter + Offset(0.2 * unitRadius, -0.3 * unitRadius);
    final touchOffset = phantomScreenPos + const Offset(15.0, 15.0);

    // Default mode is probe: dragging near phantom sets probe, not phantom
    await tester.dragFrom(touchOffset, const Offset(-50.0, 50.0));
    await tester.pumpAndSettle();
    expect(engine.phantom.x, 0.2);

    // Switch to Phantom mode using the SegmentedButton
    await tester.tap(find.text('Phantom'));
    await tester.pumpAndSettle();
    expect(engine.objectInteractionMode, ObjectInteractionMode.phantom);

    // Dragging now moves the phantom
    await tester.dragFrom(touchOffset, const Offset(-50.0, 50.0));
    await tester.pumpAndSettle();

    // Phantom should have moved left and down
    expect(engine.phantom.x, lessThan(0.2));
    expect(engine.phantom.y, lessThan(0.3));
  });

  testWidgets('RadonCanvas tap updates engine probe line', (
    WidgetTester tester,
  ) async {
    final engine = RadonEngine();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: RadonCanvas(engine: engine, showSinogram: true),
            ),
          ),
        ),
      ),
    );

    // Tap inside sinogram data region
    final center = tester.getCenter(find.byType(RadonCanvas));
    await tester.tapAt(center);
    await tester.pumpAndSettle();

    expect(engine.probeMode, ProbeMode.line);
  });

  testWidgets(
    'GraphCanvas displays reconstruction readout and updates with filtered toggle',
    (WidgetTester tester) async {
      final engine = RadonEngine();
      engine.setProbePoint(0.2, 0.3); // Inside phantom
      engine.setFiltered(false);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: GraphCanvas(engine: engine, height: 140)),
        ),
      );

      expect(find.textContaining('Unfiltered:'), findsOneWidget);
      expect(find.textContaining('Point Trajectory'), findsOneWidget);

      // Toggle to filtered
      engine.setFiltered(true);
      await tester.pumpAndSettle();

      expect(find.textContaining('Filtered wb * g:'), findsOneWidget);
      expect(find.textContaining('[Raw:'), findsOneWidget);
      expect(find.textContaining('(inside phantom)'), findsOneWidget);

      // Test single line ray mode (green ray absorption)
      engine.setProbeSinogram(engine.q, 0);
      await tester.pumpAndSettle();
      expect(find.textContaining('Ray Absorption (Green)'), findsOneWidget);
      expect(find.textContaining('Total Absorption:'), findsOneWidget);
    },
  );

  test('ColorPalettes coverage', () {
    for (final colormap in AppColormap.values) {
      final colorPos = ColorPalettes.getColor(0.1, colormap);
      final colorZero = ColorPalettes.getColor(0.0, colormap);
      final colorNeg = ColorPalettes.getColor(-0.1, colormap);
      expect(colorPos.a, equals(1.0));
      expect(colorZero.a, equals(1.0));
      expect(colorNeg.a, equals(1.0));

      final pixel = ColorPalettes.getRgbaPixel(0.1, colormap);
      expect(pixel & 0xFF, equals(0xFF)); // Alpha 255
    }
  });

  testWidgets(
    'Interaction cues animate, dismiss on tap, and replay via button',
    (WidgetTester tester) async {
      await tester.pumpWidget(const CatApp());
      await tester.pump(const Duration(milliseconds: 100));

      // In Stage 1 there is no cue (instruction is to click Next).
      final cueIconFinder = find.descendant(
        of: find.byType(InteractionCueOverlay),
        matching: find.byIcon(Icons.touch_app),
      );
      expect(cueIconFinder, findsNothing);

      // Navigate to Stage 2 (where RadonCanvas has a tap cue)
      await tester.tap(find.text('Next'));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(InteractionCueOverlay), findsNWidgets(2));
      expect(cueIconFinder, findsOneWidget);

      // Tapping on RadonCanvas dismisses the cue
      await tester.tap(find.byType(RadonCanvas));
      await tester.pump(const Duration(milliseconds: 50));

      // The cue icon is now dismissed
      expect(cueIconFinder, findsNothing);

      // Click the replay button in the instruction bar
      final replayFinder = find.byTooltip('Replay animation cue');
      expect(replayFinder, findsOneWidget);
      await tester.tap(replayFinder);
      await tester.pump(const Duration(milliseconds: 100));

      // Cue is restored
      expect(cueIconFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Stage 3 Step 3 cue targets bottom bar of canvas in tall screen',
    (WidgetTester tester) async {
      // Window is taller than wide, but wide enough for side-by-side view (width > 700)
      tester.view.physicalSize = const Size(750, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const CatApp());
      await tester.pumpAndSettle();

      // Jump to Stage 3 and advance to Step 3 using keyboard shortcuts
      await tester.sendKeyEvent(LogicalKeyboardKey.digit3);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump(const Duration(milliseconds: 100));

      // Cue is pointing at the bottom bar of RadonCanvas
      final cueIconFinder = find.descendant(
        of: find.byType(InteractionCueOverlay),
        matching: find.byIcon(Icons.touch_app),
      );
      expect(cueIconFinder, findsOneWidget);

      final Rect radonRect = tester.getRect(find.byType(RadonCanvas));
      final Offset cuePos = tester.getCenter(cueIconFinder);

      // In a tall window, RadonCanvas is taller than wide.
      // The square canvas is vertically centered inside RadonCanvas.
      final double squareSize = radonRect.width;
      final double squareCenterY = radonRect.top + radonRect.height * 0.5;
      final double canvasBottomBarY = squareCenterY + squareSize * 0.5 - 7.0;

      // Cue must be centered on the bottom bar of the square canvas,
      // NOT at the bottom of the window/RadonCanvas.
      expect(cuePos.dy, closeTo(canvasBottomBarY, 3.0));
      expect(cuePos.dy, lessThan(radonRect.bottom - 50.0));
    },
  );

  testWidgets(
    'Space key and Play Scan button toggle continuous angle sweep rotation',
    (WidgetTester tester) async {
      await tester.pumpWidget(const CatApp());
      await tester.pumpAndSettle();

      // Jump to Stage 5
      await tester.sendKeyEvent(LogicalKeyboardKey.digit5);
      await tester.pumpAndSettle();

      expect(find.textContaining('Play Scan [Space]'), findsOneWidget);

      // Press Space to start rotation
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.textContaining('Pause [Space]'), findsOneWidget);

      // Press Space to pause rotation
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.textContaining('Play Scan [Space]'), findsOneWidget);
    },
  );

  testWidgets('Stage 7 Free Play supports adding and deleting phantoms', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const CatApp());
    await tester.pumpAndSettle();

    // Jump to Stage 7
    await tester.sendKeyEvent(LogicalKeyboardKey.digit7);
    await tester.pumpAndSettle();

    expect(find.textContaining('Stage 7: Free Play'), findsOneWidget);

    // Verify Add and Delete buttons
    final addButton = find.byTooltip('Add phantom disk');
    final deleteButton = find.byTooltip('Delete selected phantom');
    expect(addButton, findsOneWidget);
    expect(deleteButton, findsOneWidget);

    // Tap Add phantom
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    final objectCanvas = tester.widget<ObjectCanvas>(find.byType(ObjectCanvas));
    expect(objectCanvas.engine.phantoms.length, 2);
    expect(objectCanvas.engine.selectedPhantomIndex, 1);

    // Tap Delete phantom
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    expect(objectCanvas.engine.phantoms.length, 1);
  });

  testWidgets(
    'Stage 5 Step 3 shows theta bar cue and Step 4 shows play button cue',
    (WidgetTester tester) async {
      await tester.pumpWidget(const CatApp());
      await tester.pumpAndSettle();

      // Jump to Stage 5
      await tester.sendKeyEvent(LogicalKeyboardKey.digit5);
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Stage 5: Cross Section of Data'),
        findsOneWidget,
      );

      // Advance to Step 2
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      // Advance to Step 3 (theta bar cue)
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump(const Duration(milliseconds: 100));

      final cueThetaFinder = find.descendant(
        of: find.byType(InteractionCueOverlay),
        matching: find.byIcon(Icons.touch_app),
      );
      expect(cueThetaFinder, findsOneWidget);

      final Rect radonRect = tester.getRect(find.byType(RadonCanvas));
      final Offset cueThetaPos = tester.getCenter(cueThetaFinder);

      // Cue should be located at the right edge of the square canvas
      expect(cueThetaPos.dx, greaterThan(radonRect.center.dx));

      // Advance to Step 4 (play button cue)
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump(const Duration(milliseconds: 100));

      expect(
        find.textContaining('Click "Play Scan"'),
        findsOneWidget,
      );

      // Play button cue in GraphCanvas should be showing the hovering hand icon
      final playCueFinder = find.descendant(
        of: find.byType(GraphCanvas),
        matching: find.byIcon(Icons.touch_app),
      );
      expect(playCueFinder, findsOneWidget);

      final Rect playButtonRect = tester.getRect(
        find.widgetWithText(InkWell, 'Play Scan [Space]'),
      );
      final Offset playCuePos = tester.getCenter(playCueFinder);

      // Cue should be hovering over the play button
      expect(playCuePos.dx, closeTo(playButtonRect.left + 15.0, 15.0));
      expect(playCuePos.dy, lessThan(playButtonRect.center.dy));

      // Tapping the Play Scan button starts scan rotation and dismisses cue
      await tester.tap(find.text('Play Scan [Space]'));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Pause [Space]'), findsOneWidget);
      expect(playCueFinder, findsNothing);

      // Stop rotation
      await tester.tap(find.text('Pause [Space]'));
      await tester.pump(const Duration(milliseconds: 100));
    },
  );

  testWidgets(
    'Light mode renders white graph backgrounds and dark lines/text',
    (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final settings = AppSettings();
      await settings.setThemeMode(ThemeMode.light);

      await tester.pumpWidget(CatApp(settings: settings));
      await tester.pump(const Duration(milliseconds: 100));

      // In Stage 1, ObjectCanvas is visible with isLight == true
      final customPaintFinder = find.descendant(
        of: find.byType(ObjectCanvas),
        matching: find.byType(CustomPaint),
      );
      final customPaint = tester.widget<CustomPaint>(customPaintFinder.first);
      final objectPainter = customPaint.painter as ObjectCanvasPainter;
      expect(objectPainter.isLight, isTrue);

      // Jump to Stage 5 where all three (Object, Radon, Graph) are visible
      await tester.sendKeyEvent(LogicalKeyboardKey.digit5);
      await tester.pump(const Duration(milliseconds: 100));

      // Verify cue hand icon color in light mode is lighter blue (0xFF42A5F5)
      final cueHandFinder = find.descendant(
        of: find.byType(InteractionCueOverlay),
        matching: find.byIcon(Icons.pan_tool_alt),
      );
      expect(cueHandFinder, findsOneWidget);
      final Icon handIcon = tester.widget<Icon>(cueHandFinder.first);
      expect(handIcon.color, const Color(0xFF42A5F5));

      // RadonCanvas painter in light mode
      final radonCustomPaintFinder = find.descendant(
        of: find.byType(RadonCanvas),
        matching: find.byType(CustomPaint),
      );
      final radonPainter =
          tester.widget<CustomPaint>(radonCustomPaintFinder.first).painter
              as RadonCanvasPainter;
      expect(radonPainter.isLight, isTrue);

      // GraphCanvas in light mode: container is white and painter is light
      final graphCanvasFinder = find.byType(GraphCanvas);
      expect(graphCanvasFinder, findsOneWidget);

      final containerFinder = find.descendant(
        of: graphCanvasFinder,
        matching: find.byType(Container),
      );
      final Container graphContainer =
          tester.widget<Container>(containerFinder.first);
      final BoxDecoration decor = graphContainer.decoration as BoxDecoration;
      expect(decor.color, Colors.white);

      final graphCustomPaintFinder = find.descendant(
        of: graphCanvasFinder,
        matching: find.byType(CustomPaint),
      );
      final graphPainter =
          tester.widget<CustomPaint>(graphCustomPaintFinder.first).painter
              as GraphCanvasPainter;
      expect(graphPainter.isLight, isTrue);

      // Switch to dark mode
      await settings.setThemeMode(ThemeMode.dark);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      final Container darkGraphContainer =
          tester.widget<Container>(containerFinder.first);
      final BoxDecoration darkDecor =
          darkGraphContainer.decoration as BoxDecoration;
      expect(darkDecor.color, const Color(0xFF0F0F14));

      final darkGraphPainter =
          tester.widget<CustomPaint>(graphCustomPaintFinder.first).painter
              as GraphCanvasPainter;
      expect(darkGraphPainter.isLight, isFalse);
    },
  );
}
