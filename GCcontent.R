library(tidyverse)

read.csv("~/translationalefficiency_data/UTR_all.bed",sep="\t",header = F) %>%
#read.csv("~/Documents/Matt/trans_effic/input/UTR_down_hg38.bed",sep="\t",header = F) %>%
  mutate(V7=paste0(V1,":",V2,"-",V3)) %>%
  filter(V2!=V3) %>%
  dplyr::select(V7) %>%
  .[[1]] -> ttt
  write.table(ttt,"~/translationalefficiency_data/seqUTRall.bed",sep=",",row.names = F,quote = F,col.names = FALSE)

############## ~/Downloads/twoBitToFa -seqList=~/translationalefficiency_data/seqUTRall.bed -noMask ~/Downloads/hg38.2bit ~/translationalefficiency_data/seqs_all.fa


seqs<-read.csv("~/translationalefficiency_data/seqs_all.fa",header = F,colClasses = "character")

####################################################

 library(seqinr)
ddd<-seqs$V1#[1:10000]

ddd %>% head
(grepl(">",ddd)) %>% which -> ddd_splits
GC_count<-c()
for(i in 1:(length(ddd_splits)-1)){
  paste(ddd[(ddd_splits[i]+1):(ddd_splits[i+1]-1)],collapse = "") %>% s2c %>% GC -> GC_count[i]
}
paste(ddd[(ddd_splits[length(ddd_splits)]+1):length(ddd)],collapse = "") %>% s2c %>% GC -> GC_count[length(ddd_splits)]

hist(GC_count)






