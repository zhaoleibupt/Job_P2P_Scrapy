library(rvest)
library(rjson)

####借款人
x<-NULL
for(i in 1:29){
  x[i]<-paste("http://www.lidfu.com/invest/index.html&page=",i,sep='')
}

go<-function(url){
  liduo<-read_html(url)
  name<-liduo%>%
    html_nodes("div.title span a")%>%
    html_text()
  name<-iconv(name,"utf8","gbk")
  
  je<-liduo%>%
    html_nodes("div.jiner.color_1")%>%
    html_text()
  je<-iconv(je,"utf8","gbk")
  
  lilv<-liduo%>%
    html_nodes("div.lilv span.color_1")%>%
    html_text()
  
  qixian<-liduo%>%
    html_nodes("div.qixian span.color_1")%>%
    html_text()
  qixian<-iconv(qixian,"utf8","gbk")
  
  fs<-liduo%>%
    html_nodes("div.fangshi span.color_1")%>%
    html_text()
  fs<-iconv(fs,"utf8","gbk") 
  
  
  url<-liduo%>%
    html_nodes("div.title span a")%>%
    html_attr("href")
  
  data<-data.frame(name,je,lilv,qixian,fs,url)
  data
}

data3<-NULL
for(i in 1:29){
  data3<-rbind(data3,go(x[i]))
}

write.csv(data3,"利多财富A.csv")

url_num <- substr(as.character(data3$url),30,nchar(as.character(data3$url))-5)
invest_url <-paste0('http://www.lidfu.com/index.php?user&q=get_pj_invest&pid=',url_num,'&currpage=1')

### "http://www.lidfu.com/index.php?user&q=get_pj_invest&pid=20150600001&currpage=1"
##########################


#get the first page
invest_go<-function(json_file){
  all_json_data <-NULL
  json_data <- fromJSON(readLines(json_file,encoding = 'utf8'))
  num<-matrix(unlist(json_data[[5]]), nrow=length(json_data[[5]]), byrow=T)
  finished_page <- num[1,1]
  per_page <- 10
  # to see whether have the second or more pages
  i = 0
  if(finished_page ==0){
    all_json_data<-NULL
  }
  else{
    url <-rep(json_file,finished_page)
    if(finished_page > per_page){
      while(finished_page > per_page ){
        json_file<-paste0(substr(json_file,1,nchar(json_file)-1),i+1)
        json_data <- fromJSON(readLines(json_file,encoding = 'utf8'))
        json_mat <- matrix(unlist(json_data[[4]]), nrow=length(json_data[[4]]), byrow=T)
        json_mat1 <- as.data.frame(json_mat)
        all_json_data <-rbind(all_json_data,json_mat1)
        finished_page = finished_page - 10*i
        i = i+1
      }
      all_json_data<-cbind(all_json_data,url) 
     }
   else{
     json_data <- fromJSON(readLines(json_file,encoding = 'utf8'))
     json_mat <- matrix(unlist(json_data[[4]]), nrow=length(json_data[[4]]), byrow=T)
     all_json_data<- as.data.frame(json_mat)
     all_json_data<-cbind(all_json_data,url) 
   }
  }
      
all_json_data
}
  
all_invest<-NULL
for(i in 1:length(invest_url)){
  all_invest<-rbind(all_invest,invest_go(invest_url[i]))
}
  

