library(rjson)
json_file <- "http://data.01caijing.com/p2p/website/index-data.json?website=www.hairongyi.com"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))
json_mat <- matrix(unlist(json_data[[3]]), nrow=length(json_data[[3]]), byrow=T)
json_mat <- as.data.frame(json_mat)
write.csv(json_mat,'json_mat.csv')
