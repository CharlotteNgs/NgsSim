###
###
###
###    Purpose:   Protocol of working through commands 
###               @ http://statlab.bio5.org/foswiki/pub/Main/RBioconductorWorkshop2012/R_BIOC_Day5.pdf
###    started:   2014/05/28 (pvr)
###
### #################################################### ###

### # unless already installed and loaded
#require(BiocInstaller)
#biocLite("Biostrings")
#require(Biostrings)
#browseVignettes("Biostrings")

## Any character
anything <- BString("Whatever you want")

## DNA sequence
dna <- DNAString("TCAACGTTGAATAGCGTACCG")
dna
## RNA sequence
rna <- RNAString(dna)
rna
## Amino Acid Sequence
aa <- AAString(translate(dna))
aa

### # alphabets
DNA_ALPHABET
DNA_BASES
RNA_ALPHABET
RNA_BASES
AA_ALPHABET

## Directory where data is stored
dataDirectory <- system.file("extdata", package = 
                               "Biostrings")
## Path to file
fastaFile <- file.path(dataDirectory, "someORF.fa")
## Read in the fasta
orf <- readDNAStringSet(fastaFile, format="fasta")
## DNAStringSet object
class(orf)
orf

### # frequencies
alphabetFrequency(orf, baseOnly=TRUE)
dinucleotideFrequency(orf)
trinucleotideFrequency(orf)

### # subsetting
## The 3rd sequence
orf3 <- orf[[3]]
orf3

## Using start and end indices
subseq(orf3, start = 1, end = 20)
## Using start index and width
subseq(orf3, start = 13, width = 10)

### # changing sequences
## Hard Mask
subseq(orf3, start = 1, end = 7) <- DNAString("NNNNNNN")
## Change C bases to T
orf3.noC <- chartr("C", "T", orf3)
alphabetFrequency(orf3.noC, baseOnly = TRUE)


### # Views of the sequence
## Create a view
view.orf <- Views(orf3, start=c(1, 35, 777, 770), 
                  width=20)
view.orf
start(view.orf)
### # create names for view.orf to be written to fasta-outputfile
myFakeOrf <- as(view.orf, "XStringSet")
myFakeOrf
myFakeIds  <- sprintf('Id: %02d, start: %2d', seq_len(length(myFakeOrf)), start(view.orf))
names(myFakeOrf) <- myFakeIds

## Invert the view
gaps(view.orf)
## Write out the view as a fasta
writeXStringSet(DNAStringSet(view.orf), "newORF.fa", format = "fasta")
writeXStringSet(myFakeOrf, "newNamedORF.fa", format = "fasta")
