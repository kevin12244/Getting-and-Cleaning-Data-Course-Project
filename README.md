---
title: "README.md"
author: "Chattapatr Leeraha"
date: '2022-07-12'
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This github repository is created in fulfillment of the course project of the Getting and Cleaning Data course on Coursera offered by John Hopkins University. The goal of this project is to get data from "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones", which are datasets on acceleration of the human body during each activity captured at 50 HZ for 2.56 seconds. Therefore, 128 frames are captured for each observation. The acceleration is measured using the smartphone attached to the subject body. There are two datasets, provided titled, "Train" and "Test". The train data set is presumably use to train a machine learning model, while the test data set is used for verification of the model. For our purposes, we are to combined both the train and test data set and derive various statistics. The "run_analysis.R" file is used to get, clean, and transform this dataset and using them for descriptive purposes, creating summary statistics. These statistics are saved in the two files, "SdMean.csv" and "MeanByGroup.csv". The CodeBook.md explains each variables in these two datasets as well as the codes in "run_analysis.R".