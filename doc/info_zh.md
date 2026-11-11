---
title: 关于计算机断层扫描演示
---

**计算机断层扫描演示工具**是一款交互式教育应用，旨在阐明计算机轴向断层扫描（CT）与氡变换（Radon Transform）背后的数学与工程机制。

## 历史与背景

本应用灵感来自**Fred Gylys-Colwell**于1998/2006年创作的原始Java Applet，并在Flutter中进行了现代化重构。该演
讲于1998年2月26日首次展示。

本项目采用 Dart 和 Flutter 开发，源码托管在 GitHub：
[https://github.com/fredgc/cat](https://github.com/fredgc/cat)。

如发现缺陷或有功能建议，欢迎
[在 GitHub 提交 Issue](https://github.com/fredgc/cat/issues)。

了解更多应用与图形工具，请访问
[www.gchouse.org](https://www.gchouse.org)。

## CT 扫描的数学原理

X射线计算机断层扫描无需手术即可无创重建体内二维截面：

1. **X射线衰减与线积分**:

X射线束沿直线$L$穿过物体，吸收比例对应吸收系数$f(x, y)$沿直线$L$的数学线积分：

   $$g(L) = \int_L f(x, y) \, ds$$

2. **直线参数化**:

平面中的每条直线都可以由距原点的有向距离$r$与法线角$\theta \in [0, 2\pi)$参数化：

   $$x \cos\theta + y \sin\theta = r$$

氡变换$\mathcal{R}[f](r, \theta)$记录所有$(r, \theta)$的线积分。

3. **正弦图对偶性**:

   - 正弦图空间中的一个点$(r_0, \theta_0)$代表物体空间中的一条直线。

   - 物体空间中的一个点$(x_1, y_1)$对应正弦图中的一条正弦曲线$r(\theta) = x_1 \cos\theta + y_1
     \sin\theta$。

4. **滤波反投影(重建)**:

直接反投影会使图像产生$1/r$的模糊。通过将每个投影与Frank Natterer设计的斜坡高通滤波核卷积，滤波反投影可以精确重建内部衰减特征（物体内部
$\approx 1$，外部为$0$）。

## 隐私与数据留存

用户偏好设置仅在本地设备存储（`SharedPreferences` / `localStorage`）。不收集任何个人身份信息。
