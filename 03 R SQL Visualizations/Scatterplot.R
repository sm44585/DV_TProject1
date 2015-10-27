# This file creates the scatterplot.
require(tidyr)
require(dplyr)
require(ggplot2)

# This selects only the comb08 and year columns
scatterplot <- vehicles %>% select(COMB08, YEAR)

ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title="The relationship between the combined MPG and the year") +
  labs(x="Year", y="Combined MPG") +
  layer(data=scatterplot , 
        mapping=aes(x=as.numeric(YEAR), y=as.numeric(COMB08)),
        stat="identity",
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )