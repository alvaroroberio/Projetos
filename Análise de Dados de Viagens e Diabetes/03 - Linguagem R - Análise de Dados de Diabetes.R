# Atividade Prática 2 - Análise de Dados

# Carregamento de Dados
diabetes <- read.csv(
file = "C:/Users/Robério/Desktop/Mestrado em Economia/7 - Econometria/Rotinas do Rstudio/Script Rstudio - Comandos Básicos/Curso Básico - Linguagem R/diabetes.csv",
)

# 1. Preparação dos dados

# Verificação dos Dados
head(diabetes)
?str
str(diabetes)

# Verificando a existência de valores missings
colSums(is.na(diabetes))

# Estatística Descritiva e Outliers
library(ggplot2)
summary(diabetes$Insulin)
boxplot(diabetes$Insulin)

# 2. Análise Exploratória
boxplot(diabetes)
hist(diabetes$Pregnancies)
hist(diabetes$Age)
hist(diabetes$BMI)

# Removendo Outliers
library(dplyr)
diabetes2 <- diabetes %>%
filter(Insulin <= 250)
boxplot(diabetes2$Insulin)
summary(diabetes2$Insulin)

# 3. Construção do Modelo Preditivo

# Divisão dos Dados (teste e avaliação)

install.packages("caTools")
library(caTools)
set.seed(123)
index = sample.split(diabetes2$Pregnancies, SplitRatio = .70)
index
train = subset(diabetes2, index == TRUE)
test  = subset(diabetes2, index == FALSE)
dim(diabetes2)
dim(train)
dim(test)

# O ponto (.) variáveis explicativas e Outcome (variável explicada)
library(ggplot2)
library(lattice)
library(caret)
library(e1071)
library(naivebayes)
library(kernlab)

modelo <- train(
Outcome ~., data = train, method = "knn")
modelo$results
modelo$bestTune

modelo2 <- train(
Outcome ~., data = train, method = "knn",
tuneGrid = expand.grid(k = c(1:20)))
modelo2$results
modelo2$bestTune


train$Outcome <- as.factor(train$Outcome)
glimpse(train)

?naive_bayes

modelo3 <- train( Outcome ~., data = train, method = "naive_bayes")
modelo3$results
modelo3$bestTune

set.seed(100)
modelo4 <-train(Outcome ~., data = train, method = "svmRadialSigma", 
                preProcess=c("center"))
modelo4$results
modelo4$bestTune

# 4. Avaliando o modelo 

?predict 

predicoes <- predict(modelo4, test)
predicoes 

?caret:: confusionMatrix
confusionMatrix(table(predicoes, test$Outcome))

# Realizando Predições 

novos.dados <- data.frame(
  Pregnancies = c(3),
  Glucose = c(111.50),
  BloodPressure = c(70),
  SkinThickness = c(20),
  Insulin = c(47.49),
  BMI = c(30.80),
  DiabetesPedigreeFunction = c(0.34),
  Age = c(28)
)
novos.dados

previsao <- predict(modelo4, novos.dados)

resultado <- ifelse(previsao == 1, "Positivo", "Negativo")
print(paste("resultado:", resultado))


