#str_trim lib
library(stringr)
#install.packages("KoNLP")
Sys.setenv(JAVA_HOME="C:\\Java\\Program Files\\jre1.8.0_121")
library(KoNLP)
useSejongDic()                 #한글 사전 사용
#install.packages("wordcloud2")
library(wordcloud2)


rm("text","nouns", "t") #변수초기화
setwd("C:\\R") #기본 폴더 설정

#파일읽기
t <- file("KakaoTalk_20170103_1808_29_187_group.txt", encoding = "UTF-8")
text <- readLines(t)
close(t)



#--------------- 2016년 8월 8일 월요일 --------------- 이 형태 제거
text <- gsub("\\--------------- (.*?)\\ ---------------", " ", text)

#대괄호안의 내용 삭제(대괄호도)
text <- gsub("\\[(.*?)\\]", " ", text)

#이모티콘 제거
text <- gsub("(이모티콘)", " ", text)

#사진
text <- gsub("사진", " ", text)

#제거할 단어들
text <- gsub("XXX", " ", text)



#사전추가
#word<-data.frame(c('유비케어', '굿모닝', "광화문"), "ncn")
#buildDictionary(ext_dic = c('sejong', 'woorimalsam'), user_dic=word,replace_usr_dic = T)



text <- gsub("[^가-힣]", " ", text)
head(text, 20)
text <- str_trim(text)

text <- Filter(function(x){nchar(x) <= 10}, text)


head(text)




nouns = sapply(text, extractNoun, USE.NAMES=F)

unlist_nouns <- unlist(nouns)

filter2_nouns <- Filter(function(x){nchar(x) >= 2 & nchar(x) <= 5}, unlist_nouns)

wordcount <- table(filter2_nouns)

write.csv(wordcount, "c:\\R\\Kakaotalk_20170515.csv")

wordcloud2(data = wordcount, minSize = 10)
