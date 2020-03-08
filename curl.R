library(httr)

start.time <- Sys.time()

body <- '{}'

res <- httr::POST(url ="", httr::content_type_json(), body = body)

httr::content(res. text, encoding = "ISO-8859-1")

end.time <- Sys.time()

time.taken <- end.time - start.time

time.taken
