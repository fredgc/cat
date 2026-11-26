---
title: Referencia matemática y de interfaz (TAC)
---

La **Herramienta de demostración de TAC** es una referencia interactiva sobre
la tomografía axial computarizada (TAC), la transformada de Radon y la
retroproyección filtrada (FBP).

## Referencia matemática

### 1. Atenuación de rayos X e integrales de línea

Un haz de rayos X que recorre una línea recta $L$ a través de un objeto pierde
intensidad según la ley de Beer-Lambert:

$$I = I_0 \exp\left(-\int_L f(x, y) \, ds\right)$$

Al medir la intensidad transmitida $I$ respecto a la incidente $I_0$ se obtiene
la integral de línea del coeficiente de absorción $f(x, y)$:

$$g(L) = -\ln\left(\frac{I}{I_0}\right) = \int_L f(x, y) \, ds$$

### 2. Parametrización de líneas y transformada de Radon

Cada línea recta en el plano 2D $[-1, 1] \times [-1, 1]$ se parametriza por su
distancia perpendicular con signo $r \in [-1, 1]$ al origen y su ángulo normal
$\theta \in [0, 2\pi)$:

$$x \cos(\theta) + y \sin(\theta) = r$$

La **transformada de Radon** $\mathcal{R}[f](r, \theta) = g(r, \theta)$
registra todas las integrales de línea en un conjunto 2D llamado **sinograma**,
discretizado en una malla $2Q \times 2P$ ($h = 1/Q$, $r_i = (i - Q)/Q$,
$\theta_j = \pi j / P$).

### 3. Dualidad del sinograma

- Un solo punto $(r_0, \theta_0)$ en el Espacio del Sinograma corresponde a una
  línea recta de rayos X en el Espacio del Objeto.

- Un solo punto $(x_0, y_0)$ en el Espacio del Objeto corresponde a todas las
  líneas que pasan por él, trazando una sinusoide en el Espacio del Sinograma:

  $$r(\theta) = x_0 \cos(\theta) + y_0 \sin(\theta)$$

### 4. Integral de línea de un fantoma circular

Para un disco circular de densidad uniforme $1$, radio $r_p$ y centro
$(x_0, y_0)$, sea $\Delta s = r - (x_0 \cos(\theta) + y_0 \sin(\theta))$. La
integral de línea a través del disco es la longitud de la cuerda:

$$\psi(\Delta s) = \begin{cases} 2\sqrt{r_p^2 - (\Delta s)^2} & \text{si } |\Delta s| < r_p \\ 0 & \text{en otro caso} \end{cases}$$

Varios fantomas se suman linealmente en el sinograma.

### 5. Retroproyección y retroproyección filtrada (FBP)

Sumar los valores del sinograma a lo largo de la sinusoide dual de $(x, y)$ da
la retroproyección sin filtrar:

$$\mathcal{B}[g](x, y) = \int_0^{2\pi} g(x \cos(\theta) + y \sin(\theta), \theta) \, d\theta$$

La retroproyección sin filtrar difumina los rasgos con una función de dispersión
$1/|r|$. Para eliminar este desenfoque, cada proyección se convoluciona con el
**núcleo discreto de filtro en rampa de Frank Natterer** (ancho de banda
$b = \pi Q$):

$$w_b(l) = \frac{b^2}{\pi^4 (1 - 4 l^2)} \quad (l \in \mathbb{Z})$$

$$(w_b * g)(r, \theta) = h \sum_{l = -L}^{L} g(r - l h, \theta) \, w_b(l)$$

Los lóbulos laterales negativos de $w_b$ cancelan el emborronamiento $1/|r|$ y
reconstruyen $f(x, y) \approx 1.0$ dentro de cada fantoma y $\approx 0.0$
fuera.

## Referencia de interfaz y controles

### Espacio del Objeto

- **Modo Sonda**: Haz clic o arrastra para situar el punto de sondeo verde
  $(x, y)$ y trazar su sinusoide dual en el sinograma.

- **Modo Fantoma**: Arrastra los discos fantoma rojos para reposicionarlos
  dentro del círculo unitario.

- **Añadir / Eliminar (`+` / papelera)**: Añade varios discos fantoma o elimina
  el seleccionado (Etapas 4–7).

### Espacio del Sinograma (Radon)

- **Mapa de calor principal**: Haz clic o arrastra para seleccionar un único
  rayo X $(r, \theta)$.

- **Barra derecha**: Haz clic o arrastra para mostrar una familia paralela de
  rayos X con ángulo fijo $\theta$.

- **Barra inferior**: Haz clic o arrastra para mostrar las rectas tangentes a
  un círculo de radio $|r|$.

### Gráfico de perfil 1D (Etapas 5–7)

- Muestra la sección transversal a lo largo de la sonda activa y calcula la
  integral de retroproyección en tiempo real.

- **Iniciar barrido / Pausar**: Barre la familia paralela a través de
  $\theta \in [0, 2\pi)$.

### Barra superior, ajustes y atajos de teclado

- **Filtro (`[F]`)**: Alterna entre el sinograma sin filtrar $g$ y el filtrado
  $w_b * g$.

- **Navegación de etapas**: Usa **Anterior**, **Siguiente**, **Saltar** o los
  números de etapa (`1`–`7`).

- **Ajustes**: Configura Tema (Oscuro, Claro, Sistema), Mapa de color (Clásico,
  Escala de grises, Viridis, Inferno), Resolución de muestreo ($P \times Q$) y
  Guías de coordenadas.

- **Atajos de teclado**: `[Enter]`/`[N]` siguiente paso/etapa, `[→]` siguiente
  etapa, `[P]`/`[←]` etapa anterior, `[1]`–`[7]` ir a etapa, `[Espacio]`
  reproducir/pausar barrido, `[F]` alternar filtro.

## Antecedentes y referencias

- Applet original de Java (1998/2006) de **Fred Gylys-Colwell**, presentado en
  la Universidad de Ball State el 26 de febrero de 1998.

- Frank Natterer, *The Mathematics of Computerized Tomography*, SIAM Classics
  in Applied Mathematics, 2001.

- Código fuente: [https://github.com/fredgc/cat](https://github.com/fredgc/cat)

- Seguimiento de problemas:
  [https://github.com/fredgc/cat/issues](https://github.com/fredgc/cat/issues)

- Más aplicaciones y herramientas: [www.gchouse.org](https://www.gchouse.org)
