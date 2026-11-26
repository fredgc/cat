---
title: Référence mathématique et d'interface (TDM)
---

L'**outil de démonstration de tomodensitométrie** est une référence interactive
sur la tomographie axiale calculée (scanner CT), la transformée de Radon et la
rétroprojection filtrée (FBP).

## Référence mathématique

### 1. Atténuation des rayons X et intégrales de ligne

Un faisceau de rayons X traversant un objet le long d'une droite $L$ est atténué
selon la loi de Beer-Lambert :

$$I = I_0 \exp\left(-\int_L f(x, y) \, ds\right)$$

La comparaison de l'intensité transmise $I$ et de l'intensité incidente $I_0$
donne l'intégrale de ligne du coefficient d'absorption $f(x, y)$ :

$$g(L) = -\ln\left(\frac{I}{I_0}\right) = \int_L f(x, y) \, ds$$

### 2. Paramétrage des droites et transformée de Radon

Chaque droite du plan 2D $[-1, 1] \times [-1, 1]$ est paramétrée par sa
distance perpendiculaire signée $r \in [-1, 1]$ à l'origine et son angle normal
$\theta \in [0, 2\pi)$ :

$$x \cos(\theta) + y \sin(\theta) = r$$

La **transformée de Radon** $\mathcal{R}[f](r, \theta) = g(r, \theta)$ rassemble
toutes les intégrales de ligne dans un jeu de données 2D appelé **sinogramme**,
discrétisé sur une grille $2Q \times 2P$ ($h = 1/Q$, $r_i = (i - Q)/Q$,
$\theta_j = \pi j / P$).

### 3. Dualité du sinogramme

- Un point unique $(r_0, \theta_0)$ dans l'Espace Sinogramme correspond à une
  droite de rayons X dans l'Espace Objet.

- Un point unique $(x_0, y_0)$ dans l'Espace Objet correspond à l'ensemble des
  droites passant par ce point, formant une sinusoïde dans le sinogramme :

  $$r(\theta) = x_0 \cos(\theta) + y_0 \sin(\theta)$$

### 4. Intégrale de ligne d'un fantôme circulaire

Pour un disque de densité uniforme $1$, de rayon $r_p$ et de centre
$(x_0, y_0)$, posons $\Delta s = r - (x_0 \cos(\theta) + y_0 \sin(\theta))$.
L'intégrale de ligne vaut la longueur de la corde :

$$\psi(\Delta s) = \begin{cases} 2\sqrt{r_p^2 - (\Delta s)^2} & \text{si } |\Delta s| < r_p \\ 0 & \text{sinon} \end{cases}$$

Plusieurs fantômes s'additionnent linéairement dans le sinogramme.

### 5. Rétroprojection et rétroprojection filtrée (FBP)

La somme des valeurs du sinogramme le long de la sinusoïde duale de $(x, y)$
donne la rétroprojection non filtrée :

$$\mathcal{B}[g](x, y) = \int_0^{2\pi} g(x \cos(\theta) + y \sin(\theta), \theta) \, d\theta$$

Sans filtrage, la rétroprojection introduit un flou en $1/|r|$. La convolution
de chaque projection avec le **noyau rampe discret de Frank Natterer** (bande
passante $b = \pi Q$) élimine ce flou :

$$w_b(l) = \frac{b^2}{\pi^4 (1 - 4 l^2)} \quad (l \in \mathbb{Z})$$

$$(w_b * g)(r, \theta) = h \sum_{l = -L}^{L} g(r - l h, \theta) \, w_b(l)$$

Les lobes négatifs de $w_b$ annulent le flou en $1/|r|$, reconstruisant
$f(x, y) \approx 1.0$ dans chaque fantôme et $\approx 0.0$ à l'extérieur.

## Référence de l'interface et des commandes

### Espace Objet

- **Mode Sonde** : Cliquez ou glissez pour placer le point sonde vert $(x, y)$
  et afficher sa sinusoïde duale dans le sinogramme.

- **Mode Fantôme** : Faites glisser les disques fantômes rouges dans le cercle
  unité.

- **Ajouter / Supprimer (`+` / corbeille)** : Ajoutez plusieurs fantômes ou
  supprimez le fantôme sélectionné (Niveaux 4–7).

### Espace Sinogramme (Radon)

- **Carte principale** : Cliquez ou glissez pour choisir un seul rayon X
  $(r, \theta)$.

- **Bordure droite** : Cliquez ou glissez pour afficher une famille de rayons
  parallèles à angle fixe $\theta$.

- **Bordure inférieure** : Cliquez ou glissez pour afficher les droites
  tangentes à un cercle de rayon $|r|$.

### Graphique de profil 1D (Niveaux 5–7)

- Affiche la coupe 1D le long de la sonde active et calcule en direct
  l'intégrale de rétroprojection.

- **Lancer le balayage / Pause** : Fait tourner la famille parallèle sur
  $\theta \in [0, 2\pi)$.

### Barre d'outils, paramètres et raccourcis clavier

- **Filtre (`[F]`)** : Bascule entre le sinogramme non filtré $g$ et filtré
  $w_b * g$.

- **Navigation** : Utilisez **Précédent**, **Suivant**, **Passer** ou les
  puces de niveau (`1`–`7`).

- **Paramètres** : Thème (Sombre, Clair, Système), Palette (Classique, Niveaux
  de gris, Viridis, Inferno), Résolution d'échantillonnage ($P \times Q$) et
  Repères de coordonnées.

- **Raccourcis clavier** : `[Entrée]`/`[N]` étape/niveau suivant, `[→]` niveau
  suivant, `[P]`/`[←]` niveau précédent, `[1]`–`[7]` accès direct, `[Espace]`
  lecture/pause du balayage, `[F]` basculer le filtre.

## Contexte et références

- Applet Java originale (1998/2006) de **Fred Gylys-Colwell**, présentée à la
  Ball State University le 26 février 1998.

- Frank Natterer, *The Mathematics of Computerized Tomography*, SIAM Classics
  in Applied Mathematics, 2001.

- Code source : [https://github.com/fredgc/cat](https://github.com/fredgc/cat)

- Suivi des problèmes :
  [https://github.com/fredgc/cat/issues](https://github.com/fredgc/cat/issues)

- Autres applications : [www.gchouse.org](https://www.gchouse.org)
