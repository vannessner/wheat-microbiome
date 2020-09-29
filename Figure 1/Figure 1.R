
library(ggplot2)
library(phyloseq)
library(vegan)
library(rncl)

# FIGURE 1

setwd(":.../Figure 1/")

#import as .txt
otu = read.table("otu_table.txt", header=TRUE, row.names=1)
#check which format it is
class (otu)
#since it is a data.frame, transform into matrix
otu=as.matrix(otu)
#check which format it is
class (otu)
#
otu_table=otu_table(otu,taxa_are_rows=TRUE,errorIfNULL = TRUE)
colnames(otu_table)

tree=read_newick_phylo(file="tree.nwk",simplify=FALSE)

taxonomy=read.table(file="taxonomy.txt", sep="\t",header=TRUE, fill=TRUE)
row.names(taxonomy) <- taxonomy$ASVs
taxonomy=as.matrix(taxonomy)
taxonomy=tax_table(taxonomy)
rownames(taxonomy)

sample = read.table(file="merged_metadata.txt", sep="\t", header = TRUE, row.names = 1)
sample$Niche=as.factor(sample$Niche)
class(sample$Niche)
sample$Date=as.factor(sample$Date)
sample$Year=as.factor(sample$Year)
sample$Treatment=as.factor(sample$Treatment)
sample$Stage=as.factor(sample$Stage)
sample$Site=as.factor(sample$Site)
sample$Origin=as.factor(sample$Origin)
sample$Description=as.factor(sample$Description)
sample$Project=as.factor(sample$Project)
sample$Cultivar=as.factor(sample$Cultivar)
sample=sample_data(sample,errorIfNULL = TRUE)

review <- phyloseq(otu_table,taxonomy, sample, tree)
review

#Remove Chloroplast sequences

review <- subset_taxa(review, (Order!= "Chloroplast"))

review

#Remove Mitochondria sequences

review <- subset_taxa(review, (Family!= "Mitochondria"))

review


#Subset review data to only include Broadbalk (BB_2015), Highfield and Meadows (Heritage1) samples


new_review <- subset_samples(review,  Project %in% c("BB_2015","Heritage1","Highfield"))
new_review

#Subset review data to only include specific cultivars


new_review <- subset_samples(new_review,  Treatment %in% c("BA","GA","AA","2.2","5","8","16","ChidhamWhiteChaff","RedLammas","Victor","Crusoe","Avalon","Gallant"))
new_review

relative_new_review <- transform_sample_counts(new_review, function(x) x/sum(x))

pcoa_bray <- ordinate(relative_new_review, "PCoA", "bray")
plot_ordination (relative_new_review, pcoa_bray, type="samples", color="Site", title="PCoA") 

#PERMANOVA

#calculate bray curtis distance matrix
relative_new_review_bray <- phyloseq::distance(relative_new_review, method="bray")

#make a review frame from the relative abundance review
relative_new_reviewdf <- data.frame(sample_data(relative_new_review))

#adonis test (Test adonis on Treatment and Niche and interaction of both (*). If I did not want to test the interaction, choose +). 
adonis(relative_new_review_bray ~ Site*Treatment, data=relative_new_reviewdf)

