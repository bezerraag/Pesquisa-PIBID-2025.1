#Dependências
library(dplyr)
library(stringr)
library(ggplot2)

#Filtragem dos dados
data    <- read.csv("data.csv")[,c(3, 6:8, 24:35, 57:75)]
control <- data[, c(1:4, 17:33)]
l       <- c("Não sabe responder", "Comédia", "Notícias", "Cotidiano", "Celebridades", "Esportes", "Política")
for (i in l) {
  control[[i]] <- ifelse(str_detect(data$X18.Três.tipos.de.conteúdo.mais.consumido, fixed(i)), 1, 0)
}
data <- control
rm(control, l, i)

#Nomeando colunas
colnames(data) <- c("Year",           "Age",          "Gender",          "Race",
                    "Work.Geography", "Work.History", "Work.Philosophy", "Work.Sociology",
                    "Enem.Geography", "Enem.History", "Enem.Philosophy", "Enem.Sociology",
                    "Life.Geography", "Life.History", "Life.Philosophy", "Life.Sociology",
                    "Exp.Geography",  "Exp.History",  "Exp.Philosophy",  "Exp.Sociology",
                    "Opinion",
                    "None", "Comedy", "News", "Life", "Celebrities", "Sports", "Politics")

#Organizando ordinais
data$Year    <- factor(data$Year,    levels = c("1º", "2 º", "3 º"), labels = c(1,2,3))
data$Opinion <- factor(data$Opinion, levels = c("Ruim, muito difícil", "Ruim, pouco útil", "Boa, muito fácil", "Boa, muito útil"))

#Organização das dummies de consumo de mídia
for (i in c("None", "Comedy", "News", "Life", "Celebrities", "Sports", "Politics")) {
  data[[i]] <- factor(data[[i]], levels = c(0,1), labels = c("Não consome", "Consome"))
}
rm(i)

#------------------------------------
#Criação do índice
Importance = 4 / (data$Work.Sociology + data$Life.Sociology + data$Exp.Sociology + data$Enem.Sociology)

#------------------------------------
#Reformulando dados
data <- data.frame(Importance, Politics = data$Politics)
rm(Importance)

#Teste T
t.test(Importance ~ Politics, data)

#Gráfico
r <- data %>%
  group_by(Politics) %>%
  summarise(
    mean = mean(Importance, na.rm = TRUE),
    median = median(Importance, na.rm = TRUE)
    )

ggplot(data, aes(Politics, Importance)) +
  geom_boxplot() +
  
  geom_line(data  = r, aes(x = Politics, y = mean, group   = 1)) +
  geom_point(data = r, aes(x = Politics, y = mean), size   = 3) +
  geom_line(data  = r, aes(x = Politics, y = median, group = 1), linetype = "dashed") +
  geom_point(data = r, aes(x = Politics, y = median), size = 3) +
  
  labs(
    x = "Consumo de conteúdo político",
    y = "Índice de importância da disciplina de Sociologia"
  ) +
  theme_minimal()
