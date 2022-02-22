
# load and pre-process gapminder.csv (or your own data) here
# Note: don't do filtering based on reactive values (inputs etc) here, do that in server
# example: gapminder <- read.csv("data/gapminder.csv", header = TRUE)

library(DT)
library(readr)
library(dplyr)
library(gapminder)

setwd("/cloud/project/challenge")
# data("mtcars")
# rds_data <- readRDS("data/gapminder_R.RDS")