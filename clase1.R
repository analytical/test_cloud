x <- rnorm(100, 10, 1)
mean(x)
sd(x)
median(x)
mad(x)

# Cálculo de intervalo de confianza para la media

icsup <- mean(x) + abs(qt(0.975, 99))*sd(x)/sqrt(100)
icinf <- mean(x) - abs(qt(0.025, 99))*sd(x)/sqrt(100)

# concatenar ambos intervaloes

c(icinf, icsup)

# Pruebas de hipótesis paramétricas
# comparar dos metodologías

icp <- rnorm(10,100, 5)
faas <- rnorm(10, 100, 5)

# Test de normalidad de Shapiro-Wilk

shapiro.test(icp)
shapiro.test(faas)

# test de precisión o varianzas 

var.test(icp, faas)

# test T para varianzas distintas

t.test(icp, faas, var.equal = F)

# Estimar intervalo de confianza mediante bootstrap

Cu <- rt(100, 3)
qqnorm(Cu)
qqline(Cu)

# Creamos la funcion bootstrap de medias

cv <- function(x){
  sd(x)/mean(x)*100
}

set.seed(123)
t <- rnorm(10, 100, 1)
cv(t)

boot.media <- function(x, i){
  mean(x[i])
}

library(boot)

promedios <- boot(Cu, boot.media, 1000)
boot.ci(promedios)


# ANOVA


aov.precision <- aov(Concentracion ~ Analista, data = datos)

boxplot(Concentracion ~ Analista, data = datos)

summary(aov.precision)


# Prueba de linealidad de carencia de ajuste
# usando la librería alr3

# Primero instalamos la librería

install.packages('alr3')

# Ajustamos un modelo lineal

modelo.lineal <- lm(y ~ x, data = lof)

# Cargamos la librería alr3
library(alr3)

# Usamos el comando pureErrorAnova

pureErrorAnova(modelo.lineal)


# test de mMandel

mandel.lineal <- lm(y ~ x, data = mandel)
mandel.nolineal <- lm(y ~ x + I(x^2), data = mandel)

anova(mandel.lineal, mandel.nolineal)

