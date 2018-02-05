# Translational Efficiency

**Author:** Robert Maidstone

------

Code for analysing translational efficiency (TE) data collected by Dr Matthew Baxter from the University of Manchester. Compares TE to the 5' UTR length and GC content percentage.

### plotting.Rmd

Code for plotting graphs of translational efficiency against UTR length and GC content. Sources `UTRdefs.R` and `GC_content.R`. Produces the markdown file (and related pngs) `plotting.md`.

### UTRdefs.R

Defines the UTRs and other genomic features. In particular we're interested in the 5' UTR length. Features are defined using the `TxDb.Hsapiens.UCSC.hg38.knownGene` and `org.Hs.eg.db` packages.

### GCcontent.R

Calculates the GC content in the UTR regions. Utilised the program `twoBitToFa` to convert the genomic regions to sequences and then the R package `seqinr` to calculate the GC percentage of the sequences.

------

Translational efficiency (TE) was compared to both the length and GC content of the 5' UTR region. 5' UTRs were defined using the `TxDb.Hsapiens.UCSC.hg38.knownGene` and `org.Hs.eg.db` R packages. Sequences of the regions were extracted using the `twoBitToFa` program and then GC content was calculated using the `seqinr` R package.
