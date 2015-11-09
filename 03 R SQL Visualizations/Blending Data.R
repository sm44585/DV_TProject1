require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)

# The following is equivalent to "04 Blending 2 Data Sources.twb"

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
"select YEAR || \\\'   Total_Vehicles_Tested\\\' as measure_names, count(MAKE) as measure_values from VEHICLES
where YEAR between 2009 and 2014
group by YEAR
union all
select YEAR || \\\'   Total_Vehicles_Sold\\\' as measure_names, CAR_SALE as measure_values from CAR_SALE
where YEAR between 2009 and 2014
order by measure_names;"
')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_cz4795', PASS='orcl_cz4795', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=KPI_Low_Max_value, p2=KPI_Medium_Max_value), verbose = TRUE))); View(df)

# df <- diamonds %>% group_by(color, clarity) %>% summarize(sum_price = sum(price), sum_carat = sum(carat)) %>% mutate(ratio = sum_price / sum_carat) %>% mutate(kpi = ifelse(ratio <= KPI_Low_Max_value, '03 Low', ifelse(ratio <= KPI_Medium_Max_value, '02 Medium', '01 High'))) %>% rename(COLOR=color, CLARITY=clarity, SUM_PRICE=sum_price, SUM_CARAT=sum_carat, RATIO=ratio, KPI=kpi)

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  #facet_wrap(~CLARITY, ncol=1) +
  labs(title='Blending 2 Data Sources') +
  labs(x=paste("Year Sales"), y=paste("Value")) +
  layer(data=df, 
        mapping=aes(x=MEASURE_NAMES, y=MEASURE_VALUES), 
        stat="identity", 
        stat_params=list(), 
        geom="bar",
        geom_params=list(colour="blue"), 
        position=position_identity()
  ) + coord_flip() +
  layer(data=df, 
        mapping=aes(x=MEASURE_NAMES, y=MEASURE_VALUES, label=round(MEASURE_VALUES)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", hjust=-0.5), 
        position=position_identity()
  ) 