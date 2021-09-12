# Rotinas Básica em Linguagem R

# Primeiro Script  

mensagem <- "Hello world!"
print(mensagem) 

# Pedido de Ajuda 

?print

# Instalação de Novo Pacote

install.packages("ggplot2")

# Carregamento de Pacote 

library (ggplot2)

# Estrutua de Dados 

# Vetores 

cidade <- c("Brasília", "São Paulo", "Rio de Janeiro", "Porto Alegre")
cidade 

temperatura <- c(32, 22, 35, 17)
temperatura 

regiao <- c(1,2,2,3)
regiao

?c()

# Acessando os Elementos 

# Acessando o Primeiro Elemento

cidade [1]

# Acessando um Intervalo de Elementos

temperatura [1:3]

# Copiando um Vetor

cidade2 <- cidade
cidade2

# Excluindo o segundo elemento da consulta

temperatura [-2]

# Alterando um vetor 

cidade2[3] <- "Belo Horizonte"
cidade2
cidade

# Adicionando um novo elementor

cidade2[5] <- "Curitiba"
cidade2

# Deletando o vetor 

cidade2 <- NULL
cidade2

# Fatores (Armazena variáveis categóricas)

?factor

UF <- factor(c("DF", "SP", "RJ", "RS"))
UF

# Fatores Ordenados 

grau.instrucao <- factor (c("Nível Médio", "Superior", "Nível Médio", "Fundamental"),
                          levels = c("Fundamental", "Nível Médio", "Superior"), ordered = TRUE)
grau.instrucao

# Listas 

?list()

pessoa <- list (sexo= "M", cidade = "Brasília", idade = 20)
pessoa

# Acessando o primeiro elementos da lista 

pessoa[1]

# Acessando o valor do primeiro elemento da lista

pessoa[[1]]
pessoa 

# Editando a lista 

pessoa [["idade"]] <- 22
pessoa
 
# Filtrando elementos da lista 

pessoa [c("cidade", "idade")]

# Lista de Listas 

cidades <- list(cidade = cidade, temperatura = temperatura, regiao = regiao)
cidades

# Criando um data-frame com vetores

df <- data.frame(cidade, temperatura)
df

# Criando um data-frame com lista 

df2 <- data.frame(cidades)
df2

# Filtrando valores do data-frame

# Recuperando o valor da linha 1, coluna 2

df[1,2]

# Todas as linhas da primeira coluna

df[,1]

# Primeira linha e todas as colunas

df[1,]

# Selecionando as 3 primeiras linhas e da primeira e última coluna

df2[c(1:3), c(1:3)]

# Verificando os tipos de dados

str(df)

# Verificando o nome das colunas

names(df)

# Verificando número de linhas x colunas

dim(df)

# Acessando uma coluna do data-frame

df$cidade
df['cidade']

# Função Matrix 

?matrix()
m <- matrix(seq(1:9), nrow = 3, ncol = 3)
m

# Função Matrix X List 

m2 <- matrix(seq(1:25), 
             ncol = 5, 
             byrow = TRUE, 
             dimnames = list(c(seq(1:5)), 
                            c('A' , 'B' , 'C' , 'D' , 'E')
                            )
            )
m2
 
# Filtrando a Matriz

m2[c(1:2), c("B", "C")]


# Estrutura de Repetição 

# Função "FOR"

# Loops # For # for (valor in sequencia {código ...})

# Exemplo for 

for (i in seq (12)){ print(i)}

# Função "WHILE"

# while(condicao){codigo...}

i <- 0 
while(i <= 10){
  print (i) 
  i = i+1
}

# Controle de Fluxo 

# if (condicao){codigo...}

x = 10
if (x>0){print ("Número Positivo")}

# Função "if" e "else if" 

nota = 4
if (nota >= 7){
  print("Aprovado")
} else if (nota > 5 && nota < 7) {
  print("Recuperação")
} else {
  print("Reprovado")
}

# Criando Funções 

par.impar <- function(num){
  if ((num %% 2)==0){
    return("Par")
  }else 
    return("Impar")
} 

# Testando a função 

num = 3
par.impar(num)

# Função Apply 

?apply

x <-seq(1:9)
matriz <- matrix(x, ncol=3)
matriz
    
result1 <- apply(matriz,1, sum)    
result1

result2 <- apply(matriz,2, sum)    
result2

?list

numeros.p <- c(2,4,6,8,10,12)
numeros.i <- c(1,3,5,7,9,11)
numeros <- list(numeros.p, numeros.i)
numeros

?lapply

lapply(numeros, mean)

?sapply

sapply(numeros, mean)

# Criando Gráficos 

?mtcars

carros <- mtcars[c(1,2,9)]
head(carros)

hist(carros$mpg)
plot(carros$mpg, carros$cyl)

library(ggplot2)
ggplot(carros, aes(am)) + geom_bar()

# Função Junções/Joins (União)

df1 <- data.frame(Produto = c(1,2,3,5), preco = c(15, 10, 25, 20))
head(df1)

df2 <- data.frame(Produto = c(1,2,3,4), nome = c("A", "B", "C", "D"))
head(df2)

install.packages("dplyr")
library(dplyr)

df3 <- left_join(df1, df2, "Produto")
df3

df4 <- right_join(df1, df2, "Produto")
df4

# Unindo os valores que estão nas duas tabelas (excluindo missings) 

df5 <- inner_join(df1, df2, "Produto")
head(df5)

# Selecionando Dados (dplyr)

library(dplyr)
?iris
head(iris)

# Obter informações do datset 

glimpse(iris)

# Filtrando os dDados (filter) - apenas vericolor

versicolor <- filter(iris,Species == "versicolor")
dim(versicolor)

# Slice - Selecionando algumas linhas especificas

slice(iris, 5:10)

# Select - Selecionamos algumas colunas 

select(iris, 2:4)

# Todas as colunas exceto Sepal widght 

select(iris, -Sepal.Width)

# Criando uma novo coluna com base colunas existentes (mutate)

iris2 <- mutate(iris, nova.coluna = Sepal.Length + Sepal.Width)

iris2[,c("Sepal.Length", "Sepal.Width", "nova.coluna")]

# Ordenando Dados - Arrange - Ordenar 

?arrange

select(iris, Sepal.Length) %>%
arrange(Sepal.Length)

# Agrupando Dados (Group by)

# Função Media (mean)
# Função Soma (sum)

?group_by

iris %>% group_by(Species) %>%
  summarise(mean(Sepal.Length))

# Transformação de Dados

library(tidyr)
library (dplyr)

# Quantidade de vendas por ano e produto 

dfDate <- data.frame(Produto=c('A', 'B', 'C'),
                    A.2015 = c(10, 12, 20),
                    A.2016 = c(20, 25, 35),
                    A.2017 = c(15, 20, 30)
                    )
head(dfDate)

# Transformando colunas em linhas (ggather)

?gather

dfDate2 <- gather(dfDate, "Ano", "Quantidade", 2:4)
head (dfDate2)

# Separando as colunas (separate)

?separate

dfDate3 <- separate (dfDate2, Ano, c("A", "Ano"))
dfDate3 <- dfDate3[-2]
dfDate3

# Acrescentando uma coluna (mes)

dfDate3$Mes <- c('01', '02', '03')
dfDate3

# Juntando colunas 

dfDate4 <- dfDate3 %>%
  unite(Data, Mes, Ano, sep='/')
head(dfDate4)
