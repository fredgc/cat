---
title: About CAT Scan Demo
---

The **CAT Scan Demonstration Tool** is an interactive educational application
designed to illustrate the mathematics and mechanics behind Computed Axial
Tomography (CAT/CT scans) and the Radon Transform.

## History & Motivation

This application is inspired by and adapted from the original 1998/2006 Java
demonstration applet by **Fred Gylys-Colwell**. The talk was first presented
on February 26, 1998.

This application is written in Dart with Flutter—the source code is available
on GitHub at [https://github.com/fredgc/cat](https://github.com/fredgc/cat).

Found a bug or have a feature request?
[File an issue on GitHub](https://github.com/fredgc/cat/issues).

Other apps and drawing tools can be found at
[www.gchouse.org](https://www.gchouse.org).

## The Mathematics Behind CAT Scans

An X-Ray CAT scan generates a 2D cross-sectional slice of the inside of an
object or human body from the outside without invasive surgery.

1. **X-Ray Attenuation & Line Integrals**: An X-ray beam is directed along a
   straight line $L$ through the body. The proportion of absorbed radiation
   corresponds to the line integral of the absorption coefficient $f(x, y)$
   along line $L$:

   $$g(L) = \int_L f(x, y) \, ds$$

2. **Parameterization of Lines**: Every line in the plane can be parameterized
   by its signed distance $r$ from the origin and normal angle $\theta \in [0,
   2\pi)$:

   $$x \cos\theta + y \sin\theta = r$$

The Radon transform $\mathcal{R}[f](r, \theta)$ records the line integrals for
all $(r, \theta)$.

3. **Sinogram Duality**:

   - A single point in sinogram space $(r_0, \theta_0)$ represents a single
     line in object space.

   - A single point $(x_1, y_1)$ in object space corresponds to a sinusoidal
     curve $r(\theta) = x_1 \cos\theta + y_1 \sin\theta$ in sinogram space
     representing all lines passing through $(x_1, y_1)$.

4. **Filtered Backprojection (Reconstruction)**: Simple backprojection smears
   projections back across the image plane, causing a $1/r$ blur. By
   convolving each projection with a ramp / high-pass filter (derived by Frank
   Natterer), backprojecting the filtered data accurately reconstructs the
   interior features ($f(x, y) \approx 1$ inside the object and $0$ outside).

## Privacy and Data Retention

This program allows you to customize settings that are saved locally on your
device (using SharedPreferences / LocalStorage). No personal data is
collected.

On Android, local settings are deleted when you uninstall the app. On Web,
settings are deleted when you clear your browser's local application data.
