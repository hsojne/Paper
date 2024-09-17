library(quantmod)
library(readxl)
library(dplyr)
library(openxlsx)
library(rvest)
library(httr)
library(FinAna)


# formation ----------------
raw_data <- getSymbols("", from="1994-01-01", to="2024-07-30", auto.assign = F)
date <- index(raw_data)
data <- coredata(raw_data)
finally_data <- data[, 4]

# USA data ------------------
raw_sp500 <-getSymbols("^GSPC", from="1994-01-01", to="2024-07-30", auto.assign = F)
us_data <- index(raw_sp500)
sp500 <- coredata(raw_sp500) 
SP500 <- sp500[,4]
USA <- data.frame(date=us_data, US=SP500)

# UK data ------------------
raw_data <- getSymbols("^FTSE", from="1994-01-01", to="2024-07-30", auto.assign = F)
date <- index(raw_data)
data <- coredata(raw_data)
finally_data <- data[, 4]
UK <- data.frame(date=date, UK=finally_data)

# GER data ------------------  
raw_data <- getSymbols("^GDAXI", from="1994-01-01", to="2024-07-30", auto.assign = F)
date <- index(raw_data)
data <- coredata(raw_data)
finally_data <- data[, 4]
GER <- data.frame(date=date, GER=finally_data)

# FRA data ------------------  
raw_data <- getSymbols("^FCHI", from="1994-01-01", to="2024-07-30", auto.assign = F)
date <- index(raw_data)
data <- coredata(raw_data)
finally_data <- data[, 4]
FRA<- data.frame(date=date, FRA=finally_data)

# JAN data ------------------  
raw_data <- getSymbols("^N225", from="1994-01-01", to="2024-07-30", auto.assign = F)
date <- index(raw_data)
data <- coredata(raw_data)
finally_data <- data[, 4]
JAN <- data.frame(date=date, JAN =finally_data)

# AUS data ------------------
raw_data <- getSymbols("^AXJO", from="1994-01-01", to="2024-07-30", auto.assign = F)
date <- index(raw_data)
data <- coredata(raw_data)
finally_data <- data[, 4]
AUS <- data.frame(date=date, AUS =finally_data)

# HKG data ------------------
raw_data <- getSymbols("^HSI", from="1994-01-01", to="2024-07-30", auto.assign = F)
date <- index(raw_data)
data <- coredata(raw_data)
finally_data <- data[, 4]
HKG <- data.frame(date=date, HKG=finally_data)

# CHN data ------------------
raw_data <- getSymbols("000001.SS", from="1994-01-01", to="2024-07-30", auto.assign = F)
date <- index(raw_data)
data <- coredata(raw_data)
finally_data <- data[, 4]
CHN <- data.frame(date=date, CHN=finally_data)

# IND data ------------------
raw_data <- getSymbols("^BSESN", from="1994-01-01", to="2024-07-30", auto.assign = F)
date <- index(raw_data)
data <- coredata(raw_data)
finally_data <- data[, 4]
IND <- data.frame(date=date, IND=finally_data)

# BRA data ------------------
raw_data <- getSymbols("^BVSP", from="1994-01-01", to="2024-07-30", auto.assign = F)
date <- index(raw_data)
data <- coredata(raw_data)
finally_data <- data[, 4]
BRA <- data.frame(date=date, BRA=finally_data)


make_data_set <- function(code, country){
  raw_data <- getSymbols(code, from ="1994-01-01", to="2024-07-30", auto.assign = F)
  date <- index(raw_data)
  data <- coredata(raw_data)
  finally_data <- data[, 4]
  data_set <- data.frame(date=date, name=finally_data)
  colnames(data_set) <- c("date", country)
  return(data_set)
}


KOR <- make_data_set("^KS11", "KOR")
MYS <- make_data_set(code[1], country[1])
PHL <- make_data_set(code[2], country[2])
SGP <- make_data_set(code[3], country[3])
TAI <- make_data_set(code[4], country[4])
THA <- make_data_set(code[5], country[5]) 
ARG <- make_data_set(code[6], country[6]) 
MEX <- make_data_set(code[8], country[8]) 
TUR <- make_data_set(code[9], country[9]) 
  code<- c("^KLSE", "PSEI.PS", "^STI", "^TWII", "^SET.BK", 'M.BA', "^IPSA",
  "^MXX", "XU100.IS")
country <- c("MYS", "PHL", "SGP", "TAI", "THA", "ARG", "CHL",
             "MEX", "TUR")

# CHL -----------------------------------

chl_1 <- read.csv("set_6/S&P CLX IGPA 과거 데이터 (1).csv")
date_1 <- as.Date(chl_1[, 1])
core_1 <- chl_1[,2]
CHL_1 <- data.frame(date = date_1, CHL =core_1)
CHL_1 <- CHL_1 %>% arrange(desc(row_number()))

chl_2 <- read.csv('set_6/S&P CLX IGPA 과거 데이터 (2).csv')
date_2 <- as.Date(chl_2[ ,1])
core_2 <- chl_2[, 2]
CHL_2 <- data.frame(date = date_2, CHL = core_2)
CHL_2 <- CHL_2 %>% arrange(desc(row_number()))

chl_3 <- read.csv("set_6/S&P CLX IGPA 과거 데이터.csv")
date_3 <- as.Date(chl_3[ ,1])
core_3 <- chl_3[,2]
CHL_3 <- data.frame(date = date_3, CHL = core_3)
CHL_3 <- CHL_3 %>% arrange(desc(row_number()))
xyy <- rbind(CHL_1, CHL_2)
CHL <- rbind(xyy, CHL_3)

# standard CHN because of min len : 6731
merged_df <- Reduce(function(x, y) full_join(x, y), list(USA, UK, GER,
                                                         FRA, JAN, AUS, HKG,
                                                         CHN, IND, BRA, KOR, MYS,
                                                         PHL, SGP, TAI, THA,
                                                         ARG, CHL, MEX, TUR))
merged_df <-na.omit(merged_df)

getwd()
setwd("/Users/shiki/Desktop/Paper/")
write.xlsx(merged_df, "data_set_4.xlsx")


