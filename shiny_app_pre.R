library(tidyverse)
#stats <- data %>% select(-name, -alignment) %>% names();
rx <- read_csv("derived_data/hf_rx.csv")
top10_1 <- rx %>% count(subject_id,drug)
top10_2 <- top10_1 %>% select(-n) %>% dplyr::count(drug) %>% 
  filter(n>5000)
stats <- top10_2 %>% left_join(.,rx) %>% select(subject_id, hadm_id, drug, gender) 
  #%>% rownames_to_column %>%
  #gather(drug, value, -rowname) %>% 
  #spread(rowname, value)
test <- stats %>% group_by(subject_id) %>% slice_head()
write_csv(test, "derived_data/s_app.csv")

# Test plots
ct <- data %>% filter(drug=="0.9% Sodium Chloride") %>% group_by(subject_id) %>% count(subject_id)
app <- data %>% filter(drug=="0.9% Sodium Chloride", gender=="F") %>% group_by(subject_id) %>% slice(1) %>% select(-hadm_id) %>%
             left_join(.,ct)
ggplot(app, aes(x=n))+geom_histogram(aes(fill=n), position="dodge", bins=200)