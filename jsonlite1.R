library(jsonlite)

#get the first page
json_file <-  "http://www.lidfu.com/index.php?user&q=get_pj_invest&pid=20150600001&currpage=1"
json_data <- fromJSON(readLines(json_file,encoding = 'utf8'))

num<-matrix(unlist(json_data[[5]]), nrow=length(json_data[[5]]), byrow=T)
finished_page <- num[1,1]
per_page <- 10



# to see whether have the second or more pages
i = 0
all_json_data <-NULL

while(finished_page > per_page ){
  json_file<-paste("http://www.lidfu.com/index.php?user&q=get_pj_invest&pid=20150600001&currpage=",i+1,sep='')
  json_data <- fromJSON(readLines(json_file,encoding = 'utf8'))
  json_mat <- json_data[[4]]
  all_json_data <-rbind(all_json_data,json_mat)
  finished_page = all_num - 10*i
  i = i+1
}
