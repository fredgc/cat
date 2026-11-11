// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get aboutAuthor =>
      'Applet Java originale présentée lors d\'une conférence à la Ball State University le 26 février 1998 par Fred Gylys-Colwell';

  @override
  String get aboutSummary =>
      'Une visualisation interactive de la transformée de Radon, des intégrales de ligne, de la dualité du sinogramme et de la rétroprojection filtrée (FBP) de Frank Natterer.';

  @override
  String get aboutTooltip => 'À propos';

  @override
  String get appTitle => 'Démonstration de tomographie axiale calculée';

  @override
  String get close => 'Fermer';

  @override
  String get collapseMainTextTooltip => 'Réduire le texte principal';

  @override
  String get colormapClassic => 'Classique (Java 1998)';

  @override
  String get colormapGrayscale => 'Niveaux de gris (CT médical)';

  @override
  String get colormapInferno => 'Inferno';

  @override
  String get colormapSection => 'Palette de couleurs du sinogramme';

  @override
  String get colormapViridis => 'Viridis';

  @override
  String get done => 'Terminé';

  @override
  String get expandMainTextTooltip => 'Développer le texte principal';

  @override
  String get filteredCheckbox => 'Filtre';

  @override
  String get filteredCheckboxWide => 'Sinogramme filtré [F]';

  @override
  String get githubButton => 'GitHub (fredgc/cat)';

  @override
  String get graphCanvasSemantics =>
      'Graphique de profil 1D montrant les coupes transversales et l\'intégrale de rétroprojection.';

  @override
  String get graphFilteredPrefix => 'Filtré wb * g : ';

  @override
  String graphLineTrajectory(String r, String theta, String val) {
    return 'Ray Absorption (Green) | Ligne (r = $r, θ = $theta) | Absorption totale : $val';
  }

  @override
  String graphPointTrajectory(
    String prefix,
    String x,
    String y,
    String val,
    String status,
  ) {
    return '${prefix}Point Trajectory ($x, $y) | Intégrale sur θ : $val $status';
  }

  @override
  String get graphSelectPrompt =>
      'Sélectionnez un point ou une ligne pour afficher la coupe transversale 1D.';

  @override
  String graphSlineTrajectory(String prefix, String r, String val) {
    return '${prefix}Coupe tangente au rayon r = $r | Intégrale : $val';
  }

  @override
  String graphThetaTrajectory(String prefix, String theta, String val) {
    return '${prefix}Coupe de projection à θ = $theta rad | Intégrale : $val';
  }

  @override
  String get graphUnfilteredPrefix => 'Non filtré g : ';

  @override
  String get insidePhantom => '(à l\'intérieur du fantôme)';

  @override
  String get issuesButton => 'Problèmes';

  @override
  String get keyboardShortcutsList =>
      '• [Entrée] : Étape d\'instruction ou niveau suivant\n• [N] / [→] : Niveau suivant\n• [P] / [←] : Niveau précédent\n• [1] - [7] : Aller au niveau 1 à 7\n• [Espace] : Lecture / Pause du balayage rotatif\n• [F] : Basculer le mode de reconstruction filtrée';

  @override
  String get keyboardShortcutsTitle => 'Raccourcis clavier :';

  @override
  String get languageAuto => 'Automatique (Système)';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get next => 'Suivant';

  @override
  String get nextStepTooltip => 'Étape d\'instruction suivante';

  @override
  String get objectCanvasSemantics =>
      'Espace de l\'objet. Plan de coordonnées interactif montrant les lignes de projection de rayons X et le fantôme.';

  @override
  String get outsidePhantom => '(à l\'extérieur du fantôme)';

  @override
  String get previous => 'Précédent';

  @override
  String get previousStepTooltip => 'Étape d\'instruction précédente';

  @override
  String get privacyPolicyButton => 'Politique de confidentialité';

  @override
  String get radonCanvasSemantics =>
      'Espace de Radon du sinogramme. Affiche les données de projection 2D avec l\'angle thêta sur l\'axe vertical et la distance radiale r sur l\'axe horizontal.';

  @override
  String get replayAnimationCueTooltip => 'Rejouer l\'animation d\'indication';

  @override
  String get res100Label => '100 (200×200)';

  @override
  String get res100Tooltip => 'Ultra résolution';

  @override
  String get res25Label => '25 (50×50)';

  @override
  String get res25Tooltip => 'Performance rapide';

  @override
  String get res50Label => '50 (100×100)';

  @override
  String get res50Tooltip => 'Résolution standard';

  @override
  String get res75Label => '75 (150×150)';

  @override
  String get res75Tooltip => 'Haute résolution';

  @override
  String get resetDefaults => 'Rétablir les paramètres par défaut';

  @override
  String get resolutionSection => 'Résolution d\'échantillonnage (P × Q)';

  @override
  String get settingsTitle => 'Paramètres & Affichage';

  @override
  String get settingsTooltip => 'Paramètres & Affichage';

  @override
  String get showGuidesSubtitle =>
      'Afficher les axes et limites circulaires sur les toiles';

  @override
  String get showGuidesTitle => 'Afficher les repères de coordonnées';

  @override
  String get stage1Description =>
      'Un tomodensitomètre (TDM) reconstruit de manière non invasive l\'intérieur 2D d\'un objet en transmettant des rayons X sous tous les angles θ. Les détecteurs mesurent l\'intensité transmise, produisant l\'intégrale de ligne mathématique du coefficient d\'absorption f(x, y) le long de chaque ligne L : g(L) = ∫_L f ds.';

  @override
  String get stage1Instruction1 =>
      'Cliquez ou glissez dans l\'Espace Objet pour voir les lignes passant par ce point. Cliquez sur « Suivant » ou sur le Niveau 2 ci-dessus pour continuer.';

  @override
  String get stage1NarrowDescription =>
      'Un scanner CT reconstruit l\'intérieur 2D d\'un objet en transmettant des rayons X sous de nombreux angles θ. Les détecteurs mesurent l\'intensité absorbée : g(L) = ∫_L f ds.';

  @override
  String get stage1NarrowInstruction1 =>
      'Touchez ou glissez dans l\'Espace Objet pour voir les lignes. Touchez « Suivant » ou le Niveau 2 pour continuer.';

  @override
  String get stage1NarrowSubtitle => 'Aperçu & Transformée de Radon';

  @override
  String get stage1NarrowTitle => 'Aperçu de la tomodensitométrie';

  @override
  String get stage1Subtitle => 'Aperçu et transformée de Radon';

  @override
  String get stage1Title => 'Tomographie axiale calculée';

  @override
  String get stage2Description =>
      'Chaque ligne droite dans l\'espace 2D est paramétrée par deux variables : sa distance perpendiculaire signée r à l\'origine et son angle normal θ : x·cos(θ) + y·sin(θ) = r. La fenêtre de gauche montre l\'Espace Objet physique (x, y) et celle de droite montre l\'Espace Sinogramme (r, θ). Chaque point (r, θ) représente une ligne complète de rayons X à travers l\'objet.';

  @override
  String get stage2Instruction1 =>
      'Étape 1 sur 3 : Cliquez ou glissez dans le sinogramme à droite pour afficher la ligne x·cos(θ) + y·sin(θ) = r correspondante à gauche.';

  @override
  String get stage2Instruction2 =>
      'Étape 2 sur 3 : Glissez vers la gauche et la droite pour faire varier la distance radiale r (-1 à 1). Observez la translation de la ligne.';

  @override
  String get stage2Instruction3 =>
      'Étape 3 sur 3 : Glissez vers le haut et le bas pour faire varier l\'angle θ (0 à 2π). Observez la rotation de la ligne.';

  @override
  String get stage2NarrowDescription =>
      'Chaque ligne droite est paramétrée par r et θ : x·cos(θ) + y·sin(θ) = r. Un point (r, θ) en bas représente une ligne complète en haut.';

  @override
  String get stage2NarrowInstruction1 =>
      'Étape 1 sur 3 : Cliquez ou glissez dans le sinogramme en bas pour voir la ligne en haut.';

  @override
  String get stage2NarrowInstruction2 =>
      'Étape 2 sur 3 : Glissez horizontalement pour faire varier r.';

  @override
  String get stage2NarrowInstruction3 =>
      'Étape 3 sur 3 : Glissez verticalement pour faire varier θ.';

  @override
  String get stage2NarrowSubtitle =>
      'Équation de la ligne : x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2NarrowTitle => 'Objet en haut, données en bas';

  @override
  String get stage2Subtitle =>
      'Paramétrage des lignes : x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2Title => 'Objet à gauche, données à droite';

  @override
  String get stage3Description =>
      'Toutes les lignes passant par un point fixe (x, y) satisfont r(θ) = x·cos(θ) + y·sin(θ). Quand l\'angle θ varie de 0 à 2π, cette famille forme une onde sinusoïdale exacte dans l\'espace (r, θ). Cette dualité est fondamentale : un point dans l\'espace objet devient une sinusoïde dans le sinogramme, et un point dans le sinogramme devient une ligne dans l\'objet.';

  @override
  String get stage3Instruction1 =>
      'Étape 1 sur 3 : Cliquez ou glissez dans l\'Espace Objet à gauche pour déplacer le point sonde et observer sa sinusoïde duale à droite.';

  @override
  String get stage3Instruction2 =>
      'Étape 2 sur 3 : Cliquez sur la bordure droite du sinogramme pour afficher des lignes parallèles à angle fixe θ.';

  @override
  String get stage3Instruction3 =>
      'Étape 3 sur 3 : Cliquez sur la bordure inférieure du sinogramme pour voir les lignes tangentes à un cercle de rayon |r|.';

  @override
  String get stage3NarrowDescription =>
      'Toutes les lignes par un point (x, y) forment une onde sinusoïdale dans l\'espace (r, θ).';

  @override
  String get stage3NarrowInstruction1 =>
      'Étape 1 sur 3 : Cliquez ou glissez dans l\'Espace Objet en haut et observez la sinusoïde en bas.';

  @override
  String get stage3NarrowInstruction2 =>
      'Étape 2 sur 3 : Cliquez sur le bord droit pour voir des lignes parallèles.';

  @override
  String get stage3NarrowInstruction3 =>
      'Étape 3 sur 3 : Cliquez sur le bord inférieur pour voir des lignes tangentes.';

  @override
  String get stage3NarrowSubtitle => 'Les points tracent des sinusoïdes';

  @override
  String get stage3Subtitle =>
      'Les points dans l\'espace objet tracent des sinusoïdes dans le sinogramme';

  @override
  String get stage3Title => 'Dualité des points';

  @override
  String get stage4Description =>
      'Un objet fantôme — un disque circulaire simulant une structure interne — est placé dans l\'espace objet. Son难道atténuation de rayons X produit un ensemble de données d\'ombre 2D g(r, θ) appelé sinogramme. Déplacer le fantôme modifie l\'amplitude et la phase de son ombre.';

  @override
  String get stage4Instruction1 =>
      'Étape 1 sur 2 : Faites glisser le disque fantôme rouge dans l\'Espace Objet à gauche pour modifier sa position.';

  @override
  String get stage4Instruction2 =>
      'Étape 2 sur 2 : Observez comment l\'ombre 2D du fantôme dans le sinogramme à droite se déplace immédiatement.';

  @override
  String get stage4NarrowDescription =>
      'Un fantôme circulaire génère une ombre 2D g(r, θ) dans le sinogramme. Déplacer le fantôme déplace son ombre.';

  @override
  String get stage4NarrowInstruction1 =>
      'Étape 1 sur 2 : Faites glisser le fantôme en haut pour modifier sa position.';

  @override
  String get stage4NarrowInstruction2 =>
      'Étape 2 sur 2 : Observez le déplacement de l\'ombre en bas.';

  @override
  String get stage4NarrowSubtitle => 'Fantôme et ombre 2D';

  @override
  String get stage4NarrowTitle => 'Ombre de l\'objet';

  @override
  String get stage4Subtitle =>
      'L\'objet fantôme et son ombre 2D dans le sinogramme';

  @override
  String get stage4Title => 'L\'objet projette une ombre';

  @override
  String get stage5Description =>
      'Le graphique du bas montre des coupes 1D du sinogramme g(r, θ). Sommer les projections le long de la sinusoïde d\'un point sur tous les angles θ s\'appelle la rétroprojection : ∫₀²π g(x·cos θ + y·sin θ, θ) dθ. Cependant, la rétroprojection non filtrée produit un flou en 1/|r|.';

  @override
  String get stage5Instruction1 =>
      'Étape 1 sur 3 : Cliquez à l\'intérieur du fantôme à gauche. Notez la valeur élevée de l\'intégrale en bas.';

  @override
  String get stage5Instruction2 =>
      'Étape 2 sur 3 : Cliquez à l\'extérieur du fantôme. Notez la diminution des valeurs 1D et de l\'intégrale.';

  @override
  String get stage5Instruction3 =>
      'Étape 3 sur 3 : Cliquez sur les bordures du sinogramme à droite pour examiner les coupes à θ ou r constant.';

  @override
  String get stage5NarrowDescription =>
      'Le graphique en bas montre la coupe 1D. La rétroprojection donne une grande intégrale dans le fantôme, mais non filtrée elle crée un flou 1/|r|.';

  @override
  String get stage5NarrowInstruction1 =>
      'Étape 1 sur 3 : Cliquez dans le fantôme en haut. Notez la grande intégrale en bas.';

  @override
  String get stage5NarrowInstruction2 =>
      'Étape 2 sur 3 : Cliquez à l\'extérieur. Notez la chute des valeurs.';

  @override
  String get stage5NarrowInstruction3 =>
      'Étape 3 sur 3 : Cliquez sur les bordures en bas pour examiner les coupes.';

  @override
  String get stage5NarrowSubtitle => 'Profils 1D & Rétroprojection';

  @override
  String get stage5NarrowTitle => 'Coupe transversale';

  @override
  String get stage5Subtitle => 'Profils 1D et rétroprojection non filtrée';

  @override
  String get stage5Title => 'Coupe transversale des données';

  @override
  String get stage6Description =>
      'Pour éliminer le flou en 1/|r|, les projections sont filtrées avant la rétroprojection (Rétroprojection Filtrée, FBP). La convolution avec le noyau discret de Frank Natterer w_b(l) = b² / (π⁴(1 - 4l²)) agit comme un filtre rehaussant les contours avec des lobes négatifs annulant le flou : ≈ 1.0 dans le fantôme et ≈ 0.0 à l\'extérieur.';

  @override
  String get stage6Instruction1 =>
      'Étape 1 sur 2 : Cliquez dans le fantôme. Observez les lobes nets et l\'intégrale reconstruite ≈ 1.0.';

  @override
  String get stage6Instruction2 =>
      'Étape 2 sur 2 : Cliquez à l\'extérieur. Les lobes négatifs annulent le flou (intégrale ≈ 0.0).';

  @override
  String get stage6NarrowDescription =>
      'Le filtrage passe-haut avec le noyau de Natterer w_b(l) = b² / (π⁴(1 - 4l²)) affine le sinogramme pour reconstruire fidèlement : ≈ 1.0 dans le fantôme, ≈ 0.0 dehors.';

  @override
  String get stage6NarrowInstruction1 =>
      'Étape 1 sur 2 : Cliquez dans le fantôme. Observez les lobes nets et l\'intégrale ≈ 1.0.';

  @override
  String get stage6NarrowInstruction2 =>
      'Étape 2 sur 2 : Cliquez dehors. Les lobes négatifs annulent le flou (intégrale ≈ 0.0).';

  @override
  String get stage6NarrowSubtitle => 'Rétroprojection filtrée (FBP)';

  @override
  String get stage6NarrowTitle => 'Reconstruction filtrée';

  @override
  String get stage6Subtitle =>
      'Rétroprojection filtrée (FBP) avec filtre rampe de Natterer';

  @override
  String get stage6Title => 'Reconstruction de données filtrées';

  @override
  String stageIndicator(int stageNumber) {
    return 'Niveau $stageNumber sur 6';
  }

  @override
  String stageTitle(int stageNumber, String title) {
    return 'Niveau $stageNumber : $title';
  }

  @override
  String get switchLanguageTooltip => 'Changer de langue';

  @override
  String get moreInfoButton => 'Plus d\'informations';

  @override
  String get termsOfServiceButton => 'Conditions d\'utilisation';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeSection => 'Thème';

  @override
  String get themeSystem => 'Système';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get websiteButton => 'www.gchouse.org';
}
