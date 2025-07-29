library(dplyr)
library(stringr)
library(ggplot2)

data    <- read.csv("data.csv")[,c(3, 6:8, 24:35, 57:75)]
control <- data[, c(1:4, 17:33)]
l       <- c("Não sabe responder", "Comédia", "Notícias", "Cotidiano", "Celebridades", "Esportes", "Políticas")
for (i in l) {
  control[[i]] <- ifelse(str_detect(data$X18.Três.tipos.de.conteúdo.mais.consumido, fixed(i)), 1, 0)
}
data <- control
rm(control, l, i)

colnames(data) <- c("Year",           "Age",          "Gender",          "Race",
                    "Work.Geography", "Work.History", "Work.Philosophy", "Work.Sociology",
                    "Enem.Geography", "Enem.History", "Enem.Philosophy", "Enem.Sociology",
                    "Life.Geography", "Life.History", "Life.Philosophy", "Life.Sociology",
                    "Exp.Geography",  "Exp.History",  "Exp.Philosophy",  "Exp.Sociology",
                    "Opinion",
                    "None", "Comedy", "News", "Life", "Celebrities", "Sports", "Politics")

data$Year    <- factor(data$Year,    levels = c("1º", "2 º", "3 º"), labels = c(1,2,3))
data$Opinion <- factor(data$Opinion, levels = c("Ruim, muito difícil", "Ruim, pouco útil", "Boa, muito fácil", "Boa, muito útil"))
for (i in c("None", "Comedy", "News", "Life", "Celebrities", "Sports", "Politics")) {
  data[[i]] <- factor(data[[i]], levels = c(0,1), labels = c("Não consome", "Consome"))
}
rm(i)

ggplot(na.omit(data)) +
  aes(News, Opinion) +
  geom_jitter()

ggplot(na.omit(data)) +
  aes(News, Enem.Sociology) +
  geom_jitter() +
  geom_boxplot()

shapiro.test(data$Enem.Sociology)
t.test(Enem.Sociology ~ News, data)
wilcox.test(Enem.Sociology ~ News, data)
cor.test(y = data$Enem.Sociology, x = ifelse(data$News == "Consome", 1, 0), method = "spearman")
