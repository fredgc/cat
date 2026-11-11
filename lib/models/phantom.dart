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

/// Represents a circular disk phantom in 2D object space with uniform attenuation.
///
/// In computerized axial tomography, a phantom is a known physical or mathematical
/// test object used to analyze and verify projection and reconstruction algorithms.
class PhantomDisk {
  /// Center x-coordinate in normalized object space [-1.0, 1.0].
  final double x;

  /// Center y-coordinate in normalized object space [-1.0, 1.0].
  final double y;

  /// Radius of the circular disk in object space units.
  final double radius;

  /// Uniform attenuation density inside the disk (default 1.0).
  final double density;

  /// Creates a [PhantomDisk].
  ///
  /// Defaults to center (0.2, 0.3) and radius 0.2 (doubled from original 0.1).
  const PhantomDisk({
    this.x = 0.2,
    this.y = 0.3,
    this.radius = 0.2,
    this.density = 1.0,
  });

  /// Computes the chord length (X-ray line integral) for a line defined by:
  /// x * cos(theta) + y * sin(theta) = r
  ///
  /// The distance from the center (x, y) to the line is:
  /// s_c = x * cos(theta) + y * sin(theta)
  /// Delta s = r - s_c
  ///
  /// If |Delta s| < radius, chord length is 2 * sqrt(radius^2 - (Delta s)^2).
  /// Otherwise, the line does not intersect the disk and chord length is 0.0.
  double chordLength(double r, double cosTheta, double sinTheta) {
    final double sc = x * cosTheta + y * sinTheta;
    final double ds = r - sc;
    final double d = radius * radius - ds * ds;
    if (d <= 0.0) {
      return 0.0;
    }
    return 2.0 * math.sqrt(d) * density;
  }

  /// Returns whether a test point (px, py) is strictly or tangentially inside the phantom disk.
  bool containsPoint(double px, double py) {
    final double dx = px - x;
    final double dy = py - y;
    return (dx * dx + dy * dy) <= (radius * radius);
  }

  /// Returns a new [PhantomDisk] translated to [newX, newY], clamped within
  /// [minBound, maxBound] to prevent the disk from leaving the viewport.
  PhantomDisk moveTo(
    double newX,
    double newY, {
    double minBound = -0.8,
    double maxBound = 0.8,
  }) {
    final double clampedX = newX.clamp(minBound, maxBound);
    final double clampedY = newY.clamp(minBound, maxBound);
    return copyWith(x: clampedX, y: clampedY);
  }

  /// Creates a copy of this phantom with the given fields replaced.
  PhantomDisk copyWith({
    double? x,
    double? y,
    double? radius,
    double? density,
  }) {
    return PhantomDisk(
      x: x ?? this.x,
      y: y ?? this.y,
      radius: radius ?? this.radius,
      density: density ?? this.density,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhantomDisk &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y &&
          radius == other.radius &&
          density == other.density;

  @override
  int get hashCode => Object.hash(x, y, radius, density);

  @override
  String toString() =>
      'PhantomDisk(center: ($x, $y), radius: $radius, density: $density)';
}
