# PAPER
library(fredr)

## Section 2 : Exchange
# fred API
fredr_set_key("89104d906090e4319bbd61e6d862b4f0")

#-1-----------------------------------------------------------
JP_raw <- fredr("DEXJPUS", observation_start = as.Date("1980-01-01"),
            observation_end = as.Date("2024-09-17"))
JP <- data_frame( date=JP_raw$date, JP=JP_raw$value)
#--2----------------------------------------------------------
CH_raw <- fredr("DEXCHUS", observation_start = as.Date("1980-01-01"),
            observation_end = as.Date("2024-09-17"))
CH <- data_frame( date=CH_raw$date, CH=CH_raw$value)
#---3---------------------------------------------------------
CA_raw <- fredr("DEXCAUS", observation_start = as.Date("1980-01-01"),
            observation_end = as.Date("2024-09-17"))
CA <- data_frame(date=CA_raw$date, CA=CA_raw$value)
#----4--------------------------------------------------------
KR_raw <- fredr("DEXKOUS", observation_start = as.Date("1980-01-01"),
  observation_end = as.Date("2024-09-17"))
KR <- data_frame(date=KR_raw$date, KR=KR_raw$value)
#-----5-----------------------------------------------------
MC_raw <- fredr("DEXMXUS", observation_start = as.Date("1980-01-01"),
                observation_end = as.Date("2024-09-17"))
MC <- data_frame(date=MC_raw$date, MC=MC_raw$value)
#------6----------------------------------------------------
BR_raw <- fredr("DEXBZUS", observation_start = as.Date("1980-01-01"),
            observation_end = as.Date("2024-09-17"))
BR <- data_frame(date=BR_raw$date, BR=BR_raw$value)
#-----7-----------------------------------------------------
EU_raw <- quantmod::getSymbols("EUR=X", from="1980-01-01",
                               to="2024-09-17", auto.assign = F)
EU <- data_frame(date=index(EU_raw), EU=as.numeric(EU_raw$`EUR=X.Close`))
#-----8-----------------------------------------------------
UK_raw <- quantmod::getSymbols("BGN=X", from="1980-01-01",
                               to="2024-09-17", auto.assign = F)
UK <- data_frame(date=index(UK_raw), UK=as.numeric(UK_raw$`BGN=X.Close`))
#-----9-----------------------------------------------------
ID_raw <- fredr("DEXINUS", observation_start = as.Date("1980-01-01"),
                observation_end = as.Date("2024-09-17"))
ID <- data_frame(date=ID_raw$date, ID=ID_raw$value)
#-----10-----------------------------------------------------
RU_raw <-quantmod::getSymbols("RUB=X", from="1980-01-01",
                          to="2024-09-17", auto.assign = F)
RU <- data_frame(date=index(RU_raw), RU=as.numeric(RU_raw$`RUB=X.Close`))
#-----11-----------------------------------------------------
AU_raw <-quantmod::getSymbols("AUD=X", from="1980-01-01",
                             to="2024-09-17", auto.assign = F)
AU <- data_frame(date=index(AU_raw), AU=as.numeric(AU_raw$`AUD=X.Close`))
#-----12-----------------------------------------------------
INN_raw <-quantmod::getSymbols("IDR=X", from="1980-01-01",
                              to="2024-09-17", auto.assign = F)
INN <- data_frame(date=index(INN_raw), INN=as.numeric(INN_raw$`IDR=X.Close`))
#-----13-----------------------------------------------------
SA_raw <- getSymbols("SAR=X", from="1980-01-01",
                 to="2024-09-17", auto.assign = F)
SA <- data_frame(date=index(SA_raw), SA=as.numeric(SA_raw$`SAR=X.Close`))
#-----14-----------------------------------------------------
TR_raw <- getSymbols("TRY=X", from="1980-01-01",
                     to="2024-09-17", auto.assign = F)
TR <- data_frame(date=index(TR_raw), TR=as.numeric(TR_raw$`TRY=X.Close`))
#-----15--남아공--------------------------------------------------
RSA_raw <- getSymbols("ZAR=X", from="1980-01-01",
                   to="2024-09-17", auto.assign = F)
RSA <- data_frame(date=index(RSA_raw), RSA=as.numeric(RSA_raw$`ZAR=X.Close`))
#-----16--newzl--------------------------------------------------
ND_raw <- getSymbols("NZD=X", from="1980-01-01",
                 to="2024-09-17", auto.assign = F)
ND <- data_frame(date=index(ND_raw), ND=as.numeric(ND_raw$`NZD=X.Close`))
#-----17--대만--------------------------------------------------
TW_raw <- getSymbols("TWD=X", from="1980-01-01",
                     to="2024-09-17", auto.assign = F)
TW <- data_frame(date=index(TW_raw), TW=as.numeric(TW_raw$`TWD=X.Close`)) 
#-----18--hung--------------------------------------------------
HK_raw <- getSymbols("HKD=X", from="1980-01-01",
                     to="2024-09-17", auto.assign = F)
HK <- data_frame(date=index(HK_raw), HK=as.numeric(HK_raw$`HKD=X.Close`)) 
#-----19-----태국----------------------------------------------
TAI_raw <- getSymbols("THB=X", from="1980-01-01",
                     to="2024-09-17", auto.assign = F)
TAI <- data_frame(date=index(TAI_raw), TAI=as.numeric(TAI_raw$`THB=X.Close`)) 
#-----20-----pli----------------------------------------------
PH_raw <- getSymbols("PHP=X", from="1980-01-01",
                     to="2024-09-17", auto.assign = F)
PH <- data_frame(date=index(PH_raw), PH=as.numeric(PH_raw$`PHP=X.Close`))  
#-----21---------------------------------------------------
SW_raw <- getSymbols("CHF=X", from="1980-01-01",
                     to="2024-09-17", auto.assign = F)
SW <- data_frame(date=index(SW_raw), SW=as.numeric(SW_raw$`CHF=X.Close`)) 

# Merge
EX_data <- Reduce(function(x, y) full_join(x, y), list(
  JP, CH, CA, KR, MC, BR, EU, UK, ID, RU, AU, INN, SA, TR, 
  RSA, ND, TW, HK, TAI, PH, SW))

# final
EX_set <-na.omit(EX_data)
colnames(EX_set) <- c("Date", "JP", "CN", "CA", "KR", "MX", "BR", "EU", "UK",
                      "IN", "RU", "AU", "ID", "SA", "TR", "ZA", "NZ", "TW",
                      "HK", "TH", "PH", "CH")
# save
write.xlsx(EX_set, "Desktop/Paper/data/EX_data.xlsx", rowNames=FALSE)

  
