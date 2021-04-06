# download the global data here: https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv 

library(zoo)


OxCGRT_latest <- read.csv("./Data/OxCGRT_latest.csv")

# find your coutry code to subset only data points of interest
OxCGRT_subset <- OxCGRT_latest[OxCGRT_latest$RegionCode == 'UK_ENG',]

# remove the global dataset from the environment
rm(OxCGRT_latest)

# subset calculated stringency index and data
Stringency <- data.frame(Stringency = OxCGRT_subset$StringencyIndex,
                         Date = as.Date.character(OxCGRT_subset$Date, "%Y%m%d"))

# from weekly to daily
stringency_ord = Stringency[order(Stringency$Date),]
stringency_zoo = zoo(stringency_ord[,'Stringency'], 
                     order.by = stringency_ord[,'Date'])
index(stringency_zoo) <- stringency_ord$Date
weekly_stringency = apply.weekly(stringency_zoo, mean)

# check whether there are missing values at the end
tail(weekly_stringency, 10)
