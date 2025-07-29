library(dplyr)
library(ggplot2)

data           <- read.csv("data.csv")
data           <- data[,c(3, 6:8, 24:35, 57:75)]
colnames(data) <- c("Year", "Age", "Gender", "Race",
                    "Main.ICT", "Main.Media", "Influence.ICT", "Influence.School",
                    "Confidence.SocialNetwork", "Confidence.TVRadio", "Confidence.Family", "Confidence.Peers", "Confidence.Newspaper", "Confidence.DigitalNewspaper", "Confidence.Teachers", "Confidence.Religion",
                    "Work.Geography", "Work.History", "Work.Philosophy", "Work.Sociology",
                    "Enem.Geography", "Enem.History", "Enem.Philosophy", "Enem.Sociology",
                    "Life.Geography", "Life.History", "Life.Philosophy", "Life.Sociology",
                    "Experience.Geography", "Experience.History", "Experience.Philosophy", "Experience.Sociology",
                    "Sociology.Rating", "Sociology.Positive", "Sociology.Negative")


