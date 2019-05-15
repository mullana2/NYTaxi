# NYTaxi
Analysis of 10 years and over 1.5 billion fares of taxi data in New York City. This research was conducted in collaboration with Dandan Ru, Zhenni Ye, and Lyu Zheng (Univeristy of California, Berkeley)

## Research

The pdf file *NY_Taxi.pdf* contains a formal write-up of the process and findings of analysis for this research. 

## Schema

#### R Files
The folder *R Files* contains the R code used to compile, clean, and analyze the data, as well as generate images for the paper and presentation of findings. Sub folder *Proof of Concept* includes early code used to ensure analysis worked as intended on a small subset of the data, before applying the code to all 1.5+ billion observations.

*Full_Data_Aggregation.Rmd* contains the script used to retrieve the raw data from the New York City Taxi and Limousine Commision. This data was aggregated using a grid system and compiled by half-hour and day of the week. These compressed data files are stored in the *Data/All_Counts* folder.

*Spat_Temp_Analysis.Rmd* contains the script used to perform the spatial and temporal predictive modeling on the compressed data. Results of this modeling process are given in *Data/Results*.

*Code_Optimization.r* is the script used to determine the optimal dispatch strategy for a taxi company, based on the predictions generated from the predictive models. 

*Presentation_Images.Rmd* is the code used to generate all images used in either the formal presentation or write-up for this research. These images can also be found in the *Images* folder.

#### Data
Folder *Data* contains both the raw data used for analysis as well as some results from the predictive models. 

Subfolder *All_Counts* contains the aggregated count data for every day of the week and every half hour in the day. The compressed files contain all count data for a given day of the week, and the names of the datasets within the compressed file indicate the beginning of the half-hour period within that day. For example, "Mon_08_05.csv" is the count data for Monday between 8:30am and 9:00am whereas "Thu_17_00" is the count data for Thursday between 5:00pm and 5:30pm. 

Subfolder *Results* contains the model performance statistics for each half-hour window in each day of the week. Both R-squared and root mean squared error values are recorded for every half-hour from each day of the week.

The compressed folder *Analysis_Data* contains the full results of each step of the modeling process.

#### Images
Folder *Images* contains all images generated for presentations and the paper.


