---
title: "Codebook.md"
author: "Chattapatr Leeraha"
date: '2022-07-12'
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

The file called 'SdMean.csv' contains a 2 by 562 dataframe, containing the standard deviation and mean of each of the element of the 561 components vector from all the observations of the dataset (both train and test datasets), provided at: "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones".

The first column, "Type", indicates whether the observation is the mean or the standard deviation (abbreviated by "sd"). The remaining columns are labeled with the letter "V" followed by a number that indicates, which component of the vector, this statistic is derived from. For example, for the first row, seventh column, first, we see that the type of the row indicates that the following statistic is the standard deviation. The name of the seventh row is V6, so that the following number is the standard deviation of the 6th component of the 561 element vector . 

The second file, titled "MeanByGroup.csv", contains the mean of each of the component of the 561 elements vector, where the observations are grouped by activity and the test subject (there are 6 activities and 30 subjects, and therefore 180 groups). The first two columns, "Activity" and "Element", indicates the mean of which activity and component of the 561 element vectors we are measuring. For example, a combination of the the activity, "laying", and variable, "V1" would indicate that we are measuring the mean of the 1 component of the vector for the observations, whose activity correspond to "laying". The rest of the columns tell us which subject we are measuring. For example, the third column, labeled "Subject1", would tell us that we are measuring the mean of Subject1. Therefore, row 1 column 3, whose activity and variable, are laying and V1, would indicate that this is the mean of subject 1 for the 1st component of the vector and activity laying.   

Line 1-33 of the "run_anlyis.R" loads the data, preparing it to be merged. The raw training and test dataset has the activity as well as the subject number of each observation in a separate file. Therefore, line 3-21 combines this data with the raw observation. The type of activity in the raw dataset is indicated by a number 1-6, with the meaning of each number in a separate file. Therefore, line 23-33 is used to convert the numeric data to a more descriptive data for activity variable. Line 35 merges the training and test dataset together. Line 37 then create the dataframe for 'SdMean.csv'. Writing the dataset into a file with the write.csv function causes the the type of statistics to be indicate by a column, named "X". The rename function is called to rename the column as "Type" to provide a more accurate description. The dataframe is then written again the second and final time into the file, "SdMean.csv"

Line 39-46 is used to create the dataframe to be stored in "MeanByGroup.csv". It creates a list of dataframes for each element of the 561 component vector in the original dataset. The row's name tells us what activity we are describing, while the column tells us which subject the statistics is describing. The name of the dataframe then tell us the component of the vector. From this dataset, line 49-61 is used to produce the final dataset. Line 59-61 is used to sort the final dataset by activity, breaking ties by the order of the component of the 561 element vector. 