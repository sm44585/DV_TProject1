require("jsonlite")
require("RCurl")

# Loads the data from Fast Food table into Fast Food dataframe
# Change the USER and PASS below to be your UTEid
vehicles <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select ATVTYPE,BARRELS08,BARRELSA08,CITY08,CITYA08,CO2TAILPIPEAGPM,CO2TAILPIPEGPM,COMB08,COMBA08,CYLINDERS,FUELCOST08,FUELCOSTA08,FUELTYPE,FUELTYPE1,FUELTYPE2,HIGHWAY08,HIGHWAYA08,HLV,HPV,LV2,LV4,MPGDATA,PV2,PV4,YEAR,MAKE from VEHICLES"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cz4795', PASS='orcl_cz4795', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

summary(vehicles)
