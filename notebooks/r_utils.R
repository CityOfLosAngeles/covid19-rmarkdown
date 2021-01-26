# Utility functions
library(dplyr)
library(zoo)

YESTERDAY_DATE <- format(Sys.Date()-1,"%Y-%m-%d")
TWO_WEEKS_AGO <- format(Sys.Date()-15, "%Y-%m-%d")


# Clean JHU case data
prep_county <- function(df, county_name, start_date){
  df<- df %>%
    mutate(date=as.Date(date)) %>%
    subset(county==county_name) %>%
    select(c("county", "state", 
             "fips", "date", 
             "Lat", "Lon", 
             "cases", "deaths", 
             "new_cases", "new_deaths")) %>%
    arrange(state, fips, date) %>%
    group_by(state, fips) %>%
    mutate(
      new_cases_avg7 = zoo::rollmean(new_cases, k = 7, fill = NA),
      new_deaths_avg7 = zoo::rollmean(new_deaths, k = 7, fill = NA),
    ) %>%
    mutate(
      new_cases_avg7 = round(new_cases_avg7, 2),
      new_deaths_avg7 = round(new_deaths_avg7, 2)
    ) %>%
    ungroup() %>%
    subset(date >= start_date)
  
  return(df)
}


# Clean hospitalizations data
prep_hospital <- function(df, county_name, start_date){
  df<- df %>%
    mutate(date=as.Date(date)) %>%
    subset(county==county_name) %>%
    select(c("date", "county", "county_fips", 
             "hospitalized_covid", "icu_covid")) %>%
    rename(fips = county_fips) %>%
    arrange(fips, county, date) %>%
    group_by(fips, county) %>%
    mutate(
      date = as.Date(date),
      hospitalized_avg7 = zoo::rollmean(hospitalized_covid, k = 7, fill = NA),
      icu_avg7 = zoo::rollmean(icu_covid, k = 7, fill = NA),
    ) %>%
    ungroup() %>%
    subset(date >= start_date) %>%
    reshape2::melt(id.vars = c("county", "fips", "date"), 
         measure.vars = c("hospitalized_avg7", "icu_avg7"),
         value.name="num") %>%
    mutate(variable = ifelse(as.character(variable) == "hospitalized_avg7", "All COVID-Hospitalized", 
                             "COVID-ICU"))
  
  return(df)
}