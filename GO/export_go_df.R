#!/usr/bin/env Rscript
# export GO gene lists

wd <- "/home/nikola/Project_Data/R_data/GO"
setwd(wd)

dir_o <- paste(wd, "output", sep = "/")
if (!dir.exists(dir_o)) {
    dir.create(dir_o)
}

# Load the necessary libraries
library(GO.db)
library(org.Hs.eg.db)

# Get all GO terms
all_GO_terms <- as.list(GOTERM)

# Filter for Biological Process (BP) and Molecular Function (MF) terms
BP_terms <- all_GO_terms[sapply(all_GO_terms, function(x) x@Ontology == "BP")]
MF_terms <- all_GO_terms[sapply(all_GO_terms, function(x) x@Ontology == "MF")]

# Get gene symbols for each GO term
get_gene_symbols <- function(go_id) {
  gene_ids <- as.character(org.Hs.egGO2ALLEGS[[go_id]])
  gene_symbols <- as.character(org.Hs.egSYMBOL[gene_ids])
  return(gene_symbols)
}

# Get gene symbol lists for all GO BP and GO MF gene sets
BP_gene_symbols <- lapply(names(BP_terms), get_gene_symbols) # very slow
MF_gene_symbols <- lapply(names(MF_terms), get_gene_symbols)

# Name the lists with the GO term IDs
names(BP_gene_symbols) <- names(BP_terms)
names(MF_gene_symbols) <- names(MF_terms)
