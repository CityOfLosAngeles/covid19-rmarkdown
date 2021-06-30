# Utility functions to make charts

# Chart parameters
NAVY<-"#0A4C6A"
MAROON<- "#F3324C"
LIGHT_GRAY<-"#EAEBEB"

YESTERDAY_DATE <- format(Sys.Date()-1,"%Y-%m-%d")
TWO_WEEKS_AGO <- format(Sys.Date()-15, "%Y-%m-%d")


# Make cases / deaths chart
#https://stackoverflow.com/questions/5106782/use-of-ggplot-within-another-function-in-r
plotCasesDeaths<-function(df, y_var, line_color, chart_title, ytitle){
  
  arg <- match.call()
  
  chart <- ggplot(df, 
                  aes(x = date, 
                      y = eval(arg$y_var)
                  )) +
    labs(x = "date", 
         y = eval(arg$ytitle), 
         title=eval(arg$chart_title)) + 
    geom_area(data = df %>% subset(date >= TWO_WEEKS_AGO),
              fill = LIGHT_GRAY) +    
    geom_line(colour=eval(arg$line_color), size=0.75) +
    scale_color_fivethirtyeight() +
    scale_x_date(date_labels = "%m-%d", 
                 date_breaks = "1 months") +
    scale_y_continuous(label=comma) + 
    theme_minimal() +
    theme(legend.position="none", 
          axis.text.x = element_text(angle=90, hjust=0)
    )
  
  return(chart)
}


# HTML version of cases

plotCasesHTML<-function(df, chart_title){
  
  arg <- match.call()
  
  chart <- ggplot(df, 
                  aes(x = date, 
                      y = new_cases_avg7,
                  )) +
    labs(x = "date", 
         y = "new cases (7-day rolling avg)", 
         title=eval(arg$chart_title)) + 
    geom_area(data = df %>% subset(date >= TWO_WEEKS_AGO),
              fill = LIGHT_GRAY) +
    geom_line(colour=NAVY, size=0.75) +
    scale_color_fivethirtyeight() +
    scale_x_date(date_labels = "%m-%d", 
                 date_breaks = "1 months") +
    scale_y_continuous(label=comma) + 
    theme_minimal() +
    theme(legend.position="none", 
          axis.text.x = element_text(angle=90, hjust=0)
    )
  
  return(chart)
}


plotDeathsHTML<-function(df, chart_title){
  
  arg <- match.call()
  
  chart <- ggplot(df, 
                  aes(x = date, 
                      y = new_deaths_avg7,
                  )) +
    labs(x = "date", 
         y = "new deaths (7-day rolling avg)", 
         title=eval(arg$chart_title)) + 
    geom_area(data = df %>% subset(date >= TWO_WEEKS_AGO),
              fill = LIGHT_GRAY) +
    geom_line(data = df, colour=MAROON, size=0.75) +
    scale_color_fivethirtyeight() +
    scale_x_date(date_labels = "%m-%d", 
                 date_breaks = "1 months") +
    scale_y_continuous(label=comma) + 
    theme_minimal() +
    theme(legend.position="none", 
          axis.text.x = element_text(angle=90, hjust=0)
          )
  
  return(chart)
}


plotVaxHTML<-function(df){
  arg <- match.call()

  chart_title = paste0(df$demographic_category[1])
  
  chart <- ggplot(df %>% subset(variable == "pct_fully_vax"), 
                  aes(x = date, 
                      y = pct,
                      color = demographic_value
                  )) +
    labs(x = "date", 
         y = "percent", 
         title=chart_title
         ) + 
    geom_line() +
    scale_color_calc() +
    scale_x_date(date_labels = "%m-%d", 
                 date_breaks = "1 months") +
    scale_y_continuous(label=comma) + 
    ylim(0, 1.0) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle=90, hjust=0))
  
  return(chart)
}






