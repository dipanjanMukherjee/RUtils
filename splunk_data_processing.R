library(readr)
library(tidyr)



setwd("")

properties <- c("metrics","host")

myfiles <- list.files(pattern = "*.csv")
for(k in myfiles){
  if(!exists("dataset1")){
    dataset1 <- readr::read_csv(k, col_name = properties, col_types = "cc______", skip = 1)
  }
  
  else{
    temp_dataset <- readr::read_csv(k, col_names = properties, col_types = "cc_____", skip = 1)
    dataset1 <- rbind(dataset1, temp_dataset)
    rm(temp_dataset)
  }
  write.csv(dataaset1, file = "data_full.csv")  
}

metric_vec <- as.vector(dataset1$metrics)
raw_metric_vec <- gsub("\n", "", metric_vec, fixed = TRUE)
rm(metric_vec)
df_raw <- as.data.frame(raw_metric_vec) %>% tidyr::separate(raw_metric_vec,c("loggedtime","gpu"))

df_raw <- cbind(df_raw, host = dataset1$host)

#remove punctuations from columns
df_raw$col1 <- gsub(".*=","", df_raw$col1)
df_raw$col2 <- gsub(".*=","", df_raw$col2)
df_raw$col3 <- gsub(".*=","", df_raw$col3)
df_raw$col4 <- gsub(".*=","", df_raw$col4)

df_raw$col2 <- gsub("\"","",df_raw$col2)
df_raw$col3 <- gsub("\"","",df_raw$col3)

df_raw$col5 <- sub("instance=","",df_raw$col5)
df_raw$col5 <- gsub("\"","",df_raw$col5)

df_raw$loggedtime <- as.POSIXct(df_raw$loggedtime, format = "%m/%d/%Y %H:%M:%OS %z")

#changing datatype for calcluation purpose
df_raw$col4 <- as.double(df_raw$col3)
df_raw$col1 <- as.factor(df_raw$col1)
df_raw$col3 <- as.factor(df_raw$col3)

#
write.csv(metrics_tbl, file = "metrics_tbl.csv")

avg_metrics_tbl <- metrics_tbl %>% group_by(host, counter) %>% summarise(mean_val = mean(value))
max_metrics_tbl <- metrics_tbl %>% group_by(host, counter) %>% summarise(max_val = max(value))
min_metrics_tbl <- metrics_tbl %>% group_by(host, counter) %>% summarise(min_val = min(value))

write.csv(avg_metrics_tbl, "avg.csv")
write.csv(max_metrics_tbl, "max.csv")
write.csv(min_metrics_tbl, "min.csv")

# filtering the tables based on counter column values
avg_cputime_tbl <- stats::filter(avg_metrics_tbl, counter == "% Processor Time")
write.csv(avg_cputime_tbl, file = "cpu.csv")

avg_gputime_tbl <- stats::filter(avg_metrics_tbl, counter == "% GPU Usage")
write.csv(avg_gputime_tbl, file = "gpu.csv")