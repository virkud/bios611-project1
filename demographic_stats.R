library(tidyverse)

#Setup datasets from Datasetup.R
all_dem <- read_csv("~/derived_data/all_dem.csv")
hf_dem<- read_csv("~/derived_data/hf_dem.csv")
hfevents <- read_csv("~/derived_data/hfevents.csv") %>% select(-`hadm_id:1`, -`subject_id:1`)

#What do HF patients look like:
p1_eth <- hf_dem %>% mutate()
  group_by(ethnicity) %>% 
  summarise(mean=mean(anchor_age), min=min(anchor_age), max=max(anchor_age))

p1 <- ggplot(p1_eth) +
  geom_bar( aes(x=ethnicity, y=mean), stat="identity", fill="skyblue", alpha=0.7) +
  geom_errorbar(aes(x=ethnicity, ymin=min, ymax=max), width=0.4, colour="orange", alpha=0.9, size=1.3) +
  title ("Average age by ethnicity")
ggsave("figures/eth_sex.png",plot=p1)
p1