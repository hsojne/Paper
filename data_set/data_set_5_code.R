library(dplyr)
library(readxl)

getwd()
setwd("/Users/shiki/Desktop/Paper/set/set_5/")
getwd()

# BTC -----------------------------
btc <- read.csv("BTC.csv")
btc_date <- btc[, 1]
btc_date <- btc_date %>% as.Date()
btc_code <- btc[, 5]
BTC <- data.frame(date = btc_date, BTC = btc_code)

# XRP -----------------------------
xrp <- read.csv("XRP.csv")
xrp_date <- as.Date(xrp[, 1], format = "%m/%d/%Y")
xrp_code <- xrp[, 5]
xrp_code <- gsub("\\$", "", xrp_code)
xrp_code <- as.numeric(xrp_code)
XRP <- data.frame(date = xrp_date, XRP = xrp_code)
XRP <- XRP %>% arrange(desc(row_number()))

# LTC -----------------------------
ltc <- read.csv("LTC.csv")
ltc_date <- as.Date(ltc[,1], format = "%m/%d/%Y")
ltc_core <- ltc[, 5]
ltc_core <- gsub("\\$", "", ltc_core)
ltc_core <- as.numeric(ltc_core)
LTC <- data.frame( date = ltc_date, LTC = ltc_core)
LTC <- LTC %>% arrange(desc(row_number()))

# PPC -----------------------------
ppc <- read.csv("PPC.csv")
ppc_date <- as.Date(ppc[,1], format = "%m/%d/%Y")
ppc_core <- ppc[, 5]
ppc_core <- gsub("\\$", "", ppc_core)
ppc_core <- as.numeric(ppc_core)
PPC <- data.frame( date = ppc_date, LTC = ppc_core)
PPC <- PPC %>% arrange(desc(row_number()))

# NMC -----------------------------
make_date_type_1 <- function(file_path, x) {
  raw_date <- read.csv(file_path)
  date <- raw_date[, 1]
  date <- as.Date(date)
  core <- raw_date[, 5]
  date_set <- data.frame( date = date, x = core)
  return(date_set)
}

NMC <- make_date_type_1("NMC.csv", NMC)
colnames(NMC) <- c("date", "NMC")

# FTC -----------------------------z
make_date_type_2 <- function(fil_path){
  raw_data <- read.csv(fil_path)
  date <- as.Date(raw_data[,1], format = "%m/%d/%Y")
  core <- raw_data[, 5]
  core <- gsub("\\$", "", core)
  core <- as.numeric(core)
  date_set <- data.frame(date = date, x = core)
  date_set <- date_set %>% arrange(desc(row_number()))
  
  return(date_set)
}

FTC <- make_date_type_2("FTC.csv")
colnames(FTC) <- c("date", "FTC")

# NVC -----------------------------
NVC <- make_date_type_2("NVC.csv")
colnames(NVC) <- c("date", "NVC")

# TRC -----------------------------
TRC <- read.csv("TRC.csv")
TRC <- make_date_type_2("TRC.csv")
colnames(TRC) <- c("date", "TRC")


# merge --------------------------
merged_df <- Reduce(function(x, y) full_join(x, y ), list(BTC, XRP, LTC,
                                                         PPC, NMC, FTC, 
                                                         NVC, TRC))

merged_df <- merged_df[1:3642, ]
merged_df <- na.omit(merged_df)
write.xlsx(merged_df, "data_set_5.xlsx")







