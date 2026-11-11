---
title: CTスキャンデモについて
---

**CTスキャンデモツール**は、コンピュータ断層撮影（CT）とラドン変換の数学的原理と仕組みを視覚的に学ぶための対話型教育アプリケーションです。

## 歴史と背景

本アプリは、1998年/2006年に**Fred Gylys-Colwell**によって作成されたJavaアプレットから着想を得てFlutterで再設計され
ました。最初の発表は1998年2月26日に行われました。

ソースコードはGitHubで公開されています：
[https://github.com/fredgc/cat](https://github.com/fredgc/cat)。

不具合の報告や機能要望はGitHubまで：
[GitHub Issues](https://github.com/fredgc/cat/issues)。

その他のアプリや描画ツールは
[www.gchouse.org](https://www.gchouse.org) をご覧ください。

## CTスキャンの数学的原理

X線CTスキャンは、非侵襲的に物体の内部断面を2次元で再構成します。

1. **X線の減衰と線積分**:

直線$L$に沿って照射されたX線の吸収率は、線上の吸収係数$f(x, y)$の線積分に対応します：

   $$g(L) = \int_L f(x, y) \, ds$$

2. **直線のパラメータ化**:

平面上の直線は原点からの距離$r$と法線角度$\theta \in [0, 2\pi)$で表現されます：

   $$x \cos\theta + y \sin\theta = r$$

ラドン変換$\mathcal{R}[f](r, \theta)$は、すべての$(r, \theta)$に対する線積分を記録します。

3. **サイノグラムの双対性**:

   - サイノグラム上の点$(r_0, \theta_0)$は、物体空間の1本の直線を表します。

   - 物体空間の点$(x_1, y_1)$は、サイノグラム上の正弦曲線$r(\theta) = x_1 \cos\theta + y_1
     \sin\theta$を描きます。

4. **フィルタ補正逆投影法（再構成）**:

単純な逆投影では$1/r$のボケが生じます。Frank Nattererによるランプフィルタで畳み込み処理を行うことで、内部構造を正確に復元します（物体内部
で$\approx 1$、外部で$0$）。

## プライバシーとデータ保持

設定は端末内（`SharedPreferences` / `localStorage`）にのみ保存されます。個人情報は一切収集されません。
