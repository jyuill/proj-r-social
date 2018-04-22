## initial explore plots

library(tidyverse)
library(scales)

F.fbplot <- read_csv("data-input/F-fb.csv")

ggplot(F.fbplot, aes(x=Interactions, y=`Total Impressions`))+geom_point()+
  scale_x_continuous(labels=comma)+
  scale_y_continuous(labels=comma)+
  theme_classic()+
  geom_smooth(method='lm')
  
ggplot(F.fbplot, aes(x=Comments, y=`Total Impressions`))+geom_point()+
  scale_x_continuous(labels=comma)+
  scale_y_continuous(labels=comma)+
  theme_classic()+
  geom_smooth(method='lm')

ggplot(F.fbplot, aes(x=Comments))+geom_histogram()+
  scale_x_continuous(labels=comma)+
  theme_classic()+
  geom_vline(xintercept=mean(F.fbplot$Comments))