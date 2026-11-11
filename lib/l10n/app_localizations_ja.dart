// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get aboutAuthor =>
      '1998年2月26日にボール州立大学での講演として発表された Fred Gylys-Colwell によるオリジナル Java アプレット';

  @override
  String get aboutSummary =>
      'ラドン変換、線積分、シノグラム双対性、Frank Natterer のフィルタ補正逆投影 (FBP) の対話型可視化。';

  @override
  String get aboutTooltip => '情報';

  @override
  String get appTitle => 'CTスキャン デモンストレーション';

  @override
  String get close => '閉じる';

  @override
  String get collapseMainTextTooltip => '本文を折りたたむ';

  @override
  String get colormapClassic => 'クラシック (1998 Java)';

  @override
  String get colormapGrayscale => 'グレースケール (医用CT)';

  @override
  String get colormapInferno => 'Inferno';

  @override
  String get colormapSection => 'シノグラムのカラーマップ';

  @override
  String get colormapViridis => 'Viridis';

  @override
  String get done => '完了';

  @override
  String get expandMainTextTooltip => '本文を展開';

  @override
  String get filteredCheckbox => 'フィルタ';

  @override
  String get filteredCheckboxWide => 'フィルタ適用サイノグラム [F]';

  @override
  String get githubButton => 'GitHub (fredgc/cat)';

  @override
  String get graphCanvasSemantics => '断面と逆投影積分を示す 1D プロファイルプロット。';

  @override
  String get graphFilteredPrefix => 'フィルタ済み wb * g: ';

  @override
  String graphLineTrajectory(String r, String theta, String val) {
    return 'Ray Absorption (Green) | 線 (r = $r, θ = $theta) | 合計吸収量: $val';
  }

  @override
  String graphPointTrajectory(
    String prefix,
    String x,
    String y,
    String val,
    String status,
  ) {
    return '${prefix}Point Trajectory ($x, $y) | θ にわたる積分: $val $status';
  }

  @override
  String get graphSelectPrompt => '点または線を選択して 1D 断面を表示します。';

  @override
  String graphSlineTrajectory(String prefix, String r, String val) {
    return '$prefix半径 r = $r の接線スライス | 積分: $val';
  }

  @override
  String graphThetaTrajectory(String prefix, String theta, String val) {
    return '$prefixθ = $theta rad の投影スライス | 積分: $val';
  }

  @override
  String get graphUnfilteredPrefix => 'フィルタ前 g: ';

  @override
  String get insidePhantom => '(ファントム内)';

  @override
  String get issuesButton => 'イシュー';

  @override
  String get keyboardShortcutsList =>
      '• [Enter]: ガイドステップまたは次のステージへ\n• [N] / [→]: 次のステージ\n• [P] / [←]: 前のステージ\n• [1] - [7]: ステージ 1〜7 へジャンプ\n• [スペース]: スキャン回転の再生/一時停止\n• [F]: フィルタ補正再構成モードの切り替え';

  @override
  String get keyboardShortcutsTitle => 'キーボードショートカット:';

  @override
  String get languageAuto => '自動 (システム)';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get next => '次へ';

  @override
  String get nextStepTooltip => '次のステップ';

  @override
  String get objectCanvasSemantics => 'オブジェクト空間。X線投影線とファントムを示す座標平面。';

  @override
  String get outsidePhantom => '(ファントム外)';

  @override
  String get previous => '前へ';

  @override
  String get previousStepTooltip => '前のステップ';

  @override
  String get privacyPolicyButton => 'プライバシーポリシー';

  @override
  String get radonCanvasSemantics =>
      'シノグラムのラドン空間。縦軸に角度シータ、横軸に動径距離 r をとる2D投影データを表示。';

  @override
  String get replayAnimationCueTooltip => 'アニメーション合図を再生';

  @override
  String get res100Label => '100 (200×200)';

  @override
  String get res100Tooltip => '超高解像度';

  @override
  String get res25Label => '25 (50×50)';

  @override
  String get res25Tooltip => '高速パフォーマンス';

  @override
  String get res50Label => '50 (100×100)';

  @override
  String get res50Tooltip => '標準解像度';

  @override
  String get res75Label => '75 (150×150)';

  @override
  String get res75Tooltip => '高解像度';

  @override
  String get resetDefaults => 'デフォルトに戻す';

  @override
  String get resolutionSection => 'サンプリング解像度 (P × Q)';

  @override
  String get settingsTitle => '設定と表示';

  @override
  String get settingsTooltip => '設定と表示';

  @override
  String get showGuidesSubtitle => 'キャンバス上に軸と円形境界を表示';

  @override
  String get showGuidesTitle => '座標ガイドを表示';

  @override
  String get stage1Description =>
      'X線コンピュータ断層撮影 (CT) は、全方向からX線を照射することで物体の2D内部を非破壊的に再構成します。検出器が吸収後の強度を測定し、各直線 L に沿った吸収係数 f(x, y) の線積分 g(L) = ∫_L f ds を得ます。';

  @override
  String get stage1Instruction1 =>
      'オブジェクト空間をクリックまたはドラッグして、その点を通るすべての線を表示します。「次へ」または上のステージ2をクリックして進みます。';

  @override
  String get stage1NarrowDescription =>
      'CT は全方向からX線を照射して2D内部を再構成します。検出器が吸収強度を測定し、線積分 g(L) = ∫_L f ds を生成します。';

  @override
  String get stage1NarrowInstruction1 =>
      'オブジェクト空間をタップまたはドラッグして線を表示します。「次へ」またはステージ2をタップして進みます。';

  @override
  String get stage1NarrowSubtitle => '概要とラドン変換';

  @override
  String get stage1NarrowTitle => 'CTの概要';

  @override
  String get stage1Subtitle => '概要とラドン変換';

  @override
  String get stage1Title => 'コンピュータ断層撮影';

  @override
  String get stage2Description =>
      '2D空間の直線は、原点からの垂直距離 r と法線角 θ の2つの変数で表されます: x·cos(θ) + y·sin(θ) = r。左は物理的なオブジェクト空間 (x, y)、右はシノグラム空間 (r, θ) です。シノグラム空間の各点 (r, θ) は、オブジェクト空間を通る1本の完全なX線を表します。';

  @override
  String get stage2Instruction1 =>
      'ステップ 1/3: 右側のシノグラムをクリックまたはドラッグして、対応する直線と法線を表示します。';

  @override
  String get stage2Instruction2 =>
      'ステップ 2/3: シノグラム上で左右にドラッグして r (-1〜1) を変更します。線の平行移動を確認してください。';

  @override
  String get stage2Instruction3 =>
      'ステップ 3/3: シノグラム上で上下にドラッグして θ (0〜2π) を変更します。線の回転を確認してください。';

  @override
  String get stage2NarrowDescription =>
      '直線は r と θ で表されます: x·cos(θ) + y·sin(θ) = r。下部の1点が上部の直線を表します。';

  @override
  String get stage2NarrowInstruction1 => 'ステップ 1/3: 下のシノグラムをクリックして上の直線を表示します。';

  @override
  String get stage2NarrowInstruction2 => 'ステップ 2/3: 左右にドラッグして r を変更します。';

  @override
  String get stage2NarrowInstruction3 => 'ステップ 3/3: 上下にドラッグして θ を変更します。';

  @override
  String get stage2NarrowSubtitle => '直線の式: x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2NarrowTitle => '上がオブジェクト、下がデータ';

  @override
  String get stage2Subtitle => '直線のパラメータ化: x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2Title => '左がオブジェクト、右がデータ';

  @override
  String get stage3Description =>
      '1つの固定点 (x, y) を通るすべての直線は r(θ) = x·cos(θ) + y·sin(θ) を満たします。θ が 0 から 2π まで変化すると、この線群はシノグラム空間で正確な正弦波を描きます。オブジェクト空間の点はシノグラム空間の正弦波に対応し、シノグラム空間の点はオブジェクト空間の直線に対応します。';

  @override
  String get stage3Instruction1 =>
      'ステップ 1/3: 左側のオブジェクト空間をクリックまたはドラッグして点を移動し、右側の正弦波を確認します。';

  @override
  String get stage3Instruction2 =>
      'ステップ 2/3: シノグラムの右端バーをクリックして、角度 θ が一定の平行線群を表示します。';

  @override
  String get stage3Instruction3 =>
      'ステップ 3/3: シノグラムの下端バーをクリックして、半径 |r| の円に接する線群を表示します。';

  @override
  String get stage3NarrowDescription => '固定点 (x, y) を通る線群はシノグラム空間で正弦波を形成します。';

  @override
  String get stage3NarrowInstruction1 =>
      'ステップ 1/3: 上のオブジェクト空間をドラッグして下の正弦波を確認します。';

  @override
  String get stage3NarrowInstruction2 => 'ステップ 2/3: 右端バーをクリックして平行線を表示します。';

  @override
  String get stage3NarrowInstruction3 => 'ステップ 3/3: 下端バーをクリックして接線を表示します。';

  @override
  String get stage3NarrowSubtitle => '点はシノグラム上で正弦波を描く';

  @override
  String get stage3Subtitle => 'オブジェクト空間の点はシノグラム空間で正弦波を描く';

  @override
  String get stage3Title => '点の双対性';

  @override
  String get stage4Description =>
      'ファントムオブジェクト（円形ディスク）がオブジェクト空間に配置されます。そのX線減衰によってシノグラムと呼ばれる2D影データ g(r, θ) が生成されます。ファントムを移動すると、その正弦波状の影の振幅と位相が変化します。';

  @override
  String get stage4Instruction1 => 'ステップ 1/2: 左側の赤いファントムディスクをドラッグして位置を変更します。';

  @override
  String get stage4Instruction2 => 'ステップ 2/2: 右側のシノグラムで影がリアルタイムに移動する様子を確認します。';

  @override
  String get stage4NarrowDescription =>
      'ファントムがシノグラム上に2D影データを生成します。ファントムをドラッグして影を移動します。';

  @override
  String get stage4NarrowInstruction1 => 'ステップ 1/2: 上のファントムをドラッグして位置を変更します。';

  @override
  String get stage4NarrowInstruction2 => 'ステップ 2/2: 下のシノグラムで影の移動を確認します。';

  @override
  String get stage4NarrowSubtitle => 'ファントムと2D影データ';

  @override
  String get stage4NarrowTitle => '物体の影';

  @override
  String get stage4Subtitle => 'ファントムオブジェクトとシノグラムの2D影';

  @override
  String get stage4Title => '物体が影を作る';

  @override
  String get stage5Description =>
      '下部のグラフはシノグラム g(r, θ) の 1D 断面を表示します。正弦波に沿って全角度で射影を合計することを逆投影と呼びます: ∫₀²π g(x·cos θ + y·sin θ, θ) dθ。ファントム内では値が大きく、外では小さくなりますが、未処理の逆投影では 1/|r| のボケが生じます。';

  @override
  String get stage5Instruction1 =>
      'ステップ 1/3: 左側のファントム内をクリックし、下の逆投影積分の高い値を確認します。';

  @override
  String get stage5Instruction2 =>
      'ステップ 2/3: ファントム外をクリックし、1D プロファイルと積分値が低下することを確認します。';

  @override
  String get stage5Instruction3 => 'ステップ 3/3: 右側のシノグラム端をクリックして 1D 断面を確認します。';

  @override
  String get stage5NarrowDescription =>
      '下のグラフは 1D 断面を表示します。逆投影はファントム内で大きくなりますが、未フィルタでは 1/|r| のボケが発生します。';

  @override
  String get stage5NarrowInstruction1 =>
      'ステップ 1/3: 上のファントム内をクリックし、下の高い積分値を確認します。';

  @override
  String get stage5NarrowInstruction2 => 'ステップ 2/3: ファントム外をクリックし、値の低下を確認します。';

  @override
  String get stage5NarrowInstruction3 => 'ステップ 3/3: 下のシノグラム端をクリックして断面を確認します。';

  @override
  String get stage5NarrowSubtitle => '1D プロファイルと逆投影';

  @override
  String get stage5NarrowTitle => '断面データ';

  @override
  String get stage5Subtitle => '1D プロファイルとフィルタなし逆投影';

  @override
  String get stage5Title => 'データの断面';

  @override
  String get stage6Description =>
      '1/|r| のボケを除去するため、逆投影の前に射影をフィルタ処理します（フィルタ補正逆投影、FBP）。Frank Natterer の離散ランプフィルタ核 w_b(l) = b² / (π⁴(1 - 4l²)) との畳み込みにより、負のサイドローブが生じてボケが相殺され、ファントム内 ≈ 1.0、外 ≈ 0.0 が正確に再構成されます。';

  @override
  String get stage6Instruction1 =>
      'ステップ 1/2: ファントム内をクリックします。シャープなエッジと再構成積分 ≈ 1.0 を確認します。';

  @override
  String get stage6Instruction2 =>
      'ステップ 2/2: ファントム外をクリックします。負のサイドローブがボケを打ち消し、積分 ≈ 0.0 となります。';

  @override
  String get stage6NarrowDescription =>
      'Natterer ランプフィルタによる高域強調フィルタ処理がシノグラムを鮮明化し、ファントム内 ≈ 1.0、外 ≈ 0.0 を正確に再構成します。';

  @override
  String get stage6NarrowInstruction1 =>
      'ステップ 1/2: ファントム内をクリックして積分 ≈ 1.0 を確認します。';

  @override
  String get stage6NarrowInstruction2 =>
      'ステップ 2/2: ファントム外をクリックして積分 ≈ 0.0 を確認します。';

  @override
  String get stage6NarrowSubtitle => 'フィルタ補正逆投影 (FBP)';

  @override
  String get stage6NarrowTitle => 'フィルタ補正再構成';

  @override
  String get stage6Subtitle => 'Natterer ランプフィルタによるフィルタ補正逆投影 (FBP)';

  @override
  String get stage6Title => 'フィルタ補正データ再構成';

  @override
  String stageIndicator(int stageNumber) {
    return 'ステージ $stageNumber / 6';
  }

  @override
  String stageTitle(int stageNumber, String title) {
    return 'ステージ $stageNumber: $title';
  }

  @override
  String get switchLanguageTooltip => '言語を切り替える';

  @override
  String get moreInfoButton => '詳細情報';

  @override
  String get termsOfServiceButton => '利用規約';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeSection => 'テーマ';

  @override
  String get themeSystem => 'システム';

  @override
  String versionLabel(String version) {
    return 'バージョン $version';
  }

  @override
  String get websiteButton => 'www.gchouse.org';
}
