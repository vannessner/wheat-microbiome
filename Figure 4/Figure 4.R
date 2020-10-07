library("reshape2")
library("ggplot2")

# Figure 4

# BROADBALK

# all treatments - commonest core features (40)

setwd(":.../Figure 4/")

BB <- read.table(file = "core_all.txt", header=TRUE)

BB

BBm <- melt(BB, id.vars = c("Phylum", "Family"), variable.name ="Samples", value.name = "Relative_abundance")
BBm

gBBm <- ggplot(BBm, aes(x = Samples, y = Family)) 

gBBm + geom_point(aes(color = Phylum, size = Relative_abundance)) + 
  scale_size(range = range(BBm$Relative_abundance)) +
  theme_classic() +
  theme(axis.title = element_text(color="black", size=20, face="bold")) + 
  theme(axis.text = element_text(color="black", size=16, face="plain")) + 
  theme(legend.text = element_text(colour="black", size=16, face = "plain")) + 
  theme(legend.title = element_text(colour="black", size=20, face="bold")) 