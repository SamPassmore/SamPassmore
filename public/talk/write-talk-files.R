#!/usr/bin/Rscript

## Script to update the talks part of my website
library(googlesheets)
library(stringr)

gs_auth()
object = gs_url("https://docs.google.com/spreadsheets/d/1V-VWoaEWJAal20WTay_1wF9uCBJT8kOstegjNuWvLrU/edit#gid=0")
## Assuming I always want the first sheet 
talks = gs_read(object, check.names = TRUE, ws = 1)
talks = subset(talks, talks$Type == "Talk" | talks$Type == "Poster")
today = Sys.Date()

for(i in 1:nrow(talks)){
  row = talks[i,]
  
  title = row$Title
  date = lubridate::dmy(row$Date)
  year = lubridate::year(date)
  event = row$Event
  type = row$Type
  location = row$Location
  institute = row$Institute
  
  file = stringr::str_glue('+++
title = "{title}"
date = "{date}"  # Schedule page publish date.
draft = false
           
all_day = false
           
authors = []
           
# Name of event and optional event URL.
event = "{event}"
           
# Location of event.
location = "{institute}"
           
# Is this a featured talk? (true/false)
featured = false
           
+++
')
  
  institute_strip = institute %>% 
    tolower() %>%
    str_remove_all("[:space:]")
  fname = title %>% 
    str_extract_all('[:alnum:]') %>% 
    unlist(.) %>%
    paste0(., collapse = "") %>% 
    paste0("content/talk/", year, ., institute_strip,".md")
  fileConn<-file(fname)
  if(!file.exists(fname))
    writeLines(file, fileConn)
    close(fileConn)
}
