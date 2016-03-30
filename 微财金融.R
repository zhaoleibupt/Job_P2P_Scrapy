 url1<-NULL
 h<-c( 1 , 2  ,4,  7 , 9 ,11 ,13 ,15 ,17, 18  ,20, 21 ,23 ,25 ,26) 
 h<-sort(h,decreasing=T)
 for(i in h){
     url1[i]<-paste('http://www.weicaijr.com/borrowinfo?id=9000',i+161,sep='')
   }
 
   #url<-'http://www.weicaijr.com/borrowinfo?id=9000187'
   
   go<-function(url){
       doc<-htmlParse(url,encoding='UTF-8')
       rootNode<-xmlRoot(doc)
       title<-xpathSApply(rootNode,"//li[@class='tr_s2']/span",xmlValue)
       
         
         times<-NULL
         names<-NULL
         money<-NULL
         times<-title[seq(1,length(title),by=3)]
         names<-title[seq(2,length(title),by=3)]
         money<-title[seq(3,length(title),by=3)]
         data1<-data.frame(times,names,money)
         data1
       }
   
   data<-NULL
   for (i in h)
      {
        data<-rbind(data,go(url1[i]))
   }
   

   
