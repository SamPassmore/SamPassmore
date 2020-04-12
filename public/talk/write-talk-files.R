#!/usr/bin/Rscript

## Script to update the talks part of my website
library(googlesheets4)
library(stringr)

url = "https://docs.google.com/spreadsheets/d/11BSx_rj4XqgrxLuw7asd2etWiNzDqgNskqYhQg3vJhw/edit#gid=0"

# authenticate
sheets_auth()

talks = read_sheet(url)
talks = subset(talks, talks$Type == "Talk" | talks$Type == "Poster")
today = Sys.Date()

for(i in 1:nrow(talks)){
  row = talks[i,]
  
  title = row$Title
  date = lubridate::ymd(row$Date)
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
