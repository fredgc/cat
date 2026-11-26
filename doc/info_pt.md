---
title: Referência matemática e de interface (TC)
---

A **Demonstração de Tomografia Computadorizada** é uma referência interativa
sobre tomografia computadorizada (TC), Transformada de Radon e Retroprojeção
Filtrada (FBP).

## Referência matemática

### 1. Atenuação de raios X e integrais de linha

Um feixe de raios X que percorre uma linha reta $L$ através de um objeto perde
intensidade segundo a lei de Beer-Lambert:

$$I = I_0 \exp\left(-\int_L f(x, y) \, ds\right)$$

Comparar a intensidade transmitida $I$ com a incidente $I_0$ fornece a integral
de linha do coeficiente de absorção $f(x, y)$:

$$g(L) = -\ln\left(\frac{I}{I_0}\right) = \int_L f(x, y) \, ds$$

### 2. Parametrização de linhas e Transformada de Radon

Cada linha reta no plano 2D $[-1, 1] \times [-1, 1]$ é parametrizada pela
distância perpendicular com sinal $r \in [-1, 1]$ da origem e pelo ângulo
normal $\theta \in [0, 2\pi)$:

$$x \cos(\theta) + y \sin(\theta) = r$$

A **Transformada de Radon** $\mathcal{R}[f](r, \theta) = g(r, \theta)$ registra
todas as integrais de linha em um conjunto 2D chamado **sinograma**,
discretizado em uma grade $2Q \times 2P$ ($h = 1/Q$, $r_i = (i - Q)/Q$,
$\theta_j = \pi j / P$).

### 3. Dualidade do sinograma

- Um único ponto $(r_0, \theta_0)$ no Espaço do Sinograma corresponde a uma
  linha reta de raio X no Espaço do Objeto.

- Um único ponto $(x_0, y_0)$ no Espaço do Objeto corresponde a todas as linhas
  que passam por ele, traçando uma senoide no Espaço do Sinograma:

  $$r(\theta) = x_0 \cos(\theta) + y_0 \sin(\theta)$$

### 4. Integral de linha de um fantoma circular

Para um disco circular de densidade uniforme $1$, raio $r_p$ e centro
$(x_0, y_0)$, seja $\Delta s = r - (x_0 \cos(\theta) + y_0 \sin(\theta))$. A
integral de linha é o comprimento da corda:

$$\psi(\Delta s) = \begin{cases} 2\sqrt{r_p^2 - (\Delta s)^2} & \text{se } |\Delta s| < r_p \\ 0 & \text{caso contrário} \end{cases}$$

Múltiplos fantomas somam-se linearmente no sinograma.

### 5. Retroprojeção e Retroprojeção Filtrada (FBP)

Somar os valores do sinograma ao longo da senoide dual de $(x, y)$ produz a
retroprojeção sem filtro:

$$\mathcal{B}[g](x, y) = \int_0^{2\pi} g(x \cos(\theta) + y \sin(\theta), \theta) \, d\theta$$

A retroprojeção sem filtro borra os detalhes com dispersão $1/|r|$. Convoluir
cada projeção com o **kernel discreto em rampa de Frank Natterer** (largura de
banda $b = \pi Q$) remove esse desfoque:

$$w_b(l) = \frac{b^2}{\pi^4 (1 - 4 l^2)} \quad (l \in \mathbb{Z})$$

$$(w_b * g)(r, \theta) = h \sum_{l = -L}^{L} g(r - l h, \theta) \, w_b(l)$$

Os lobos negativos de $w_b$ cancelam o borramento $1/|r|$, reconstruindo
$f(x, y) \approx 1.0$ dentro de cada fantoma e $\approx 0.0$ fora.

## Referência de interface e controles

### Espaço do Objeto

- **Modo Sonda**: Clique ou arraste para posicionar o ponto verde $(x, y)$ e
  ver sua senoide dual no sinograma.

- **Modo Fantoma**: Arraste os discos vermelhos dentro do círculo unitário.

- **Adicionar / Excluir (`+` / lixeira)**: Adicione vários discos fantoma ou
  remova o selecionado (Etapas 4–7).

### Espaço do Sinograma (Radon)

- **Mapa principal**: Clique ou arraste para selecionar um único raio X
  $(r, \theta)$.

- **Barra direita**: Clique ou arraste para exibir uma família de raios
  paralelos com ângulo fixo $\theta$.

- **Barra inferior**: Clique ou arraste para exibir retas tangentes a um
  círculo de raio $|r|$.

### Gráfico de perfil 1D (Etapas 5–7)

- Exibe a seção transversal 1D ao longo da sonda ativa e calcula a integral de
  retroprojeção em tempo real.

- **Iniciar varredura / Pausar**: Varre a família paralela por
  $\theta \in [0, 2\pi)$.

### Barra superior, configurações e atalhos

- **Filtro (`[F]`)**: Alterna entre sinograma sem filtro $g$ e filtrado
  $w_b * g$.

- **Navegação**: Use **Anterior**, **Próximo**, **Pular** ou os botões de etapa
  (`1`–`7`).

- **Configurações**: Tema (Escuro, Claro, Sistema), Mapa de cores (Clássico,
  Tons de cinza, Viridis, Inferno), Resolução de amostragem ($P \times Q$) e
  Guias de coordenadas.

- **Atalhos do teclado**: `[Enter]`/`[N]` próximo passo/etapa, `[→]` próxima
  etapa, `[P]`/`[←]` etapa anterior, `[1]`–`[7]` ir para etapa, `[Espaço]`
  iniciar/pausar varredura, `[F]` alternar filtro.

## Contexto e referências

- Applet Java original (1998/2006) de **Fred Gylys-Colwell**, apresentado na
  Ball State University em 26 de fevereiro de 1998.

- Frank Natterer, *The Mathematics of Computerized Tomography*, SIAM Classics
  in Applied Mathematics, 2001.

- Código-fonte: [https://github.com/fredgc/cat](https://github.com/fredgc/cat)

- Problemas:
  [https://github.com/fredgc/cat/issues](https://github.com/fredgc/cat/issues)

- Mais aplicativos: [www.gchouse.org](https://www.gchouse.org)
