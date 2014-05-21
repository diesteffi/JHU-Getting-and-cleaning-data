##Set working directory
if(!file.exists('Data project')) {
  dir.create('Data project')
}

setwd('.\\Data project')

##Load necessary packages
if(!'data.table' %in% rownames(installed.packages())){
  install.packages('data.table')
}

library(data.table)

## Download data
datafile<-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(datafile, destfile = 'Dataset.zip')
Dataset<-unzip('Dataset.zip')

rm(datafile)

## Import data
features<-readLines(Dataset[grep('features.txt',Dataset)])
lable<-c(readLines(Dataset[grep('/y_train.txt',Dataset)]),readLines(Dataset[grep('/y_test.txt',Dataset)]))
subjects<-c(readLines(Dataset[grep('/subject_train.txt',Dataset)]),readLines(Dataset[grep('/subject_test.txt',Dataset)]))
data<-rbind(read.table(Dataset[grep('/X_train.txt',Dataset)],colClass='numeric'),read.table(Dataset[grep('/X_test.txt',Dataset)],colClass='numeric'))

##Creating meaningful activity names
activity<-readLines(Dataset[grep('/activity_labels.txt',Dataset)])
activity<-strsplit(activity,'\\ ')
firstElement<-function(x){x[2]}
activity<-sapply(activity,firstElement)
activity<-tolower(activity)
newnames<-function(x){activity[as.numeric(x)]}
lable<-sapply(lable,newnames)

rm(Dataset,activity,firstElement,newnames)

## Extract data for mean and standard deviation
Ext<-grep('mean\\W|std\\W',features)
Data<-data.table(data[,Ext])
setnames(Data,names(Data),features[Ext])
rm(data)

## Build datatable
Data<-data.table(subjects=subjects,lable=lable,Data)

## Extract new dataset
Datamelt<-melt(Data, id.vars=c('subjects','lable'), measure.vars=features[Ext])
tidyData<-dcast.data.table(data.table(Datamelt),subjects+lable~variable,mean)
rm(lable,subjects,Ext,features, Data, Datamelt )

write.csv(tidyData,file='tidyData.txt')
