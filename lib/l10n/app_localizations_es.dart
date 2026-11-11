// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get aboutAuthor =>
      'Applet original de Java presentado como una charla en la Universidad de Ball State el 26 de febrero de 1998 por Fred Gylys-Colwell';

  @override
  String get aboutSummary =>
      'Una visualización interactiva de la transformada de Radon, integrales de línea, dualidad del sinograma y la retroproyección filtrada (FBP) de Frank Natterer.';

  @override
  String get aboutTooltip => 'Acerca de';

  @override
  String get appTitle => 'Demostración de tomografía axial computarizada';

  @override
  String get close => 'Cerrar';

  @override
  String get collapseMainTextTooltip => 'Contraer texto principal';

  @override
  String get colormapClassic => 'Clásico (Java 1998)';

  @override
  String get colormapGrayscale => 'Escala de grises (TC médica)';

  @override
  String get colormapInferno => 'Inferno';

  @override
  String get colormapSection => 'Mapa de color del sinograma';

  @override
  String get colormapViridis => 'Viridis';

  @override
  String get done => 'Listo';

  @override
  String get expandMainTextTooltip => 'Expandir texto principal';

  @override
  String get filteredCheckbox => 'Filtro';

  @override
  String get filteredCheckboxWide => 'Sinograma filtrado [F]';

  @override
  String get githubButton => 'GitHub (fredgc/cat)';

  @override
  String get graphCanvasSemantics =>
      'Gráfico de perfil 1D que muestra secciones transversales y la integral de retroproyección.';

  @override
  String get graphFilteredPrefix => 'Filtrado wb * g: ';

  @override
  String graphLineTrajectory(String r, String theta, String val) {
    return 'Absorción de rayos (Verde) | Línea (r = $r, θ = $theta) | Absorción total: $val';
  }

  @override
  String graphPointTrajectory(
    String prefix,
    String x,
    String y,
    String val,
    String status,
  ) {
    return '${prefix}Trayectoria del punto ($x, $y) | Integral sobre θ: $val $status';
  }

  @override
  String get graphSelectPrompt =>
      'Selecciona un punto o línea para mostrar la sección transversal 1D.';

  @override
  String graphSlineTrajectory(String prefix, String r, String val) {
    return '${prefix}Corte tangente en radio r = $r | Integral: $val';
  }

  @override
  String graphThetaTrajectory(String prefix, String theta, String val) {
    return '${prefix}Corte de proyección en θ = $theta rad | Integral: $val';
  }

  @override
  String get graphUnfilteredPrefix => 'Sin filtrar g: ';

  @override
  String get insidePhantom => '(dentro del fantoma)';

  @override
  String get issuesButton => 'Problemas';

  @override
  String get keyboardShortcutsList =>
      '• [Enter]: Avanzar paso de instrucción o siguiente etapa\n• [N] / [→]: Siguiente etapa\n• [P] / [←]: Etapa anterior\n• [1] - [7]: Saltar a etapa 1 a 7\n• [Espacio]: Reproducir / Pausar rotación de barrido angular\n• [F]: Alternar modo de reconstrucción filtrada';

  @override
  String get keyboardShortcutsTitle => 'Atajos de teclado:';

  @override
  String get languageAuto => 'Automático (del sistema)';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get next => 'Siguiente';

  @override
  String get nextStepTooltip => 'Paso de instrucción siguiente';

  @override
  String get objectCanvasSemantics =>
      'Espacio del objeto. Plano de coordenadas interactivo que muestra las líneas de proyección de rayos X y el fantoma.';

  @override
  String get outsidePhantom => '(fuera del fantoma)';

  @override
  String get previous => 'Anterior';

  @override
  String get previousStepTooltip => 'Paso de instrucción anterior';

  @override
  String get privacyPolicyButton => 'Política de privacidad';

  @override
  String get radonCanvasSemantics =>
      'Espacio de Radon del sinograma. Muestra datos de proyección 2D con el ángulo theta en el eje vertical y la distancia radial r en el horizontal.';

  @override
  String get replayAnimationCueTooltip => 'Repetir indicación de animación';

  @override
  String get res100Label => '100 (200×200)';

  @override
  String get res100Tooltip => 'Ultra resolución';

  @override
  String get res25Label => '25 (50×50)';

  @override
  String get res25Tooltip => 'Rendimiento rápido';

  @override
  String get res50Label => '50 (100×100)';

  @override
  String get res50Tooltip => 'Resolución estándar';

  @override
  String get res75Label => '75 (150×150)';

  @override
  String get res75Tooltip => 'Alta resolución';

  @override
  String get resetDefaults => 'Restablecer valores predeterminados';

  @override
  String get resolutionSection => 'Resolución de muestreo (P × Q)';

  @override
  String get settingsTitle => 'Ajustes y visualización';

  @override
  String get settingsTooltip => 'Ajustes y visualización';

  @override
  String get showGuidesSubtitle =>
      'Mostrar ejes y límites circulares en los lienzos';

  @override
  String get showGuidesTitle => 'Mostrar guías de coordenadas';

  @override
  String get stage1Description =>
      'Una tomografía axial computarizada por rayos X (TAC) reconstruye de forma no invasiva el interior 2D de un objeto transmitiendo haces de rayos X a través de él desde todos los ángulos θ. Los detectores miden la intensidad transmitida, la cual, según la ley de Beer-Lambert, produce la integral de línea matemática del coeficiente de absorción f(x, y) a lo largo de cada línea L: g(L) = ∫_L f ds. El desafío fundamental de la tomografía consiste en invertir estas integrales de línea para recuperar el interior.';

  @override
  String get stage1Instruction1 =>
      'Haz clic o arrastra en el Espacio del Objeto para ver todas las líneas que pasan por ese punto. Haz clic en \"Siguiente\" o en la Etapa 2 arriba para continuar.';

  @override
  String get stage1NarrowDescription =>
      'Una TAC reconstruye el interior 2D de un objeto de forma no invasiva transmitiendo rayos X a través de él en muchos ángulos θ. Los detectores miden la intensidad absorbida, produciendo la integral de línea de absorción f(x, y) a lo largo de cada línea L: g(L) = ∫_L f ds.';

  @override
  String get stage1NarrowInstruction1 =>
      'Toca o arrastra en el Espacio del Objeto para ver las líneas que pasan por ese punto. Toca \"Siguiente\" o la Etapa 2 arriba para continuar.';

  @override
  String get stage1NarrowSubtitle =>
      'Descripción general y transformada de Radon';

  @override
  String get stage1NarrowTitle => 'Resumen de tomografía';

  @override
  String get stage1Subtitle => 'Descripción general y la transformada de Radon';

  @override
  String get stage1Title => 'Tomografía axial computarizada';

  @override
  String get stage2Description =>
      'Cada línea recta en el espacio 2D está parametrizada por dos variables: su distancia perpendicular con signo r desde el origen y su ángulo normal θ: x·cos(θ) + y·sin(θ) = r. La ventana izquierda muestra el Espacio del Objeto físico (x, y) y la derecha muestra el Espacio del Sinograma (r, θ). Cada punto individual (r, θ) en el espacio del sinograma representa una línea recta completa de rayos X que atraviesa el espacio del objeto.';

  @override
  String get stage2Instruction1 =>
      'Paso 1 de 3: Haz clic o arrastra en cualquier parte del sinograma a la derecha para ver la línea correspondiente x·cos(θ) + y·sin(θ) = r y su normal a la izquierda.';

  @override
  String get stage2Instruction2 =>
      'Paso 2 de 3: Arrastra hacia la izquierda y derecha en el sinograma para variar la distancia radial r (-1 a 1). Observa cómo se traslada la línea en el Espacio del Objeto.';

  @override
  String get stage2Instruction3 =>
      'Paso 3 de 3: Arrastra hacia arriba y abajo en el sinograma para variar el ángulo θ (0 a 2π). Observa cómo gira la línea en el Espacio del Objeto.';

  @override
  String get stage2NarrowDescription =>
      'Cada línea recta en el plano está parametrizada por su distancia perpendicular con signo r desde el origen y su ángulo normal θ: x·cos(θ) + y·sin(θ) = r. Un solo punto (r, θ) en el lienzo inferior representa una línea completa que atraviesa el espacio del objeto en la parte superior.';

  @override
  String get stage2NarrowInstruction1 =>
      'Paso 1 de 3: Haz clic o arrastra en el sinograma en la parte inferior para ver la línea correspondiente y su normal en la parte superior.';

  @override
  String get stage2NarrowInstruction2 =>
      'Paso 2 de 3: Arrastra hacia la izquierda y derecha en el sinograma para variar la distancia radial r (-1 a 1). Observa la traslación de la línea.';

  @override
  String get stage2NarrowInstruction3 =>
      'Paso 3 de 3: Arrastra hacia arriba y abajo en el sinograma para variar el ángulo θ (0 a 2π). Observa la rotación de la línea.';

  @override
  String get stage2NarrowSubtitle =>
      'Ecuación de la línea: x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2NarrowTitle => 'Objeto arriba, datos abajo';

  @override
  String get stage2Subtitle =>
      'Parametrización de líneas: x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2Title => 'Objeto a la izquierda, datos a la derecha';

  @override
  String get stage3Description =>
      'Todas las líneas que pasan por un único punto fijo (x, y) satisfacen r(θ) = x·cos(θ) + y·sin(θ). A medida que el ángulo de proyección θ varía de 0 a 2π, esta familia de líneas forma una onda sinusoidal exacta en el espacio del sinograma (r, θ). Esta dualidad es fundamental: un punto en el espacio del objeto se mapea a una sinusoide en el espacio del sinograma, mientras que un punto en el espacio del sinograma se mapea a una línea en el espacio del objeto. Al hacer clic en las barras de borde se muestran líneas con θ constante o r constante.';

  @override
  String get stage3Instruction1 =>
      'Paso 1 de 3: Haz clic o arrastra en el Espacio del Objeto a la izquierda para mover el punto de sondeo y observa su curva dual sinusoidal a la derecha.';

  @override
  String get stage3Instruction2 =>
      'Paso 2 de 3: Haz clic en la barra del borde derecho en el sinograma para mostrar una familia de líneas paralelas en todo r con un ángulo fijo θ.';

  @override
  String get stage3Instruction3 =>
      'Paso 3 de 3: Haz clic en la barra del borde inferior en el sinograma para ver líneas tangentes a un círculo concéntrico de radio |r|.';

  @override
  String get stage3NarrowDescription =>
      'Cada línea que pasa por un punto fijo (x, y) satisface r(θ) = x·cos(θ) + y·sin(θ). A medida que θ varía de 0 a 2π, esta familia de líneas forma una onda sinusoidal exacta en el espacio (r, θ).';

  @override
  String get stage3NarrowInstruction1 =>
      'Paso 1 de 3: Haz clic o arrastra en el Espacio del Objeto arriba para mover el punto de sondeo y observa su curva sinusoidal abajo.';

  @override
  String get stage3NarrowInstruction2 =>
      'Paso 2 de 3: Haz clic en la barra derecha del sinograma para mostrar líneas paralelas con ángulo fijo θ.';

  @override
  String get stage3NarrowInstruction3 =>
      'Paso 3 de 3: Haz clic en la barra inferior del sinograma para ver líneas tangentes a un círculo de radio |r|.';

  @override
  String get stage3NarrowSubtitle =>
      'Los puntos trazan sinusoides en el sinograma';

  @override
  String get stage3Subtitle =>
      'Los puntos en el espacio del objeto trazan sinusoides en el espacio del sinograma';

  @override
  String get stage3Title => 'Dualidad puntual';

  @override
  String get stage4Description =>
      'Un objeto fantoma —un disco circular que simula una estructura interna— se sitúa en el espacio del objeto. Su atenuación de rayos X genera un conjunto de datos de sombra 2D g(r, θ) llamado sinograma. Hay una intensidad débil cuando un rayo X solo roza el borde del disco y una intensidad fuerte cuando pasa a través del diámetro. Al arrastrar el fantoma se desplaza la amplitud y la fase de su banda de sombra sinusoidal.';

  @override
  String get stage4Instruction1 =>
      'Paso 1 de 2: Arrastra el disco fantoma rojo en el Espacio del Objeto a la izquierda para cambiar su posición.';

  @override
  String get stage4Instruction2 =>
      'Paso 2 de 2: Observa cómo la sombra 2D del fantoma en el sinograma se desplaza de inmediato a la derecha, codificando su ubicación.';

  @override
  String get stage4NarrowDescription =>
      'Un objeto fantoma (disco circular) se sitúa en el espacio del objeto. Sus proyecciones de rayos X forman un conjunto de datos de sombra 2D g(r, θ) conocido como sinograma. Al arrastrar el fantoma se desplaza su banda de sombra.';

  @override
  String get stage4NarrowInstruction1 =>
      'Paso 1 de 2: Arrastra el disco fantoma rojo en el Espacio del Objeto arriba para cambiar su posición.';

  @override
  String get stage4NarrowInstruction2 =>
      'Paso 2 de 2: Observa cómo la sombra del fantoma en el sinograma se desplaza abajo al arrastrar.';

  @override
  String get stage4NarrowSubtitle => 'Fantoma y sombra 2D en el sinograma';

  @override
  String get stage4NarrowTitle => 'Sombra del objeto';

  @override
  String get stage4Subtitle =>
      'El objeto fantoma y su sombra 2D en el sinograma';

  @override
  String get stage4Title => 'El objeto produce sombra';

  @override
  String get stage5Description =>
      'El gráfico inferior muestra secciones transversales 1D del sinograma g(r, θ). En particular, examinar las proyecciones a lo largo de la curva sinusoidal de un punto (x, y) y sumarlas en todos los ángulos θ se denomina retroproyección: ∫₀²π g(x·cos θ + y·sin θ, θ) dθ. Si el punto está dentro del disco fantoma, la integral es grande; si está fuera, es pequeña. Sin embargo, la retroproyección sin filtrar difumina los rasgos con una función de dispersión de punto 1/|r|.';

  @override
  String get stage5Instruction1 =>
      'Paso 1 de 3: Haz clic dentro del disco fantoma a la izquierda. Observa el valor elevado de la integral de retroproyección en el gráfico inferior.';

  @override
  String get stage5Instruction2 =>
      'Paso 2 de 3: Haz clic fuera del disco fantoma. Observa cómo los valores del perfil 1D caen y la integral de retroproyección disminuye.';

  @override
  String get stage5Instruction3 =>
      'Paso 3 de 3: Haz clic en las barras de borde del sinograma a la derecha para examinar secciones transversales 1D con θ o r constantes.';

  @override
  String get stage5NarrowDescription =>
      'El gráfico inferior muestra la sección transversal 1D de g(r, θ) a lo largo de la trayectoria de sondeo. Sumar estas proyecciones en todos los ángulos (retroproyección) produce una integral grande dentro del fantoma y más pequeña fuera, pero la retroproyección sin filtrar produce una imagen borrosa 1/|r|.';

  @override
  String get stage5NarrowInstruction1 =>
      'Paso 1 de 3: Haz clic dentro del disco fantoma arriba. Observa la gran integral de retroproyección en el gráfico inferior.';

  @override
  String get stage5NarrowInstruction2 =>
      'Paso 2 de 3: Haz clic fuera del disco fantoma. Observa cómo caen los valores del perfil y disminuye la integral.';

  @override
  String get stage5NarrowInstruction3 =>
      'Paso 3 de 3: Haz clic en las barras de borde del sinograma abajo para examinar secciones transversales 1D con θ o r constantes.';

  @override
  String get stage5NarrowSubtitle => 'Perfiles 1D y retroproyección';

  @override
  String get stage5NarrowTitle => 'Sección transversal';

  @override
  String get stage5Subtitle => 'Perfiles 1D y retroproyección sin filtrar';

  @override
  String get stage5Title => 'Sección transversal de datos';

  @override
  String get stage6Description =>
      'Para eliminar el desenfoque 1/|r|, las proyecciones se filtran antes de la retroproyección (Retroproyección Filtrada, FBP). La convolución de cada proyección con el núcleo de filtro de rampa discreto de Frank Natterer w_b(l) = b² / (π⁴(1 - 4l²)) actúa como un filtro derivativo de realce de bordes que añade lóbulos laterales negativos. Al retroproyectar, estos lóbulos negativos cancelan exactamente el emborronamiento, produciendo una atenuación interior precisa: ≈ 1.0 dentro del disco fantoma y ≈ 0.0 fuera.';

  @override
  String get stage6Instruction1 =>
      'Paso 1 de 2: Haz clic dentro del disco fantoma. Observa los lóbulos de borde nítidos en el perfil 1D y la integral reconstruida ≈ 1.0.';

  @override
  String get stage6Instruction2 =>
      'Paso 2 de 2: Haz clic fuera del disco fantoma. Observa cómo los lóbulos laterales negativos cancelan el emborronamiento, produciendo una integral ≈ 0.0.';

  @override
  String get stage6NarrowDescription =>
      'El filtrado de paso alto de las proyecciones con el núcleo de filtro discreto de Frank Natterer w_b(l) = b² / (π⁴(1 - 4l²)) enfoca el sinograma. Retroproyectar los datos filtrados reconstruye con exactitud los valores de atenuación interior: ≈ 1.0 dentro del fantoma y ≈ 0.0 fuera.';

  @override
  String get stage6NarrowInstruction1 =>
      'Paso 1 de 2: Haz clic dentro del disco fantoma. Observa los lóbulos de borde nítidos en el perfil 1D y la integral ≈ 1.0.';

  @override
  String get stage6NarrowInstruction2 =>
      'Paso 2 de 2: Haz clic fuera del disco fantoma. Los lóbulos laterales negativos cancelan el emborronamiento, dando una integral ≈ 0.0.';

  @override
  String get stage6NarrowSubtitle => 'Retroproyección filtrada (FBP)';

  @override
  String get stage6NarrowTitle => 'Reconstrucción filtrada';

  @override
  String get stage6Subtitle =>
      'Retroproyección filtrada (FBP) con núcleo de rampa de Natterer';

  @override
  String get stage6Title => 'Reconstrucción de datos filtrados';

  @override
  String stageIndicator(int stageNumber) {
    return 'Etapa $stageNumber de 6';
  }

  @override
  String stageTitle(int stageNumber, String title) {
    return 'Etapa $stageNumber: $title';
  }

  @override
  String get switchLanguageTooltip => 'Cambiar idioma';

  @override
  String get moreInfoButton => 'Más información';

  @override
  String get termsOfServiceButton => 'Condiciones del servicio';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeSection => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String versionLabel(String version) {
    return 'Versión $version';
  }

  @override
  String get websiteButton => 'www.gchouse.org';
}
