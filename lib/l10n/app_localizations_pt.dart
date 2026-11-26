// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get aboutAuthor =>
      'Applet Java original apresentado como uma palestra na Ball State University em 26 de fevereiro de 1998 por Fred Gylys-Colwell';

  @override
  String get aboutSummary =>
      'Uma visualização interativa da Transformada de Radon, integrais de linha, dualidade do sinograma e retroprojeção filtrada (FBP) de Frank Natterer.';

  @override
  String get aboutTooltip => 'Sobre';

  @override
  String get addPhantomTooltip => 'Adicionar disco fantoma';

  @override
  String get appTitle => 'Demonstração de Tomografia Computadorizada';

  @override
  String get close => 'Fechar';

  @override
  String get collapseMainTextTooltip => 'Recolher texto principal';

  @override
  String get colormapClassic => 'Clássico (Java 1998)';

  @override
  String get colormapGrayscale => 'Tons de cinza (TC Médica)';

  @override
  String get colormapInferno => 'Inferno';

  @override
  String get colormapSection => 'Mapa de cores do sinograma';

  @override
  String get colormapViridis => 'Viridis';

  @override
  String get deletePhantomTooltip => 'Excluir fantoma selecionado';

  @override
  String get done => 'Concluído';

  @override
  String get expandMainTextTooltip => 'Expandir texto principal';

  @override
  String get filteredCheckbox => 'Filtro';

  @override
  String get filteredCheckboxWide => 'Sinograma filtrado [F]';

  @override
  String get githubButton => 'GitHub (fredgc/cat)';

  @override
  String get graphAxisAngle => 'Ângulo θ ∈ [0, 2π)';

  @override
  String get graphAxisRadialOffset => 'Deslocamento radial r ∈ [-1, 1]';

  @override
  String get graphAxisRayPath => 'Trajeto ao longo do raio s ∈ [-1, 1]';

  @override
  String get graphCanvasSemantics =>
      'Gráfico de perfil 1D exibindo seções transversais e a integral de retroprojeção.';

  @override
  String get graphFilteredPrefix => 'Filtrado wb * g: ';

  @override
  String get graphLegendFiltered => '— Filtrado (kernel rampa)';

  @override
  String get graphLegendUnfilteredPoint => '— Sem filtro g(θ)';

  @override
  String get graphLegendUnfilteredTheta => '— Sem filtro P_θ(r)';

  @override
  String graphLineTrajectory(String r, String theta, String val) {
    return 'Absorção do raio (Verde) | Linha (r = $r, θ = $theta) | Absorção total: $val';
  }

  @override
  String graphPointTrajectory(
    String prefix,
    String x,
    String y,
    String val,
    String status,
  ) {
    return '${prefix}Trajetória do ponto ($x, $y) | Integral sobre θ: $val $status';
  }

  @override
  String graphRawValue(String val) {
    return '[Bruto: $val]';
  }

  @override
  String get graphSelectPrompt =>
      'Selecione um ponto ou linha para exibir a seção transversal 1D.';

  @override
  String graphSlineTrajectory(String prefix, String r, String val) {
    return '${prefix}Corte tangente no raio r = $r | Integral: $val';
  }

  @override
  String graphThetaTrajectory(String prefix, String theta, String val) {
    return '${prefix}Corte de projeção em θ = $theta rad | Integral: $val';
  }

  @override
  String get graphUnfilteredPrefix => 'Sem filtro: ';

  @override
  String get insidePhantom => '(dentro do fantoma)';

  @override
  String get issuesButton => 'Problemas';

  @override
  String get keyboardShortcutsList =>
      '• [Enter] / [N]: Próximo passo de instrução ou etapa seguinte\n• [→]: Próxima etapa\n• [P] / [←]: Etapa anterior\n• [1] - [7]: Ir para etapa 1 a 7\n• [Espaço]: Reproduzir / Pausar rotação de varredura angular\n• [F]: Alternar modo de reconstrução filtrada';

  @override
  String get keyboardShortcutsTitle => 'Atalhos do teclado:';

  @override
  String get languageAuto => 'Automático (Sistema)';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get modePhantom => 'Fantoma';

  @override
  String get modeProbe => 'Sonda';

  @override
  String get moreInfoButton => 'Mais informações';

  @override
  String get next => 'Próximo';

  @override
  String get nextStepTooltip => 'Próximo passo de instrução';

  @override
  String get objectCanvasSemantics =>
      'Espaço do objeto. Plano cartesiano interativo mostrando linhas de projeção de raios X e o fantoma.';

  @override
  String get openInBrowser => 'Abrir no navegador';

  @override
  String get outsidePhantom => '(fora do fantoma)';

  @override
  String get pauseScan => 'Pausar';

  @override
  String get pauseScanWide => 'Pausar [Espaço]';

  @override
  String get playScan => 'Iniciar varredura';

  @override
  String get playScanWide => 'Iniciar varredura [Espaço]';

  @override
  String get previous => 'Anterior';

  @override
  String get previousStepTooltip => 'Passo de instrução anterior';

  @override
  String get privacyPolicyButton => 'Política de Privacidade';

  @override
  String get radonCanvasSemantics =>
      'Espaço de Radon do sinograma. Exibe dados de projeção 2D com ângulo theta no eixo vertical e distância radial r no eixo horizontal.';

  @override
  String get replayAnimationCueTooltip => 'Repetir sinalização de animação';

  @override
  String get res100Label => '100 (200×200)';

  @override
  String get res100Tooltip => 'Resolução ultra';

  @override
  String get res25Label => '25 (50×50)';

  @override
  String get res25Tooltip => 'Desempenho rápido';

  @override
  String get res50Label => '50 (100×100)';

  @override
  String get res50Tooltip => 'Resolução padrão';

  @override
  String get res75Label => '75 (150×150)';

  @override
  String get res75Tooltip => 'Alta resolução';

  @override
  String get resetDefaults => 'Restaurar padrões';

  @override
  String get resolutionSection => 'Resolução de amostragem (P × Q)';

  @override
  String get settingsTitle => 'Configurações e exibição';

  @override
  String get settingsTooltip => 'Configurações e exibição';

  @override
  String get showGuidesSubtitle =>
      'Exibir eixos e limites circulares nas telas';

  @override
  String get showGuidesTitle => 'Exibir guias de coordenadas';

  @override
  String get skip => 'Pular';

  @override
  String get skipStageTooltip => 'Pular para a próxima etapa';

  @override
  String get stage1Description =>
      'A tomografia computadorizada (TC) reconstrói em 2D o interior de um objeto de forma não invasiva, transmitindo raios X por meio de todos os ângulos θ. Detectores medem a intensidade transmitida, fornecendo segundo a lei de Beer-Lambert a integral de linha do coeficiente de absorção f(x, y) ao longo de cada linha L: g(L) = ∫_L f ds.';

  @override
  String get stage1Instruction1 =>
      'Clique em \"Próximo\" acima para continuar para a próxima etapa.';

  @override
  String get stage1NarrowDescription =>
      'A TC reconstrói em 2D o interior de um objeto emitindo raios X em múltiplos ângulos θ. Detectores medem a intensidade absorvida gerando a integral de linha f(x, y): g(L) = ∫_L f ds.';

  @override
  String get stage1NarrowInstruction1 =>
      'Toque em \"Próximo\" acima para continuar para a próxima etapa.';

  @override
  String get stage1NarrowSubtitle => 'Visão geral e Transformada de Radon';

  @override
  String get stage1NarrowTitle => 'Visão geral da TC';

  @override
  String get stage1Subtitle => 'Visão geral e Transformada de Radon';

  @override
  String get stage1Title => 'Tomografia Computadorizada Axial';

  @override
  String get stage2Description =>
      'Cada linha reta no espaço 2D é parametrizada por duas variáveis: sua distância perpendicular r com sinal em relação à origem e seu ângulo normal θ: x·cos(θ) + y·sin(θ) = r. O painel esquerdo exibe o Espaço do Objeto (x, y) e o direito exibe o Espaço do Sinograma (r, θ). Cada ponto (r, θ) no sinograma representa uma linha reta completa de raio X atravessando o espaço do objeto.';

  @override
  String get stage2Instruction1 =>
      'Passo 1 de 3: Clique ou arraste no sinograma à direita para visualizar a linha correspondente x·cos(θ) + y·sin(θ) = r à esquerda.';

  @override
  String get stage2Instruction2 =>
      'Passo 2 de 3: Arraste para a esquerda e direita no sinograma para variar a distância r (-1 a 1). Observe a translação da linha no espaço do objeto.';

  @override
  String get stage2Instruction3 =>
      'Passo 3 de 3: Arraste para cima e para baixo no sinograma para variar o ângulo θ (0 a 2π). Observe a rotação da linha no espaço do objeto.';

  @override
  String get stage2NarrowDescription =>
      'Cada linha reta é parametrizada por r e θ: x·cos(θ) + y·sin(θ) = r. Um ponto (r, θ) na tela inferior representa uma linha completa na tela superior.';

  @override
  String get stage2NarrowInstruction1 =>
      'Passo 1 de 3: Clique ou arraste no sinograma inferior para ver a linha correspondente acima.';

  @override
  String get stage2NarrowInstruction2 =>
      'Passo 2 de 3: Arraste horizontalmente para variar a distância radial r.';

  @override
  String get stage2NarrowInstruction3 =>
      'Passo 3 de 3: Arraste verticalmente para variar o ângulo θ.';

  @override
  String get stage2NarrowSubtitle =>
      'Equação da linha: x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2NarrowTitle => 'Objeto em cima, dados em baixo';

  @override
  String get stage2Subtitle =>
      'Parametrização da linha: x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2Title => 'Objeto à esquerda, dados à direita';

  @override
  String get stage3Description =>
      'Todas as linhas que passam por um único ponto fixo (x, y) satisfazem r(θ) = x·cos(θ) + y·sin(θ). Conforme o ângulo θ varia de 0 a 2π, essa família de linhas forma uma senoide exata no espaço do sinograma (r, θ). Essa dualidade é fundamental: um ponto no espaço do objeto mapeia para uma senoide no sinograma, e um ponto no sinograma mapeia para uma linha no espaço do objeto.';

  @override
  String get stage3Instruction1 =>
      'Passo 1 de 3: Clique ou arraste no Espaço do Objeto à esquerda para mover o ponto e observar a curva senoidal dual à direita.';

  @override
  String get stage3Instruction2 =>
      'Passo 2 de 3: Clique na barra lateral direita no sinograma para exibir a família de linhas paralelas com ângulo fixo θ.';

  @override
  String get stage3Instruction3 =>
      'Passo 3 de 3: Clique na barra inferior no sinograma para exibir as linhas tangentes a um círculo de raio |r|.';

  @override
  String get stage3NarrowDescription =>
      'Todas as linhas por um ponto (x, y) satisfazem r(θ) = x·cos(θ) + y·sin(θ) e formam uma senoide em (r, θ).';

  @override
  String get stage3NarrowInstruction1 =>
      'Passo 1 de 3: Clique ou arraste no objeto acima e veja a senoide abaixo.';

  @override
  String get stage3NarrowInstruction2 =>
      'Passo 2 de 3: Clique na barra lateral direita para ver linhas paralelas.';

  @override
  String get stage3NarrowInstruction3 =>
      'Passo 3 de 3: Clique na barra inferior para ver linhas tangentes.';

  @override
  String get stage3NarrowSubtitle => 'Pontos traçam senoides no sinograma';

  @override
  String get stage3Subtitle =>
      'Pontos no espaço do objeto traçam senoides no sinograma';

  @override
  String get stage3Title => 'Dualidade de Pontos';

  @override
  String get stage4Description =>
      'Um fantoma — disco circular simulando estrutura interna — é posicionado no espaço do objeto. Sua atenuação cria um conjunto de dados de sombra 2D g(r, θ) chamado sinograma. Ao mover o fantoma, a amplitude e fase da sua sombra senoidal se alteram.';

  @override
  String get stage4Instruction1 =>
      'Passo 1 de 2: Arraste o disco vermelho do fantoma no Espaço do Objeto à esquerda para mudar sua posição.';

  @override
  String get stage4Instruction2 =>
      'Passo 2 de 2: Observe como a sombra 2D do fantoma no sinograma à direita se desloca imediatamente.';

  @override
  String get stage4NarrowDescription =>
      'Um fantoma (disco circular) no espaço do objeto produz um conjunto de sombras 2D g(r, θ), o sinograma.';

  @override
  String get stage4NarrowInstruction1 =>
      'Passo 1 de 2: Arraste o disco do fantoma em cima para reposicioná-lo.';

  @override
  String get stage4NarrowInstruction2 =>
      'Passo 2 de 2: Observe o deslocamento da sombra no sinograma abaixo.';

  @override
  String get stage4NarrowSubtitle => 'Fantoma e sombra 2D no sinograma';

  @override
  String get stage4NarrowTitle => 'Sombra do objeto';

  @override
  String get stage4Subtitle => 'O objeto fantoma e sua sombra 2D no sinograma';

  @override
  String get stage4Title => 'O objeto produz sombra';

  @override
  String get stage5Description =>
      'O gráfico inferior exibe seções transversais 1D de g(r, θ). A soma das projeções ao longo da curva senoidal de um ponto em todos os ângulos θ chama-se retroprojeção: ∫₀²π g(x·cos θ + y·sin θ, θ) dθ. Se o ponto está dentro do fantoma, a integral é grande; fora dele, é pequena. No entanto, a retroprojeção sem filtro borra a imagem com dispersão 1/|r|.';

  @override
  String get stage5Instruction1 =>
      'Passo 1 de 4: Arraste a sonda para dentro do disco fantoma à esquerda. Observe como a integral de retroprojeção no gráfico inferior aumenta.';

  @override
  String get stage5Instruction2 =>
      'Passo 2 de 4: Clique em qualquer lugar do sinograma para selecionar um único raio X. Observe o pulso verde indicando a intensidade de absorção ao longo desse raio.';

  @override
  String get stage5Instruction3 =>
      'Passo 3 de 4: Clique na barra lateral direita do sinograma para ver uma família paralela de raios X em todo r com ângulo fixo θ (curva ciano).';

  @override
  String get stage5Instruction4 =>
      'Passo 4 de 4: Clique em \"Iniciar varredura\" ou pressione [Espaço] para varrer a família paralela por todos os ângulos θ, animando a curva de projeção 1D.';

  @override
  String get stage5NarrowDescription =>
      'O gráfico abaixo exibe a seção 1D de g(r, θ). A retroprojeção resulta em grande valor no fantoma, mas sem filtro gera desfoque 1/|r|.';

  @override
  String get stage5NarrowInstruction1 =>
      'Passo 1 de 4: Arraste a sonda para dentro do fantoma acima. Observe o aumento da integral de retroprojeção.';

  @override
  String get stage5NarrowInstruction2 =>
      'Passo 2 de 4: Clique no sinograma para selecionar um único raio e observe o pulso verde de absorção.';

  @override
  String get stage5NarrowInstruction3 =>
      'Passo 3 de 4: Clique na barra direita do sinograma para ver uma família paralela de raios X com ângulo fixo θ (curva ciano).';

  @override
  String get stage5NarrowInstruction4 =>
      'Passo 4 de 4: Toque em \"Iniciar varredura\" para varrer a família paralela por todos os ângulos θ.';

  @override
  String get stage5NarrowSubtitle => 'Perfis 1D e retroprojeção';

  @override
  String get stage5NarrowTitle => 'Seção transversal';

  @override
  String get stage5Subtitle => 'Perfis 1D e retroprojeção sem filtro';

  @override
  String get stage5Title => 'Seção transversal dos dados';

  @override
  String get stage6Description =>
      'Para eliminar o desfoque 1/|r|, as projeções são filtradas antes da retroprojeção (Retroprojeção Filtrada, FBP). A convolução com o kernel de filtro discreto em rampa de Frank Natterer w_b(l) = b² / (π⁴(1 - 4l²)) age como derivada que acentua bordas com lobos negativos, cancelando o espalhamento: ≈ 1.0 dentro do fantoma e ≈ 0.0 fora.';

  @override
  String get stage6Instruction1 =>
      'Passo 1 de 3: Observe no gráfico inferior a família paralela: a curva laranja mostra o resultado filtrado com lobos negativos nítidos que cancelam o desfoque.';

  @override
  String get stage6Instruction2 =>
      'Passo 2 de 3: Clique em \"Iniciar varredura\" ou pressione [Espaço] para observar as projeções filtradas variando conforme o ângulo gira.';

  @override
  String get stage6Instruction3 =>
      'Passo 3 de 3: Clique em pontos de sonda no Espaço do Objeto. A retroprojeção filtrada reconstrói a atenuação interior exata: ≈ 1.0 dentro e ≈ 0.0 fora.';

  @override
  String get stage6NarrowDescription =>
      'A filtragem passa-alta com o filtro discreto de Frank Natterer w_b(l) = b² / (π⁴(1 - 4l²)) refina o sinograma. A retroprojeção filtrada reconstrói com precisão: ≈ 1.0 no fantoma, ≈ 0.0 fora.';

  @override
  String get stage6NarrowInstruction1 =>
      'Passo 1 de 3: O gráfico inferior exibe a curva filtrada laranja com lobos negativos nítidos que cancelam o desfoque.';

  @override
  String get stage6NarrowInstruction2 =>
      'Passo 2 de 3: Toque em \"Iniciar varredura\" para observar as projeções filtradas girando dinamicamente.';

  @override
  String get stage6NarrowInstruction3 =>
      'Passo 3 de 3: Toque em pontos no Espaço do Objeto. A retroprojeção filtrada reconstrói ≈ 1.0 dentro e ≈ 0.0 fora.';

  @override
  String get stage6NarrowSubtitle => 'Retroprojeção Filtrada (FBP)';

  @override
  String get stage6NarrowTitle => 'Reconstrução filtrada';

  @override
  String get stage6Subtitle =>
      'Retroprojeção Filtrada (FBP) com kernel em rampa de Natterer';

  @override
  String get stage6Title => 'Reconstrução de dados filtrados';

  @override
  String get stage7Description =>
      'No modo Livre, crie suas próprias cenas usando vários discos fantoma. Adicione discos com \"+\", arraste-os para a posição desejada e observe como cada disco adiciona uma faixa senoidal ao sinograma. Use a Retroprojeção Filtrada para reconstruir suas cenas e verificar as densidades internas.';

  @override
  String get stage7Instruction1 =>
      'Passo 1 de 3: Toque em \"+\" no canto superior direito do Espaço do Objeto para criar mais discos fantoma. Selecione e arraste os discos para qualquer lugar dentro do círculo.';

  @override
  String get stage7Instruction2 =>
      'Passo 2 de 3: Inspecione o sinograma. Observe como cada fantoma gera seu próprio traço senoidal e as áreas sobrepostas se somam linearmente.';

  @override
  String get stage7Instruction3 =>
      'Passo 3 de 3: Mude para o modo \"Sonda\" no Espaço do Objeto para testar retroprojeções pontuais. Alterne o Filtro [F] para ver como os lobos negativos reconstroem cada fantoma.';

  @override
  String get stage7NarrowDescription =>
      'Crie cenas personalizadas com vários discos fantoma. Use \"+\" para adicionar discos, arraste-os e explore seus sinogramas aditivos e a reconstrução FBP.';

  @override
  String get stage7NarrowInstruction1 =>
      'Passo 1 de 3: Toque em \"+\" no Espaço do Objeto para criar discos fantoma e arraste-os dentro do círculo.';

  @override
  String get stage7NarrowInstruction2 =>
      'Passo 2 de 3: Inspecione o sinograma para ver como vários fantomas se somam linearmente no espaço de Radon.';

  @override
  String get stage7NarrowInstruction3 =>
      'Passo 3 de 3: Mude para o modo \"Sonda\" e alterne o Filtro [F] para reconstruir seus fantomas personalizados.';

  @override
  String get stage7NarrowSubtitle => 'Sandbox multi-fantoma';

  @override
  String get stage7NarrowTitle => 'Modo livre';

  @override
  String get stage7Subtitle =>
      'Construa cenas multi-fantoma e explore a reconstrução';

  @override
  String get stage7Title => 'Modo livre e fantomas personalizados';

  @override
  String stageIndicator(int stageNumber) {
    return 'Etapa $stageNumber de 7';
  }

  @override
  String stageTitle(int stageNumber, String title) {
    return 'Etapa $stageNumber: $title';
  }

  @override
  String get switchLanguageTooltip => 'Mudar idioma';

  @override
  String get termsOfServiceButton => 'Termos de Serviço';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeSection => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String unableToLoadDocument(String title) {
    return 'Não foi possível carregar o documento $title.';
  }

  @override
  String versionLabel(String version) {
    return 'Versão $version';
  }

  @override
  String get websiteButton => 'www.gchouse.org';
}
