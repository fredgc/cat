---
title: Apie kompiuterinės tomografijos demonstraciją
---

**Kompiuterinės tomografijos demonstracinisįrankis** yra interaktyvi mokomoji
programa, skirta iliustruoti kompiuterinės tomografijos (KT) ir Radono
transformacijos matematikąbei veikimo principus.

## Istorija ir motyvacija

Ši programa sukurta remiantis **Fred Gylys-Colwell** 1998/2006 m. originaliu
„Java“apletu. Pirmasis pranešimas buvo pristatytas 1998 m. vasario 26 d.

Programa parašyta„Dart“ir„Flutter“. Atviras pradinis kodas pasiekiamas
„GitHub“: [https://github.com/fredgc/cat](https://github.com/fredgc/cat).

Pastebėjote klaidą ar turite pasiūlymą?
[Registruokite problemą „GitHub“](https://github.com/fredgc/cat/issues).

Kitas programas rasite [www.gchouse.org](https://www.gchouse.org).

## Matematika už kompiuterinės tomografijos

Rentgeno kompiuterinėtomografija neinvaziniu būdu atkuria objekto vidinį2D
skerspjūvį.

1. **Rentgeno spinduliųslopinimas ir tiesiniai integralai**:

Rentgeno spindulys siunčiamas tiese $L$ per kūną. Sugertos spinduliuotės dalis
atitinka sugerties koeficiento $f(x, y)$ tiesinįintegralątiese $L$:

   $$g(L) = \int_L f(x, y) \, ds$$

2. **Tiesiųparametrizavimas**:

Kiekviena plokštumos tiesėparametrizuojama atstumu $r$ nuo pradžios taško ir
normalės kampu $\theta \in [0, 2\pi)$:

   $$x \cos\theta + y \sin\theta = r$$

Radono transformacija $\mathcal{R}[f](r, \theta)$ užrašo tiesinius integralus
visiems $(r, \theta)$.

3. **Sinogramos dvilypumas**:

   - Vienas taškas sinogramos erdvėje $(r_0, \theta_0)$ atitinka tiesęobjekto
     erdvėje.

   - Objekto erdvės taškas $(x_1, y_1)$ atitinka sinusoidę$r(\theta) = x_1
     \cos\theta + y_1 \sin\theta$ sinogramos erdvėje.

4. **Filtruota atgalinėprojekcija (rekonstrukcija)**:

Paprasta atgalinėprojekcija išsklaido duomenis ir sukelia $1/r$ suliejimą.
Atlikus sąsūkąsu Frank Natterer filtro branduoliu, filtruota atgalinė
projekcija tiksliai rekonstruoja vidinęstruktūrą($f(x, y) \approx 1$ viduje,
$0$ išorėje).

## Privatumas ir duomenų saugojimas

Vartotojo nustatymai saugomi tik lokaliai jūsųįrenginyje (`SharedPreferences`
/ `localStorage`). Jokie asmens duomenys nerenkami.
