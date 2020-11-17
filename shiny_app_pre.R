library(tidyverse)
#stats <- data %>% select(-name, -alignment) %>% names();
rx <- read_csv("derived_data/hf_rx.csv")
top10_1 <- rx %>% count(subject_id,drug)
top10_2 <- top10_1 %>% select(-n) %>% dplyr::count(drug) %>% 
  filter(n>5000)
# Test plots
ct <- data %>% filter(drug=="0.9% Sodium Chloride") %>% group_by(subject_id) %>% count(subject_id)
app <- data %>% filter(drug=="0.9% Sodium Chloride", gender=="F") %>% group_by(subject_id) %>% slice(1) %>% select(-hadm_id) %>%
             left_join(.,ct)
ggplot(app, aes(x=n))+geom_histogram(aes(fill=n), position="dodge", bins=200)stats <- rx %>% right_join(.,top10_2) %>% select(subject_id, hadm_id, gender, drug) %>% unique()
app <- stats %>% group_by(subject_id, drug, gender) %>% count()
write_csv(app, "derived_data/s_app.csv")