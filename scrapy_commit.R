library(XML)
#²âÊÔ74Ìõ
test<-read.table('E:/test.txt')
a<-as.vector(test[,1])
a<-a[1:5]

#²âÊÔ1000Ìõ
#test<-read.table('E:/url.txt')
#a<-as.vector(test[,1])

#a<-a[1:1000]
url<-NULL
topic<-list()
title<-NULL


for (i in 1:length(a)){
url<-a[i]
doc<-htmlParse(url,encoding="UTF-8")
rootNode<-xmlRoot(doc)
title[i]<-xpathSApply(rootNode,"//title",xmlValue)
topic[[i]]<-xpathSApply(rootNode,"//span[@class='conter']",xmlValue)
}

name<-NULL
for(i in 1:length(a)){
name[i]<-substr(title[i],1,regexpr('_',title[1])-1)
}

total<-rep(name,sapply(topic,length))

word<-NULL
for(i in 1:length(topic)){
  word<-c(word,paste(topic[[i]],sep=','))
}


data1<-data.frame(name=total,word=word)
write.csv(data1,"E:/data1.csv")
