# Log_Reg_Social_Network_Ads

## Intro
Data cleanining and logistic regression model created with the goal of predicting the probability that someone will purchase a product. This analysis was accomplished by downloading a Social Network Ads dataset from Kaggle, adding an If function to create categorical binary columns in Microsoft Excel, implementing pivot tables to create categorical binary columns for certain features, and running logistic regression models in RStudio.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

1. Download and save all csv files, workbooks, and r script
2. Open all csv files and workbooks with Microsft Excel
3. Open Social Networkd Ads.r with RStudio
4. Within RStudio, set working directory to wherever you completed step 1

### Prerequisites
R 3.3.2

RStudio 1.0.135

Packages to install: dplyr, caret.

### Breakdown
Social Networkd Ads.xlsx contains original dataset, dataset with if function for above average age and above average estimated salary, and pivot tables to produce all csv files produced for Social Network Ads.r

Social Network Ads.r uses input of all csv files to create logistic regression model and produce results for Probability.xlsx
