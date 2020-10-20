library(tidyverse)
library(dplyr)
library(ggplot2)

hf_pat <-  read_csv("derived_data/hf_dem.csv")
all_pat <- read_csv("derived_data/all_dem.csv")

hf_pat1 <- hf_pat %>%
            dplyr::count(anchor_age, gender)

hf_pat2 <- hf_pat1 %>% mutate (Population = ifelse(gender=="M",hf_pat1$n*-1,hf_pat1$n)) %>% 
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
  dplyr::count(anchor_age, gender)
all_pat2 <- all_pat1 %>% mutate(Population = ifelse(gender=="M",all_pat1$n*-1,all_pat1$n)) %>% 
  select(anchor_age, gender, Population) %>% 
  dplyr::rename(Age=anchor_age, Sex=gender)

p2 <- ggplot(all_pat2, aes(x = Age, y = Population, fill = Sex)) + 
  ggtitle("Population pyramid of all ICU patients (with newborns)") +
  geom_bar(data=subset(all_pat2, Sex == "F"), stat = "identity") + 
  geom_bar(data=subset(all_pat2, Sex == "M"), stat = "identity") +
  scale_y_continuous(breaks = seq(-30000, 30000, 10000), 
                     labels = paste0(as.character(c(seq(30000, 0, -10000), seq(10000, 30000, 10000))))) + 
  coord_flip() + 
  scale_fill_brewer(palette = "Set1") + 
  theme_bw()
ggsave("figures/all_age_sex_new.png",plot=p2)
p2

all_pat3 <- all_pat2 %>% dplyr::filter(Age>0)

p3 <- ggplot(all_pat3, aes(x = Age, y = Population, fill = Sex)) + 
  ggtitle("Population pyramid of all ICU patients (without newborns)") +
  geom_bar(data=subset(all_pat3, Sex == "F"), stat = "identity") + 
  geom_bar(data=subset(all_pat3, Sex == "M"), stat = "identity") +
  scale_y_continuous(breaks = seq(-6000, 6000, 1000), 
                     labels = paste0(as.character(c(seq(6000, 0, -1000), seq(1000, 6000, 1000))))) + 
  coord_flip() + 
  scale_fill_brewer(palette = "Set1") + 
  theme_bw()
ggsave("figures/all_age_sex.png",plot=p3)
p3
