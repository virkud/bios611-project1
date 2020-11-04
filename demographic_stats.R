library(tidyverse)

#Setup datasets from Datasetup.R
all_dem <- read_csv("derived_data/all_dem.csv")
hf_dem<- read_csv("derived_data/hf_dem.csv")

#What do HF patients look like:
summary(hf_dem)
hf_dem %>% count(gender) %>%  mutate(prop = 100*prop.table(n))
hf_dem %>% count(ethnicity) %>%  mutate(prop = 100*prop.table(n))
hf_dem %>% count(marital_status) %>%  mutate(prop = 100*prop.table(n))
hf_dem %>% count(language) %>%  mutate(prop = 100*prop.table(n))
p1_eth <- hf_dem %>%
  group_by(ethnicity)%>%
  summarise(mean=mean(anchor_age), min=min(anchor_age), max=max(anchor_age)) 
  
plot_eth <- ggplot(p1_eth) +
  geom_bar(aes(x=ethnicity, y=mean), stat="identity", fill="skyblue", alpha=0.7) +
  geom_errorbar(aes(x=ethnicity, ymin=min, ymax=max), width=0.4, colour="orange", alpha=0.9, size=1.3) +
  xlab("Ethnicity") +
  ylab("Average age") +
  scale_x_discrete(labels = c('AI/AN', 'Asian','Black','HL','Other','Unable','Unknown','White'))+
  ggtitle("Average age by ethnicity")
ggsave("figures/eth_sex.png",plot=plot_eth)
plot_eth