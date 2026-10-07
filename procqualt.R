library(ggplot2)
library(tidyverse)

df<-file.choose()
dat<-read.csv(df, header = T)
dat<-dat[3:nrow(dat),]

wdat<-data.frame(t(rbind(dat$Q4, dat$Q2_1_1, dat$Q2_1_2, dat$Q3_1_1, dat$Q3_1_2, dat$Q6_1_1, dat$Q6_1_2 , dat$Q7_1_1, dat$Q7_1_2, dat$Q8_1_1, dat$Q8_1_2 , dat$Q9_1_1, dat$Q9_1_2)))
colnames(wdat)<-c("gakuseki", "hr_consistent", "hr_inconsistent", "rt_consistent", "rt_inconsistent", "hr_consistent", "hr_inconsistent", "rt_consistent", "rt_inconsistent", "hr_consistent", "hr_inconsistent", "rt_consistent", "rt_inconsistent")
ldat_temp<-pivot_longer(wdat, cols=-gakuseki, names_to=c(".value","condition"),names_sep = "_")
subs<-unique(ldat_temp$gakuseki)
session<-rep(c(rep('identity1',2),rep('position',2),rep('identity2',2)), length(subs))
ldat<-cbind(ldat_temp, session)

grt<-ggplot(data=ldat, aes(x=session, y=rt, color=condition, fill=condition))+geom_boxplot()+geom_jitter(width=0.1, height=0)
grt<-grt+stat_summary(fun=mean, geom='point', color='white', position=position_dodge(width=0.7), size=2)
plot(grt)

ghit<-ggplot(data=ldat, aes(x=session, y=hr, color=condition))+geom_boxplot()+geom_jitter(width=0.1, height=0)
ghit<-g+stat_summary(fun=mean, geom='point', color='white', position=position_dodge(width=0.7), size=2)
plot(ghit)
