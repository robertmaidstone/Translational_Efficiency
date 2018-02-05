# Translational Efficiency

**Author:** Robert Maidstone

------

Code for analysising translational efficiency (TE) data collected by Dr Matthew Baxter from the University of Manchester. Compares TE to the 5' UTR length and GC content percentage.

### plotting.Rmd

Code for plotting graphs of translational efficiency against UTR length and GC content. Sources `UTRdefs.R` and `GC_content.R`. Produces the markdown file (and related pngs) `plotting.md`.

### UTRdefs.R

Defines the UTRs and other genomic features. In particular we're interested in the 5' UTR length. Features are defined using the `TxDb.Hsapiens.UCSC.hg38.knownGene` and `org.Hs.eg.db packages`.

### GCcontent.R

Calculates the GC content in the UTR regions. Utilised the program `twoBitToFa` to convert the genomic regions to sequences and then the R package `seqinr` to calculate the GC percentage of the sequences.
