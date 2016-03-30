library(XML)
library(RCurl)
library(stringr)


x<-NULL
for(i in 1:9){
  x[i]<-paste('http://www.hongyundt.com/invest/index.html?p=',i,sep='')
}

go<-function(url){
  doc<-htmlParse(url,encoding = 'UTF-8')
  rootsNode<-xmlRoot(doc)
  title<-xpathSApply(rootsNode,'//li[@class="title"]/span',xmlValue)
  lilu<-xpathSApply(rootsNode,'//p[@class="num color-f7a947"]',xmlValue)
  all<-xpathSApply(rootsNode,'//p[@class="num color-383b3e"]',xmlValue)
  a<-c(T,F)
  time<-gsub(' |\\r\\n','',all[a])
  b<-c(F,T)
  money<-all[b]
  data=data.frame(title,lilu,time,money)
  data
}

data1<-NULL
for (i in 1:9){
  data1<-rbind(data1,go(x[i]))
}

write.csv(data1,'鸿运当投.csv')






text<-NULL
url<-NULL
for (i in 1:9){
  x[i]<-paste('http://www.hongyundt.com/invest/index.html?p=',i,sep='')
  text[i]<-getURL(x[i])
  a<-str_extract_all(text[i],'a href=\"(.*?)">\r\n')[[1]]
  a<-substr(a,9,nchar(a)-4)
  url<-c(url,a)
}

all_url<-paste('http://www.hongyundt.com',url,sep='')


all<-NULL
m<-NULL
pages<-NULL
for(i in 1:length(all_url)){
  m<-getURL(all_url[i])
  
  pages<-str_extract_all(m,'共 \\d+ 页')[[1]]
  pages<-as.numeric(substr(pages,3,nchar(pages)-2))
   
  all<-c(all,pages)
}
data2<-data.frame(url=all_url,pages=all)
num<-as.numeric(substr(all_url,33,nchar(all_url)-5))
num1<-rep(num,times=all)
num2<-unlist(lapply(all, function(x) 1:x))
data3<-data.frame(num1,num2)
invest<-paste("http://www.hongyundt.com/invest/investRecord?borrow_id=",num1,"&p=",num2,sep="")
write.table(invest,'invest.txt')


data3<-NULL
for(i in 1:length(invest)){

  doc<-htmlParse(invest[i],encoding='UTF-8')
  rootnodes<-xmlRoot(doc)
  x<-xpathSApply(rootnodes,'//td',xmlValue)
  title<-substr(invest[i],1,nchar(invest[i])-4)
  names<-x[seq(1,length(x),by=4)]
  types<-x[seq(2,length(x),by=4)]
  money<-x[seq(3,length(x),by=4)]
  dates<-x[seq(4,length(x),by=4)]
  
  invests<-data.frame(title,names,types,money,dates)
  data3<-rbind(data3,invests)
}
write.csv(data3,'invests.csv')
