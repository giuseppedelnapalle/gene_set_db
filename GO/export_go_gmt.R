#!/usr/bin/env Rscript
# export GO gene lists as GMT files

wd <- "/home/nikola/Project_Data/R_data/GO"
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
  go_bp_gs <- getGenesets(org, db = "go", gene.id.type = "SYMBOL", onto = "BP", mode = "GO.db")
})

# Get GO MF gene sets
system.time({
  go_mf_gs <- getGenesets(org, db = "go", gene.id.type = "SYMBOL", onto = "MF", mode = "GO.db")
})

# Write gene sets to a GMT file
writeGMT(go_bp_gs, gmt.file = file.path(dir_o, "GO_BP_hsa.gmt"))
writeGMT(go_mf_gs, gmt.file = file.path(dir_o, "GO_MF_hsa.gmt"))
