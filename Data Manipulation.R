library(TTR)
library(zoo)
library(xts)
library(quantmod)
library(car)
library(PerformanceAnalytics)
library(foreach)
library(FinancialInstrument)
library(tidyquant)
library(tidyverse)
library(writexl)

natco=getSymbols("NATCOPHARM.NS",from="2020-04-01",to="2024-03-31",auto.assign = F)
hal=getSymbols("HAL.NS",from="2020-04-01",to="2024-03-31",auto.assign = F)
zentec=getSymbols("ZENTEC.NS",from="2020-04-01",to="2024-03-31",auto.assign = F)
zydus=getSymbols("ZYDUSLIFE.NS",from="2020-04-01",to="2024-03-31",auto.assign = F)

#Adding EMA to all the stocks
natco$EMA50 <- EMA(Ad(natco),50)
hal$EMA50 <- EMA(Ad(hal),50)
zentec$EMA50 <- EMA(Ad(zentec),50)
zydus$EMA50 <- EMA(Ad(zydus),50)

natco$EMA200 <- EMA(Ad(natco),200)
hal$EMA200 <- EMA(Ad(hal),200)
zentec$EMA200 <- EMA(Ad(zentec),200)
zydus$EMA200 <- EMA(Ad(zydus),200)



natco_df <- as.data.frame(natco)
hal_df <- as.data.frame(hal)
zentec_df <- as.data.frame(zentec)
zydus_df <- as.data.frame(zydus)

#Creating Date fields and relocating
natco_df$Date=row.names(natco_df)
natco_df <- relocate(natco_df,Date,.before="NATCOPHARM.NS.Open")

hal_df$Date=row.names(hal_df)
hal_df <- relocate(hal_df,Date,.before="HAL.NS.Open")

zentec_df$Date=row.names(zentec_df)
zentec_df <- relocate(zentec_df,Date,.before="ZENTEC.NS.Open")

zydus_df$Date=row.names(zydus_df)
zydus_df <- relocate(zydus_df,Date,.before="ZYDUSLIFE.NS.Open")

setwd("D:/Academic/MBA/MBA 3rd Semester/BA/Final Project")

write_xlsx(natco_df,"Natco_Pharma_Stock_Prices.xlsx")
write_xlsx(hal_df,"HAL_Stock_Prices.xlsx")
write_xlsx(zentec_df,"Zentec_Stock_Prices.xlsx")
write_xlsx(zydus_df,"Zydus_Life_Stock_Prices.xlsx")


write.csv(natco_df, "Natco_Pharma_Stock_Prices.csv", row.names = TRUE)
write.csv(hal_df, "HAL_Stock_Prices.csv", row.names = TRUE)
write.csv(zentec_df, "Zentec_Stock_Prices.csv", row.names = TRUE)
write.csv(zydus_df, "Zydus_Life_Stock_Prices.csv", row.names = TRUE)



pricedata=cbind.zoo(natco,hal,zentech,zydus_life)

pricedata_df=as.data.frame(pricedata)
summary(pricedata_df)

pricedata_df$Date=row.names(pricedata_df)
pricedata_df <- relocate(pricedata_df,Date,.before="NATCOPHARM.NS.Open")

write_xlsx(pricedata_df,"Stock_Prices_Dataset.xlsx")






















library(readxl)
Stock_Prices_Dataset <- read_excel("D:/Academic/MBA/MBA 3rd Semester/BA/Final Project/Stock_Prices_Dataset.xlsx")
View(Stock_Prices_Dataset)

summary(Stock_Prices_Dataset)
head(Stock_Prices_Dataset)

natco <- Stock_Prices_Dataset[,1:6]
head(natco)

hal <- Stock_Prices_Dataset[,8:13]
hal$Date <- Stock_Prices_Dataset[,1]
hal

hal_df <- as.data.frame(hal)
library(dplyr)
hal_df <- relocate(hal_df,Date,.before ="HAL.NS.Open" )
hal_df
head(hal_df)
View(hal_df)

##Zentec

zentec <- Stock_Prices_Dataset[,14:19]
head(zentec)
zentec$Date <- Stock_Prices_Dataset[,1]
zentec_df <- as.data.frame(zentec)
zentec_df <- relocate(zentec_df,Date,.before = "ZENTEC.NS.Open")
head(zentec_df)
View(zentec_df)


###Zyduslife

zydus <- Stock_Prices_Dataset[,20:25]
head(zydus)
zydus$Date <- Stock_Prices_Dataset[,1]
zydus_df <- as.data.frame(zydus)
zydus_df <- relocate(zydus_df,Date,.before = "ZYDUSLIFE.NS.Open")
View(zydus_df)



