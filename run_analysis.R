library('dplyr')

Test <- read.csv('UCI HAR Dataset/test/X_test.txt',sep='',header=F)
Testlabels <- read.csv('UCI HAR Dataset/test/y_test.txt',sep='',header=F)
Testsubjects <- read.csv('UCI HAR Dataset/test/subject_test.txt',sep='',header=F)
Testlabels <- rename(Testlabels,Activity = V1)
Testsubjects <- rename(Testsubjects,Subjectnumber=V1)
Test$index <- 1:length(Test[,1])
Testlabels$index <- 1:length(Testlabels[,1])
Testsubjects$index <- 1:length(Testsubjects[,1])
Labeledtest <- Test %>% merge(Testlabels,by = 'index') %>% merge(Testsubjects,by = 'index')

Train <- read.csv('UCI HAR Dataset/train/X_train.txt',sep='',header=F)
Trainlabels <- read.csv('UCI HAR Dataset/train/y_train.txt',sep='',header=F)
Trainsubjects <- read.csv('UCI HAR Dataset/train/subject_train.txt',sep='',header=F)
Trainlabels <- rename(Trainlabels,Activity = V1)
Trainsubjects <- rename(Trainsubjects,Subjectnumber=V1)
Train$index <- 1:length(Train[,1])
Trainlabels$index <- 1:length(Trainlabels[,1])
Trainsubjects$index <- 1:length(Trainsubjects[,1])
Labeledtrain <- Train %>% merge(Trainlabels,by = 'index') %>% merge(Trainsubjects,by = 'index')

convertActivities <- function(activity) {
    switch(as.character(activity), 
           '1'="Walking",
           '2' = 'WalkingUpstairs',
           '3' = 'WalkingDownstairs',
           '4' = 'Sitting',
           '5' = 'Standing',
           '6' = 'Laying')
}
Labeledtest$Activity <- sapply(Labeledtest$Activity,convertActivities)
Labeledtrain$Activity <- sapply(Labeledtrain$Activity,convertActivities)

Merged <- merge(Labeledtest,Labeledtrain,all=T)

SdMean <- sapply(select(Merged,-c('index','Activity','Subjectnumber')),function(x) c(sd=sd(x), mean=mean(x)))

meanByActivitySubject <- function(column) {
    df <- tapply(column,list(Merged$Activity,Merged$Subjectnumber),mean) %>% data.frame()
    tempnames <- names(df)
    df <- rename(df,Subject=tempnames)
    df
 
}
MeanByGroup <- lapply(select(Merged,-c('index','Activity','Subjectnumber')),meanByActivitySubject)


for (i in 1:length(MeanByGroup)) {
    if (i==1) {
        df <- MeanByGroup[[i]]
        df <- mutate(df,Element=names(MeanByGroup[i]),Activity=row.names(MeanByGroup[[i]])) 
    }
    else {
        df <- MeanByGroup[[i]] %>% mutate(Element=names(MeanByGroup[i]),Activity=row.names(MeanByGroup[[i]])) %>% merge(df,all=T)
    }
}

levels <- paste('V',1:length(MeanByGroup),sep='')
df$Element <- factor(df$Element,levels)
df <- select(df[order(df$Activity,df$Element),],c('Activity','Element',1:30))
