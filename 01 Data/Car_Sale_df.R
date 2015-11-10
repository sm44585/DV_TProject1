require("jsonlite")
require("RCurl")

# Loads the data from Total Car Sales table into CAR_Sale dataframe
# Change the USER and PASS below to be your UTEid
CAR_Sale <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select YEAR, CAR_SALE from CAR_SALE"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_cz4795', PASS='orcl_cz4795', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE),))

summary(CAR_Sale)
