# Utility functions
library(dplyr)
library(arrow)


prep_county <- function(df, county_name, start_date){
  df<- df %>%
    mutate(date=as.Date(date)) %>%
    subset(county==county_name & date >= start_date) %>%
    select(c("county", "state", 
             "fips", "date", 
             "Lat", "Lon", 
             "cases", "deaths", 
             "new_cases", "new_deaths"))
  
  return(df)
}
  
 
