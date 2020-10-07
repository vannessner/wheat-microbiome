install.packages("agricolae")
install.packages("rcompanion")

library(agricolae)
library(rcompanion)

setwd(":.../Figure 3/")

# Figure 3A

#First, check if data follow a normal distribution (SHAPIRO-WILK test) (p>0.05) 
#If data is not normal check homocedasticity: homogeneity of variances (Levene's test) (p>0.05)
#If variances do not differentiate, it is ok to apply ANOVA. 
#ANOVA is robust to non-normal distributions (DOI: http://dx.doi.org/10.1027/1614-2241/a000016) 

# BROADBALK

# n = 28 pairwise comparison

bb_values <- c(545,
            551,
            551,
            584,
            547,
            568,
            549,
            489,
            495,
            518,
            506,
            523,
            518,
            528,
            541,
            532,
            511,
            518,
            543,
            536,
            533,
            532,
            541,
            527,
            526,
            524,
            528,
            521, 
            549,
            459,
            457,
            555,
            507,
            505,
            477,
            465,
            471,
            589,
            523,
            548,
            512,
            406,
            488,
            437,
            433,
            412,
            495,
            424,
            421,
            420,
            527,
            553,
            512,
            495,
            461,
            466,
            429,
            404,
            491,
            402,
            474,
            558,
            570,
            391,
            433,
            373,
            429,
            496,
            490,
            430,
            392,
            420,
            487,
            462,
            431,
            492,
            549,
            558,
            405,
            449,
            455,
            541,
            540,
            645,
            485,
            406,
            423,
            390,
            473,
            412,
            438,
            440,
            492,
            431,
            503,
            451,
            504,
            409,
            366,
            434,
            372,
            409,
            397,
            463,
            402,
            452,
            414,
            387,
            384,
            426,
            466,
            413)

# The central limit theorem tells us that no matter what distribution things have, 
# the sampling distribution tends to be normal if the sample is large enough (n > 30)
# http://www.sthda.com/english/wiki/normality-test-in-r

core_BB <- read.table(file = "BB_core.txt",header = TRUE, fill = FALSE, sep="\t")

# One-way analysis of variance

boxplot(Core ~ Treatment, ylab="Average number of core features", xlab="Fertilization regime", data = core_BB)
anova <- aov(Core ~ Treatment, data = core_BB)
summary(anova)
groups <- HSD.test(anova, "Treatment", group = TRUE, console = TRUE)

