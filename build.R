## update talks
source('content/talk/write-talk-files.R')

## update publications
#source()

blogdown::build_dir()
blogdown::serve_site()
