# CAT Scan Demonstration Tool Plan

This document outlines the strategic roadmap, architecture goals, and
milestones for the **CAT Scan** Flutter application. Background information,
history, and mathematical theory are located in [README.md](README.md) .

> **Note**: Active day-to-day tasks and issue tracking are managed >

dynamically using `~/bin/todo.py`. Run `~/bin/todo.py list` to view active >
tasks.

---

## 1. Project Roadmap & Milestone Status

- [x] **Milestone 1: Project Setup, Tooling & Initial Framework** (Completed)

  - Flutter web & android project initialized with Material 3.

  - Dependencies configured: `shared_preferences`, `google_fonts`,
    `flex_color_picker`, `package_info_plus`, `url_launcher`, `html_tweak`.

  - Development and build scripts integrated: `Makefile`, `html_tweak/`,
    `roll_build_number.sh`, `run-local-server.sh`, `run-local-release.sh`.

  - Android and Web launcher icons generated from `icon.xcf`.

  - Documentation structure created (`doc/info.md`, `README.md`, `GEMINI.md`,
    `plan.md`).

  - Blank application shell in `lib/main.dart` with stage navigation (Stages
    1–6) and passing widget smoke tests.

- [x] **Milestone 2: Mathematical Engine & Radon Model (`RadonEngine`)**
      (Completed)

  - Implemented phantom model (`lib/models/phantom.dart`) with analytical
    chord length calculations and translation bounds.

  - Implemented mathematical transform engine (`lib/models/radon_engine.dart`)
    with discrete sampling ($2P \times 2Q$), lookup tables, and probe modes.

  - Implemented Frank Natterer ramp filter kernel $w_b(l)$ and high-precision
    convolution.

  - Implemented discrete backprojection integral verifying $\approx 1.0$
    inside and $\approx 0.0$ outside when filtered.

  - Comprehensive unit test suite (`test/radon_engine_test.dart`) with 100%
    passing tests and 0 analysis lints.

- [x] **Milestone 3: Interactive Viewports & Custom Painters** (Completed)

  - Implemented `ObjectCanvas` (`lib/widgets/object_canvas.dart`) with
    interactive phantom dragging, coordinate guides, and point/line probe
    overlays.

  - Implemented `RadonCanvas` (`lib/widgets/radon_canvas.dart`) with real-time
    sinogram heatmap image caching (`ui.Image`), sinusoidal curve overlays,
    and border scrollbars.

  - Implemented `GraphCanvas` (`lib/widgets/graph_canvas.dart`) for live 1D
    slice plotting, zero-baseline axes, and backprojection integral readout.

  - Implemented colormaps and palette utilities (`lib/color.dart`).

  - Added full widget test coverage (`test/widget_test.dart`) for canvases,
    interactions, and 6-stage navigation.

- [x] **Milestone 4: Stage Narrative Controller & UI Integration** (Completed)

  - Implemented `StageStepper` (`lib/widgets/stage_stepper.dart`) with
    narrative cards, stage indicators, and contextual interaction hints.

  - Connected `RadonEngine` state to the 6-stage presentation, synchronizing
    visibility (phantom in stages 4–6, 1D graph in stages 5–6, filtered in
    stage 6).

  - Implemented keyboard shortcuts via `CallbackShortcuts` and `Focus` (digits
    `1`–`6`, Arrow Left/Right, and `F` for filter toggle).

  - Fully verified with widget test suite (`test/widget_test.dart`) passing
    100%.

- [x] **Milestone 5: Settings & Customization** (Completed)

  - Implemented `AppSettings` (`lib/settings.dart`) with persistent storage
    via `shared_preferences`.

  - Implemented `SettingsDialog` (`lib/settings.dart`) for configuring theme
    (Dark, Light, System), sinogram colormaps (Classic, Grayscale, Viridis,
    Inferno), grid resolution ($P \times Q$), and coordinate guides toggle.

  - Implemented `AppAboutDialog` (`lib/widgets/about_dialog.dart`) with
    version readout, talk links, and compiled HTML viewer.

  - Implemented `CatApp` in `lib/my_app.dart` listening to `AppSettings` to
    update MaterialApp themes reactively.

  - Added comprehensive test suite in `test/settings_test.dart` passing 100%.

- [x] **Milestone 6: Verification & Quality Assurance** (Completed)

  - Complete test suite passing 100% across unit, widget, and settings tests
    (23 passing tests).

  - Codebase verified with `flutter analyze` with 0 errors and 0 warnings.

  - Production release build verified via `make build_all` (`flutter build
    web`).

- [ ] **Milestone 7: Deployment & Public Release** (NEXT STEP)

  - Configure Firebase hosting (`fredgc-cat`).

  - Verify staging deployment via `make stage`.

  - Create and configure public GitHub repository.

---

## 2. Immediate Next Steps (Milestone 2 Execution Plan)

### Step 2.1: Implement Phantom Model (`lib/models/phantom.dart`)

* Define `PhantomDisk` representing a circular disk phantom:

  * Center coordinates: $(x_0, y_0)$, default $(0.2, 0.3)$ to match the
    original Java applet.

  * Radius: $r_p$, default $0.1$.

  * Attenuation density: default $1.0$.

* Method `double chordLength(double r, double cosTheta, double sinTheta)`:

  * Evaluates distance to line: $s_c = x_0 \cos\theta + y_0 \sin\theta$,
    $\Delta s = r - s_c$.

  * Returns $2\sqrt{r_p^2 - (\Delta s)^2}$ if $|\Delta s| < r_p$, else $0.0$.

* Support translation $(x_0, y_0)$ bounded within $[-0.8, 0.8]$.

### Step 2.2: Implement Mathematical Engine (`lib/models/radon_engine.dart`)

* Discretization grid:

  * Angle samples: $2P$ (default $P = 50 \implies 100$ angles), $\theta_j =
    \pi j / P$ for $j \in \{0, \dots, 2P - 1\}$.

  * Radial samples: $2Q$ (default $Q = 50 \implies 100$ samples), $r_i = (i -
    Q)/Q$ for $i \in \{0, \dots, 2Q - 1\}$, step $h = 1/Q$.

* Lookup tables:

  * Precompute $\cos(\theta_j)$ and $\sin(\theta_j)$ for all $2P$ angles.

  * Precompute centered disk profile $\psi[i]$ for $4Q$ radial points:

    $$\psi[i] = 2\sqrt{r_p^2 - s^2} \quad \text{where } s = (i - 2Q)/Q$$

* Natterer ramp filter kernel $w_b(l)$ (Natterer Eq. 1.23, p. 111):

  $$w_b(l) = \frac{b^2}{\pi^4(1 - 4l^2)}, \quad b = \pi Q, \quad l \in \mathbb{Z}$$

* Filtered disk profile $w\psi[k]$:

  $$w\psi[k] = h \sum_{l = 0}^{4Q - 1} \psi[l] \cdot w_b(k - l)$$

* Fast sinogram generation:

  * Unfiltered sinogram lookup: $g(r_i, \theta_j) = \psi[Q + i -
    \text{round}(Q \cdot s_c)]$.

  * Filtered sinogram lookup: $g_{\text{filtered}}(r_i, \theta_j) = w\psi[Q +
    i - \text{round}(Q \cdot s_c)]$.

* Active probe modes:

  * `ProbeMode.none`: No active selection.

  * `ProbeMode.point`: Point $(x_p, y_p)$ selected in object space $\to$
    sinusoid $r(\theta_j) = x_p \cos\theta_j + y_p \sin\theta_j$.

  * `ProbeMode.line`: Line $(r_s, \theta_k)$ selected in sinogram $\to$ line
    $x\cos\theta_k + y\sin\theta_k = r_s$ and origin normal.

  * `ProbeMode.theta`: Constant angle $\theta_k \to$ family of parallel lines
    across all $r$.

  * `ProbeMode.sline`: Constant offset $r_s \to$ family of lines tangent to
    circle of radius $|r_s|$.

* 1D Slice Extraction & Backprojection Integral:

  * Compute 1D profile array $f[j]$ along the active trajectory.

  * Compute the backprojection integral:

    $$\text{Integral} = \frac{1}{2P} \sum_{j=0}^{2P - 1} f[j]$$

  * When filtered, returns $\approx 1.0$ inside the phantom disk, and $\approx
    0.0$ outside.

### Step 2.3: Implement Unit Tests (`test/radon_engine_test.dart`)

* Validate grid generation and trigonometric tables.

* Test phantom line integral calculations against known analytical values.

* Verify filter kernel $w_b(l)$ properties:

  * Symmetric: $w_b(l) = w_b(-l)$.

  * Decay: $w_b(l) \sim -1 / (4 \pi^2 l^2)$ for large $|l|$.

* Test 1D backprojection integral:

  * Filtered integral inside phantom evaluates close to $1.0$ (within $\pm
    0.05$).

  * Filtered integral outside phantom evaluates close to $0.0$ (within $\pm
    0.05$).

* Run `flutter test` and `flutter analyze` to guarantee 100% clean passes.
