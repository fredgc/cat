---
title: Acerca de la demostración de TAC
---

La **Herramienta de demostración de TAC** es una aplicación educativa
interactiva diseñada para ilustrar las matemáticas y la mecánica detrás de la
tomografía axial computarizada (TAC) y la transformada de Radon.

## Historia y motivación

Esta aplicación estáinspirada y adaptada del applet de demostración original
de Java de 1998/2006 creado por **Fred Gylys-Colwell**. La presentación se
expuso por primera vez el 26 de febrero de 1998.

Esta aplicación está escrita en Dart con Flutter. El código fuente está
disponible en GitHub en
[https://github.com/fredgc/cat](https://github.com/fredgc/cat).

¿Encontró un error o desea solicitar una función?
[Abra un ticket en GitHub](https://github.com/fredgc/cat/issues).

Puede encontrar otras aplicaciones y herramientas de dibujo en
[www.gchouse.org](https://www.gchouse.org).

## Las matemáticas detrás de la TAC

Una tomografía axial computarizada por rayos X genera un corte transversal 2D
del interior de un objeto o cuerpo humano desde el exterior sin cirugía
invasiva.

1. **Atenuación de rayos X e integrales de línea**:

Un haz de rayos X se dirige a lo largo de una línea recta $L$ a través del
cuerpo. La proporción de radiación absorbida corresponde a la integral de
línea del coeficiente de absorción $f(x, y)$ a lo largo de la línea $L$:

   $$g(L) = \int_L f(x, y) \, ds$$

2. **Parametrización de líneas**:

Cada línea en el plano se puede parametrizar mediante su distancia con signo
$r$ desde el origen y suángulo normal $\theta \in [0, 2\pi)$:

   $$x \cos\theta + y \sin\theta = r$$

La transformada de Radon $\mathcal{R}[f](r, \theta)$ registra las integrales
de línea para todos los $(r, \theta)$.

3. **Dualidad del sinograma**:

   - Un solo punto en el espacio del sinograma $(r_0, \theta_0)$ representa
     una sola línea en el espacio del objeto.

   - Un solo punto $(x_1, y_1)$ en el espacio del objeto corresponde a una
     curva sinusoidal $r(\theta) = x_1 \cos\theta + y_1 \sin\theta$ en el
     espacio del sinograma que representa todas las líneas que pasan por
     $(x_1, y_1)$.

4. **Retroproyección filtrada (reconstrucción)**:

La retroproyección simple dispersa las proyecciones sobre el plano de la
imagen, provocando un desenfoque de $1/r$. Al convolucionar cada proyección
con un filtro de rampa o paso alto (derivado por Frank Natterer), la
retroproyección de los datos filtrados reconstruye con precisión los rasgos
interiores ($f(x, y) \approx 1$ dentro del objeto y $0$ fuera).

## Privacidad y retención de datos

Este programa le permite personalizar ajustes que se guardan localmente en su
dispositivo (mediante SharedPreferences / LocalStorage). No se recopilan datos
personales.

En Android, los ajustes locales se eliminan al desinstalar la aplicación. En
la web, los ajustes se eliminan al borrar los datos locales del navegador.
