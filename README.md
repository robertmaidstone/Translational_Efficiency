# Translational Efficiency

**Author:** Robert Maidstone

------

Code for analysing translational efficiency (TE) data collected by Dr Matthew Baxter from the University of Manchester. Compares TE to the 5' UTR length and GC content percentage.

Results published in [Cardiac mitochondrial function depends on BUD23 mediated ribosome programming. Baxter et al., Elife, 2020](https://pubmed.ncbi.nlm.nih.gov/31939735/)

### plotting.Rmd

Code for plotting graphs of translational efficiency against UTR length and GC content. Sources `UTRdefs.R` and `GC_content.R`. Produces the markdown file (and related pngs) `plotting.md`.

### UTRdefs.R

Defines the UTRs and other genomic features. In particular we're interested in the 5' UTR length. Features are defined using the `TxDb.Hsapiens.UCSC.hg38.knownGene` and `org.Hs.eg.db` packages.

### GCcontent.R

Calculates the GC content in the UTR regions. Utilised the program `twoBitToFa` to convert the genomic regions to sequences and then the R package `seqinr` to calculate the GC percentage of the sequences.

------

## Methods

Translational efficiency (TE) was compared to both the length and GC content of the 5' UTR region. 5' UTRs were defined using the `TxDb.Hsapiens.UCSC.hg38.knownGene` (Bioconductor Core Team and Bioconductor Package Maintainer, 2016) and `org.Hs.eg.db` (Carlson, 2017) R packages. Sequences of the regions were extracted using the `twoBitToFa` program from the BLAT suite (Kent, 2002) and then GC content was calculated using the `seqinr` R package (Charif and Lobry, 2007). The Pearson correlation coeeficients, and their relative significances, were calculated using `cor.test` function from the `stats` R package (R Core Team, 2017).

### References

Bioconductor Core Team and Bioconductor Package Maintainer (2016). TxDb.Hsapiens.UCSC.hg38.knownGene: Annotation package for TxDb object(s). R package version 3.4.0.
  
Carlson, M. (2017). org.Hs.eg.db: Genome wide annotation for Human. R package version 3.4.1.

Charif, D. and Lobry, J.R. (2007). SeqinR: Biological sequences retrieval and analysis. R package version 3.4.5.
  
Kent W.J. (2002). BLAT - the BLAST-like alignment tool. Genome Research, 12(4):656-64.

R Core Team (2017). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna,
  Austria. URL https://www.R-project.org/.


  
