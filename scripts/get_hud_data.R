# Download data from HUD

library(tidyverse)
library(here)
library(readxl)

# Output file names

hud_out_file_csv <- here("Data_Transformation", "hud_2020_tract_joined.csv")
hud_out_file_rds <- here("Data_Transformation", "hud_2020_tract_joined.rds")

# Check if we have files already downloaded

if(file.exists(hud_out_file_csv)) {
  
  return(cat("HUD files already exists"))
  
} else {
  
  hud_2020_tract_AK_URL <- "https://www.huduser.gov/portal/datasets/pictures/files/TRACT_AK_MN_2020.xlsx"
  hud_2020_tract_MO_URL <- "https://www.huduser.gov/portal/datasets/pictures/files/TRACT_MO_WY_2020.xlsx"
  hud_2020_tract_AK_filepath <- here("Data", "TRACT_AK_MN_2020.xlsx")
  hud_2020_tract_MO_filepath <- here("Data", "TRACT_MO_WY_2020.xlsx")
  
  
  download.file(hud_2020_tract_AK_URL, hud_2020_tract_AK_filepath)
  download.file(hud_2020_tract_MO_URL, hud_2020_tract_MO_filepath)
  
  AK_data <- read_xlsx(hud_2020_tract_AK_filepath)
  MO_data <- read_xlsx(hud_2020_tract_MO_filepath)
  
  joined_data <- AK_data %>% 
    bind_rows(MO_data)
  
  # Save file
  write_csv(joined_data, hud_out_file_csv)
}
