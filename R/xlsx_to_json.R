library(openxlsx)
library(jsonlite)
library(base64enc)

#' xlsx_to_json
#' 
#' Accepts base64 string of excel workbook and outputs a JSON with base64 of individual worksheets.
#' @param base64_xlsx base64 of excel workbook.
#' @return JSON of individual worksheets.
xlsx_to_json <- function(base64_xlsx) {
  
  excel = base64decode(base64_xlsx)
  
  wb <- loadWorkbook(excel)
  
  sheet_names <- names(wb)
  
  output <- list()
  
  for (sheet_name in sheet_names) {
    sheet_data <- read.xlsx(wb, sheet = sheet_name)
    sheet_base64 <- base64encode(charToRaw(write.csv(sheet_data, row.names = FALSE)))
    output[[sheet_name]] <- sheet_base64
  }
  
  json_output <- toJSON(output)
}