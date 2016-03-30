f<-scan('E:/test1.txt',sep='\n',what='')
seg <- qseg[f] #使用qseg类型分词，并把结果保存到对象seg中
seg <- seg[nchar(seg)>1] #去除字符长度小于2的词语

seg <- table(seg) #统计词频

seg <- seg[!grepl('[0-9]+',names(seg))] #去除数字
length(seg) #查看处理完后剩余的词数

seg <- sort(seg, decreasing = TRUE)[1:100] #降序排序，并提取出现次数最多的前100个词语
seg #查看100个词频最高的


bmp("comment_cloud.bmp", width = 100, height = 100)
par(bg = "white")
wordcloud(names(seg), seg, colors = rainbow(100), random.order=F)
dev.off()
