#!/usr/bin/env Rscript
# export KEGG gene lists as GMT file

wd <- "/home/nikola/Project_Data/R_data/KEGG"
setwd(wd)

dir_o <- paste(wd, "output", sep = "/")
if (!dir.exists(dir_o)) {
    dir.create(dir_o)
}

# Load the library
library(EnrichmentBrowser)

org <- "hsa"

# Get GO BP gene sets
system.time({
  kegg_gs <- getGenesets(org, db = "kegg", gene.id.type = "SYMBOL")
})

# Write gene sets to a GMT file
writeGMT(kegg_gs, gmt.file = file.path(dir_o, "KEGG_hsa.gmt"))
