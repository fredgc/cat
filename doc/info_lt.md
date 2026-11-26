---
title: KT matematikos ir sąsajos žinynas
---

**Kompiuterinės tomografijos demonstracija** yra interaktyvus kompiuterinės
tomografijos (KT), Radono transformacijos ir filtruotos atgalinės projekcijos
(FBP) žinynas.

## Matematinis žinynas

### 1. Rentgeno slopinimas ir tiesiniai integralai

Rentgeno spindulys, einantis tiese $L$ per objektą, silpnėja pagal
Bero-Lamberto dėsnį:

$$I = I_0 \exp\left(-\int_L f(x, y) \, ds\right)$$

Palyginus praėjusį intensyvumą $I$ su pradiniu $I_0$, gaunamas sugerties
koeficiento $f(x, y)$ tiesinis integralas:

$$g(L) = -\ln\left(\frac{I}{I_0}\right) = \int_L f(x, y) \, ds$$

### 2. Tiesių parametrizavimas ir Radono transformacija

Kiekviena tiesė 2D plokštumoje $[-1, 1] \times [-1, 1]$ parametrizuojama
statmenu atstumu $r \in [-1, 1]$ nuo pradžios taško ir normalės kampu
$\theta \in [0, 2\pi)$:

$$x \cos(\theta) + y \sin(\theta) = r$$

**Radono transformacija** $\mathcal{R}[f](r, \theta) = g(r, \theta)$ įrašo
visus tiesinius integralus kaip 2D duomenų rinkinį (**sinogramą**)
$2Q \times 2P$ tinklelyje ($h = 1/Q$, $r_i = (i - Q)/Q$,
$\theta_j = \pi j / P$).

### 3. Sinogramos dvilypumas

- Vienas taškas $(r_0, \theta_0)$ sinogramos erdvėje atitinka vieną tiesę
  objekto erdvėje.

- Vienas taškas $(x_0, y_0)$ objekto erdvėje atitinka visas per jį einančias
  tieses ir sinogramos erdvėje brėžia sinusoidę:

  $$r(\theta) = x_0 \cos(\theta) + y_0 \sin(\theta)$$

### 4. Apskrito fantomo tiesinis integralas

Apskritam diskui, kurio tankis $1$, spindulys $r_p$, o centras $(x_0, y_0)$,
tegul $\Delta s = r - (x_0 \cos(\theta) + y_0 \sin(\theta))$. Tiesinis integralas
lygus stygos ilgiui:

$$\psi(\Delta s) = \begin{cases} 2\sqrt{r_p^2 - (\Delta s)^2} & \text{jei } |\Delta s| < r_p \\ 0 & \text{kitaip} \end{cases}$$

Keli fantomai sinogramoje sumuojasi tiesiškai.

### 5. Atgalinė projekcija ir filtruota atgalinė projekcija (FBP)

Sinogramos reikšmių sumavimas išilgai taško $(x, y)$ sinusoidės yra nefiltruota
atgalinė projekcija:

$$\mathcal{B}[g](x, y) = \int_0^{2\pi} g(x \cos(\theta) + y \sin(\theta), \theta) \, d\theta$$

Nefiltruota atgalinė projekcija sukelia $1/|r|$ suliejimą. Kiekvienos
projekcijos sąsūka su **Frank Natterer diskrečiuoju rampos filtro branduoliu**
(juostos plotis $b = \pi Q$) šį suliejimą panaikina:

$$w_b(l) = \frac{b^2}{\pi^4 (1 - 4 l^2)} \quad (l \in \mathbb{Z})$$

$$(w_b * g)(r, \theta) = h \sum_{l = -L}^{L} g(r - l h, \theta) \, w_b(l)$$

Neigiami $w_b$ šoniniai sparnai tiksliai atkuria $f(x, y) \approx 1.0$ fantomo
viduje ir $\approx 0.0$ išorėje.

## Sąsajos ir valdymo žinynas

### Objekto erdvė

- **Zondo režimas**: Spustelėkite arba vilkite, kad padėtumėte žalią zondo
  tašką $(x, y)$ ir matytumėte jo sinusoidę sinogramoje.

- **Fantomo režimas**: Vilkite raudonus fantomo diskus vienetiniame apskritime.

- **Pridėti / Ištrinti (`+` / šiukšliadėžė)**: Pridėkite kelis fantomo diskus
  arba pašalinkite pasirinktą (4–7 etapai).

### Sinogramos (Radono) erdvė

- **Pagrindinė diagrama**: Spustelėkite arba vilkite, kad pasirinktumėte vieną
  spindulį $(r, \theta)$.

- **Dešinioji juosta**: Lygiagrečių spindulių šeima esant fiksuotam kampui
  $\theta$.

- **Apatinė juosta**: Tiesės, liečiančios apskritimą su spinduliu $|r|$.

### 1D profilio grafikas (5–7 etapai)

- Rodo 1D skerspjūvį pagal aktyvų zondą ir skaičiuoja atgalinės projekcijos
  integralą realiuoju laiku.

- **Paleisti skenavimą / Pristabdyti**: Suka lygiagrečių spindulių šeimą per
  $\theta \in [0, 2\pi)$.

### Įrankių juosta, nustatymai ir trumpiniai

- **Filtras (`[F]`)**: Perjungia tarp nefiltruotos $g$ ir filtruotos
  $w_b * g$ sinogramos.

- **Etapų naršymas**: **Ankstesnis**, **Kitas**, **Praleisti** arba etapų
  mygtukai (`1`–`7`).

- **Nustatymai**: Tema (Tamsi, Šviesi, Sistemos), Spalvų paletė (Klasikinė,
  Pilki atspalviai, Viridis, Inferno), Diskretizavimo raiška ($P \times Q$) ir
  Koordinačių gairės.

- **Klaviatūros trumpiniai**: `[Enter]`/`[N]` kitas žingsnis/etapas, `[→]`
  kitas etapas, `[P]`/`[←]` ankstesnis etapas, `[1]`–`[7]` perėjimas į etapą,
  `[Tarpas]` paleisti/pristabdyti, `[F]` perjungti filtrą.

## Kilmė ir šaltiniai

- Originalus 1998/2006 m. „Java“ apletas, autorius **Fred Gylys-Colwell**,
  pristatytas Ball State universitete 1998 m. vasario 26 d.

- Frank Natterer, *The Mathematics of Computerized Tomography*, SIAM Classics
  in Applied Mathematics, 2001.

- Pradinis kodas: [https://github.com/fredgc/cat](https://github.com/fredgc/cat)

- Klaidų pranešimai:
  [https://github.com/fredgc/cat/issues](https://github.com/fredgc/cat/issues)

- Daugiau programų: [www.gchouse.org](https://www.gchouse.org)
