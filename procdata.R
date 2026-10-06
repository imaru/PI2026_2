library(jsonlite)
library(tidyverse)
library(ggplot2)
library(readr)
library(tcltk)

files <- tk_choose.files(caption = "ファイルを選択してください", multi = TRUE)

dat<-data.frame()

c1<-grep('i1.json', files)
c2<-grep('i2.json', files)
c3<-grep('p.json', files)

dat<-data.frame()
for (i in 1:length(files)){
  #dat<-jsonlite::read_json(paste0(pt,'\\',files[i]), simplifyVector = TRUE)
  rawdat<-jsonlite::read_json(files[i], simplifyVector = TRUE)
  
  dat2<-rawdat[!is.na(rawdat$task),]
  datrt<-dat2[dat2$task=='response',]
  dat[i,1]<-rawdat[rawdat$trial_type=='survey-text',]$response[[1]]$Q0
  dat[i,2]<-datrt[1,]$condition
  dat[i,3]<-mean(datrt[datrt$cond==0 & datrt$correct,]$rt, na.rm=T)
  dat[i,4]<-mean(datrt[datrt$cond==1 & datrt$correct,]$rt, na.rm=T)
  dat[i,5]<-sum(datrt$cond==0 & datrt$correct)/sum(datrt$cond==0)
  dat[i,6]<-sum(datrt$cond==1 & datrt$correct)/sum(datrt$cond==1)
  
}
colnames(dat)<-c('gakuseki','session','rt_consistent','rt_inconsistent','hr_consistent','hr_inconsistent')


ldat<-pivot_longer(dat,cols=c('rt_consistent','rt_inconsistent','hr_consistent','hr_inconsistent'), names_to=c(".value","condition"),names_sep = "_")

ldldat<-pivot_longer(dat,cols=c('rt.consistent','rt.inconsistent','hr.consistent','hr.inconsistent'), names_prefix = c('rt.','hr.'), values_to = c('rt','hr'))

grt<-ggplot(data=ldat, aes(x=session, y=rt, color=condition))+geom_boxplot()+geom_jitter(width=0.1, height=0)
plot(grt)

ghit<-ggplot(data=ldat, aes(x=session, y=hr, color=condition))+geom_boxplot()+geom_jitter(width=0.1, height=0)
plot(ghit)

ldatrt<-ldat[,1:4]
ldathr<-ldat[,c(1,2,3,5)]

source('./anovakun_489.txt')
anovakun(ldatrt, 'sAB', 3, 2, long=T)
anovakun(ldathr, 'sAB', 3, 2, long=T)
