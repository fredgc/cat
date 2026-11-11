---
title: À propos de la démonstration de tomodensitométrie
---

L'**Outil de démonstration de tomodensitométrie** est une application
pédagogique interactive illustrant les mathématiques et mécanismes de la
tomographie axiale calculée (scanner CT) et de la transformée de Radon.

## Histoire et motivation

Cette application est inspirée et adaptée de l'applet Java originale de
1998/2006 de **Fred Gylys-Colwell**. L'exposéaétéprésentépour la première fois
le 26 février 1998.

Cette application est écrite en Dart avec Flutter. Le code source est
disponible sur GitHub :
[https://github.com/fredgc/cat](https://github.com/fredgc/cat).

Un bug ou une suggestion ?
[Signalez un problème sur GitHub](https://github.com/fredgc/cat/issues).

D'autres applications sont disponibles sur
[www.gchouse.org](https://www.gchouse.org).

## Les mathématiques de la tomodensitométrie

La tomodensitométrie aux rayons X reconstruit une coupe transversale 2D de
l'intérieur d'un objet sans chirurgie invasive.

1. **Atténuation des rayons X et intégrales de ligne** :

Un faisceau de rayons X est dirigéle long d'une droite $L$. La proportion de
rayonnement absorbée correspondàl'intégrale de ligne du coefficient
d'absorption $f(x, y)$ le long de la droite $L$ :

   $$g(L) = \int_L f(x, y) \, ds$$

2. **Paramétrisation des droites** :

Toute droite dans le plan est paramétrée par sa distance signée $r$àl'origine
et son angle normal $\theta \in [0, 2\pi)$ :

   $$x \cos\theta + y \sin\theta = r$$

La transformée de Radon $\mathcal{R}[f](r, \theta)$ enregistre les intégrales
de ligne pour tous les $(r, \theta)$.

3. **Dualitédu sinogramme** :

   - Un point unique dans l'espace du sinogramme $(r_0, \theta_0)$ représente
     une droite complète dans l'espace de l'objet.

   - Un point $(x_1, y_1)$ dans l'espace de l'objet correspondàune sinusoïde
     $r(\theta) = x_1 \cos\theta + y_1 \sin\theta$ dans l'espace du sinogramme
     représentant toutes les droites passant par ce point.

4. **Rétroprojection filtrée (Reconstruction)** :

La rétroprojection simpleétale les données et crée un flou en $1/r$. En
convoluant chaque projection avec un filtre rampe passe-haut (conçu par Frank
Natterer), la rétroprojection filtrée reconstruit précisément les structures
internes ($f(x, y) \approx 1$àl'intérieur, $0$àl'extérieur).

## Confidentialité et conservation des données

Ce programme enregistre vos préférences uniquement sur votre appareil
(`SharedPreferences` / `localStorage`). Aucune donnée personnelle n'est
collectée.
