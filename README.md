# CAT Scan Demonstration Tool

An interactive, educational application for visualizing the mathematics and
physics behind **Computed Axial Tomography (CAT / CT scans)** and the **Radon
Transform**.

This project modernizes and enhances an educational Java demonstration applet
originally created by **Fred Gylys-Colwell** in 1998 (last revised 2006) for a
talk on the Radon transform
([gchouse.org/CAT/talk.html](http://www.gchouse.org/CAT/talk.html)).

---

## 1. Project Overview & Motivation

An X-Ray CAT scan generates a detailed 2D interior cross-section of an object
or human body from the outside without invasive surgery. The machine sends
X-ray beams through the body from all angles $\theta$ and measures how much
radiation is absorbed.

Mathematically, the physical attenuation satisfies the Beer-Lambert law:

$$I = I_0 \exp\left(-\int_L f(x, y) \, ds\right) \implies g(L) = -\ln\left(\frac{I}{I_0}\right) = \int_L f(x, y) \, ds$$

where $f(x, y)$ is the spatial absorption coefficient. This is equivalent to
measuring line integrals over all straight lines traversing the object.

This application provides an intuitive, interactive environment to explore:

* How 1D projection integrals combine across angles to form a 2D parameter
  dataset known as a **sinogram** $g(r, \theta)$.

* The geometric duality between points in object space and sinusoidal
  trajectories in sinogram space.

* Why unfiltered backprojection produces a blurry image ($1/|r|$ blur).

* How high-pass filtering projections with Frank Natterer's ramp filter kernel
  ($w_b$) sharpens the sinogram so that backprojection accurately reconstructs
  the exact interior attenuation values.

---

## Documentation

In-depth documentation and policies are located in `doc/`:

* [doc/info.md](doc/info.md) : Project history, author attribution, and
  background on the original 1998 Java applet.

* [doc/privacy.md](doc/privacy.md) : Privacy policy and explanation of local
  preference persistence.

* [doc/terms.md](doc/terms.md) : Terms of service.

---

## 2. Mathematical Foundation

### 2.1 Parameterization of Lines & The Radon Transform

Every line $L_{r, \theta}$ in the 2D Cartesian plane is parameterized by:

* $\theta \in [0, 2\pi)$: the angle of the normal vector from the origin to
  the line.

* $r \in [-1, 1]$: the signed perpendicular distance from the origin to the
  line.

The equation of the line is:

$$x \cos\theta + y \sin\theta = r$$

The **Radon Transform** maps a 2D function $f(x, y)$ in object space to
sinogram space $g(r, \theta)$:

$$g(r, \theta) = \mathcal{R}[f](r, \theta) = \iint_{\mathbb{R}^2} f(x, y) \, \delta(x \cos\theta + y \sin\theta - r) \, dx \, dy$$

### 2.2 Sinogram Duality & Geometry

* **Point in Object Space $\leftrightarrow$ Sinusoid in Sinogram Space**: All
  lines passing through a fixed point $(x_1, y_1)$ satisfy:

  $$r(\theta) = x_1 \cos\theta + y_1 \sin\theta$$

As $\theta$ varies from $0$ to $2\pi$, this traces an exact sinusoidal curve
in $(r, \theta)$ space.

* **Point in Sinogram Space $\leftrightarrow$ Line in Object Space**: A single
  point $(r_0, \theta_0)$ in sinogram space corresponds to a single line $x
  \cos\theta_0 + y \sin\theta_0 = r_0$ in object space.

* **Row of Sinogram (constant $\theta$)**: Represents a parallel beam of
  X-rays passing through the object at angle $\theta$ across all radial
  offsets $r$.

* **Column of Sinogram (constant $r$)**: Represents lines tangent to a circle
  of radius $|r|$ centered at the origin.

### 2.3 Phantom & Analytical Projections

To test reconstruction algorithms, a known mathematical object called a
**phantom** is simulated. For a circular disk phantom of radius $r_p$ centered
at $(x_0, y_0)$ with uniform attenuation density $1$:

* The distance from the center $(x_0, y_0)$ to line $L_{r, \theta}$ is
  $|\Delta s|$, where:

  $$s_c = x_0 \cos\theta + y_0 \sin\theta, \quad \Delta s = r - s_c$$

* If $|\Delta s| < r_p$, the chord length (line integral) is:

  $$\psi(\Delta s) = 2 \sqrt{r_p^2 - (\Delta s)^2}$$

Otherwise, $\psi(\Delta s) = 0$.

### 2.4 Backprojection & Frank Natterer's Ramp Filter

Simple backprojection integrates the recorded projections over all angles:

$$f_{\text{unfiltered}}(x, y) = \int_0^{2\pi} g(x \cos\theta + y \sin\theta, \theta) \, d\theta$$

Because every projection point contributes energy across the entire line,
unfiltered backprojection blurs features by a point spread function
proportional to $1/|r|$.

To achieve exact reconstruction, projections must be filtered prior to
backprojection (**Filtered Backprojection**, FBP). Using Frank Natterer's
discrete filter kernel $w_b(l)$ (*The Mathematics of Computerized Tomography*,
Eq. 1.23, p. 111):

$$w_b(l) = \frac{b^2}{\pi^4 (1 - 4 l^2)} \quad (l \in \mathbb{Z})$$

where $b = \pi Q$, step size $h = 1/Q$, and $Q$ is the radial sampling
resolution.

Convolving $g(r, \theta)$ with $w_b$ along the radial coordinate yields the
filtered sinogram:

$$g_{\text{filtered}}(r, \theta) = (g * w_b)(r, \theta) = h \sum_{l = -L}^{L} g(r - l h, \theta) \, w_b(l)$$

When the backprojection integral is computed on the filtered data:

$$\int_0^{2\pi} g_{\text{filtered}}(x \cos\theta + y \sin\theta, \theta) \, d\theta \approx \begin{cases} 1.0 & \text{if } (x, y) \text{ is inside the phantom} \\ 0.0 & \text{if } (x, y) \text{ is outside the phantom} \end{cases}$$

---

## 3. The 6 Interactive Demonstration Stages

The application guides users through a six-stage pedagogical narrative adapted
from the original 1998/2006 talk:

| Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside.                                      |
| ----------- | ---------------------------------- | ---------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside.                                      |
| Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside.                                      |
| Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside.                                      |
| Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside.                                      |
| Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside.                                      |
| Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside. | Sinogram and 1D graph show filtered signal. Backprojection integral now evaluates to precisely $\approx 1.0$ inside and $0.0$ outside.                                      |

---

## 4. Technology Stack & Key Features

* **Framework**: [Flutter](https://flutter.dev) (Dart 3) targeting Web and
  Android.

* **Dual Synchronized Viewports**:

  * **Object Space**: Interactive 2D coordinate plane showing the
    object/phantom, active X-ray lines, and probe points.

  * **Sinogram / Radon Space**: 2D parameter plane $(r, \theta)$ displaying
    attenuation values as an interactive heatmap, with probe cursors and
    sinusoidal curves.

* **1D Profile & Backprojection Graph**:

  * Live cross-sections of $g(r, \theta)$ along chosen angles $\theta$, radial
    offsets $r$, or sinusoidal point trajectories.

  * Real-time calculation and display of the backprojection integral
    $\int_0^{2\pi} g(x\cos\theta + y\sin\theta, \theta) \, d\theta$.

* **Fast Custom Painting**: Hardware-accelerated 2D canvas painters
  (`CustomPainter`) and cached pixel buffers for smooth 60 FPS drag
  interactions.

* **Preferences**: Local user settings (theme, colormaps, resolution, guides)
  stored via `shared_preferences`. No file manager or Google Drive storage
  required.

---

## 5. Getting Started & Running Locally

### Prerequisites

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.13+
  recommended)

* Google Chrome (for web development)

* `make` and [Pandoc](https://pandoc.org/) (for compiling documentation)

### Forking and Cloning

1. Fork the repository on GitHub to your account.

2. Clone your fork locally:

   ```bash
   git clone https://github.com/<your-username>/cat.git
   cd cat
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Build documentation assets:

   ```bash
   make docs
   ```

### Local Development Commands

* **Run web development server**:

  ```bash
  ./run-local-server.sh
  ```

* **Run local release build**:

  ```bash
  ./run-local-release.sh
  ```

* **Run automated test suite**:

  ```bash
  flutter test
  ```

* **Analyze codebase**:

  ```bash
  flutter analyze
  ```

* **Build documentation and icons**:

  ```bash
  make ASSETS
  ```

---

## 6. License & Attribution

Based on the original 1998/2006 demonstration program by **Fred Gylys-
Colwell** ([gchouse.org/CAT/talk.html](http://www.gchouse.org/CAT/talk.html)).
Released under the Apache 2.0 License.
