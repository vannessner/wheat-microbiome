install.packages("agricolae")
install.packages("rcompanion")

library(agricolae)
library(rcompanion)

setwd(".../Figure 5/")
getwd()

# Figure 5A

#First, check if data follow a normal distribution (SHAPIRO-WILK test) (p>0.05) 
#If data is not normal check homocedasticity: homogeneity of variances (Levene's test) (p>0.05)
#If variances do not differentiate, it is ok to apply ANOVA. 
#ANOVA is robust to non-normal distributions (DOI: http://dx.doi.org/10.1027/1614-2241/a000016) 

# HIGHFIELD

# n = 3 pairwise comparison

hf_values <- c (709,
                732,
                864,
                631,
                593,
                567,
                821,
                850,
                846)

hist (hf_values)
qqnorm (hf_values)
qqline (hf_values, col="red")
shapiro.test (hf_values)
plotNormalHistogram(hf_values)

core_HF <- read.table(file = "HF_core.txt",header = TRUE, fill = FALSE, sep="\t")

# One-way analysis of variance

boxplot(Core ~ Treatment, ylab="Average number of core features", xlab="Land use", data = core_HF)
anova <- aov(Core ~ Treatment, data = core_HF)
summary(anova)
groups <- HSD.test(anova, "Treatment", group = TRUE, console = TRUE)

