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
    geom_line(colour=eval(arg$line_color)) +
    geom_area(data = df %>% subset(date >= TWO_WEEKS_AGO),
              fill = LIGHT_GRAY) +
    #Draw a line again otherwise the shading removes some of the line
    geom_line(colour=eval(arg$line_color)) +
    scale_color_fivethirtyeight() +
    scale_x_date(date_labels = "%m-%d", 
                 date_breaks = "1 months") +
    theme_minimal() +
    theme(legend.position="none", 
    )
  
  return(chart)
}


plotCasesHTML<-function(df, chart_title){
  
  arg <- match.call()
  
  chart <- ggplot(df, 
                  aes(x = date, 
                      y = new_cases_avg7,
                  )) +
    labs(x = "date", 
         y = "daily new cases", 
         title=eval(arg$chart_title)) + 
    geom_line(colour=NAVY) +
    geom_area(data = df %>% subset(date >= TWO_WEEKS_AGO),
              fill = LIGHT_GRAY) +
    #Draw a line again otherwise the shading removes some of the line
    geom_line(colour=NAVY) +
    scale_color_fivethirtyeight() +
    scale_x_date(date_labels = "%m-%d", 
                 date_breaks = "2 weeks") +
    theme_minimal() +
    theme(legend.position="none", 
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
         y = "daily new cases", 
         title=eval(arg$chart_title)) + 
    geom_area(data = df %>% subset(date >= TWO_WEEKS_AGO),
              fill = LIGHT_GRAY) +
    geom_line(data = df, colour=NAVY, size=1) +
    scale_color_fivethirtyeight() +
    scale_x_date(date_labels = "%m-%d", 
                 date_breaks = "1 months") +
    theme_minimal() +
    theme(legend.position="none")
  
  return(chart)
}


plotDeathsHTML<-function(df, chart_title){
  
  arg <- match.call()
  
  chart <- ggplot(df, 
                  aes(x = date, 
                      y = new_deaths_avg7,
                  )) +
    labs(x = "date", 
         y = "daily new deaths", 
         title=eval(arg$chart_title)) + 
    geom_area(data = df %>% subset(date >= TWO_WEEKS_AGO),
              fill = LIGHT_GRAY) +
    geom_line(data = df, colour=MAROON, size=1) +
    scale_color_fivethirtyeight() +
    scale_x_date(date_labels = "%m-%d", 
                 date_breaks = "1 months") +
    theme_minimal() +
    theme(legend.position="none")
  
  return(chart)
}



