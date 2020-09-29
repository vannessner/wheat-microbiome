install.packages("agricolae")
install.packages("rcompanion")

library(agricolae)
library(rcompanion)

setwd(":.../Figure 2/")

# Figure 2A

core <- read.table(file = "reps_core.txt",header = TRUE, fill = FALSE, sep="\t")

# One-way analysis of variance

boxplot(Core ~ Replicates, ylab="Average number of core features", xlab="Number of replicates", data = core)
anova <- aov(Core ~ Replicates, data = core)
summary(anova)
groups <- HSD.test(anova, "Replicates", group = TRUE, console = TRUE)

# Figure 2B

core2 <- read.table(file = "combination_core.txt",header = TRUE, fill = FALSE, sep="\t")

# One-way analysis of variance

boxplot(Core ~ Combination, ylab="Average number of core features", xlab="Number of combinations", data = core2)
anova <- aov(Core ~ Combination, data = core2)
summary(anova)
groups <- HSD.test(anova, "Combination", group = TRUE, console = TRUE)
