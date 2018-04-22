## Get data

library(googledrive)
library(tidyverse)
library(readxl)

## https://drive.google.com/file/d/12lVAPKk1TnPxpeqBIuHvZOL1rupHCcOg/view?usp=sharing
file.id <- "12lVAPKk1TnPxpeqBIuHvZOL1rupHCcOg"
drive_download(file = as_id(file.id), path="data-raw/F.xlsx")

F.fb <- read_xlsx("data-raw/F.xlsx", sheet='FB_Data')
F.fb <- F.fb %>% select('Post Type',
                        'Total Reach',
                        'Organic Reach',
                        'Total Impressions',
                        'Engaged Users',
                        'Interactions',
                        'Reactions',
                        'Comments',
                        'Shares',
                        'Link Clicks',
                        'Other Clicks',
                        'Photo Views',
                        'Video Plays',
                        'Negative Feedback',
                        'Video Length',
                        'Organic Views',
                        'Paid Views',
                        'Organic 10-sec Views',
                        'Paid 10-sec Views',
                        'Organic Views to 95%',
                        'Paid Views to 95%',
                        'Reach (Fans)',
                        'Paid Reach (Fans)',
                        'Engaged Users (Fans)',
                        'Reach (Non-Fans)',
                        'Engaged Users (Non-Fans)',
                        'Channel',
                        'Organic / Paid')
