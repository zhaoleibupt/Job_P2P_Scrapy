library(XML)
library(RCurl)
library(stringr)

####爬取借款人信息
x<-NULL
for(i in 1:40){
  x[i]<-paste('http://www.dhqjr.com/projects/list?page=',i,sep='')
}


go<-function(url){
  doc<-htmlParse(url,encoding='UTF-8')
  rootnodes<-xmlRoot(doc)
  name<-xpathSApply(rootnodes,"//div[@class='name']/a",xmlValue)
  money<-xpathSApply(rootnodes,"//div[@class='em amt']",xmlValue)
  money=gsub('\\t|\\n|\\r','',money)
  rate<-xpathSApply(rootnodes,"//div[@class='em rate']",xmlValue)
  rate=gsub('\\t|\\n|\\r','',rate)
  date<-xpathSApply(rootnodes,"//div[@class='em life']",xmlValue)
  date=gsub('\\t|\\n|\\r','',date)
  process<-xpathSApply(rootnodes,"//div[@class='perTxt']",xmlValue)
  
  text<-NULL
  text<-getURL(url)
  ##<a href=\" /projects/detail?proNo=PE20160312001\"> 
  url1<-str_extract_all(text,'<a href=(.*?)> ')[[1]][-1]
  part<-substr(url1,11,nchar(url1)-3)
  all_urls<-paste('http://www.dhqjr.com/',part,sep='')
  data<-data.frame(name,money,rate,date,process,all_urls)
  data
}


data1<-NULL
for(i in 1:40){
 
  data1<-rbind(data1,go(x[i]))
}

write.csv(data1,'东融在线(bet).csv')





####爬取投资人信息

fun2<-function(x){
  text<-NULL
  data2<-NULL
  text<-getURL(x)
##<a href=\" /projects/detail?proNo=PE20160312001\"> 
 url1<-str_extract_all(text,'<a href=(.*?)> ')[[1]][-1]
 part<-substr(url1,11,nchar(url1)-3)
 all_urls<-paste('http://www.dhqjr.com/',part,sep='')
for(i in 1:length(all_urls))
{
  invest<-readHTMLTable(all_urls[i])[[2]]
  url2<-rep(all_urls[i],dim(invest)[1])
  invest$url<-url2
  names(invest)<-c('投资人','年化利率','投资金额（元）','投资时间','状态','url')
  data2<-rbind(data2,invest)
}
 data2
}



data3<-NULL
for(i in 23:38){
  data3<-rbind(data3,fun2(x[i]))
}


write.csv(data3,'invest2.csv')
