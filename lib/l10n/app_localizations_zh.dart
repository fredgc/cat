// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get aboutAuthor =>
      '由 Fred Gylys-Colwell 于 1998 年 2 月 26 日在鲍尔州立大学演讲展示的原创 Java Applet';

  @override
  String get aboutSummary =>
      '氡变换（Radon Transform）、线积分、正弦图对偶性以及 Frank Natterer 滤波反投影（FBP）的交互式可视化。';

  @override
  String get aboutTooltip => '关于';

  @override
  String get appTitle => '计算机断层扫描演示';

  @override
  String get close => '关闭';

  @override
  String get collapseMainTextTooltip => '折叠正文';

  @override
  String get colormapClassic => '经典 (1998 Java)';

  @override
  String get colormapGrayscale => '灰度 (医学 CT)';

  @override
  String get colormapInferno => '地狱 (Inferno)';

  @override
  String get colormapSection => '正弦图配色方案';

  @override
  String get colormapViridis => '翠绿 (Viridis)';

  @override
  String get done => '完成';

  @override
  String get expandMainTextTooltip => '展开正文';

  @override
  String get filteredCheckbox => '滤波';

  @override
  String get filteredCheckboxWide => '滤波正弦图 [F]';

  @override
  String get githubButton => 'GitHub (fredgc/cat)';

  @override
  String get graphCanvasSemantics => '一维轮廓图，显示横截面和反投影积分。';

  @override
  String get graphFilteredPrefix => '滤波 wb * g: ';

  @override
  String graphLineTrajectory(String r, String theta, String val) {
    return 'Ray Absorption (Green) | 直线 (r = $r, θ = $theta) | 总吸收量: $val';
  }

  @override
  String graphPointTrajectory(
    String prefix,
    String x,
    String y,
    String val,
    String status,
  ) {
    return '${prefix}Point Trajectory ($x, $y) | 关于 θ 的积分: $val $status';
  }

  @override
  String get graphSelectPrompt => '选择点或直线以显示一维横截面。';

  @override
  String graphSlineTrajectory(String prefix, String r, String val) {
    return '$prefix半径 r = $r 处的切线切片 | 积分: $val';
  }

  @override
  String graphThetaTrajectory(String prefix, String theta, String val) {
    return '$prefixθ = $theta rad 处的投影切片 | 积分: $val';
  }

  @override
  String get graphUnfilteredPrefix => '未滤波 g: ';

  @override
  String get insidePhantom => '(模型内部)';

  @override
  String get issuesButton => '问题反馈';

  @override
  String get keyboardShortcutsList =>
      '• [Enter]: 下一步说明或下一阶段\n• [N] / [→]: 下一阶段\n• [P] / [←]: 上一阶段\n• [1] - [7]: 跳转至第 1 至 7 阶段\n• [空格]: 播放 / 暂停角度扫描旋转\n• [F]: 切换滤波重建模式';

  @override
  String get keyboardShortcutsTitle => '键盘快捷键：';

  @override
  String get languageAuto => '自动 (系统默认)';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get next => '下一步';

  @override
  String get nextStepTooltip => '下一步说明';

  @override
  String get objectCanvasSemantics => '物体空间。显示 X 射线投影线和模型的交互式坐标平面。';

  @override
  String get outsidePhantom => '(模型外部)';

  @override
  String get previous => '上一步';

  @override
  String get previousStepTooltip => '上一步说明';

  @override
  String get privacyPolicyButton => '隐私政策';

  @override
  String get radonCanvasSemantics => '正弦图氡空间。二维投影数据显示，垂直轴为角度 theta，水平轴为径向距离 r。';

  @override
  String get replayAnimationCueTooltip => '重放动画提示';

  @override
  String get res100Label => '100 (200×200)';

  @override
  String get res100Tooltip => '超高分辨率';

  @override
  String get res25Label => '25 (50×50)';

  @override
  String get res25Tooltip => '快速性能';

  @override
  String get res50Label => '50 (100×100)';

  @override
  String get res50Tooltip => '标准分辨率';

  @override
  String get res75Label => '75 (150×150)';

  @override
  String get res75Tooltip => '高分辨率';

  @override
  String get resetDefaults => '恢复默认设置';

  @override
  String get resolutionSection => '采样分辨率 (P × Q)';

  @override
  String get settingsTitle => '设置与显示';

  @override
  String get settingsTooltip => '设置与显示';

  @override
  String get showGuidesSubtitle => '在画布上显示坐标轴与圆形边界';

  @override
  String get showGuidesTitle => '显示坐标参考线';

  @override
  String get stage1Description =>
      'X 射线计算机断层扫描（CT）通过从所有角度 θ 发射穿透物体的射线，非侵入式地重建其二维内部结构。探测器测量透射强度，根据比尔-朗伯定律得出吸收系数 f(x, y) 沿每条直线 L 的数学线积分：g(L) = ∫_L f ds。断层成像的核心挑战正是反演这些线积分以恢复内部结构。';

  @override
  String get stage1Instruction1 =>
      '在物体空间中点击或拖动，以查看穿过该点的所有射线。点击上方的“下一步”或阶段 2 继续。';

  @override
  String get stage1NarrowDescription =>
      'CT 通过从多个角度 θ 穿透射线，非侵入式重建二维内部结构。探测器测量吸收强度，生成沿每条直线 L 的线积分 f(x, y)：g(L) = ∫_L f ds。';

  @override
  String get stage1NarrowInstruction1 => '在物体空间点击或拖动以查看射线。点击“下一步”或阶段 2 继续。';

  @override
  String get stage1NarrowSubtitle => '概述与氡变换';

  @override
  String get stage1NarrowTitle => 'CT 概述';

  @override
  String get stage1Subtitle => '概述与氡变换';

  @override
  String get stage1Title => '计算机轴向断层扫描';

  @override
  String get stage2Description =>
      '二维空间中的每条直线都可以用两个变量参数化：其距离原点的有向垂直距离 r，以及法线角度 θ：x·cos(θ) + y·sin(θ) = r。左侧视图显示物理物体空间 (x, y)，右侧视图显示正弦图空间 (r, θ)。正弦图空间中的每一个单独点 (r, θ) 都代表穿过物体空间的一条完整 X 射线直线。';

  @override
  String get stage2Instruction1 =>
      '第 1 步（共 3 步）：在右侧正弦图中点击或拖动，在左侧查看对应的直线 x·cos(θ) + y·sin(θ) = r 及其法线。';

  @override
  String get stage2Instruction2 =>
      '第 2 步（共 3 步）：在正弦图中左右拖动以改变径向距离 r (-1 到 1)。观察直线在物体空间中的平移。';

  @override
  String get stage2Instruction3 =>
      '第 3 步（共 3 步）：在正弦图中上下拖动以改变角度 θ (0 到 2π)。观察直线在物体空间中的旋转。';

  @override
  String get stage2NarrowDescription =>
      '每条直线均由 r 和 θ 参数化：x·cos(θ) + y·sin(θ) = r。底部画布上的一个点 (r, θ) 代表顶部物体空间中的一条完整直线。';

  @override
  String get stage2NarrowInstruction1 =>
      '第 1 步（共 3 步）：在底部正弦图中点击或拖动，在顶部查看对应的直线。';

  @override
  String get stage2NarrowInstruction2 => '第 2 步（共 3 步）：水平拖动以改变径向距离 r。';

  @override
  String get stage2NarrowInstruction3 => '第 3 步（共 3 步）：垂直拖动以改变角度 θ。';

  @override
  String get stage2NarrowSubtitle => '直线方程：x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2NarrowTitle => '上为物体，下为数据';

  @override
  String get stage2Subtitle => '直线参数化：x·cos(θ) + y·sin(θ) = r';

  @override
  String get stage2Title => '左为物体，右为数据';

  @override
  String get stage3Description =>
      '穿过单个固定点 (x, y) 的所有直线满足 r(θ) = x·cos(θ) + y·sin(θ)。随着投影角度 θ 从 0 变化到 2π，这族直线在 (r, θ) 正弦图空间中形成一条精确的正弦曲线。这种对偶性是根本性的：物体空间中的一个点映射为正弦图中的一条正弦曲线，而正弦图中的一个点映射为物体空间中的一条直线。';

  @override
  String get stage3Instruction1 =>
      '第 1 步（共 3 步）：在左侧物体空间中点击或拖动探针点，观察右侧对应的正弦对偶曲线。';

  @override
  String get stage3Instruction2 =>
      '第 2 步（共 3 步）：点击正弦图右侧边框条，查看固定角度 θ 下跨越所有 r 的平行直线族。';

  @override
  String get stage3Instruction3 =>
      '第 3 步（共 3 步）：点击正弦图底部边框条，查看与半径为 |r| 的同心圆相切的直线族。';

  @override
  String get stage3NarrowDescription =>
      '穿过固定点 (x, y) 的所有直线满足 r(θ) = x·cos(θ) + y·sin(θ)，在 (r, θ) 空间中形成一条正弦曲线。';

  @override
  String get stage3NarrowInstruction1 => '第 1 步（共 3 步）：在顶部物体空间点击或拖动，观察底部正弦曲线。';

  @override
  String get stage3NarrowInstruction2 => '第 2 步（共 3 步）：点击右侧边框条查看平行直线。';

  @override
  String get stage3NarrowInstruction3 => '第 3 步（共 3 步）：点击底部边框条查看切线族。';

  @override
  String get stage3NarrowSubtitle => '点在正弦图中描绘正弦曲线';

  @override
  String get stage3Subtitle => '物体空间中的点在正弦图空间中描绘正弦曲线';

  @override
  String get stage3Title => '点对偶性';

  @override
  String get stage4Description =>
      '模拟内部结构的圆形模型位于物体空间中。其 X 射线衰减形成称为正弦图的二维阴影数据集 g(r, θ)。当移动模型时，其正弦阴影带的振幅和相位会随之改变。';

  @override
  String get stage4Instruction1 => '第 1 步（共 2 步）：在左侧物体空间中拖动红色模型圆盘以改变其位置。';

  @override
  String get stage4Instruction2 => '第 2 步（共 2 步）：观察右侧正弦图中模型的二维阴影如何即时移动。';

  @override
  String get stage4NarrowDescription => '物体空间中的模型（圆盘）生成二维阴影数据集 g(r, θ)，即正弦图。';

  @override
  String get stage4NarrowInstruction1 => '第 1 步（共 2 步）：在顶部拖动模型圆盘以改变其位置。';

  @override
  String get stage4NarrowInstruction2 => '第 2 步（共 2 步）：观察底部正弦图中阴影的移动。';

  @override
  String get stage4NarrowSubtitle => '模型与二维正弦图阴影';

  @override
  String get stage4NarrowTitle => '物体阴影';

  @override
  String get stage4Subtitle => '模型物体及其二维正弦图阴影';

  @override
  String get stage4Title => '物体产生阴影';

  @override
  String get stage5Description =>
      '底部图表显示正弦图 g(r, θ) 的一维横截面。特别地，沿点 (x, y) 的正弦曲线检查投影并对所有角度 θ 求和称为反投影：∫₀²π g(x·cos θ + y·sin θ, θ) dθ。如果点位于模型圆盘内，积分值很大；如果在外部，则很小。然而，未滤波的反投影会产生 1/|r| 的模糊点扩散。';

  @override
  String get stage5Instruction1 => '第 1 步（共 3 步）：在左侧模型圆盘内部点击。观察底部图表中较大的反投影积分值。';

  @override
  String get stage5Instruction2 => '第 2 步（共 3 步）：在模型圆盘外部点击。观察一维轮廓值下降且反投影积分变小。';

  @override
  String get stage5Instruction3 => '第 3 步（共 3 步）：点击右侧正弦图边框条，查看恒定 θ 或 r 处的一维截面。';

  @override
  String get stage5NarrowDescription =>
      '底部图表显示 g(r, θ) 的一维截面。反投影在模型内部产生大积分，但未滤波会导致 1/|r| 模糊图像。';

  @override
  String get stage5NarrowInstruction1 => '第 1 步（共 3 步）：点击顶部模型内部。观察底部的大积分值。';

  @override
  String get stage5NarrowInstruction2 => '第 2 步（共 3 步）：点击模型外部。观察数值明显下降。';

  @override
  String get stage5NarrowInstruction3 => '第 3 步（共 3 步）：点击底部正弦图边框条查看一维截面。';

  @override
  String get stage5NarrowSubtitle => '一维轮廓与反投影';

  @override
  String get stage5NarrowTitle => '数据截面';

  @override
  String get stage5Subtitle => '一维轮廓与未滤波反投影';

  @override
  String get stage5Title => '数据横截面';

  @override
  String get stage6Description =>
      '为了消除 1/|r| 的模糊，投影在反投影之前需先滤波（滤波反投影，FBP）。将每个投影与 Frank Natterer 的离散斜坡滤波器核 w_b(l) = b² / (π⁴(1 - 4l²)) 卷积，相当于具有负旁瓣的边缘锐化导数滤波器。反投影时，负旁瓣精确抵消了模糊散布：模型圆盘内精确为 ≈ 1.0，外部为 ≈ 0.0。';

  @override
  String get stage6Instruction1 =>
      '第 1 步（共 2 步）：点击模型圆盘内部。观察一维轮廓中清晰的边缘旁瓣和重建积分 ≈ 1.0。';

  @override
  String get stage6Instruction2 => '第 2 步（共 2 步）：点击模型圆盘外部。负旁瓣完全抵消模糊（积分 ≈ 0.0）。';

  @override
  String get stage6NarrowDescription =>
      '使用 Frank Natterer 离散滤波器核 w_b(l) = b² / (π⁴(1 - 4l²)) 进行高通滤波可锐化正弦图。滤波反投影能精确重建内部衰减值：模型内 ≈ 1.0，外部 ≈ 0.0。';

  @override
  String get stage6NarrowInstruction1 => '第 1 步（共 2 步）：点击模型内部。观察锐利旁瓣和积分 ≈ 1.0。';

  @override
  String get stage6NarrowInstruction2 =>
      '第 2 步（共 2 步）：点击模型外部。负旁瓣抵消模糊（积分 ≈ 0.0）。';

  @override
  String get stage6NarrowSubtitle => '滤波反投影 (FBP)';

  @override
  String get stage6NarrowTitle => '滤波重建';

  @override
  String get stage6Subtitle => '使用 Natterer 斜坡滤波核的滤波反投影 (FBP)';

  @override
  String get stage6Title => '滤波数据重建';

  @override
  String stageIndicator(int stageNumber) {
    return '阶段 $stageNumber / 6';
  }

  @override
  String stageTitle(int stageNumber, String title) {
    return '阶段 $stageNumber：$title';
  }

  @override
  String get switchLanguageTooltip => '切换语言';

  @override
  String get moreInfoButton => '更多信息';

  @override
  String get termsOfServiceButton => '服务条款';

  @override
  String get themeDark => '深色';

  @override
  String get themeLight => '浅色';

  @override
  String get themeSection => '主题';

  @override
  String get themeSystem => '跟随系统';

  @override
  String versionLabel(String version) {
    return '版本 $version';
  }

  @override
  String get websiteButton => 'www.gchouse.org';
}
