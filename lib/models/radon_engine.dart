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

import 'package:flutter/foundation.dart';

import 'phantom.dart';

/// Interaction mode defining what probe or family of lines is currently selected.
enum ProbeMode {
  /// No probe selected.
  none,

  /// Point probe (x_p, y_p) in object space.
  /// Corresponds to all lines through the point, tracing a sinusoidal curve
  /// r(theta) = x_p * cos(theta) + y_p * sin(theta) in sinogram space.
  point,

  /// Single line probe (r_s, theta_s) in sinogram space.
  /// Corresponds to line x * cos(theta_s) + y * sin(theta_s) = r_s in object space,
  /// with a perpendicular normal vector from the origin.
  line,

  /// Family of parallel lines at a constant projection angle theta.
  theta,

  /// Family of lines tangent to a circle of radius |r|.
  sline,
}

/// Interaction target when clicking or dragging in Object Space.
enum ObjectInteractionMode {
  /// Pointer interactions move the probe point (x, y).
  probe,

  /// Pointer interactions reposition the phantom disk.
  phantom,
}

class _PhantomEntry {
  PhantomDisk disk;
  final Float64List psi;
  final Float64List wpsi;

  _PhantomEntry({required this.disk, required this.psi, required this.wpsi});
}

/// Core mathematical engine for Computed Axial Tomography and the Radon Transform.
///
/// Discretizes the continuous Radon transform:
/// - Angular range [0, 2*pi) discretized into 2*P samples: theta_j = pi * j / P.
/// - Radial range [-1.0, 1.0] discretized into 2*Q samples: r_i = (i - Q) / Q, step h = 1 / Q.
///
/// Implements Frank Natterer's discrete ramp filter kernel w_b(l) for Filtered Backprojection (FBP).
class RadonEngine extends ChangeNotifier {
  /// Number of angular half-periods (default 50 => 2*P = 100 angle samples).
  final int p;

  /// Number of radial half-samples (default 50 => 2*Q = 100 radial samples).
  final int q;

  /// Step size for radial discretization: h = 1 / Q.
  late final double h;

  /// Bandwidth parameter for Natterer ramp filter: b = pi * Q.
  late final double b;

  /// Total number of angular samples: 2 * P.
  int get numAngles => 2 * p;

  /// Total number of radial samples: 2 * Q.
  int get numRadialSamples => 2 * q;

  // Precomputed trigonometric tables for theta_j = pi * j / P.
  late final Float64List cosTable;
  late final Float64List sinTable;
  late final Float64List thetaTable;

  // Active state
  final List<PhantomDisk> _phantoms = [];
  final List<_PhantomEntry> _phantomEntries = [];
  int _selectedPhantomIndex = 0;
  int _version = 0;
  bool _filtered;
  ProbeMode _probeMode;
  ObjectInteractionMode _objectInteractionMode = ObjectInteractionMode.probe;

  // Probe coordinates in object space [-1.0, 1.0]
  double _probeX = 0.0;
  double _probeY = 0.0;

  // Probe indices in sinogram space [0, 2*Q - 1] and [0, 2*P - 1]
  int _probeRIndex;
  int _probeThetaIndex;

  // 1D Profile curve values along active probe trajectory
  late Float64List _profile;
  late Float64List _unfilteredProfile;
  late Float64List _filteredProfile;

  // Calculated backprojection integral
  double _backprojectionIntegral = 0.0;
  double _backprojectionValue = 0.0;
  double _unfilteredBackprojectionValue = 0.0;
  double _filteredBackprojectionValue = 0.0;

  /// Creates a [RadonEngine] instance.
  RadonEngine({
    this.p = 50,
    this.q = 50,
    PhantomDisk? phantom,
    List<PhantomDisk>? phantoms,
    bool initialFiltered = false,
    ProbeMode initialProbeMode = ProbeMode.none,
  }) : _filtered = initialFiltered,
       _probeMode = initialProbeMode,
       _probeRIndex = q,
       _probeThetaIndex = 0 {
    h = 1.0 / q;
    b = math.pi * q;

    cosTable = Float64List(numAngles);
    sinTable = Float64List(numAngles);
    thetaTable = Float64List(numAngles);

    for (int j = 0; j < numAngles; j++) {
      final double theta = math.pi * j / p;
      thetaTable[j] = theta;
      cosTable[j] = math.cos(theta);
      sinTable[j] = math.sin(theta);
    }

    _profile = Float64List(numAngles);
    _unfilteredProfile = Float64List(numAngles);
    _filteredProfile = Float64List(numAngles);

    final initialList = phantoms ?? [phantom ?? const PhantomDisk()];
    for (final d in initialList) {
      _phantoms.add(d);
      _phantomEntries.add(_createPhantomEntry(d));
    }

    compute();
  }

  // Getters for current state
  int get version => _version;
  List<PhantomDisk> get phantoms => List.unmodifiable(_phantoms);
  int get selectedPhantomIndex => _selectedPhantomIndex;
  PhantomDisk get phantom => _phantoms.isEmpty
      ? const PhantomDisk()
      : _phantoms[_selectedPhantomIndex.clamp(0, _phantoms.length - 1)];

  Float64List get psi => _phantomEntries.isEmpty
      ? Float64List(4 * q)
      : _phantomEntries[_selectedPhantomIndex.clamp(
              0,
              _phantomEntries.length - 1,
            )]
            .psi;
  Float64List get wpsi => _phantomEntries.isEmpty
      ? Float64List(4 * q)
      : _phantomEntries[_selectedPhantomIndex.clamp(
              0,
              _phantomEntries.length - 1,
            )]
            .wpsi;

  bool get filtered => _filtered;
  ProbeMode get probeMode => _probeMode;
  double get probeX => _probeX;
  double get probeY => _probeY;
  int get probeRIndex => _probeRIndex;
  int get probeThetaIndex => _probeThetaIndex;
  Float64List get profile => _profile;
  Float64List get unfilteredProfile => _unfilteredProfile;
  Float64List get filteredProfile => _filteredProfile;
  double get backprojectionIntegral => _backprojectionIntegral;
  double get backprojectionValue => _backprojectionValue;
  double get unfilteredBackprojectionValue => _unfilteredBackprojectionValue;
  double get filteredBackprojectionValue => _filteredBackprojectionValue;
  ObjectInteractionMode get objectInteractionMode => _objectInteractionMode;

  /// Sets whether Object Space interactions target probe points or phantom disks.
  void setObjectInteractionMode(ObjectInteractionMode mode) {
    if (_objectInteractionMode != mode) {
      _objectInteractionMode = mode;
      notifyListeners();
    }
  }

  /// Returns the radial value r for sample index [i] in [0, 2*Q - 1].
  double rForIndex(int i) => (i - q) / q;

  /// Returns the angle theta for sample index [j] in [0, 2*P - 1].
  double thetaForIndex(int j) => thetaTable[j];

  /// Returns sample index in [0, 2*Q - 1] closest to radial value [r] in [-1.0, 1.0].
  int indexForR(double r) {
    final int idx = ((r + 1.0) * q).round();
    return idx.clamp(0, numRadialSamples - 1);
  }

  /// Returns sample index in [0, 2*P - 1] closest to angle [theta] in [0, 2*pi).
  int indexForTheta(double theta) {
    double normalized = theta % (2.0 * math.pi);
    if (normalized < 0.0) normalized += 2.0 * math.pi;
    final int idx = (normalized * p / math.pi).round();
    return idx % numAngles;
  }

  /// Frank Natterer's discrete filter kernel w_b(l) (Eq. 1.23, p. 111):
  /// w_b(l) = b^2 / (pi^4 * (1 - 4 * l^2)), where b = pi * Q.
  ///
  /// For any integer l, 1 - 4*l^2 is never zero.
  double wb(int l) {
    return (b * b) / (math.pow(math.pi, 4) * (1.0 - 4.0 * l * l));
  }

  /// Creates precomputed profile tables for a phantom disk.
  _PhantomEntry _createPhantomEntry(PhantomDisk disk) {
    final Float64List entryPsi = Float64List(4 * q);
    final Float64List entryWpsi = Float64List(4 * q);

    final double r = disk.radius;
    final double rSq = r * r;
    final double density = disk.density;

    for (int i = 0; i < 4 * q; i++) {
      final double s = (i - 2.0 * q) / q;
      final double d = rSq - s * s;
      if (d <= 0.0) {
        entryPsi[i] = 0.0;
      } else {
        entryPsi[i] = 2.0 * math.sqrt(d) * density;
      }
    }

    for (int k = 0; k < 4 * q; k++) {
      double sum = 0.0;
      for (int l = 0; l < 4 * q; l++) {
        sum += entryPsi[l] * wb(k - l);
      }
      entryWpsi[k] = sum * h;
    }

    return _PhantomEntry(disk: disk, psi: entryPsi, wpsi: entryWpsi);
  }

  /// Evaluates sinogram value g(r, theta) for grid sample indices [rIdx] and [thetaIdx].
  ///
  /// Sums projection contributions across all phantom disks.
  double getSinogramValue(int rIdx, int thetaIdx, {bool? useFiltered}) {
    final bool isFilt = useFiltered ?? _filtered;
    double total = 0.0;
    for (final entry in _phantomEntries) {
      final Float64List table = isFilt ? entry.wpsi : entry.psi;
      final double sc =
          entry.disk.x * cosTable[thetaIdx] + entry.disk.y * sinTable[thetaIdx];
      final int scIndex = (q * sc).round();
      final int tableIndex = (q + rIdx - scIndex).clamp(0, 4 * q - 1);
      total += table[tableIndex];
    }
    return total;
  }

  /// Sets the phantom object and recalculates tables if radius/density changed.
  void setPhantom(PhantomDisk newPhantom, [int? index]) {
    if (_phantoms.isEmpty) {
      addPhantom(newPhantom);
      return;
    }
    final int targetIndex = (index ?? _selectedPhantomIndex).clamp(
      0,
      _phantoms.length - 1,
    );
    final bool radiusChanged =
        newPhantom.radius != _phantoms[targetIndex].radius ||
        newPhantom.density != _phantoms[targetIndex].density;
    _phantoms[targetIndex] = newPhantom;
    if (radiusChanged) {
      _phantomEntries[targetIndex] = _createPhantomEntry(newPhantom);
    } else {
      _phantomEntries[targetIndex].disk = newPhantom;
    }
    _version++;
    compute();
    notifyListeners();
  }

  /// Moves the phantom center to (newX, newY).
  void setPhantomPosition(double newX, double newY, [int? index]) {
    final int targetIndex = (index ?? _selectedPhantomIndex).clamp(
      0,
      _phantoms.length - 1,
    );
    if (_phantoms.isEmpty) return;
    setPhantom(_phantoms[targetIndex].moveTo(newX, newY), targetIndex);
  }

  /// Selects the phantom at [index].
  void selectPhantom(int index) {
    if (index >= 0 &&
        index < _phantoms.length &&
        _selectedPhantomIndex != index) {
      _selectedPhantomIndex = index;
      notifyListeners();
    }
  }

  /// Adds a new phantom disk and selects it.
  void addPhantom([PhantomDisk? disk]) {
    final double offset = (_phantoms.length * 0.2) % 0.6;
    final PhantomDisk newDisk =
        disk ??
        PhantomDisk(
          x: (-0.3 + offset).clamp(-0.7, 0.7),
          y: (-0.3 + offset).clamp(-0.7, 0.7),
          radius: 0.15,
          density: 1.0,
        );
    _phantoms.add(newDisk);
    _phantomEntries.add(_createPhantomEntry(newDisk));
    _selectedPhantomIndex = _phantoms.length - 1;
    _version++;
    compute();
    notifyListeners();
  }

  /// Removes the currently selected phantom (keeping at least 1 phantom).
  void removeSelectedPhantom() {
    if (_phantoms.length <= 1) return;
    _phantoms.removeAt(_selectedPhantomIndex);
    _phantomEntries.removeAt(_selectedPhantomIndex);
    if (_selectedPhantomIndex >= _phantoms.length) {
      _selectedPhantomIndex = _phantoms.length - 1;
    }
    _version++;
    compute();
    notifyListeners();
  }

  /// Returns whether a test point (px, py) is inside any phantom disk.
  bool isInsideAnyPhantom(double px, double py) {
    for (final p in _phantoms) {
      if (p.containsPoint(px, py)) return true;
    }
    return false;
  }

  /// Sets the filtered mode (true for filtered backprojection, false for unfiltered).
  void setFiltered(bool value) {
    if (_filtered != value) {
      _filtered = value;
      _version++;
      compute();
      notifyListeners();
    }
  }

  /// Sets the probe mode.
  void setProbeMode(ProbeMode mode) {
    if (_probeMode != mode) {
      _probeMode = mode;
      compute();
      notifyListeners();
    }
  }

  /// Sets the probe point (x, y) in object space.
  void setProbePoint(double x, double y) {
    _probeMode = ProbeMode.point;
    _probeX = x;
    _probeY = y;
    compute();
    notifyListeners();
  }

  /// Sets the probe line from sinogram indices.
  void setProbeSinogram(int rIdx, int thetaIdx) {
    _probeMode = ProbeMode.line;
    _probeRIndex = rIdx.clamp(0, numRadialSamples - 1);
    _probeThetaIndex = thetaIdx.clamp(0, numAngles - 1);
    compute();
    notifyListeners();
  }

  /// Sets probe to constant angle theta (parallel beam across all r).
  void setProbeTheta(int thetaIdx) {
    _probeMode = ProbeMode.theta;
    _probeThetaIndex = thetaIdx.clamp(0, numAngles - 1);
    compute();
    notifyListeners();
  }

  /// Sets probe to constant radial offset r (tangent circle across all theta).
  void setProbeR(int rIdx) {
    _probeMode = ProbeMode.sline;
    _probeRIndex = rIdx.clamp(0, numRadialSamples - 1);
    compute();
    notifyListeners();
  }

  /// Calculates the 1D profile curve and backprojection integral according to active mode.
  void compute() {
    switch (_probeMode) {
      case ProbeMode.none:
        _profile.fillRange(0, _profile.length, 0.0);
        _unfilteredProfile.fillRange(0, _unfilteredProfile.length, 0.0);
        _filteredProfile.fillRange(0, _filteredProfile.length, 0.0);
        _backprojectionIntegral = 0.0;
        _backprojectionValue = 0.0;
        _unfilteredBackprojectionValue = 0.0;
        _filteredBackprojectionValue = 0.0;
        break;

      case ProbeMode.point:
        _computePointProfile();
        break;

      case ProbeMode.line:
        _computeLineProfile();
        break;

      case ProbeMode.theta:
        _computeThetaProfile();
        break;

      case ProbeMode.sline:
        _computeSLineProfile();
        break;
    }
  }

  /// Computes 1D profile along the sinusoid r(theta) = probeX * cos(theta) + probeY * sin(theta).
  void _computePointProfile() {
    if (_profile.length != numAngles) {
      _profile = Float64List(numAngles);
      _unfilteredProfile = Float64List(numAngles);
      _filteredProfile = Float64List(numAngles);
    }
    _profile.fillRange(0, numAngles, 0.0);
    _unfilteredProfile.fillRange(0, numAngles, 0.0);
    _filteredProfile.fillRange(0, numAngles, 0.0);

    for (final disk in _phantoms) {
      final double px = disk.x;
      final double py = disk.y;
      final double rSq = disk.radius * disk.radius;
      final double density = disk.density;

      for (int t = 0; t < numAngles; t++) {
        final double cost = cosTable[t];
        final double sint = sinTable[t];
        final double sc = px * cost + py * sint;
        final double s = _probeX * cost + _probeY * sint;
        final double ds = s - sc;

        final double d = rSq - ds * ds;
        if (d > 0.0) {
          _unfilteredProfile[t] += 2.0 * math.sqrt(d) * density;
        }

        double val = 0.0;
        // High-precision convolution with Natterer kernel
        for (int l = -15; l <= 15; l++) {
          final double dsl = ds - h * l;
          final double dl = rSq - dsl * dsl;
          if (dl > 0.0) {
            val += 2.0 * math.sqrt(dl) * density * h * wb(l);
          }
        }
        _filteredProfile[t] += val;
      }
    }

    double sumUnfilt = 0.0;
    double sumFilt = 0.0;
    for (int t = 0; t < numAngles; t++) {
      _profile[t] = _filtered ? _filteredProfile[t] : _unfilteredProfile[t];
      sumUnfilt += _unfilteredProfile[t];
      sumFilt += _filteredProfile[t];
    }
    _unfilteredBackprojectionValue = 2.0 * math.pi * (sumUnfilt / numAngles);
    _filteredBackprojectionValue = 2.0 * math.pi * (sumFilt / numAngles);
    _backprojectionIntegral = (_filtered ? sumFilt : sumUnfilt) / numAngles;
    // Reconstruction evaluates to: 2 * pi * (average over [0, 2*pi))
    _backprojectionValue = 2.0 * math.pi * _backprojectionIntegral;
  }

  /// Computes 1D spatial intensity profile along a single X-ray line.
  /// Points along the line are parameterized by arc-length t in [-1.0, 1.0].
  void _computeLineProfile() {
    final int samples = numRadialSamples;
    if (_profile.length != samples) {
      _profile = Float64List(samples);
    }
    _profile.fillRange(0, samples, 0.0);

    final double r = rForIndex(_probeRIndex);
    final double cost = cosTable[_probeThetaIndex];
    final double sint = sinTable[_probeThetaIndex];
    final double dt = 2.0 / (samples - 1);

    for (int i = 0; i < samples; i++) {
      final double t = -1.0 + i * dt;
      final double xt = r * cost - t * sint;
      final double yt = r * sint + t * cost;
      double ptDensity = 0.0;
      for (final disk in _phantoms) {
        final double dx = xt - disk.x;
        final double dy = yt - disk.y;
        if (dx * dx + dy * dy <= disk.radius * disk.radius) {
          ptDensity += disk.density;
        }
      }
      _profile[i] = ptDensity;
    }

    // Exact analytical chord length integral summed across all phantoms
    double totalChord = 0.0;
    for (final disk in _phantoms) {
      final double sc = disk.x * cost + disk.y * sint;
      final double ds = r - sc;
      final double d = disk.radius * disk.radius - ds * ds;
      if (d > 0.0) {
        totalChord += 2.0 * math.sqrt(d) * disk.density;
      }
    }

    _backprojectionIntegral = totalChord;
    _backprojectionValue = totalChord;
  }

  /// Computes 1D profile across all radial offsets at a fixed angle theta.
  void _computeThetaProfile() {
    // Radial cross section has numRadialSamples (2*Q) elements.
    if (_profile.length != numRadialSamples) {
      _profile = Float64List(numRadialSamples);
    }
    if (_unfilteredProfile.length != numRadialSamples) {
      _unfilteredProfile = Float64List(numRadialSamples);
    }
    if (_filteredProfile.length != numRadialSamples) {
      _filteredProfile = Float64List(numRadialSamples);
    }
    _profile.fillRange(0, numRadialSamples, 0.0);
    _unfilteredProfile.fillRange(0, numRadialSamples, 0.0);
    _filteredProfile.fillRange(0, numRadialSamples, 0.0);

    final int thetaIdx = _probeThetaIndex;
    final double cost = cosTable[thetaIdx];
    final double sint = sinTable[thetaIdx];

    for (final disk in _phantoms) {
      final double px = disk.x;
      final double py = disk.y;
      final double sc = px * cost + py * sint;
      final double rSq = disk.radius * disk.radius;
      final double density = disk.density;

      for (int i = 0; i < numRadialSamples; i++) {
        final double s = rForIndex(i);
        final double ds = s - sc;
        final double d = rSq - ds * ds;
        if (d > 0.0) {
          _unfilteredProfile[i] += 2.0 * math.sqrt(d) * density;
        }

        double filtVal = 0.0;
        for (int l = -15; l <= 15; l++) {
          final double dsl = ds - h * l;
          final double dl = rSq - dsl * dsl;
          if (dl > 0.0) {
            filtVal += 2.0 * math.sqrt(dl) * density * h * wb(l);
          }
        }
        _filteredProfile[i] += filtVal;
      }
    }

    double sum = 0.0;
    double sumUnfilt = 0.0;
    double sumFilt = 0.0;
    for (int i = 0; i < numRadialSamples; i++) {
      _profile[i] = _filtered ? _filteredProfile[i] : _unfilteredProfile[i];
      sum += _profile[i];
      sumUnfilt += _unfilteredProfile[i];
      sumFilt += _filteredProfile[i];
    }

    _backprojectionIntegral = sum / numRadialSamples;
    _backprojectionValue = 2.0 * math.pi * _backprojectionIntegral;
    _unfilteredBackprojectionValue =
        2.0 * math.pi * (sumUnfilt / numRadialSamples);
    _filteredBackprojectionValue = 2.0 * math.pi * (sumFilt / numRadialSamples);
  }

  /// Computes 1D profile along constant radial offset r across all angles theta.
  void _computeSLineProfile() {
    if (_profile.length != numAngles) {
      _profile = Float64List(numAngles);
      _unfilteredProfile = Float64List(numAngles);
      _filteredProfile = Float64List(numAngles);
    }
    _profile.fillRange(0, numAngles, 0.0);
    _unfilteredProfile.fillRange(0, numAngles, 0.0);
    _filteredProfile.fillRange(0, numAngles, 0.0);

    final double s = rForIndex(_probeRIndex);

    for (final disk in _phantoms) {
      final double px = disk.x;
      final double py = disk.y;
      final double rSq = disk.radius * disk.radius;
      final double density = disk.density;

      for (int t = 0; t < numAngles; t++) {
        final double sc = px * cosTable[t] + py * sinTable[t];
        final double ds = s - sc;
        final double d = rSq - ds * ds;
        if (d > 0.0) {
          _unfilteredProfile[t] += 2.0 * math.sqrt(d) * density;
        }

        double filtVal = 0.0;
        for (int l = -15; l <= 15; l++) {
          final double dsl = ds - h * l;
          final double dl = rSq - dsl * dsl;
          if (dl > 0.0) {
            filtVal += 2.0 * math.sqrt(dl) * density * h * wb(l);
          }
        }
        _filteredProfile[t] += filtVal;
      }
    }

    double sum = 0.0;
    for (int t = 0; t < numAngles; t++) {
      _profile[t] = _filtered ? _filteredProfile[t] : _unfilteredProfile[t];
      sum += _profile[t];
    }

    _backprojectionIntegral = sum / numAngles;
    _backprojectionValue = 2.0 * math.pi * _backprojectionIntegral;
  }
}
