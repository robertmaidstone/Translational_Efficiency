#source("https://bioconductor.org/biocLite.R")
#biocLite("org.Hs.eg.db")

#library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

#txdb<-TxDb.Hsapiens.UCSC.hg19.knownGene
txdb<-TxDb.Hsapiens.UCSC.hg38.knownGene

library("org.Hs.eg.db")
library("tidyverse")

TE<-read.csv("~/translationalefficiency_data/polysome mean_ratio_1.txt",sep="\t")
TE %>% rownames() %>% as.character() -> gene
crgenes<-unlist(mget(x=gene,envir=org.Hs.egENSEMBL2EG,ifnotfound = NA))
head(crgenes[is.na(crgenes)]) #genes not converted to entrez id
TE<-TE[!is.na(crgenes),] 
crgenes<-crgenes[!is.na(crgenes)] #remove NAs
TE<-TE[(crgenes %in% (transcriptsBy(txdb, "gene") %>% names) ),] 
crgenes<-crgenes[(crgenes %in% (transcriptsBy(txdb, "gene") %>% names) )] #only genes in db
TE<-cbind(TE,crgenes,rownames(TE))

txbygene <- transcriptsBy(txdb, "gene")[crgenes] ## subset on colorectal genes
map <- relist(unlist(txbygene, use.names=FALSE)$tx_id, txbygene)
map

cds <- cdsBy(txdb, "tx")
threeUTR <- threeUTRsByTranscript(txdb)
fiveUTR <- fiveUTRsByTranscript(txdb)

txid <- unlist(map, use.names=FALSE)
cds <- cds[names(cds) %in% txid]
threeUTR <- threeUTR[names(threeUTR) %in% txid]
fiveUTR <- fiveUTR[names(fiveUTR) %in% txid]

fiveUTR %>% unlist %>% ranges() %>% width() %>% plot()

names(fiveUTR)

tibble(GENES=names(unlist(map)),TRANS=unlist(map)) -> map_tibb

merge(x=map_tibb,y=TE,by.x="GENES",by.y="crgenes",all.x=TRUE) -> TE_map

fiveUTR_length <- tibble(TRANS=names(unlist(fiveUTR)),LENGTH=width(unlist(fiveUTR)),START=start(unlist(fiveUTR)),END=end(unlist(fiveUTR)),STRAND=as.character(strand(unlist(fiveUTR))),CHR=as.character(seqnames(unlist(fiveUTR))))

merge(x=fiveUTR_length,y=TE_map,by.y="TRANS",by.x="TRANS",all.x=TRUE) %>% as_tibble -> TE_UTRlength

TE_UTRlength %>% filter(!is.na(con_ratio)) %>% 
  mutate(ratio=con_ratio - merm1_ratio)-> TE_UTRlength

TE_UTRlength %>%
  ggplot(aes(x=LENGTH,y=ratio))+geom_point(alpha=0.1) +theme_classic() + scale_x_log10()


TE_UTRlength %>% filter(ratio>1) %>%
  mutate(seqnames=CHR) %>%
  mutate(starts=START) %>%
  mutate(ends=END) %>%
  mutate(strands=STRAND) %>%
  mutate(names=paste(`rownames(TE)`,TRANS,LENGTH,sep=".")) %>%
  mutate(scores=".") %>%
  dplyr::select(seqnames,starts,ends,names,scores,strands) %>%
  as.data.frame() %>%
  write.table(file="~/translationalefficiency_data/UTR_decreased.bed", quote=F, sep="\t", row.names=F, col.names=F)

TE_UTRlength %>% filter(ratio<(-1)) %>%
  mutate(seqnames=CHR) %>%
  mutate(starts=START) %>%
  mutate(ends=END) %>%
  mutate(strands=STRAND) %>%
  mutate(names=paste(`rownames(TE)`,TRANS,LENGTH,sep=".")) %>%
  mutate(scores=".") %>%
  dplyr::select(seqnames,starts,ends,names,scores,strands) %>%
  as.data.frame() %>%
  write.table(file="~/translationalefficiency_data/UTR_increased.bed", quote=F, sep="\t", row.names=F, col.names=F)

TE_UTRlength %>% filter((ratio>(-1)) &  (ratio<1))%>%
  mutate(seqnames=CHR) %>%
  mutate(starts=START) %>%
  mutate(ends=END) %>%
  mutate(strands=STRAND) %>%
  mutate(names=paste(`rownames(TE)`,TRANS,LENGTH,sep=".")) %>%
  mutate(scores=".") %>%
  dplyr::select(seqnames,starts,ends,names,scores,strands) %>%
  as.data.frame() %>%
  write.table(file="~/translationalefficiency_data/UTR_null.bed", quote=F, sep="\t", row.names=F, col.names=F)

TE_UTRlength %>% 
  mutate(seqnames=CHR) %>%
  mutate(starts=START) %>%
  mutate(ends=END) %>%
  mutate(strands=STRAND) %>%
  mutate(names=paste(`rownames(TE)`,TRANS,LENGTH,sep=".")) %>%
  mutate(scores=".") %>%
  dplyr::select(seqnames,starts,ends,names,scores,strands) %>%
  as.data.frame() %>%
  write.table(file="~/translationalefficiency_data/UTR_all.bed", quote=F, sep="\t", row.names=F, col.names=F)




