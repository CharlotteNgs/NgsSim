###
###
###
###   Purpose:   Protocol and script to produce reference genome into one FASTA file
###   started:   2014/05/21 (pvr)
###
### ################################################################################## ###

setwd("C:/Daten/GitHub/NgsSim/data/yeast/refgen")

### # load Bsgenome to work with genomes in BioC
library(Biostrings)
library(ShortRead)
library(BSgenome)

### # check which yeast genomes are available
sYestGenomeSearchName  <- "BSgenome.Scerevisiae"
vAvGen <- available.genomes()
vYeastGen <- vAvGen[grep(sYestGenomeSearchName, vAvGen)]
cat(" *** Available yeast genomes: \n")
print(vYeastGen)
#[1] "BSgenome.Scerevisiae.UCSC.sacCer1" "BSgenome.Scerevisiae.UCSC.sacCer2"
#[3] "BSgenome.Scerevisiae.UCSC.sacCer3"

### # choose the last one and load it
sYeastGen <- vYeastGen[3]
cat(" *** Chosen yeast genomes: \n")
print(sYeastGen)
library(package=sYeastGen, character.only = TRUE)

### # use short reads
dnaStringSet <- DNAStringSet(Scerevisiae[[1]])
writeFasta(dnaStringSet, file="refGenYeast.fasta")