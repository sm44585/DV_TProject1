require(jsonlite)
require(RCurl)
# The following is equivalent to creat a crosstab with two KPIs in Tableau"
#MPG_PV2_KPI_LOW = 0.5   
#MPG_PV2_KPI_HIGH = 2

crosstab <- vehicles %>% group_by(MAKE, YEAR) %>% summarize(sum_comb08 = sum(COMB08), sum_pv2 = sum(PV2),sum_pv4 = sum(PV4)) %>% mutate(ratio_1 = sum_comb08 / (sum_pv2+1))%>% mutate(ratio_2 = sum_comb08 / (sum_pv4+1)) %>% mutate(kpi_1 = ifelse(ratio_1 <= MPG_PV2_KPI_LOW, '03 Low', ifelse(ratio_1 <= MPG_PV2_KPI_HIGH, '02 Medium', '01 High')))%>% mutate(kpi_2 = ifelse(ratio_2 <= MPG_PV2_KPI_LOW, '03 Low', ifelse(ratio_2 <= MPG_PV2_KPI_HIGH, '02 Medium', '01 High'))) %>% rename(MAKE=MAKE, YEAR=YEAR, SUM_COMB08=sum_comb08, SUM_PV2=sum_pv2, RATIO_1=ratio_1, RATIO_2=ratio_2, KPI_1=kpi_1, KPI_2=kpi_2)%>%filter(MAKE %in% c("Acura", "Aston Martin", "Audi", "Bentley", "BMW", "Buick", "Chevrolet", "Dodge", "Ferrari", "Ford", "Honda", "Kia", "Lincoln", "Lexus", "Maserati", "Mazda", "Mercedes-Benz", "Nissan", "Toyota", "Volkswagen"))

#spread(crosstab, MAKE, YEAR) %>% View

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Vehicles Crosstab') +
  labs(x=paste("MAKE"), y=paste("YEAR")) +
  layer(data=crosstab, 
        mapping=aes(x=MAKE, y=YEAR, label=round(RATIO_1, 2)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", vjust=4), 
        position=position_identity()
  ) +
  layer(data=crosstab, 
        mapping=aes(x=MAKE, y=YEAR, label=round(RATIO_2, 2)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", vjust=4), 
        position=position_identity()
  ) +
  layer(data=crosstab, 
        mapping=aes(x=MAKE, y=YEAR, fill=KPI_1), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.50), 
        position=position_identity()
  ) +
  layer(data=crosstab, 
        mapping=aes(x=MAKE, y=YEAR, fill=KPI_2), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.50), 
        position=position_identity()
  )

