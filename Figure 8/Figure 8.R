library("reshape2")
library("ggplot2")

# Figure 8

# MEADOWS

# all cultivars - commonest core features (124)

#####################

setwd(":.../Figure 8/")

h <- read.table(file = "core_all.txt", header=TRUE)
h

hm <- melt(h, id.vars = c("Phylum", "Family"), variable.name ="Samples", value.name = "Relative_abundance")
hm

bhm <- ggplot(hm, aes(x = Samples, y = Family)) 

bhm + geom_point(aes(color = Phylum, size = Relative_abundance)) + 
  scale_size(range = range(hm$Relative_abundance)) +
  theme_classic() +
  theme(axis.title = element_text(color="black", size=20, face="bold")) + 
  theme(axis.text = element_text(color="black", size=16, face="plain")) + 
  theme(legend.text = element_text(colour="black", size=16, face = "plain")) + 
  theme(legend.title = element_text(colour="black", size=20, face="bold")) 