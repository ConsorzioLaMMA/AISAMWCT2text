library(stringr)
library(XLConnect)
library(readr)
library(tm)
library(readxl)

source("AIS_aux.r")

mat_orig=as.data.frame(read_xlsx("../data/res_boll_wt.xlsx"))
mat_stat=as.data.frame(read_xlsx("../data/frequenze_totali.xlsx"))
writeWorksheetToFile("../data/counts.xls",mat_stat,"stat voyant")

words=readLines("words.txt")

f_annuale=list.files(path="../raw_data/",pattern="^P.*txt",recursive = T)
f_spr=list.files(path="../raw_data/",pattern="^SPR.*txt",recursive = T)
f_aut=list.files(path="../raw_data/",pattern="^AUT.*txt",recursive = T)
f_win=list.files(path="../raw_data/",pattern="^WIN.*txt",recursive = T)
f_sum=list.files(path="../raw_data/",pattern="^SUMM.*txt",recursive = T)

########################################################################################


ls_annuale=lapply(f_annuale, FUN=function(x) paste(readLines(x),collapse ="\n"))
f_wt=data.frame(annual=unlist(lapply(f_annuale, FUN=function(x) length(readLines(x)))))



res=list()
for ( i in 1:length(ls_annuale)){
  res[[i]]=sapply(words,function(x) str_count(tolower(as.character(ls_annuale[[i]])),x))
}
writeWorksheetToFile("..data/counts.xls",do.call("rbind",res),"annuale")
########################################################################################
#############$###########################################################################
ls_spr=lapply(f_spr, FUN=function(x) paste(readLines(x),collapse ="\n"))
f_wt$spr=unlist(lapply(f_spr, FUN=function(x) length(readLines(x))))

res=list()
for ( i in 1:length(ls_spr)){
  res[[i]]=sapply(words,function(x) str_count(tolower(as.character(ls_spr[[i]])),x))
}
writeWorksheetToFile("..data/counts.xls",do.call("rbind",res),"spring")
########################################################################################

########################################################################################
ls_win=lapply(f_win, FUN=function(x) paste(readLines(x),collapse ="\n"))
f_wt$win=unlist(lapply(f_win, FUN=function(x) length(readLines(x))))
res=list()
for ( i in 1:length(ls_win)){
  res[[i]]=sapply(words,function(x) str_count(tolower(as.character(ls_win[[i]])),x))
}
writeWorksheetToFile("..data/counts.xls",do.call("rbind",res),"winter")
########################################################################################
########################################################################################
ls_aut=lapply(f_aut, FUN=function(x) paste(readLines(x),collapse ="\n"))
f_wt$aut=unlist(lapply(f_aut, FUN=function(x) length(readLines(x))))

res=list()
for ( i in 1:length(ls_aut)){
  res[[i]]=sapply(words,function(x) str_count(tolower(as.character(ls_aut[[i]])),x))
}
writeWorksheetToFile("..data/counts.xls",do.call("rbind",res),"aut")
########################################################################################
########################################################################################
ls_sum=lapply(f_sum, FUN=function(x) paste(readLines(x),collapse ="\n"))
f_wt$sum=unlist(lapply(f_sum, FUN=function(x) length(readLines(x))))

res=list()
for ( i in 1:length(ls_sum)){
  res[[i]]=sapply(words,function(x) str_count(tolower(as.character(ls_sum[[i]])),x))
}
writeWorksheetToFile("..data/counts.xls",do.call("rbind",res),"summer")
########################################################################################
writeWorksheetToFile("..data/counts.xls", f_wt,"day_frequency")

