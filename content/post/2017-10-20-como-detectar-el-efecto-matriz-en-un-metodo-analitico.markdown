---
title: como detectar el efecto matriz en un metodo analitico
author: cgomez
date: '2017-10-20'
slug: como-detectar-el-efecto-matriz-en-un-metodo-analitico
math: true
categories:
  - sesgo
  - incertidumbre
tags:
  - calibracion
  - adicion conocida
  - R
---



He vuelto a postear, después de una gira que me llevó por los cinco... 
mentira, fue por pura pega.

El famoso efecto matriz, algo tan etéreo como el _criterio analítico_.
La situación es la siguiente: Ud. tiene un método analítico que consistentemente
entrega valores sesgados

El efecto matriz está íntimamente relacionado con las interferencias de la 
matriz que de alguna forma aumentan o disminuyen la señal instrumental que, 
en teoría, es producida sólo por el analito de interés.

Para evaluar y detectar el efecto matriz, debemos desempolvar algunos papers
que nos enseñaron el famoso método de calibración con adición conocida o 
adición de estándar. en este método de calibración, la matriz es nuestro 
medio de calibración. En vez de preparar los calibrantes en solventes puros o 
en solución ácida, utilizaremos la misma matriz para preparar (adicionar) las 
soluciones de calibración.

Existen varias formas de implementar el método de adición conocida. Una muy
buena referencia es el excelente y pedagógico paper de M. Bader:

> Morris Bade, A systematic approach to standard addition methods in 
instrumental analysis _J. Chem. Educ., 1980, 57 (10), p 703_

El método consiste en añadir cantidades conocidas del analito en solvente 
puro o solución ácida y medir la respuesta instrumental en una serie de
adiciones crecientes. Es necesario que las adiciones de analito generen, en 
conjunto con la cantidad de analito en la muestra original, una concentración
tal que aún se encuentre en el rango lineal de calibración. De esta forma
se otiene una curva de calibración como se observa en la figura<a href="#fig:adicion">1</a>:

<div class="figure">
<img src="/img/c0adicion.png" alt="Preparación curva método de adición conocida"  />
<p class="caption">Figure 1 Preparación curva método de adición conocida</p>
</div>

Las unidades del eje `\(X\)` pueden establecerse como _analito añadido_ o, 
tal como lo propone Bader en su paper, como múltiplos de un volumen
o cantidad fija del analito. Por lo tanto, en `\(x = 0\)` se obtiene la 
señal de la muestra problema a la cual no se le ha agregado el 
analito, es decir, la señal original. En cada una de las adiciones
del estándar mediremos la señal instrumental de tal manera de 
obtener, y así lo esperamos, una relación lineal entre analito 
agregado `\(x\)` y señal `\(y\)` de la forma:

\begin{equation}
  y = \beta_{0} + \beta_{1}x + \epsilon
    \tag{1}
\end{equation}

donde se asumen los mismos supuestos que discutimos en el caso de la
calibración lineal estándar(en solvente puro) y que puede recordar en este 
[post](https://www.analytical.cl/post/como-demuestro-que-mi-curva-de-calibracion-es-lineal/).

La concentración de la muestra problema `\(C_{0}\)` se obtiene a partir de la 
ecuación (2):

\begin{equation}
  C_{0} = \frac{\beta_{1}}{\beta_{0}}
  \tag{2}
\end{equation}
  

La incertidumbre de la concentración de la muestra problema `\(u(C_{0})\)` se 
calcula a partir de la ecuación:


\begin{equation}
  u(C_{0}) = \frac{\sigma_{y/x}}{\beta_{1}}
  \sqrt{\frac{1}{n} + \frac{\overline{y}^2}
  {\beta_{1}\sum_{i}^{n} (x_{i} - \overline{x})^2}}
    \tag{3}
\end{equation}

donde:
- `\(\sigma_{y/x}\)` es la desviación estándar del error aleatorio `\(\epsilon\)`
- `\(n\)` es el número de adiciones independientes del estándar
- `\(\overline{y}\)` es el promedio de las señales instrumentales de las adiciones
- `\(\overline{x}\)` es el promedio de las concentraciones 


Como puede apreciar la expresión de la incertidumbre de calibración para el 
método de adición conocida es muy
similar a la correspondiente a la calibración estandar que discutimos en un 
[post anterior](https://www.analytical.cl/post/como-calcular-la-incertidumbre-de-una-curva-de-calibracion/).

Si queremos minimizar esta incertidumbre podríamos aumentar el número de 
adiciones `\(n\)` o aumentar el término `\(\sum_{i}^{n} (x_{i} - \overline{x})^2\)`. 
Este último es interesante pues nos dice que la incertidumbre de calibración 
de este método se minimiza utilizando un rango amplio de concentración de
adición. Ellison hace un análisis donde demuestra que, dado que la propiedad
de linealidad se mantiene, basta preparar dos puntos de calibración:

- La muestra original sin adición ($x = 0$)
- El extremo superior del rango lineal

Por ejemplo, si por alguna razón se tuvieran que preparar `\(n = 6\)` adiciones, lo
que indica la ecuación (3), es que sería mejor preparar tres puntos
sin adición ($x = 0$) y tres en el extremos superior del rango lineal, tal 
como lo demuestra la figura <a href="#fig:doe">2</a>

<div class="figure">
<img src="/img/doeadicion.png" alt="Diseño de una curva de calibración con adición conocida para minimizar la incertidumbre"  />
<p class="caption">Figure 2 Diseño de una curva de calibración con adición conocida para minimizar la incertidumbre</p>
</div>







An effective and commonly used technique to overcome matrix interferences is standard addition. This involves adding known quantities of the analyte (the standard) to the solution of interest and measuring the solution's analytical signals in response to each addition. (Adding the standard to the sample is commonly called "spiking the sample.") Assuming that the analytical signal still changes proportionally to the concentration of the analyte in the presence of matrix effects, a calibration curve can be obtained based on simple linear regression. The analyte's concentration in the solution before any additions of the standard can then be extrapolated from the regression line; I will explain how this extrapolation works later in the post with a plot of the regression line.

