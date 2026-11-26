---
title: CT 扫描数学与界面参考
---

**计算机断层扫描演示工具**是计算机断层扫描（CT）、拉东变换（Radon Transform）
和滤波反投影（FBP）的交互式参考手册。

## 数学参考

### 1. X 射线衰减与线积分

沿直线 $L$ 穿过物体的 X 射线束遵循比尔-朗伯定律发生衰减：

$$I = I_0 \exp\left(-\int_L f(x, y) \, ds\right)$$

将透射强度 $I$ 与入射强度 $I_0$ 对比，可得到吸收系数 $f(x, y)$ 的线积分：

$$g(L) = -\ln\left(\frac{I}{I_0}\right) = \int_L f(x, y) \, ds$$

### 2. 直线参数化与拉东变换

二维平面 $[-1, 1] \times [-1, 1]$ 中的每条直线都由到原点的有向垂直距离
$r \in [-1, 1]$ 和法线角 $\theta \in [0, 2\pi)$ 参数化：

$$x \cos(\theta) + y \sin(\theta) = r$$

**拉东变换** $\mathcal{R}[f](r, \theta) = g(r, \theta)$ 将所有线积分记录为
称为**正弦图**的二维数据集，并在 $2Q \times 2P$ 网格上离散化（$h = 1/Q$，
$r_i = (i - Q)/Q$，$\theta_j = \pi j / P$）。

### 3. 正弦图对偶性

- 正弦图空间中的单个点 $(r_0, \theta_0)$ 对应物体空间中的一条 X 射线直线。

- 物体空间中的单个点 $(x_0, y_0)$ 对应穿过该点的所有直线，在正弦图空间中
  形成正弦曲线：

  $$r(\theta) = x_0 \cos(\theta) + y_0 \sin(\theta)$$

### 4. 圆形模型的线积分

对于密度均匀为 $1$、半径为 $r_p$、圆心在 $(x_0, y_0)$ 的圆盘，令
$\Delta s = r - (x_0 \cos(\theta) + y_0 \sin(\theta))$，其线积分等于弦长：

$$\psi(\Delta s) = \begin{cases} 2\sqrt{r_p^2 - (\Delta s)^2} & |\Delta s| < r_p \\ 0 & \text{其他情况} \end{cases}$$

多个模型在正弦图中按线性叠加。

### 5. 反投影与滤波反投影（FBP）

沿点 $(x, y)$ 的对偶正弦曲线对正弦图求和，即得到未滤波反投影：

$$\mathcal{B}[g](x, y) = \int_0^{2\pi} g(x \cos(\theta) + y \sin(\theta), \theta) \, d\theta$$

未滤波反投影会引入 $1/|r|$ 模糊。将每条投影与 **Frank Natterer 离散斜坡
滤波器核**（带宽 $b = \pi Q$）卷积可消除模糊：

$$w_b(l) = \frac{b^2}{\pi^4 (1 - 4 l^2)} \quad (l \in \mathbb{Z})$$

$$(w_b * g)(r, \theta) = h \sum_{l = -L}^{L} g(r - l h, \theta) \, w_b(l)$$

$w_b$ 的负旁瓣精确抵消 $1/|r|$ 模糊，使模型内部重建为 $f(x, y) \approx 1.0$，
外部为 $\approx 0.0$。

## 界面与操作参考

### 物体空间视图

- **探针模式**：点击或拖动绿色探针点 $(x, y)$，在正弦图中查看其对偶正弦曲线。

- **模型模式**：在单位圆内拖动红色模型圆盘以调整位置。

- **添加 / 删除（`+` / 垃圾桶）**：添加多个模型圆盘或删除当前选中圆盘（阶段
  4–7）。

### 正弦图（拉东空间）视图

- **主热力图**：点击或拖动选择单条 X 射线 $(r, \theta)$。

- **右侧边框条**：点击或拖动查看固定角度 $\theta$ 的平行 X 射线族。

- **底部边框条**：点击或拖动查看与半径 $|r|$ 同心圆相切的直线族。

### 一维轮廓图（阶段 5–7）

- 绘制当前探针对应的一维截面，并实时计算反投影积分。

- **播放扫描 / 暂停**：使平行射线族在 $\theta \in [0, 2\pi)$ 范围内连续扫描。

### 工具栏、设置与快捷键

- **滤波（`[F]`）**：在未滤波正弦图 $g$ 与滤波正弦图 $w_b * g$ 之间切换。

- **阶段导航**：使用**上一步**、**下一步**、**跳过**或阶段编号（`1`–`7`）。

- **设置**：主题（深色、浅色、跟随系统）、配色方案（经典、灰度、Viridis、
  Inferno）、采样分辨率（$P \times Q$）和坐标参考线。

- **键盘快捷键**：`[Enter]`/`[N]` 下一步/下一阶段、`[→]` 下一阶段、`[P]`/`[←]`
  上一阶段、`[1]`–`[7]` 跳转阶段、`[空格]` 播放/暂停扫描、`[F]` 切换滤波。

## 背景与参考资料

- 原创 1998/2006 Java Applet，作者 **Fred Gylys-Colwell**，于 1998 年 2 月
  26 日在鲍尔州立大学演讲展示。

- Frank Natterer, *The Mathematics of Computerized Tomography*, SIAM Classics
  in Applied Mathematics, 2001.

- 源代码：[https://github.com/fredgc/cat](https://github.com/fredgc/cat)

- 问题反馈：
  [https://github.com/fredgc/cat/issues](https://github.com/fredgc/cat/issues)

- 更多应用：[www.gchouse.org](https://www.gchouse.org)
