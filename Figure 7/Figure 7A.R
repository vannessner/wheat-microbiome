install.packages("agricolae")
install.packages("rcompanion")

library(agricolae)
library(rcompanion)

setwd(".../Figure 7/")

# Figure 7A

#First, check if data follow a normal distribution (SHAPIRO-WILK test) (p>0.05) 
#If data is not normal check homocedasticity: homogeneity of variances (Levene's test) (p>0.05)
#If variances do not differentiate, it is ok to apply ANOVA. 
#ANOVA is robust to non-normal distributions (DOI: http://dx.doi.org/10.1027/1614-2241/a000016) 

# MEADOWS

# n = 3 pairwise comparison

m_values <- c(846,
              896,
              786,
              341,
              341,
              454,
              700,
              660,
              668,
              678,
              645,
              693,
              506,
              579,
              654,
              626,
              561,
              612)


hist (m_values)
qqnorm (m_values)
qqline (m_values, col="red")
shapiro.test (m_values)
plotNormalHistogram(m_values)

core_M <- read.table(file = "M_core.txt",header = TRUE, fill = FALSE, sep="\t")

# One-way analysis of variance

boxplot(Core ~ Treatment, ylab="Average number of core features", xlab="Cultivars", data = core_M)
anova <- aov(Core ~ Treatment, data = core_M)
summary(anova)
groups <- HSD.test(anova, "Treatment", group = TRUE, console = TRUE)



