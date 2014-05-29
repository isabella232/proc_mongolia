setwd("./proc_mongolia")

library(rCharts)


wbdat <- read.csv("./data/wb_data.csv")

# 
`%notin%` <- function(x,y) !(x %in% y) 
`%+%` <- function(x,y) paste(x,y,sep="")

## Get useable names
names(wbdat) <- gsub("\\.", "_", tolower(names(wbdat)))
names(wbdat) <- gsub("__", "_", names(wbdat))


wbdat$amount <- as.integer(gsub(",", "", wbdat$amount))

by_year <- aggregate(amount ~ fiscal_year, data=wbdat, sum)
wbdat$count <- 1


proj_sector <- aggregate(amount ~ proj_id + major_sector, data=wbdat, sum)
boxplot(log(amount)~major_sector, data=proj_sector)

# Top suppliers
topsupplier_amt <- aggregate(cbind(amount,count) ~ supplier, data=wbdat, sum)

a <- topsupplier_amt[order(-topsupplier_amt$amount),]

## head(a, 10)

# 354                       JILIN EXPRESSWAY DEVELOPMENT CO., LTD. 18055950     2
# 131                                     CATERPILAR OVERSEAS S.A. 14652552     1
# 446                                   MCS INTERNATIONAL CO., LTD  8480287     5
# 344                                           ITOCHU CORPORATION  5184183     9
# 303                                              IBM CANADA LTD.  5119656     2
# 137                                              CFC CORPORATION  4754066     2
# 436                                              MARUBENI/KAROSA  4000000     3
# 110                                       BP SUN OASIS CO., LTD.  2837862     2
# 95                                             BEVERTEC CST INC.  2800000     1
# 142 CHINA POWER (BEIJING) HIGH VOLTAGE ELECTRIC EQUIPMENT CO., L  2799900     1

# ## 
# a <- topsupplier_amt[order(-topsupplier_amt$count),]
# head(a,10)

# 28       ANGELIQUE INTERNATIONAL 1828729    18
# 442              MCS ELECTRONICS 1918868    16
# 3   A/S VENTART, TALINN, ESTONIA  470655    12
# 34                   AO BITOTECH 1113416    12
# 133   CENTER FOR POLICY RESEARCH 1787513    12
# 156             CLYDE E. GOULDEN  223725    12
# 115        BSB SERVICE CO., LTD.  397149    10
# 175           DALAIVAN AUDIT LLC   39539     9
# 227                   ERDENE ZAM 2128684     9
# 344           ITOCHU CORPORATION 5184183     9

