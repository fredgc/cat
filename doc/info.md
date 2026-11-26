---
title: CAT Scan Math & UI Reference
---

The **CAT Scan Demonstration Tool** is an interactive reference for Computed
Axial Tomography (CAT / CT scans), the Radon Transform, and Filtered
Backprojection (FBP).

## Mathematical Reference

### 1. X-Ray Attenuation & Line Integrals

An X-ray beam traveling along a straight line $L$ through an object loses
intensity according to the Beer-Lambert law:

$$I = I_0 \exp\left(-\int_L f(x, y) \, ds\right)$$

Measuring transmitted intensity $I$ against incident intensity $I_0$ yields the
line integral of the attenuation coefficient $f(x, y)$:

$$g(L) = -\ln\left(\frac{I}{I_0}\right) = \int_L f(x, y) \, ds$$

### 2. Line Parameterization & The Radon Transform

Every straight line in the 2D plane $[-1, 1] \times [-1, 1]$ is parameterized
by its signed perpendicular distance $r \in [-1, 1]$ from the origin and its
normal angle $\theta \in [0, 2\pi)$:

$$x \cos(\theta) + y \sin(\theta) = r$$

The **Radon Transform** $\mathcal{R}[f](r, \theta) = g(r, \theta)$ records all
line integrals as a 2D dataset called a **sinogram**, discretized on a
$2Q \times 2P$ grid ($h = 1/Q$, $r_i = (i - Q)/Q$, $\theta_j = \pi j / P$).

### 3. Sinogram Duality

- A single point $(r_0, \theta_0)$ in Sinogram Space corresponds to a single
  straight X-ray line in Object Space.

- A single point $(x_0, y_0)$ in Object Space corresponds to all lines passing
  through it, tracing a sinusoidal curve in Sinogram Space:

  $$r(\theta) = x_0 \cos(\theta) + y_0 \sin(\theta)$$

### 4. Circular Phantom Line Integral

For a circular disk of uniform density $1$, radius $r_p$, and center
$(x_0, y_0)$, let $\Delta s = r - (x_0 \cos(\theta) + y_0 \sin(\theta))$. The line
integral across the disk is its chord length:

$$\psi(\Delta s) = \begin{cases} 2\sqrt{r_p^2 - (\Delta s)^2} & \text{if } |\Delta s| < r_p \\ 0 & \text{otherwise} \end{cases}$$

Multiple phantoms sum linearly in the sinogram.

### 5. Backprojection & Filtered Backprojection (FBP)

Summing sinogram values along the dual sinusoid of $(x, y)$ gives unfiltered
backprojection:

$$\mathcal{B}[g](x, y) = \int_0^{2\pi} g(x \cos(\theta) + y \sin(\theta), \theta) \, d\theta$$

Unfiltered backprojection blurs features with a $1/|r|$ point-spread function.
To remove this blur, each projection is convolved with **Frank Natterer's
discrete ramp filter kernel** (bandwidth $b = \pi Q$):

$$w_b(l) = \frac{b^2}{\pi^4 (1 - 4 l^2)} \quad (l \in \mathbb{Z})$$

$$(w_b * g)(r, \theta) = h \sum_{l = -L}^{L} g(r - l h, \theta) \, w_b(l)$$

The negative side lobes of $w_b$ cancel the $1/|r|$ smearing, reconstructing
$f(x, y) \approx 1.0$ inside each phantom disk and $\approx 0.0$ outside.

## UI & Controls Reference

### Object Space Viewport

- **Probe mode**: Click or drag to position the green probe point $(x, y)$ and
  plot its dual sinusoid in Sinogram Space.

- **Phantom mode**: Drag red phantom disks to reposition them inside the unit
  circle.

- **Add / Delete (`+` / trash)**: Add multiple phantom disks or remove the
  selected disk (Stages 4–7).

### Sinogram (Radon Space) Viewport

- **Main heatmap**: Click or drag to select a single X-ray line $(r, \theta)$.

- **Right border bar**: Click or drag to select a family of parallel X-rays at
  fixed angle $\theta$.

- **Bottom border bar**: Click or drag to select lines tangent to a circle of
  radius $|r|$.

### 1D Profile Graph (Stages 5–7)

- Plots the cross-section along the active probe (single ray, parallel family,
  tangent circle, or point sinusoid) and computes the live backprojection
  integral.

- **Play Scan / Pause**: Sweeps the parallel ray family through
  $\theta \in [0, 2\pi)$.

### Toolbar, Settings & Keyboard Shortcuts

- **Filter (`[F]`)**: Toggles between unfiltered sinogram $g$ and filtered
  sinogram $w_b * g$.

- **Stage navigation**: Use **Previous**, **Next**, **Skip**, or the stage
  chips (`1`–`7`).

- **Settings**: Configure Theme (Dark, Light, System), Colormap (Classic,
  Grayscale, Viridis, Inferno), Sampling Resolution ($P \times Q$), and
  Coordinate Guides.

- **Keyboard shortcuts**: `[Enter]`/`[N]` next step/stage, `[→]` next stage,
  `[P]`/`[←]` previous stage, `[1]`–`[7]` jump to stage, `[Space]` play/pause
  scan, `[F]` toggle filter.

## Background & References

- Original 1998/2006 Java demonstration applet by **Fred Gylys-Colwell**,
  presented at Ball State University on February 26, 1998.

- Frank Natterer, *The Mathematics of Computerized Tomography*, SIAM Classics
  in Applied Mathematics, 2001.

- Source code: [https://github.com/fredgc/cat](https://github.com/fredgc/cat)

- Issue tracker:
  [https://github.com/fredgc/cat/issues](https://github.com/fredgc/cat/issues)

- More apps and tools: [www.gchouse.org](https://www.gchouse.org)
