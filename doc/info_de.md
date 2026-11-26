---
title: CT-Scan Mathematik- & UI-Referenz
---

Das **Computertomographie-Demonstrationswerkzeug** ist eine interaktive
Referenz für die Computertomographie (CT), die Radon-Transformation und die
gefilterte Rückprojektion (FBP).

## Mathematische Referenz

### 1. Röntgenabschwächung & Linienintegrale

Ein Röntgenstrahl entlang einer Geraden $L$ durch ein Objekt verliert nach dem
Beer-Lambertschen Gesetz an Intensität:

$$I = I_0 \exp\left(-\int_L f(x, y) \, ds\right)$$

Der Vergleich von transmittierter Intensität $I$ und Ausgangsintensität $I_0$
liefert das Linienintegral des Absorptionskoeffizienten $f(x, y)$:

$$g(L) = -\ln\left(\frac{I}{I_0}\right) = \int_L f(x, y) \, ds$$

### 2. Linienparametrisierung & Radon-Transformation

Jede Gerade in der 2D-Ebene $[-1, 1] \times [-1, 1]$ wird durch ihren
vorzeichenbehafteten Abstand $r \in [-1, 1]$ zum Ursprung und ihren
Normalenwinkel $\theta \in [0, 2\pi)$ parametrisiert:

$$x \cos(\theta) + y \sin(\theta) = r$$

Die **Radon-Transformation** $\mathcal{R}[f](r, \theta) = g(r, \theta)$ erfasst
alle Linienintegrale als 2D-Datensatz (**Sinogramm**) auf einem
$2Q \times 2P$-Gitter ($h = 1/Q$, $r_i = (i - Q)/Q$, $\theta_j = \pi j / P$).

### 3. Sinogramm-Dualität

- Ein einzelner Punkt $(r_0, \theta_0)$ im Sinogrammraum entspricht einer
  einzelnen geraden Röntgenlinie im Objektraum.

- Ein einzelner Punkt $(x_0, y_0)$ im Objektraum entspricht allen Geraden durch
  diesen Punkt und bildet eine Sinuskurve im Sinogrammraum:

  $$r(\theta) = x_0 \cos(\theta) + y_0 \sin(\theta)$$

### 4. Linienintegral einer kreisförmigen Phantomscheibe

Für eine Kreisscheibe mit konstanter Dichte $1$, Radius $r_p$ und Mittelpunkt
$(x_0, y_0)$ sei $\Delta s = r - (x_0 \cos(\theta) + y_0 \sin(\theta))$. Das
Linienintegral ist die Sehnenlänge:

$$\psi(\Delta s) = \begin{cases} 2\sqrt{r_p^2 - (\Delta s)^2} & \text{für } |\Delta s| < r_p \\ 0 & \text{sonst} \end{cases}$$

Mehrere Phantome addieren sich im Sinogramm linear.

### 5. Rückprojektion & Gefilterte Rückprojektion (FBP)

Die Summation der Sinogrammwerte entlang der dualen Sinuskurve von $(x, y)$
ergibt die ungefilterte Rückprojektion:

$$\mathcal{B}[g](x, y) = \int_0^{2\pi} g(x \cos(\theta) + y \sin(\theta), \theta) \, d\theta$$

Die ungefilterte Rückprojektion erzeugt eine $1/|r|$-Unschärfe. Durch Faltung
jeder Projektion mit **Frank Natterers diskretem Rampenkern** (Bandbreite
$b = \pi Q$) wird diese Unschärfe aufgehoben:

$$w_b(l) = \frac{b^2}{\pi^4 (1 - 4 l^2)} \quad (l \in \mathbb{Z})$$

$$(w_b * g)(r, \theta) = h \sum_{l = -L}^{L} g(r - l h, \theta) \, w_b(l)$$

Die negativen Nebenkeulen von $w_b$ kompensieren die $1/|r|$-Verschmierung und
rekonstruieren $f(x, y) \approx 1.0$ innerhalb und $\approx 0.0$ außerhalb der
Phantomscheiben.

## UI- & Steuerungsreferenz

### Objektraum

- **Sondenmodus**: Klicken oder ziehen, um den grünen Sondenpunkt $(x, y)$ zu
  setzen und seine duale Sinuskurve im Sinogramm anzuzeigen.

- **Phantommodus**: Rote Phantomscheiben innerhalb des Einheitskreises
  verschieben.

- **Hinzufügen / Löschen (`+` / Papierkorb)**: Weitere Phantomscheiben
  hinzufügen oder das ausgewählte Phantom löschen (Stufen 4–7).

### Sinogrammraum (Radon-Raum)

- **Haupt-Heatmap**: Klicken oder ziehen für einen einzelnen Röntgenstrahl
  $(r, \theta)$.

- **Rechte Randleiste**: Klicken oder ziehen für parallele Röntgenstrahlen bei
  festem Winkel $\theta$.

- **Untere Randleiste**: Klicken oder ziehen für Tangenten an einen Kreis mit
  Radius $|r|$.

### 1D-Profildiagramm (Stufen 5–7)

- Zeigt den 1D-Querschnitt entlang der aktiven Sonde sowie das aktuelle
  Rückprojektionsintegral.

- **Scan starten / Pause**: Schwenkt die parallele Strahlenfamilie über
  $\theta \in [0, 2\pi)$.

### Symbolleiste, Einstellungen & Tastaturkürzel

- **Filter (`[F]`)**: Wechselt zwischen ungefiltertem Sinogramm $g$ und
  gefiltertem Sinogramm $w_b * g$.

- **Stufennavigation**: **Zurück**, **Weiter**, **Überspringen** oder die
  Stufen-Buttons (`1`–`7`).

- **Einstellungen**: Design (Dunkel, Hell, System), Farbtabelle (Klassisch,
  Graustufen, Viridis, Inferno), Abtastauflösung ($P \times Q$) und
  Koordinatenhilfslinien.

- **Tastaturkürzel**: `[Enter]`/`[N]` nächster Schritt/Stufe, `[→]` nächste
  Stufe, `[P]`/`[←]` vorherige Stufe, `[1]`–`[7]` Stufenauswahl, `[Leertaste]`
  Scan starten/pausieren, `[F]` Filter umschalten.

## Hintergrund & Literatur

- Ursprüngliches Java-Applet (1998/2006) von **Fred Gylys-Colwell**, vorgestellt
  an der Ball State University am 26. Februar 1998.

- Frank Natterer, *The Mathematics of Computerized Tomography*, SIAM Classics
  in Applied Mathematics, 2001.

- Quellcode: [https://github.com/fredgc/cat](https://github.com/fredgc/cat)

- Fehlerberichte:
  [https://github.com/fredgc/cat/issues](https://github.com/fredgc/cat/issues)

- Weitere Apps und Werkzeuge: [www.gchouse.org](https://www.gchouse.org)
