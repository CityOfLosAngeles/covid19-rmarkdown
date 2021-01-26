library(rmarkdown)
library(stringr)
library(tidyverse)
library(knitr)

# create an index
county <- c("Los Angeles", "Alameda")

# create a data frame with parameters and output file names
reports <- tibble(
  filename = str_c(county, ".pdf"),
  params = map(county, ~list(county = .))
)


# iterate render() along the tibble of parameters and file names
reports %>%
  select(output_file = filename, params) %>%
  pwalk(rmarkdown::render, input = "notebooks/ca-report", 
        output_format = "pdf_document",
        output_dir = "reports")



html_reports <- tibble(
  filename = str_c(county, ".html"),
  params = map(county, ~list(county = .))
)

html_reports %>%
  select(output_file = filename, params) %>%
  pwalk(rmarkdown::render, input = "notebooks/county-charts-html.Rmd", 
        output_format = "html_document",
        output_dir = "reports")


# Just render 1 report, don't need the pwalk
rmarkdown::render(input = "notebooks/county-report.Rmd",
                  output_format = "html_document",
                  output_dir = "reports", 
                  output_file = "county-report.html"
                  )



# for pdf reports  
#   rmarkdown::render(input = "/Users/majerus/Desktop/R/auto_reporting/test/r_script_pdf.Rmd", 
#           output_format = "pdf_document",
#           output_file = paste("test_report_", car, Sys.Date(), ".pdf", sep=''),
#           output_dir = "/Users/majerus/Desktop/R/auto_reporting/test/reports")