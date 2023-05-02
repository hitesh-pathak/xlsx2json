library(openxlsx)
library(jsonlite)
library(base64enc)

#'  xlsx_to_json
#'  
#'  This functions accepts the base 64 encoded string of an excel workbook, and outputs a JSON with base 64 strings of the worksheets contained within the workbook.
#'  @param base64_xlsx base64 string of the excel workbook
#'  
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