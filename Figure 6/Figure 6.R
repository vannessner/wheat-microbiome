library("reshape2")
library("ggplot2")

# Figure 6

# HIGHFIELD

# all treatments - commonest core features (190)

setwd(":.../Figure 6/")

hf <- read.table(file = "core_all.txt", header=TRUE)

hf

hfm <- melt(hf, id.vars = c("Phylum", "Family"), variable.name ="Samples", value.name = "Relative_abundance")
hfm

bhfm <- ggplot(hfm, aes(x = Samples, y = Family)) 

bhfm + geom_point(aes(color = Phylum, size = Relative_abundance)) + 
  scale_size(range = range(hfm$Relative_abundance)) +
  theme_classic() +
  theme(axis.title = element_text(color="black", size=20, face="bold")) + 
  theme(axis.text = element_text(color="black", size=16, face="plain")) + 
  theme(legend.text = element_text(colour="black", size=16, face = "plain")) + 
  theme(legend.title = element_text(colour="black", size=20, face="bold")) 


