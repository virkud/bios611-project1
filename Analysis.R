library(tidyverse)
library(ggplot2)
library(gridExtra)
library(reshape2)
library(plyr)

hf_pat <-  read_csv("~/derived_data/hf_dem.csv")
all_pat <- read_csv("~/derived_data/all_dem.csv")

hf_pat1 <- hf_pat %>% 
            group_by(anchor_age, gender) %>% 
            tally(name="pop")
hf_pat2 <- hf_pat1 %>% mutate (Population = ifelse(gender=="M",hf_pat1$pop*-1,hf_pat1$pop)) %>% 
            select(anchor_age, gender, Population) %>% 
            dplyr::rename(Age=anchor_age, Sex=gender)

p1 <- ggplot(hf_pat2, aes(x = Age, y = Population, fill = Sex)) + 
  ggtitle("Population pyramid of Heart Failure ICU patients") +
  geom_bar(data=subset(hf_pat2, Sex == "F"), stat = "identity") + 
  geom_bar(data=subset(hf_pat2, Sex == "M"), stat = "identity") +
  scale_y_continuous(breaks = seq(-700, 700, 100), 
                     labels = paste0(as.character(c(seq(700, 0, -100), seq(100, 700, 100))))) + 
  coord_flip() + 
  scale_fill_brewer(palette = "Set1") + 
  theme_bw()
ggsave("figures/hf_age_sex.png",plot=p1)
p1

all_pat1 <- all_pat %>% 
  group_by(anchor_age, gender) %>% 
  tally(name="pop")
all_pat2 <- all_pat1 %>% mutate (Population = ifelse(gender=="M",hf_pat1$pop*-1,hf_pat1$pop)) %>% 
  select(anchor_age, gender, Population) %>% 
  dplyr::rename(Age=anchor_age, Sex=gender)

p2 <- ggplot(all_pat2, aes(x = Age, y = Population, fill = Sex)) + 
  ggtitle("Population pyramid of all ICU patients") +
  geom_bar(data=subset(all_pat2, Sex == "F"), stat = "identity") + 
  geom_bar(data=subset(all_pat2, Sex == "M"), stat = "identity") +
  scale_y_continuous(breaks = seq(-700, 700, 100), 
                     labels = paste0(as.character(c(seq(700, 0, -100), seq(100, 700, 100))))) + 
  coord_flip() + 
  scale_fill_brewer(palette = "Set1") + 
  theme_bw()
ggsave("figures/all_age_sex.png",plot=p2)
p2
