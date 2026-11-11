---
title: Sobre a Demonstração de Tomografia
---

A **Ferramenta de Demonstração de Tomografia**éum aplicativo educacional
interativo projetado para ilustrar a matemática e os mecanismos por trás da
Tomografia Axial Computadorizada (TC) e da Transformada de Radon.

## História e motivação

Este aplicativoéinspirado no applet Java original de 1998/2006 de **Fred
Gylys-Colwell**. A apresentação foi realizada em 26 de fevereiro de 1998.

O aplicativo foi desenvolvido em Dart com Flutter. O código-fonte está
disponível no GitHub:
[https://github.com/fredgc/cat](https://github.com/fredgc/cat).

Encontrou um erro ou tem sugestões?
[Abra uma issue no GitHub](https://github.com/fredgc/cat/issues).

Outros aplicativos podem ser encontrados em
[www.gchouse.org](https://www.gchouse.org).

## A matemática por trás da tomografia

A tomografia computadorizada gera uma seção transversal 2D do interior de um
objeto sem cirurgia invasiva.

1. **Atenuação de raios X e integrais de linha**:

Um feixe de raios Xédirecionado ao longo de uma linha reta $L$. A proporção de
radiação absorvida correspondeàintegral de linha do coeficiente de absorção
$f(x, y)$ ao longo da linha $L$:

   $$g(L) = \int_L f(x, y) \, ds$$

2. **Parametrização de linhas retas**:

Toda linha no planoéparametrizada por sua distância $r$àorigem e peloângulo
normal $\theta \in [0, 2\pi)$:

   $$x \cos\theta + y \sin\theta = r$$

A transformada de Radon $\mathcal{R}[f](r, \theta)$ registra as integrais de
linha para todos os pares $(r, \theta)$.

3. **Dualidade do sinograma**:

   - Um ponto no sinograma $(r_0, \theta_0)$ representa uma linha reta no
     espaço do objeto.

   - Um ponto $(x_1, y_1)$ no espaço do objeto corresponde a uma curva
     senoidal $r(\theta) = x_1 \cos\theta + y_1 \sin\theta$ no sinograma.

4. **Retroprojeção filtrada (reconstrução)**:

A retroprojeção simples borra as projeções com dispersão $1/r$. Ao realizar a
convolução de cada projeção com um filtro passa-alta (desenvolvido por Frank
Natterer), a retroprojeção filtrada reconstrói com precisão a estrutura
interna ($f(x, y) \approx 1$ no interior, $0$ no exterior).

## Privacidade e retenção de dados

As preferências são armazenadas exclusivamente no seu dispositivo
(`SharedPreferences` / `localStorage`). Nenhum dado pessoalécoletado.
