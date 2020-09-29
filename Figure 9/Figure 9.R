install.packages("phyloseq")
install.packages("rncl")

library(phyloseq)
library(rncl)

# FIGURE 9

setwd(":.../Figure 9/")

# Commonest core features among three sites 

# Data after using qiime2 core features and then going to VENNY and checking which core features are present in all three pairwise comparisons
# Excel file (*) - "Formula common core features heritage per cultivar"
# 10 commonest core features

#import as .txt
otu_commonest_all <- read.table("otu_table.txt", header=TRUE, row.names=1)

#check which format it is
class (otu_commonest_all)

#since it is a data.frame, transform into matrix
otu_commonest_all <- as.matrix(otu_commonest_all)

#check which format it is
class (otu_commonest_all)
#
otu_commonest_all <- otu_table(otu_commonest_all,taxa_are_rows=TRUE,errorIfNULL = TRUE)
colnames(otu_commonest_all)

tree_commonest_all <- read_newick_phylo(file="tree.nwk",simplify=FALSE)

taxonomy_table_commonest_all <- read.table(file="modified_taxonomy.txt", sep="\t",header=TRUE, fill=TRUE)
row.names(taxonomy_table_commonest_all) <- taxonomy_table_commonest_all$FeatureID
taxonomy_table_commonest_all <- as.matrix(taxonomy_table_commonest_all)
taxonomy_table_commonest_all <- tax_table(taxonomy_table_commonest_all)
rownames(taxonomy_table_commonest_all)
class(taxonomy_table_commonest_all)

sample <-  read.table(file="merged_metadata.txt", header = TRUE, row.names = 1)

sample$Treatment=as.factor(sample$Treatment)
sample$Stage=as.factor(sample$Stage)
sample$Site=as.factor(sample$Site)
sample$Origin=as.factor(sample$Origin)
sample$Description=as.factor(sample$Description)
sample$Project=as.factor(sample$Project)
sample$Cultivar=as.factor(sample$Cultivar)
sample=sample_data(sample,errorIfNULL = TRUE)

review_commonest_all <- phyloseq(otu_commonest_all,taxonomy_table_commonest_all, sample, tree_commonest_all)
review_commonest_all


#Subset review data to only include Broadbalk (BB_2015), Highfield and Meadows (Heritage1) samples


review_commonest_all <- subset_samples(review_commonest_all,  Project %in% c("BB_2015","Heritage1","Highfield"))
review_commonest_all

#Subset review data to only include specific cultivars


review_commonest_all <- subset_samples(review_commonest_all,  Treatment %in% c("BA","GA","AA","2.2","5","8","16","ChidhamWhiteChaff","RedLammas","Victor","Crusoe","Avalon","Gallant"))
review_commonest_all

# TREE (Figure 9)

plot_tree(review_commonest_all, label.tips="Genus", color="Phylum", shape="Site") 




