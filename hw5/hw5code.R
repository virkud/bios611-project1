library(tidyverse)
library(gbm)
library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot)
q1dset <- read_csv("hw5/q1dset.csv")
q2dset <- read_csv("hw5/q2dset.csv")
#Q1: Repeat your GBM model. Contrast your results with the results for the
#previous exercise.
set.seed(2020)
N <- length(q1dset$Gender)
index.train <- sample(N, N*2/3)
dat <- q1dset %>% mutate(female = if_else(Gender=="Female",1,0))
train <- dat[index.train,]
test <- dat[-index.train,]
model.gbm <- gbm(female ~ Height +
                   Weight,
                 distribution="bernoulli",
                 train,
                 n.trees = 200,
                 interaction.depth = 5,
                 shrinkage=0.1)
summary(model.gbm)
test$female.p <- predict(model.gbm, test, type="response")
ggplot(test, aes(female.p)) + geom_density()
c(sum((test$female.p>0.5)==test$female)/nrow(test),
  sum(FALSE==test$female)/nrow(test))

#Examine the dataset for any irregularities. 
#Make the case for filtering out a subset of rows (or for not doing so).
summary(q2dset)
count
q2dset %>% group_by(Alignment) %>% tally()
q2dset %>% group_by(Name) %>% 
  filter(n()>1)
missing<-q2dset %>% filter(is.na(Alignment))
q2dset2<-q2dset %>% filter(!is.na(Alignment))  
#Perform a principal component analysis on the numerical columns of this data.
#How many components do we need to get 85% of the variation in the data set?
pca <- prcomp(q2dset2%>% select(-Name,-Alignment,-Total))
pca <- prcomp(q2dset2 %>% select(-Name,-Alignment), center = TRUE,scale. = TRUE)
summary(pca)
#Do we need to normalize these columns or not?
#Is the "total" column really the total of the values in the other columns?
discrep <- q2dset2 %>% mutate(test=Total-Intelligence-Strength-Speed-Durability-Power
                             -Combat) %>% filter(test>0)
#Should we have included in the PCA? What do you expect about the largest principal components and the total column? Remember, a given principal component corresponds to a weighted combination of the original variables.
pca2 <- prcomp(q2dset2 %>% select(-Name,-Alignment,-Total), center = TRUE,scale. = TRUE)
summary(pca2)
#Make a plot of the two largest components. Any insights?
transformed <- do.call(rbind, Map(function(row){
  v <- solve(pcs$rotation) %*% c(data$x[row], data$y[row], data$z[row]);
  tibble(x=v[1],y=v[2],z=v[3]);    
}, seq(nrow(data))))
p<-ggplot(transformed,aes(x,y)) + geom_point(); p;
p1<-ggbiplot(pca2)
ggsave("hw5/pca.png",plot=p1)