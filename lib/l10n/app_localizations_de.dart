// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get aboutAuthor =>
      'Ursprüngliches Java-Applet, vorgestellt als Vortrag an der Ball State University am 26. Februar 1998 von Fred Gylys-Colwell';

  @override
  String get aboutSummary =>
      'Eine interaktive Visualisierung der Radon-Transformation, Linienintegrale, Sinogramm-Dualität und Frank Natterers gefilterter Rückprojektion (FBP).';

  @override
  String get aboutTooltip => 'Über';

  @override
  String get appTitle => 'Computertomographie-Demonstration';

  @override
  String get close => 'Schließen';

  @override
  String get collapseMainTextTooltip => 'Haupttext einklappen';

  @override
  String get colormapClassic => 'Klassisch (1998 Java)';

  @override
  String get colormapGrayscale => 'Graustufen (Medizinische CT)';

  @override
  String get colormapInferno => 'Inferno';

  @override
  String get colormapSection => 'Sinogramm-Farbtabelle';

  @override
  String get colormapViridis => 'Viridis';

  @override
  String get done => 'Fertig';

  @override
  String get expandMainTextTooltip => 'Haupttext ausklappen';

  @override
  String get filteredCheckbox => 'Filter';

  @override
  String get filteredCheckboxWide => 'Gefiltertes Sinogramm [F]';

  @override
  String get githubButton => 'GitHub (fredgc/cat)';

  @override
  String get graphCanvasSemantics =>
      '1D-Profildiagramm mit Querschnitten und Rückprojektionsintegral.';

  @override
  String get graphFilteredPrefix => 'Gefiltert wb * g: ';

  @override
  String graphLineTrajectory(String r, String theta, String val) {
    return 'Strahlabsorption (Grün) | Linie (r = $r, θ = $theta) | Gesamtabsorption: $val';
  }

  @override
  String graphPointTrajectory(
    String prefix,
    String x,
    String y,
    String val,
    String status,
  ) {
    return '${prefix}Punkttrajektorie ($x, $y) | Integral über θ: $val $status';
  }

  @override
  String get graphSelectPrompt =>
      'Wählen Sie einen Punkt oder eine Linie aus, um den 1D-Querschnitt anzuzeigen.';

  @override
  String graphSlineTrajectory(String prefix, String r, String val) {
    return '${prefix}Tangentialer Schnitt bei Radius r = $r | Integral: $val';
  }

  @override
  String graphThetaTrajectory(String prefix, String theta, String val) {
    return '${prefix}Projektionsschnitt bei θ = $theta rad | Integral: $val';
  }

  @override
  String get graphUnfilteredPrefix => 'Ungefiltert g: ';

  @override
  String get insidePhantom => '(innerhalb des Phantoms)';

  @override
  String get issuesButton => 'Probleme';

  @override
  String get keyboardShortcutsList =>
      '• [Enter]: Anleitungsschritt oder nächste Stufe\n• [N] / [→]: Nächste Stufe\n• [P] / [←]: Vorherige Stufe\n• [1] - [7]: Zu Stufe 1 bis 7 springen\n• [Leertaste]: Winkelrotations-Scan abspielen / pausieren\n• [F]: Gefilterten Rekonstruktionsmodus umschalten';

  @override
  String get keyboardShortcutsTitle => 'Tastaturkürzel:';

  @override
  String get languageAuto => 'Automatisch (System)';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get next => 'Weiter';

  @override
  String get nextStepTooltip => 'Nächster Anleitungsschritt';

  @override
  String get objectCanvasSemantics =>
      'Objektraum. Interaktive Koordinatenebene, die Röntgenprojektionslinien und das Phantom zeigt.';

  @override
  String get outsidePhantom => '(außerhalb des Phantoms)';

  @override
  String get previous => 'Zurück';

  @override
  String get previousStepTooltip => 'Vorheriger Anleitungsschritt';

  @override
  String get privacyPolicyButton => 'Datenschutzerklärung';

  @override
  String get radonCanvasSemantics =>
      'Radon-Sinogramm-Raum. Zeigt 2D-Projektionsdaten mit Winkel Theta auf der vertikalen Achse und radialem Abstand r auf der horizontalen Achse.';

  @override
  String get replayAnimationCueTooltip => 'Animationshinweis wiederholen';

  @override
  String get res100Label => '100 (200×200)';

  @override
  String get res100Tooltip => 'Ultra-Auflösung';

  @override
  String get res25Label => '25 (50×50)';

  @override
  String get res25Tooltip => 'Schnelle Leistung';

  @override
  String get res50Label => '50 (100×100)';

  @override
  String get res50Tooltip => 'Standardauflösung';

  @override
  String get res75Label => '75 (150×150)';

  @override
  String get res75Tooltip => 'Hohe Auflösung';

  @override
  String get resetDefaults => 'Auf Standard zurücksetzen';

  @override
  String get resolutionSection => 'Abtastauflösung (P × Q)';

  @override
  String get settingsTitle => 'Einstellungen & Anzeige';

  @override
  String get settingsTooltip => 'Einstellungen & Anzeige';

  @override
  String get showGuidesSubtitle =>
      'Achsen und Kreisgrenzen auf den Leinwänden anzeigen';

  @override
  String get showGuidesTitle => 'Koordinatenhilfslinien anzeigen';

  @override
  String get stage1Description =>
      'Ein Röntgen-Computertomograph (CT) rekonstruiert das 2D-Innere eines Objekts nichtinvasiv, indem er Röntgenstrahlen aus allen Winkeln θ durch das Objekt sendet. Detektoren messen die übertragene Intensität, die nach dem Beer-Lambertschen Gesetz das Linienintegral des Absorptionskoeffizienten f(x, y) entlang jeder Linie L ergibt: g(L) = ∫_L f ds.';

  @override
  String get stage1Instruction1 =>
      'Klicken oder ziehen Sie im Objektraum, um alle Linien zu sehen, die durch diesen Punkt verlaufen. Klicken Sie auf „Weiter“ oder Stufe 2 oben, um fortzufahren.';

  @override
  String get stage1NarrowDescription =>
      'Ein CT rekonstruiert das 2D-Innere eines Objekts nichtinvasiv, indem er Röntgenstrahlen aus vielen Winkeln θ durchstrahlt. Detektoren messen die absorbierte Intensität und erzeugen das Linienintegral f(x, y): g(L) = ∫_L f ds.';

  @override
  String get stage1NarrowInstruction1 =>
      'Tippen oder ziehen Sie im Objektraum, um Linien zu sehen. Tippen Sie auf „Weiter“ oder Stufe 2, um fortzufahren.';

  @override
  String get stage1NarrowSubtitle => 'Überblick & Radon-Transformation';

  @override
  String get stage1NarrowTitle => 'CT-Überblick';

  @override
  String get stage1Subtitle => 'Überblick und die Radon-Transformation';

  @override
  String get stage1Title => 'Computertomographie';

  @override
  String get stage2Description =>
      'Jede gerade Linie im 2D-Raum wird durch zwei Variablen parametrisiert: ihren vorzeichenbehafteten senkrechten Abstand r vom Ursprung und ihren Normalenwinkel θ: x·cos(θ) + y·sin(θ) = r. Das linke Fenster zeigt den physikalischen Objektraum (x, y) und das rechte Fenster den Sinogrammraum (r, θ). Jeder einzelne Punkt (r, θ) im Sinogrammraum repräsentiert eine vollständige Röntgenlinie durch den Objektraum.';

  @override
  String get stage2Instruction1 =>
      'Schritt 1 von 3: Klicken oder ziehen Sie im Sinogramm rechts, um die entsprechende Linie x·cos(θ) + y·sin(θ) = r und ihre Normale links anzuzeigen.';

  @override
  String get stage2Instruction2 =>
      'Schritt 2 von 3: Ziehen Sie im Sinogramm nach links und rechts, um den radialen Abstand r (-1 bis 1) zu variieren. Beobachten Sie die Linienverschiebung.';

  @override
  String get stage2Instruction3 =>
      'Schritt 3 von 3: Ziehen Sie im Sinogramm nach oben und unten, um den Winkel θ (0 bis 2π) zu variieren. Beobachten Sie die Liniendrehung.';

  @override
  String get stage2NarrowDescription =>
      'Jede gerade Linie wird durch r und θ parametrisiert: x·cos(θ) + y·sin(θ) = r. Ein Punkt (r, θ) unten stellt eine vollständige Linie oben dar.';

  @override
  String get stage2NarrowInstruction1 =>
      'Schritt 1 von 3: Klicken oder ziehen Sie im Sinogramm unten, um die Linie oben anzuzeigen.';

  @override
  String get stage2NarrowInstruction2 =>
      'Schritt 2 von 3: Ziehen Sie horizontal, um den radialen Abstand r zu variieren.';

  @override
  String get stage2NarrowInstruction3 =>
      'Schritt 3 von 3: Ziehen Sie vertikal, um den Winkel θ zu variieren.';

  @override
  String get stage2NarrowSubtitle => 'Liniengleichung: x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2NarrowTitle => 'Objekt oben, Daten unten';

  @override
  String get stage2Subtitle =>
      'Linienparametrisierung: x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2Title => 'Objekt links, Daten rechts';

  @override
  String get stage3Description =>
      'Alle Linien, die durch einen einzelnen festen Punkt (x, y) verlaufen, erfüllen r(θ) = x·cos(θ) + y·sin(θ). Wenn der Projektionswinkel θ von 0 bis 2π variiert, bildet diese Linienfamilie eine exakte Sinuskurve im Sinogrammraum (r, θ). Diese Dualität ist grundlegend: Ein Punkt im Objektraum entspricht einer Sinuskurve im Sinogrammraum, während ein Punkt im Sinogrammraum einer Linie im Objektraum entspricht.';

  @override
  String get stage3Instruction1 =>
      'Schritt 1 von 3: Klicken oder ziehen Sie im Objektraum links, um den Punkt zu verschieben und seine duale Sinuskurve rechts zu beobachten.';

  @override
  String get stage3Instruction2 =>
      'Schritt 2 von 3: Klicken Sie auf die rechte Randleiste im Sinogramm, um parallele Linien bei festem Winkel θ anzuzeigen.';

  @override
  String get stage3Instruction3 =>
      'Schritt 3 von 3: Klicken Sie auf die untere Randleiste im Sinogramm, um Tangenten an einen Kreis mit Radius |r| anzuzeigen.';

  @override
  String get stage3NarrowDescription =>
      'Alle Linien durch einen festen Punkt (x, y) erfüllen r(θ) = x·cos(θ) + y·sin(θ) und bilden eine Sinuswelle im Raum (r, θ).';

  @override
  String get stage3NarrowInstruction1 =>
      'Schritt 1 von 3: Klicken oder ziehen Sie im Objektraum oben und beobachten Sie die Sinuskurve unten.';

  @override
  String get stage3NarrowInstruction2 =>
      'Schritt 2 von 3: Klicken Sie auf den rechten Rand für parallele Linien.';

  @override
  String get stage3NarrowInstruction3 =>
      'Schritt 3 von 3: Klicken Sie auf den unteren Rand für Tangentenlinien.';

  @override
  String get stage3NarrowSubtitle => 'Punkte erzeugen Sinuskurven im Sinogramm';

  @override
  String get stage3Subtitle =>
      'Punkte im Objektraum zeichnen Sinuskurven im Sinogrammraum';

  @override
  String get stage3Title => 'Punktdualität';

  @override
  String get stage4Description =>
      'Ein Phantomobjekt – eine kreisförmige Scheibe, die eine interne Struktur simuliert – befindet sich im Objektraum. Seine Röntgendämpfung erzeugt einen 2D-Schattendatensatz g(r, θ), der als Sinogramm bezeichnet wird. Wenn Sie das Phantom verschieben, ändern sich Amplitude und Phase seines Sinusschattens.';

  @override
  String get stage4Instruction1 =>
      'Schritt 1 von 2: Ziehen Sie die rote Phantomscheibe im Objektraum links, um ihre Position zu verändern.';

  @override
  String get stage4Instruction2 =>
      'Schritt 2 von 2: Beobachten Sie, wie sich der 2D-Schatten des Phantoms im Sinogramm rechts sofort verschiebt.';

  @override
  String get stage4NarrowDescription =>
      'Ein Phantomobjekt (Kreisscheibe) im Objektraum erzeugt einen 2D-Schattendatensatz g(r, θ), das Sinogramm.';

  @override
  String get stage4NarrowInstruction1 =>
      'Schritt 1 von 2: Ziehen Sie die Phantomscheibe oben, um ihre Position zu verändern.';

  @override
  String get stage4NarrowInstruction2 =>
      'Schritt 2 von 2: Beobachten Sie die Schattenverschiebung im Sinogramm unten.';

  @override
  String get stage4NarrowSubtitle => 'Phantom und 2D-Sinogrammschatten';

  @override
  String get stage4NarrowTitle => 'Objektschatten';

  @override
  String get stage4Subtitle =>
      'Das Phantomobjekt und sein 2D-Sinogrammschatten';

  @override
  String get stage4Title => 'Objekt wirft Schatten';

  @override
  String get stage5Description =>
      'Das untere Diagramm zeigt 1D-Querschnitte des Sinogramms g(r, θ). Die Summation der Projektionen entlang der Sinuskurve eines Punktes über alle Winkel θ heißt Rückprojektion: ∫₀²π g(x·cos θ + y·sin θ, θ) dθ. Liegt der Punkt im Phantom, ist das Integral groß; liegt er außerhalb, ist es klein. Die ungefilterte Rückprojektion verschmiert jedoch Details mit 1/|r|.';

  @override
  String get stage5Instruction1 =>
      'Schritt 1 von 3: Klicken Sie in die Phantomscheibe links. Beachten Sie den hohen Rückprojektionswert im unteren Diagramm.';

  @override
  String get stage5Instruction2 =>
      'Schritt 2 von 3: Klicken Sie außerhalb der Phantomscheibe. Beachten Sie das Abfallen der 1D-Werte und des Integrals.';

  @override
  String get stage5Instruction3 =>
      'Schritt 3 von 3: Klicken Sie auf die Randleisten des Sinogramms rechts für Querschnitte bei konstantem θ oder r.';

  @override
  String get stage5NarrowDescription =>
      'Das Diagramm unten zeigt 1D-Querschnitte von g(r, θ). Die Rückprojektion ergibt innerhalb des Phantoms ein großes Integral, führt aber ungefiltert zu 1/|r|-Unschärfe.';

  @override
  String get stage5NarrowInstruction1 =>
      'Schritt 1 von 3: Klicken Sie in das Phantom oben. Beachten Sie das hohe Integral unten.';

  @override
  String get stage5NarrowInstruction2 =>
      'Schritt 2 von 3: Klicken Sie außerhalb des Phantoms. Beachten Sie den Abfall der Werte.';

  @override
  String get stage5NarrowInstruction3 =>
      'Schritt 3 von 3: Klicken Sie auf die Ränder des Sinogramms unten für Querschnitte.';

  @override
  String get stage5NarrowSubtitle => '1D-Profile & Rückprojektion';

  @override
  String get stage5NarrowTitle => 'Datenquerschnitt';

  @override
  String get stage5Subtitle => '1D-Profile und ungefilterte Rückprojektion';

  @override
  String get stage5Title => 'Datenquerschnitt';

  @override
  String get stage6Description =>
      'Um die 1/|r|-Unschärfe zu eliminieren, werden die Projektionen vor der Rückprojektion gefiltert (Gefilterte Rückprojektion, FBP). Die Faltung jeder Projektion mit Frank Natterers diskretem Rampenkern w_b(l) = b² / (π⁴(1 - 4l²)) wirkt als kantenverstärkender Filter mit negativen Nebenkeulen, die die Unschärfe exakt aufheben: ≈ 1.0 innerhalb des Phantoms und ≈ 0.0 außerhalb.';

  @override
  String get stage6Instruction1 =>
      'Schritt 1 von 2: Klicken Sie in die Phantomscheibe. Beobachten Sie die scharfen Kantenkeulen und das rekonstruierte Integral ≈ 1.0.';

  @override
  String get stage6Instruction2 =>
      'Schritt 2 von 2: Klicken Sie außerhalb der Phantomscheibe. Die negativen Nebenkeulen heben die Unschärfe auf (Integral ≈ 0.0).';

  @override
  String get stage6NarrowDescription =>
      'Die Hochpassfilterung der Projektionen mit Frank Natterers diskretem Rampenkern w_b(l) = b² / (π⁴(1 - 4l²)) schärft das Sinogramm. Gefilterte Rückprojektion rekonstruiert exakt: ≈ 1.0 im Phantom, ≈ 0.0 außerhalb.';

  @override
  String get stage6NarrowInstruction1 =>
      'Schritt 1 von 2: Klicken Sie in das Phantom. Beobachten Sie scharfe Keulen und Integral ≈ 1.0.';

  @override
  String get stage6NarrowInstruction2 =>
      'Schritt 2 von 2: Klicken Sie außerhalb des Phantoms. Negative Keulen heben Unschärfe auf (Integral ≈ 0.0).';

  @override
  String get stage6NarrowSubtitle => 'Gefilterte Rückprojektion (FBP)';

  @override
  String get stage6NarrowTitle => 'Gefilterte Rekonstruktion';

  @override
  String get stage6Subtitle =>
      'Gefilterte Rückprojektion (FBP) mit Natterer-Rampenkern';

  @override
  String get stage6Title => 'Gefilterte Datenrekonstruktion';

  @override
  String stageIndicator(int stageNumber) {
    return 'Stufe $stageNumber von 6';
  }

  @override
  String stageTitle(int stageNumber, String title) {
    return 'Stufe $stageNumber: $title';
  }

  @override
  String get switchLanguageTooltip => 'Sprache wechseln';

  @override
  String get moreInfoButton => 'Weitere Informationen';

  @override
  String get termsOfServiceButton => 'Nutzungsbedingungen';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeSection => 'Design';

  @override
  String get themeSystem => 'System';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get websiteButton => 'www.gchouse.org';
}
