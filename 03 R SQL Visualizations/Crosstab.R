# The following is equivalent to creat a crosstab with two KPIs in Tableau"
MPG_PV2_KPI_LOW = 0.5   
MPG_PV2_KPI_HIGH = 2

crosstab <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= 
"select make, year, sum_comb08, round(sum_pv2) as sum_pv2, kpi_1 as pv2_ratio,
case
when kpi_1 < "p1" then \\\'03 Not Efficent and Spacious\\\'
when kpi_1 < "p2" then \\\'02 Average Effciency and Space\\\'
else \\\'01 Efficent and Spacious\\\'
end kpi_1
from (select make, year,
  sum(comb08) sum_comb08, sum(pv2) sum_pv2,
  sum(comb08) / sum(pv2) kpi_1
  from vehicles
  group by make, year)
order by year;"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cz4795', PASS='orcl_cz4795', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=MPG_PV2_KPI_LOW, p2=MPG_PV2_KPI_HIGH), verbose = TRUE))); #View(df)

# df <- diamonds %>% group_by(color, clarity) %>% summarize(sum_price = sum(price), sum_carat = sum(carat)) %>% mutate(ratio = sum_price / sum_carat) %>% mutate(kpi = ifelse(ratio <= KPI_Low_Max_value, '03 Low', ifelse(ratio <= KPI_Medium_Max_value, '02 Medium', '01 High'))) %>% rename(COLOR=color, CLARITY=clarity, SUM_PRICE=sum_price, SUM_CARAT=sum_carat, RATIO=ratio, KPI=kpi)

spread(df, COLOR, SUM_PRICE) %>% View

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Vehicles Crosstab\SUM_COMB08, SUM_PV2, SUM_PV4, SUM_COMB08 / SUM_PV2 and SUM_COMB08 / SUM_PV4') +
  labs(x=paste("MAKE"), y=paste("YEAR")) +
  layer(data=df, 
        mapping=aes(x=MAKE, y=YEAR, label=Calculated_MPG_PV2), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black"), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(x=MAKE, y=YEAR, label=Calculated_MPG_PV4), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", vjust=2), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(x=MAKE, y=YEAR, label=round(RATIO, 2)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", vjust=4), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(x=MAKE, y=YEAR, fill=KPI_1), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.50), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(x=MAKE, y=YEAR, fill=KPI_2), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.50), 
        position=position_identity()
  )

