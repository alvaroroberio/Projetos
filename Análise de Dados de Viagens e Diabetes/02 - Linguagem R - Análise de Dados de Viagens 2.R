# Curso Básico - Análise Prática de Dados 

# (1) Carregando os Dados #sep (separador) #dec (separador de casas decimais)

?read.csv

viagens <- read.csv(
  file = "C:/Users/Robério/Desktop/Mestrado em Economia/7 - Econometria/Rotinas do Rstudio/Script Rstudio - Comandos Básicos/Curso Básico - Linguagem R/2019_Viagem.csv",
  sep = ';',
  dec = ','
)

# (2) Visualizando os Dados

head(viagens)
View(viagens)

# (3) Verificando o número de observações e colunas

dim(viagens)

# (4) Estatística Descritiva 

?summary
summary(viagens)
summary(viagens$Valor.passagens)

# (5) Organização dos Dados 

library(dplyr)

# Verificando os tipos de dados

glimpse(viagens)

# Transformando dados 

? as.Date

viagens$data.inicio <- as.Date(viagens$Período...Data.de.início, "%d/%m/%Y")
glimpse(viagens)

# Formatando (Campo Data)
# Conteúdo de R <https://www.statmethods.net/input/dates.html> 

?format 
viagens$data.inicio.formatada <- format(viagens$data.inicio, "%Y-%m")
viagens$data.inicio.formatada

# (6) Exploração dos Dados 

# Gráfico (histograma)

hist(viagens$Valor.passagens)

# Valores Min, Max, Med, ..., da Coluna Valor 

summary(viagens$Valor.passagens)

# Visualizando os valores em um boxplot 

boxplot(viagens$Valor.passagens)

# Calculando o Desvio-Padrão 

sd(viagens$Valor.passagens)

# Verificando se existem missings (valores não preenchidos) 

?is.na
?colSums

colSums(is.na(viagens))


# Verificando Ocorrências 

str(viagens$Situação)

table(viagens$Situação)

prop.table(table(viagens$Situação))*100

# (7) Resultados 

# (7.1) Quais órgãos estão gastando mais com passagens aéreas?
# Criando um dataframe com os 15 órgãos que gastam mais 

p1 <- viagens %>%
  group_by(Nome.do.órgão.superior) %>%
  summarise(n = sum(Valor.passagens)) %>%
  arrange(desc(n)) %>%
  top_n(15)

names(p1) <- c("orgao", "valor")
p1 

# Plotando os dados com o ggplot 

options(scipen = 999)

library(ggplot2)
ggplot(p1, aes(x= reorder(orgao, valor), y = valor))+
  geom_bar(stat = "identity")+
  coord_flip()+
  labs(x="Valor", y="Órgãos")

# (7.2) Valores gastos com viagens por cidade 
  
p2 <- viagens %>%
  group_by(Destinos) %>%
  summarise(n = sum(Valor.passagens)) %>%
  arrange(desc(n)) %>%
  top_n(15)

names(p2) <- c('destino', 'valor')
p2

# Criando o gráfico 

ggplot(p2, aes(x = reorder (destino, valor), y = valor))+
  geom_bar(stat = "identity", fill = "#0ba791")+
  geom_text(aes (label = valor), vjust=0.3, size=3)+
  coord_flip()+
  labs(x="Destino", y="Valor")

options(scipen = 999)

# (7.3) Analisando a quantidade de viagens realizadas por mês 

p3 <- viagens %>%
  group_by(data.inicio.formatada) %>%
  summarise(qtd = n_distinct(Identificador.do.processo.de.viagem))
head(p3)

# Criando o gráfico 

ggplot(p3, aes(x = data.inicio.formatada, y = qtd, group = 1))+
  geom_line()+
  geom_point()

# (8) Visualização de Resultados 

install.packages("rmarkdown")
install.packages('tinytex')

tinytex::install_tinytex()

library(rmarkdown)
library(tinytex)

