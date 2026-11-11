// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get aboutAuthor =>
      'Originalus „Java“ apletas, pristatytas pranešime Ball State universitete 1998 m. vasario 26 d., autorius Fred Gylys-Colwell';

  @override
  String get aboutSummary =>
      'Interaktyvi Radono transformacijos, tiesinių integralų, sinogramos dvilypumo ir Frank Natterer filtruotos atgalinės projekcijos (FBP) vizualizacija.';

  @override
  String get aboutTooltip => 'Apie';

  @override
  String get appTitle => 'Kompiuterinės tomografijos demonstracija';

  @override
  String get close => 'Uždaryti';

  @override
  String get collapseMainTextTooltip => 'Suskleisti pagrindinį tekstą';

  @override
  String get colormapClassic => 'Klasikinė (1998 m. Java)';

  @override
  String get colormapGrayscale => 'Pilki atspalviai (medicininė KT)';

  @override
  String get colormapInferno => 'Inferno';

  @override
  String get colormapSection => 'Sinogramos spalvų paletė';

  @override
  String get colormapViridis => 'Viridis';

  @override
  String get done => 'Atlikta';

  @override
  String get expandMainTextTooltip => 'Išskleisti pagrindinį tekstą';

  @override
  String get filteredCheckbox => 'Filtras';

  @override
  String get filteredCheckboxWide => 'Filtruota sinograma [F]';

  @override
  String get githubButton => 'GitHub (fredgc/cat)';

  @override
  String get graphCanvasSemantics =>
      '1D profilio diagrama, rodanti skerspjūvius ir atgalinės projekcijos integralą.';

  @override
  String get graphFilteredPrefix => 'Filtruota wb * g: ';

  @override
  String graphLineTrajectory(String r, String theta, String val) {
    return 'Ray Absorption (Green) | Tiesė (r = $r, θ = $theta) | Bendra absorbcija: $val';
  }

  @override
  String graphPointTrajectory(
    String prefix,
    String x,
    String y,
    String val,
    String status,
  ) {
    return '${prefix}Point Trajectory ($x, $y) | Integralas pagal θ: $val $status';
  }

  @override
  String get graphSelectPrompt =>
      'Pasirinkite tašką arba tiesę, kad pamatytumėte 1D skerspjūvį.';

  @override
  String graphSlineTrajectory(String prefix, String r, String val) {
    return '${prefix}Liestinis pjūvis esant spinduliui r = $r | Integralas: $val';
  }

  @override
  String graphThetaTrajectory(String prefix, String theta, String val) {
    return '${prefix}Projekcijos pjūvis esant θ = $theta rad | Integralas: $val';
  }

  @override
  String get graphUnfilteredPrefix => 'Nefiltruota g: ';

  @override
  String get insidePhantom => '(fantomo viduje)';

  @override
  String get issuesButton => 'Problemos';

  @override
  String get keyboardShortcutsList =>
      '• [Enter]: Kitas instrukcijos žingsnis arba etapas\n• [N] / [→]: Kitas etapas\n• [P] / [←]: Ankstesnis etapas\n• [1] - [7]: Pereiti į 1–7 etapą\n• [Tarpas]: Paleisti / Pristabdyti kampinį skenavimą\n• [F]: Perjungti filtruotos rekonstrukcijos režimą';

  @override
  String get keyboardShortcutsTitle => 'Klaviatūros trumpiniai:';

  @override
  String get languageAuto => 'Automatinė (sistemos)';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get next => 'Kitas';

  @override
  String get nextStepTooltip => 'Kitas instrukcijos žingsnis';

  @override
  String get objectCanvasSemantics =>
      'Objekto erdvė. Interaktyvi koordinačių plokštuma, rodanti rentgeno projekcijos tieses ir fantomą.';

  @override
  String get outsidePhantom => '(už fantomo ribų)';

  @override
  String get previous => 'Ankstesnis';

  @override
  String get previousStepTooltip => 'Ankstesnis instrukcijos žingsnis';

  @override
  String get privacyPolicyButton => 'Privatumo politika';

  @override
  String get radonCanvasSemantics =>
      'Sinogramos Radono erdvė. Rodo 2D projekcijos duomenis su kampu theta vertikalioje ašyje ir spinduliniu atstumu r horizontalioje ašyje.';

  @override
  String get replayAnimationCueTooltip => 'Pakartoti animacijos užuominą';

  @override
  String get res100Label => '100 (200×200)';

  @override
  String get res100Tooltip => 'Ypatinga raiška';

  @override
  String get res25Label => '25 (50×50)';

  @override
  String get res25Tooltip => 'Spartus veikimas';

  @override
  String get res50Label => '50 (100×100)';

  @override
  String get res50Tooltip => 'Standartinė raiška';

  @override
  String get res75Label => '75 (150×150)';

  @override
  String get res75Tooltip => 'Aukšta raiška';

  @override
  String get resetDefaults => 'Atkurti numatytąsias reikšmes';

  @override
  String get resolutionSection => 'Diskretizavimo raiška (P × Q)';

  @override
  String get settingsTitle => 'Nustatymai ir rodymas';

  @override
  String get settingsTooltip => 'Nustatymai ir rodymas';

  @override
  String get showGuidesSubtitle => 'Rodyti ašis ir apskritimo ribas drobėse';

  @override
  String get showGuidesTitle => 'Rodyti koordinačių gaires';

  @override
  String get stage1Description =>
      'Rentgeno kompiuterinė tomografija (KT) neinvaziniu būdu rekonstruoja objekto 2D vidų, siųsdama rentgeno spindulius visais kampais θ. Detektoriai matuoja praėjusią spinduliuotę, kuri pagal Bero-Lamberto dėsnį atitinka sugerties koeficiento f(x, y) tiesinį integralą išilgai kiekvienos tiesės L: g(L) = ∫_L f ds.';

  @override
  String get stage1Instruction1 =>
      'Spustelėkite arba vilkite objekto erdvėje, kad pamatytumėte visas per tą tašką einančias tieses. Spustelėkite „Kitas“ arba 2 etapą viršuje.';

  @override
  String get stage1NarrowDescription =>
      'KT neinvaziniu būdu rekonstruoja objekto 2D vidų, siųsdama rentgeno spindulius daugeliu kampų θ. Detektoriai matuoja sugertį ir pateikia f(x, y) tiesinį integralą: g(L) = ∫_L f ds.';

  @override
  String get stage1NarrowInstruction1 =>
      'Palieskite arba vilkite objekto erdvėje, kad pamatytumėte tieses. Palieskite „Kitas“ arba 2 etapą viršuje.';

  @override
  String get stage1NarrowSubtitle => 'Apžvalga ir Radono transformacija';

  @override
  String get stage1NarrowTitle => 'KT apžvalga';

  @override
  String get stage1Subtitle => 'Apžvalga ir Radono transformacija';

  @override
  String get stage1Title => 'Kompiuterinė ašinė tomografija';

  @override
  String get stage2Description =>
      'Kiekviena 2D erdvės tiesė parametrizuojama dviem kintamaisiais: statmenu atstumu r nuo pradžios taško ir normalės kampu θ: x·cos(θ) + y·sin(θ) = r. Kairėje rodoma fizinė objekto erdvė (x, y), o dešinėje – sinogramos erdvė (r, θ). Kiekvienas sinogramos taškas (r, θ) atitinka pilną rentgeno spindulio tiesę per objekto erdvę.';

  @override
  String get stage2Instruction1 =>
      '1 iš 3 žingsnis: Spustelėkite arba vilkite sinogramoje dešinėje, kad pamatytumėte atitinkamą tiesę x·cos(θ) + y·sin(θ) = r kairėje.';

  @override
  String get stage2Instruction2 =>
      '2 iš 3 žingsnis: Vilkite sinogramoje kairėn ir dešinėn, keisdami atstumą r (-1 iki 1). Stebėkite tiesės slinkimą objekto erdvėje.';

  @override
  String get stage2Instruction3 =>
      '3 iš 3 žingsnis: Vilkite sinogramoje aukštyn ir žemyn, keisdami kampą θ (0 iki 2π). Stebėkite tiesės sukimąsi.';

  @override
  String get stage2NarrowDescription =>
      'Kiekviena tiesė parametrizuojama r ir θ: x·cos(θ) + y·sin(θ) = r. Taškas (r, θ) apatinėje drobėje atitinka pilną tiesę viršuje.';

  @override
  String get stage2NarrowInstruction1 =>
      '1 iš 3 žingsnis: Spustelėkite arba vilkite sinogramoje apačioje, kad pamatytumėte tiesę viršuje.';

  @override
  String get stage2NarrowInstruction2 =>
      '2 iš 3 žingsnis: Vilkite horizontaliai, kad keistumėte atstumą r.';

  @override
  String get stage2NarrowInstruction3 =>
      '3 iš 3 žingsnis: Vilkite vertikaliai, kad keistumėte kampą θ.';

  @override
  String get stage2NarrowSubtitle => 'Tiesės lygtis: x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2NarrowTitle => 'Objektas viršuje, duomenys apačioje';

  @override
  String get stage2Subtitle =>
      'Tiesės parametrizavimas: x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2Title => 'Objektas kairėje, duomenys dešinėje';

  @override
  String get stage3Description =>
      'Visos tiesės, einančios per fiksuotą tašką (x, y), tenkina r(θ) = x·cos(θ) + y·sin(θ). Kampui θ kintant nuo 0 iki 2π, ši tiesių šeima sinogramos erdvėje (r, θ) sudaro sinusoidę. Šis dvilypumas yra pamatinis: taškas objekto erdvėje atitinka sinusoidę sinogramoje, o taškas sinogramoje – tiesę objekto erdvėje.';

  @override
  String get stage3Instruction1 =>
      '1 iš 3 žingsnis: Spustelėkite arba vilkite objekto erdvėje kairėje, kad pajudintumėte tašką ir stebėtumėte jo sinusoidę dešinėje.';

  @override
  String get stage3Instruction2 =>
      '2 iš 3 žingsnis: Spustelėkite dešiniąją sinogramos juostą, kad pamatytumėte lygiagrečias tieses esant fiksuotam kampui θ.';

  @override
  String get stage3Instruction3 =>
      '3 iš 3 žingsnis: Spustelėkite apatinę sinogramos juostą, kad pamatytumėte apskritimo su spinduliu |r| liestines.';

  @override
  String get stage3NarrowDescription =>
      'Visos tiesės per tašką (x, y) tenkina r(θ) = x·cos(θ) + y·sin(θ) ir sudaro sinusoidę erdvėje (r, θ).';

  @override
  String get stage3NarrowInstruction1 =>
      '1 iš 3 žingsnis: Spustelėkite arba vilkite objekto erdvėje viršuje ir stebėkite sinusoidę apačioje.';

  @override
  String get stage3NarrowInstruction2 =>
      '2 iš 3 žingsnis: Spustelėkite dešinį kraštą lygiagrečioms tiesėms.';

  @override
  String get stage3NarrowInstruction3 =>
      '3 iš 3 žingsnis: Spustelėkite apatinį kraštą liestinėms tiesėms.';

  @override
  String get stage3NarrowSubtitle => 'Taškai sinogramoje formuoja sinusoidę';

  @override
  String get stage3Subtitle =>
      'Taškai objekto erdvėje formuoja sinusoidę sinogramos erdvėje';

  @override
  String get stage3Title => 'Taško dvilypumas';

  @override
  String get stage4Description =>
      'Fantomas – apskritas diskas, imituojantis vidinę struktūrą – yra objekto erdvėje. Jo rentgeno spindulių slopinimas sukuria 2D šešėlio duomenų rinkinį g(r, θ), vadinamą sinograma. Perkeliant fantomą, kinta jo sinusoidinio šešėlio amplitudė ir fazė.';

  @override
  String get stage4Instruction1 =>
      '1 iš 2 žingsnis: Vilkite raudoną fantomo diską objekto erdvėje kairėje, kad pakeistumėte jo padėtį.';

  @override
  String get stage4Instruction2 =>
      '2 iš 2 žingsnis: Stebėkite, kaip fantomo 2D šešėlis sinogramoje dešinėje iškart pasislenka.';

  @override
  String get stage4NarrowDescription =>
      'Fantomas (apskritas diskas) objekto erdvėje sukuria 2D šešėlio duomenis g(r, θ) – sinogramą.';

  @override
  String get stage4NarrowInstruction1 =>
      '1 iš 2 žingsnis: Vilkite fantomo diską viršuje, kad pakeistumėte jo padėtį.';

  @override
  String get stage4NarrowInstruction2 =>
      '2 iš 2 žingsnis: Stebėkite šešėlio poslinkį sinogramoje apačioje.';

  @override
  String get stage4NarrowSubtitle => 'Fantomas ir 2D sinogramos šešėlis';

  @override
  String get stage4NarrowTitle => 'Objekto šešėlis';

  @override
  String get stage4Subtitle => 'Fantomas ir jo 2D sinogramos šešėlis';

  @override
  String get stage4Title => 'Objektas meta šešėlį';

  @override
  String get stage5Description =>
      'Apatinis grafikas rodo sinogramos g(r, θ) 1D skerspjūvius. Projekcijų sumavimas išilgai taško sinusoidės per visus kampus θ vadinamas atgaline projekcija: ∫₀²π g(x·cos θ + y·sin θ, θ) dθ. Jei taškas yra fantome, integralas yra didelis; jei už jo ribų – mažas. Tačiau nefiltruota atgalinė projekcija išsilieja pagal 1/|r| funkciją.';

  @override
  String get stage5Instruction1 =>
      '1 iš 3 žingsnis: Spustelėkite fantomo disko viduje kairėje. Atkreipkite dėmesį į didelę atgalinės projekcijos reikšmę apatiniame grafike.';

  @override
  String get stage5Instruction2 =>
      '2 iš 3 žingsnis: Spustelėkite už fantomo disko ribų. Stebėkite 1D reikšmių ir integralo sumažėjimą.';

  @override
  String get stage5Instruction3 =>
      '3 iš 3 žingsnis: Spustelėkite sinogramos kraštines juostas dešinėje, norėdami pamatyti skerspjūvius esant pastoviam θ arba r.';

  @override
  String get stage5NarrowDescription =>
      'Grafikas apačioje rodo g(r, θ) 1D skerspjūvį. Atgalinė projekcija duoda didelį integralą fantome, bet nefiltruota sukelia 1/|r| suliejimą.';

  @override
  String get stage5NarrowInstruction1 =>
      '1 iš 3 žingsnis: Spustelėkite fantome viršuje. Stebėkite didelį integralą apačioje.';

  @override
  String get stage5NarrowInstruction2 =>
      '2 iš 3 žingsnis: Spustelėkite už fantomo ribų. Stebėkite verčių kritimą.';

  @override
  String get stage5NarrowInstruction3 =>
      '3 iš 3 žingsnis: Spustelėkite sinogramos kraštines juostas apačioje.';

  @override
  String get stage5NarrowSubtitle => '1D profiliai ir atgalinė projekcija';

  @override
  String get stage5NarrowTitle => 'Duomenų skerspjūvis';

  @override
  String get stage5Subtitle =>
      '1D profiliai ir nefiltruota atgalinė projekcija';

  @override
  String get stage5Title => 'Duomenų skerspjūvis';

  @override
  String get stage6Description =>
      'Siekiant panaikinti 1/|r| suliejimą, projekcijos prieš atgalinę projekciją yra filtruojamos (Filtruota atgalinė projekcija, FBP). Kiekvienos projekcijos sąsūka su Frank Natterer diskrečiuoju filtro branduoliu w_b(l) = b² / (π⁴(1 - 4l²)) veikia kaip kraštus ryškinantis filtras su neigiamais šoniniais sparnais, kurie tiksliai panaikina suliejimą: ≈ 1.0 fantomo viduje ir ≈ 0.0 išorėje.';

  @override
  String get stage6Instruction1 =>
      '1 iš 2 žingsnis: Spustelėkite fantomo diske. Stebėkite aštrias kraštų bangas ir rekonstruotą integralą ≈ 1.0.';

  @override
  String get stage6Instruction2 =>
      '2 iš 2 žingsnis: Spustelėkite už fantomo disko. Neigiami sparnai panaikina suliejimą (integralas ≈ 0.0).';

  @override
  String get stage6NarrowDescription =>
      'Aukšto dažnio filtravimas Frank Natterer filtro branduoliu w_b(l) = b² / (π⁴(1 - 4l²)) paryškina sinogramą. Filtruota atgalinė projekcija tiksliai rekonstruoja: ≈ 1.0 fantome, ≈ 0.0 išorėje.';

  @override
  String get stage6NarrowInstruction1 =>
      '1 iš 2 žingsnis: Spustelėkite fantome. Stebėkite aštrias bangas ir integralą ≈ 1.0.';

  @override
  String get stage6NarrowInstruction2 =>
      '2 iš 2 žingsnis: Spustelėkite už fantomo. Neigiami sparnai panaikina suliejimą (integralas ≈ 0.0).';

  @override
  String get stage6NarrowSubtitle => 'Filtruota atgalinė projekcija (FBP)';

  @override
  String get stage6NarrowTitle => 'Filtruota rekonstrukcija';

  @override
  String get stage6Subtitle =>
      'Filtruota atgalinė projekcija (FBP) su Natterer filtro branduoliu';

  @override
  String get stage6Title => 'Filtruota duomenų rekonstrukcija';

  @override
  String stageIndicator(int stageNumber) {
    return '$stageNumber etapas iš 6';
  }

  @override
  String stageTitle(int stageNumber, String title) {
    return '$stageNumber etapas: $title';
  }

  @override
  String get switchLanguageTooltip => 'Pakeisti kalbą';

  @override
  String get moreInfoButton => 'Daugiau informacijos';

  @override
  String get termsOfServiceButton => 'Paslaugų teikimo sąlygos';

  @override
  String get themeDark => 'Tamsi';

  @override
  String get themeLight => 'Šviesi';

  @override
  String get themeSection => 'Tema';

  @override
  String get themeSystem => 'Sistemos';

  @override
  String versionLabel(String version) {
    return 'Versija $version';
  }

  @override
  String get websiteButton => 'www.gchouse.org';
}
