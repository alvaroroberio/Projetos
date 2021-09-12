# Análise de Dados de Viagens 

# Carregamento de pacotes 

library(dplyr)
library(ggplot2)
library(rmarkdown)
library(tidyr)
library(tinytex)

# Carregamento de Dados

viagens <- read.csv(
  file = "C:/Users/Robério/Desktop/Mestrado em Economia/7 - Econometria/Rotinas do Rstudio/Script Rstudio - Comandos Básicos/Curso Básico - Linguagem R/2019_Viagem.csv",
  sep = ';',
  dec = ','
)

# Estatística Descritiva 

summary(viagens)
summary(viagens$Valor.passagens)

viagens$data.inicio.formatada <- format(viagens$data.inicio, "%Y-%m")
viagens$data.inicio.formatada

# Alterando Formato de Dados

glimpse(viagens)
viagens$data.inicio <- as.Date(viagens$Período...Data.de.início, "%d/%m/%Y")
glimpse(viagens)

# Histograma e Estatística 

hist(viagens$Valor.passagens)
summary(viagens$Valor.passagens)

# Estatística (Proporção)

table(viagens$Situação)
prop.table(table(viagens$Situação))*100

# Visualizando os valores em um boxplot

boxplot(viagens$Valor.passagens)
sd(viagens$Valor.passagens)
colSums(is.na(viagens))
str(viagens$Situação)

# Qual o valor gasto por órgão ?

p1 <- viagens %>%
  group_by(Nome.do.órgão.superior) %>%
  summarise(n = sum(Valor.passagens)) %>%
  arrange(desc(n)) %>%
  top_n(15)
names(p1) <- c("orgao", "valor")
p1

# Criando Gráfico 1 

ggplot(p1, aes(x= reorder(orgao, valor), y = valor))+
  geom_bar(stat = "identity")+
  coord_flip()+
  labs(x="Valor", y="Órgãos")

# Qual é o valor gasto por cidade?

p2 <- viagens %>%
  group_by(Destinos) %>%
  summarise(n = sum(Valor.passagens)) %>%
  arrange(desc(n)) %>%
  top_n(15)
names(p2) <- c('destino', 'valor')
p2

# Gráfico 2 

ggplot(p2, aes(x = reorder (destino, valor), y = valor))+
  geom_bar(stat = "identity", fill = "#0ba791")+
  geom_text(aes (label = valor), vjust=0.3, size=3)+
  coord_flip()+
  labs(x="Destino", y="Valor")
options(scipen = 999)

# Formatação de Data 

viagens$data.inicio <- as.Date(viagens$Período...Data.de.início, "%d/%m/%Y")
glimpse(viagens)
viagens$data.inicio.formatada <- format(viagens$data.inicio, "%Y-%m")
viagens$data.inicio.formatada

# Qual é a quantidade de viagens por mês?

p3 <- viagens %>%
  group_by(data.inicio.formatada) %>%
  summarise(qtd = n_distinct(Identificador.do.processo.de.viagem))
head(p3)

# Gráfico 3

ggplot(p3, aes(x = data.inicio.formatada, y = qtd, group = 1))+
  geom_line()+
  geom_point()

