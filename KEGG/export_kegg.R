#!/usr/bin/env Rscript
# export KEGG gene lists

wd <- "/home/nikola/Project_Data/R_data/KEGG"
setwd(wd)

dir_o <- paste(wd, "output", sep = "/")
if (!dir.exists(dir_o)) {
    dir.create(dir_o)
}

library(KEGGREST)
library(org.Hs.eg.db)
library(dplyr)

# res <- keggLink("pathway", "hsa") ## KEGG pathways linked from each of ## the human genes equivalent to 'get.genes.by.pathway' in KEGGSOAP
path_entrezid_hsa  <- keggLink("pathway", "hsa") %>%
tibble(pathway = ., entrezid = sub("hsa:", "", names(.)))
path_entrezid_hsa$pathway <- sub("path:", "", path_entrezid_hsa$pathway)

# map ENTREZID to SYMBOL and ENSEMBL identifiers
kegg_genes_hsa <- path_entrezid_hsa %>%
    mutate(
        symbol = mapIds(org.Hs.eg.db, entrezid, "SYMBOL", "ENTREZID"),
        ensembl = mapIds(org.Hs.eg.db, entrezid, "ENSEMBL", "ENTREZID")
    )
# 'select()' returned 1:1 mapping between keys and columns
# 'select()' returned 1:many mapping between keys and columns

# get KEGG pathway descriptions
kegg_desc_hsa <- keggList("pathway", "hsa") %>% 
    tibble(pathway = names(.), description = .)

# write tables
write.csv(kegg_desc_hsa, file = file.path(dir_o, "KEGG_descriptions_hsa.csv"), row.names = FALSE)
write.csv(kegg_genes_hsa, file = file.path(dir_o, "KEGG_genes_hsa.csv"), row.names = FALSE)
