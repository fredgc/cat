---
title: Über die Computertomographie-Demonstration
---

Das **Computertomographie-Demonstrationswerkzeug** ist eine interaktive
pädagogische Anwendung zur Veranschaulichung der Mathematik und Mechanismen
hinter der Computertomographie (CT) und der Radon-Transformation.

## Geschichte & Motivation

Diese Anwendung ist inspiriert vom ursprünglichen Java-Applet aus den Jahren
1998/2006 von **Fred Gylys-Colwell**. Der Vortrag wurde erstmals am

26. Februar 1998 gehalten.

Diese Anwendung ist in Dart mit Flutter geschrieben. Der Quellcode ist
auf GitHub verfügbar:
[https://github.com/fredgc/cat](https://github.com/fredgc/cat).

Haben Sie einen Fehler gefunden oder Vorschläge?
[Erstellen Sie ein Problem auf GitHub](https://github.com/fredgc/cat/issues).

Weitere Anwendungen und Zeichenwerkzeuge finden Sie unter
[www.gchouse.org](https://www.gchouse.org).

## Die Mathematik hinter der Computertomographie

Eine Röntgen-Computertomographie erzeugt nichtinvasiv eine
2D-Querschnittsansicht des Inneren eines Objekts oder menschlichen Körpers von
außen.

1. **Röntgenabsorption & Linienintegrale**:

Ein Röntgenstrahl verläuft entlang einer geraden Linie $L$ durch den Körper.
Der Anteil der absorbierten Strahlung entspricht dem Linienintegral des
Absorptionskoeffizienten $f(x, y)$ entlang der Linie $L$:

   $$g(L) = \int_L f(x, y) \, ds$$

2. **Parametrisierung von Geraden**:

Jede Gerade in der Ebene wird durch ihren vorzeichenbehafteten Abstand $r$ vom
Ursprung und ihren Normalenwinkel $\theta \in [0, 2\pi)$ parametrisiert:

   $$x \cos\theta + y \sin\theta = r$$

Die Radon-Transformation $\mathcal{R}[f](r, \theta)$ erfasst die
Linienintegrale für alle $(r, \theta)$.

3. **Sinogramm-Dualität**:

   - Ein einzelner Punkt im Sinogrammraum $(r_0, \theta_0)$ repräsentiert eine
     einzelne Linie im Objektraum.

   - Ein einzelner Punkt $(x_1, y_1)$ im Objektraum entspricht einer
     Sinuskurve $r(\theta) = x_1 \cos\theta + y_1 \sin\theta$ im
     Sinogrammraum, die alle Linien durch $(x_1, y_1)$ darstellt.

4. **Gefilterte Rückprojektion (Rekonstruktion)**:

Die einfache Rückprojektion verschmiert Projektionenüber die Bildebene und
erzeugt eine $1/r$-Unschärfe. Durch Faltung jeder Projektion mit einem Rampen-
bzw. Hochpassfilter (hergeleitet von Frank Natterer) rekonstruiert die
Rückprojektion der gefilterten Daten die inneren Strukturen exakt ($f(x, y)
\approx 1$ im Objekt, $0$ außerhalb).

## Datenschutz und Datenaufbewahrung

Diese Anwendung speichert Benutzereinstellungen ausschließlich lokal auf Ihrem
Gerät (`SharedPreferences` / `localStorage`). Es werden keine
personenbezogenen Daten erhoben.
