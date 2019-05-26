library(jsonlite)

json <- "D:/input.json"
document <- jsonlite::fromJSON(json, flatten = TRUE)

dat <- document$parameters

doc <- as.data.frame(document)

pipe <- doc$pipeline
path <- doc$path

#
testda <- function(json){
  document <- jsonlite::fromJSON(json)
  doc <- as.data.frame(document)
  pipe <- doc$pipeline
  path <- doc$path
  print(pipe)
  print(path)
}
testda("D/input.json")