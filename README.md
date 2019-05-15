# NYTaxi
Analysis of 10 years and over 1.5 billion fares of taxi data in New York City. This research was conducted in collaboration with Dandan Ru, Zhenni Ye, and Lyu Zheng (Univeristy of California, Berkeley)

## Research

The pdf file *NY_Taxi.pdf* contains a formal write-up of the process and findings of analysis for this research. 

## Schema

#### R Files
Folder *R Files* contains the R code used to compile, clean, and analyze the data, as well as generate images for the paper and presentation of findings. Sub folder *Proof of Concept* includes early code used to ensure analysis worked as intended on a small subset of the data, before applying the code to all 1.5+ billion observations.

#### Data
Folder *Data* contains both the raw data used for analysis as well as the $R^2$ and root mean squared error of predictions generated for the data. Subfolder *All_Counts* contains the aggregated count data for every day of the week and every half hour in the day. The compressed files contain all count data for a given day of the week, and the names of the datasets within the compressed file indicate the beginning of the half-hour period within that day. For example, "Mon_08_05.csv" is the count data for Monday between 8:30am and 9:00am whereas "Thu_17_00" is the count data for Thursday between 5:00pm and 5:30pm. Subfolder *Results* contains the model performance statistics for each half-hour window in each day of the week. The compressed folder *Analysis_Data* contains the results of each stage of analysis.

#### Images
Folder *Images* contains all images generated for presentations and the paper.


