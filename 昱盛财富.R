library(RCurl)
library(XML)
library(stringr)

myHttpheader <- c(
  "User-Agent"="Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6) ",
  "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Accept-Language"="en-us",
  "Connection"="keep-alive",
  "Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7"
  )
temp <- getURL("http://www.yushengcaifu.com/invest?p=1",httpheader=myHttpheader)




a<-str_extract_all(temp,'<a.*?href=\"/invest(.*?)"><')[[1]]
nchar('<a href=\"/')
a<-substr(a,11,nchar(a)-3)
paste('http://www.yushengcaifu.com/',a,sep='')








url<-'http://www.yushengcaifu.com/invest/detail/id/140.html'
TableData <- readHTMLTable(url)
