// Unit tests for PhantomDisk and RadonEngine.

import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:cat/models/phantom.dart';
import 'package:cat/models/radon_engine.dart';

void main() {
  group('PhantomDisk tests', () {
    test('Default values match original specification', () {
      const phantom = PhantomDisk();
      expect(phantom.x, 0.2);
      expect(phantom.y, 0.3);
      expect(phantom.radius, 0.2);
      expect(phantom.density, 1.0);
    });

    test('containsPoint detects inside, boundary, and outside points', () {
      const phantom = PhantomDisk(x: 0.0, y: 0.0, radius: 0.2);

      // Center
      expect(phantom.containsPoint(0.0, 0.0), isTrue);
      // Inside
      expect(phantom.containsPoint(0.1, 0.1), isTrue);
      // Boundary
      expect(phantom.containsPoint(0.2, 0.0), isTrue);
      // Outside
      expect(phantom.containsPoint(0.21, 0.0), isFalse);
      expect(phantom.containsPoint(0.5, 0.5), isFalse);
    });

    test('chordLength analytical calculation', () {
      const phantom = PhantomDisk(x: 0.0, y: 0.0, radius: 0.1);

      // Line passing through center: theta = 0, r = 0 => x*cos(0) + y*sin(0) = 0 => x = 0
      // Chord length is diameter = 2 * r = 0.2
      final double diameter = phantom.chordLength(0.0, 1.0, 0.0);
      expect(diameter, closeTo(0.2, 1e-9));

      // Line at distance 0.06 from center: sqrt(0.01 - 0.0036) = sqrt(0.0064) = 0.08 => 2 * 0.08 = 0.16
      final double chord = phantom.chordLength(0.06, 1.0, 0.0);
      expect(chord, closeTo(0.16, 1e-9));

      // Tangent line at distance 0.1
      final double tangent = phantom.chordLength(0.1, 1.0, 0.0);
      expect(tangent, closeTo(0.0, 1e-9));

      // Non-intersecting line at distance 0.2
      final double outside = phantom.chordLength(0.2, 1.0, 0.0);
      expect(outside, equals(0.0));
    });

    test('moveTo and clamp to bounds', () {
      const phantom = PhantomDisk(x: 0.0, y: 0.0);
      final moved = phantom.moveTo(0.5, -0.4);
      expect(moved.x, 0.5);
      expect(moved.y, -0.4);

      // Beyond bounds
      final clamped = phantom.moveTo(1.2, -1.5, minBound: -0.8, maxBound: 0.8);
      expect(clamped.x, 0.8);
      expect(clamped.y, -0.8);
    });
  });

  group('RadonEngine tests', () {
    test('Grid dimensions and precomputed trigonometric tables', () {
      final engine = RadonEngine(p: 50, q: 50);

      expect(engine.numAngles, 100);
      expect(engine.numRadialSamples, 100);
      expect(engine.cosTable.length, 100);
      expect(engine.sinTable.length, 100);

      // theta = 0: cos = 1, sin = 0
      expect(engine.cosTable[0], closeTo(1.0, 1e-9));
      expect(engine.sinTable[0], closeTo(0.0, 1e-9));

      // theta = pi (j = 50): cos = -1, sin = 0
      expect(engine.cosTable[50], closeTo(-1.0, 1e-9));
      expect(engine.sinTable[50], closeTo(0.0, 1e-9));

      // Pythagorean identity across all sample angles
      for (int j = 0; j < engine.numAngles; j++) {
        final double cosVal = engine.cosTable[j];
        final double sinVal = engine.sinTable[j];
        expect(cosVal * cosVal + sinVal * sinVal, closeTo(1.0, 1e-9));
      }
    });

    test('Coordinate index conversions', () {
      final engine = RadonEngine(p: 50, q: 50);

      expect(engine.rForIndex(0), closeTo(-1.0, 1e-9));
      expect(engine.rForIndex(50), closeTo(0.0, 1e-9));
      expect(engine.rForIndex(99), closeTo(0.98, 1e-9));

      expect(engine.indexForR(-1.0), 0);
      expect(engine.indexForR(0.0), 50);
      expect(engine.indexForR(1.0), 99);

      expect(engine.thetaForIndex(0), closeTo(0.0, 1e-9));
      expect(engine.thetaForIndex(50), closeTo(math.pi, 1e-9));
      expect(engine.indexForTheta(0.0), 0);
      expect(engine.indexForTheta(math.pi), 50);
    });

    test('Frank Natterer ramp filter kernel w_b properties', () {
      final engine = RadonEngine(p: 50, q: 50);

      // Kernel peak at l = 0: b^2 / pi^4 = Q^2 / pi^2 = 2500 / pi^2
      final double expectedW0 = (50.0 * 50.0) / (math.pi * math.pi);
      expect(engine.wb(0), closeTo(expectedW0, 1e-6));

      // Kernel symmetry: w_b(l) = w_b(-l)
      for (int l = 1; l <= 20; l++) {
        expect(engine.wb(l), equals(engine.wb(-l)));
        // Negative for all non-zero integers because 1 - 4*l^2 < 0
        expect(engine.wb(l), lessThan(0.0));
      }

      // Decay property: |w_b(l)| decreases monotonically as |l| increases
      for (int l = 1; l < 20; l++) {
        expect(engine.wb(l).abs(), greaterThan(engine.wb(l + 1).abs()));
      }
    });

    test('Precomputed centered profiles psi and wpsi', () {
      final engine = RadonEngine(p: 50, q: 50);

      expect(engine.psi.length, 200);
      expect(engine.wpsi.length, 200);

      // Center index is 2*Q = 100 (where s = 0)
      // Chord length at center is 2 * r_p = 0.4
      expect(engine.psi[100], closeTo(0.4, 1e-9));

      // Far away from center (|s| > radius 0.2, step h = 0.02 => 10 steps away)
      // Index 100 + 11 = 111 has s = 0.22 > 0.2 => 0.0
      expect(engine.psi[111], equals(0.0));
      expect(engine.psi[89], equals(0.0));
    });

    test('Filtered vs unfiltered backprojection reconstruction', () {
      // Phantom at center (0.2, 0.3) with radius 0.1
      final engine = RadonEngine(
        p: 50,
        q: 50,
        phantom: const PhantomDisk(x: 0.2, y: 0.3, radius: 0.1),
      );

      // 1. Probe exactly at phantom center (0.2, 0.3)
      engine.setProbePoint(0.2, 0.3);

      // Unfiltered backprojection evaluates to non-zero blur
      engine.setFiltered(false);
      expect(engine.backprojectionValue, greaterThan(0.0));

      // Filtered backprojection inside phantom evaluates to approximately 1.0 (density)
      engine.setFiltered(true);
      expect(engine.backprojectionValue, closeTo(1.0, 0.05));
      expect(engine.filteredBackprojectionValue, closeTo(1.0, 0.05));
      expect(engine.unfilteredBackprojectionValue, greaterThan(0.5));
      expect(engine.unfilteredProfile.length, engine.numAngles);
      expect(engine.filteredProfile.length, engine.numAngles);

      // 2. Probe off-center but still inside phantom: (0.25, 0.3) => distance 0.05 < radius 0.1
      engine.setProbePoint(0.25, 0.3);
      expect(engine.backprojectionValue, closeTo(1.0, 0.05));

      // 3. Probe far outside phantom: (0.5, 0.5) => distance = sqrt(0.3^2 + 0.2^2) = 0.36 >> 0.1
      engine.setProbePoint(0.5, 0.5);
      // Filtered backprojection outside evaluates close to 0.0
      expect(engine.backprojectionValue.abs(), lessThan(0.06));

      // In unfiltered mode, the outside retains a noticeable blur tail (greater than filtered)
      engine.setFiltered(false);
      final double unfilteredOutsideVal = engine.backprojectionValue;
      engine.setFiltered(true);
      final double filteredOutsideVal = engine.backprojectionValue;
      expect(filteredOutsideVal.abs(), lessThan(unfilteredOutsideVal.abs()));
    });

    test('ChangeNotifier and probe mode updates', () {
      final engine = RadonEngine(p: 50, q: 50);

      int notifyCount = 0;
      engine.addListener(() {
        notifyCount++;
      });

      // Probe point
      engine.setProbePoint(0.1, -0.2);
      expect(engine.probeMode, ProbeMode.point);
      expect(engine.probeX, 0.1);
      expect(engine.probeY, -0.2);
      expect(notifyCount, 1);

      // Filtered toggle
      engine.setFiltered(true);
      expect(engine.filtered, isTrue);
      expect(notifyCount, 2);

      // Probe sinogram line
      engine.setProbeSinogram(30, 45);
      expect(engine.probeMode, ProbeMode.line);
      expect(engine.probeRIndex, 30);
      expect(engine.probeThetaIndex, 45);
      expect(notifyCount, 3);

      // Probe theta
      engine.setProbeTheta(20);
      expect(engine.probeMode, ProbeMode.theta);
      expect(engine.probeThetaIndex, 20);
      expect(notifyCount, 4);

      // Probe sline
      engine.setProbeR(40);
      expect(engine.probeMode, ProbeMode.sline);
      expect(engine.probeRIndex, 40);
      expect(notifyCount, 5);

      // Move phantom
      engine.setPhantomPosition(-0.1, 0.4);
      expect(engine.phantom.x, -0.1);
      expect(engine.phantom.y, 0.4);
      expect(notifyCount, 6);
    });

    test('Multi-phantom management, linearity, and reconstruction', () {
      const diskA = PhantomDisk(x: -0.3, y: -0.2, radius: 0.15, density: 1.0);
      const diskB = PhantomDisk(x: 0.3, y: 0.4, radius: 0.12, density: 1.0);

      final engineA = RadonEngine(phantom: diskA);
      final engineB = RadonEngine(phantom: diskB);
      final multiEngine = RadonEngine(phantoms: [diskA, diskB]);

      expect(multiEngine.phantoms.length, 2);
      expect(multiEngine.selectedPhantomIndex, 0);
      expect(multiEngine.phantom.x, -0.3);

      // Verify linearity of Radon transform across sinogram grid
      for (int t = 0; t < multiEngine.numAngles; t += 10) {
        for (int r = 0; r < multiEngine.numRadialSamples; r += 10) {
          final double valA = engineA.getSinogramValue(r, t);
          final double valB = engineB.getSinogramValue(r, t);
          final double valMulti = multiEngine.getSinogramValue(r, t);
          expect(valMulti, closeTo(valA + valB, 1e-9));
        }
      }

      // Inside point test
      expect(multiEngine.isInsideAnyPhantom(-0.3, -0.2), isTrue);
      expect(multiEngine.isInsideAnyPhantom(0.3, 0.4), isTrue);
      expect(multiEngine.isInsideAnyPhantom(0.0, 0.0), isFalse);

      // Filtered backprojection at center of disk A
      multiEngine.setFiltered(true);
      multiEngine.setProbePoint(-0.3, -0.2);
      expect(multiEngine.backprojectionValue, closeTo(1.0, 0.10));

      // Filtered backprojection at center of disk B
      multiEngine.setProbePoint(0.3, 0.4);
      expect(multiEngine.backprojectionValue, closeTo(1.0, 0.10));

      // Filtered backprojection outside both disks
      multiEngine.setProbePoint(0.0, 0.0);
      expect(multiEngine.backprojectionValue.abs(), lessThan(0.06));

      // Selection and addition
      multiEngine.addPhantom(
        const PhantomDisk(x: 0.0, y: -0.5, radius: 0.1, density: 1.0),
      );
      expect(multiEngine.phantoms.length, 3);
      expect(multiEngine.selectedPhantomIndex, 2);
      expect(multiEngine.phantom.y, -0.5);

      // Select disk 1
      multiEngine.selectPhantom(1);
      expect(multiEngine.selectedPhantomIndex, 1);
      expect(multiEngine.phantom.x, 0.3);

      // Remove selected disk (disk B)
      multiEngine.removeSelectedPhantom();
      expect(multiEngine.phantoms.length, 2);
      expect(multiEngine.isInsideAnyPhantom(0.3, 0.4), isFalse);

      // Cannot remove last phantom
      multiEngine.removeSelectedPhantom();
      expect(multiEngine.phantoms.length, 1);
      multiEngine.removeSelectedPhantom(); // No-op
      expect(multiEngine.phantoms.length, 1);
    });
  });
}
