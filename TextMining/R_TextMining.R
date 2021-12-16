# ---- 데이터 불러오기 ----

library(ggplot2) # 시각화 코드
library(dplyr) # 데이터 가공
library(reshape) # 데이터 가공 <-- tidyr
library(readr) # 파일 입출력

raw_reviews = read_csv("data/Womens Clothing E-Commerce Reviews.csv") %>% select(-1)

# raw_reviews <- raw_reviews %>% select(-1)
glimpse(raw_reviews)

colnames(raw_reviews) <- c("ID", "Age", "Title", "Review", "Rating", "Recommend", "Liked", "Division", "Dept", "Class")

glimpse(raw_reviews) 

# age 리뷰 작성한 고객의 연령
# Title, Review Text 리뷰 제목, 내용
# Rating: 고객이 부여한 평점
# Recommend IND: 추천 여부
# Positive Feedback Count: 좋아여 수치
# Division, Dept, Class --> 상품의 대분류 정보

set.seed(2021)
library(tm)

idx = sample(1:nrow(raw_reviews), nrow(raw_reviews) * 0.1, replace = FALSE)

reviews = raw_reviews[idx, ]

# 텍스트 데이터 추출
REVIEW_TEXT = as.character(reviews$Review)

# 텍스트 데이터
REVIEW_TEXT[1:10]

# 텍스트 데이터 모두 소문자
TEXT_lower = tolower(REVIEW_TEXT)
TEXT_lower[1]

# Corpus: 말뭉치
# 텍스트 데이터 --> Corpus (말뭉치) --> 특수 문자 및 숫자 제거, 불용어 처리 --> 키워드 행렬

Corpus_df = Corpus(VectorSource(TEXT_lower))
Corpus_tm = tm_map(Corpus_df, removePunctuation) # 특수문자 제거
Corpus_tm = tm_map(Corpus_df, removeNumbers) # 특수문자 제거
Corpus_tm = tm_map(Corpus_df, removeWords, c(stopwords("english"))) # 불용어 제거

# Term Document Matrix
?TermDocumentMatrix
tdm_df = TermDocumentMatrix(Corpus_tm)
# tdm_df$dimnames$Terms

tdm_matrix = as.matrix(tdm_df)


# 키워드 등장 빈도 데이터셋
freq = rowSums(tdm_matrix)
freq

data.frame(
  word = names(freq), 
  freq = freq 
) %>% arrange(-freq) -> FREQ_df

glimpse(FREQ_df)

# 워드 클라우드
library(wordcloud)

wordcloud(words = FREQ_df$word, 
          freq = FREQ_df$freq, 
          max.words = 300, 
          random.order = FALSE, 
          random.color = TRUE, 
          colors = brewer.pal(8, "Dark2"))

# ---- 키워드 토큰화 ---- 
library(tokenizers)
unlist(tokenize_word_stems(REVIEW_TEXT[1]))

# 단어를 이어 붙인 후, 토큰화된 단어들로 문장 재구성
TEXT_Token = c()
for(i in 1:length(REVIEW_TEXT)) {
  token_words = unlist(tokenize_word_stems(REVIEW_TEXT[i]))
  Sentence = ""
  
  for (tw in token_words) {
    Sentence = paste(Sentence, tw)
  }
  
  TEXT_Token[i] = Sentence
  
}

REVIEW_TEXT[1]
TEXT_Token[1]

# ---- 텍스트 전처리 ----
Corpus_token = Corpus(VectorSource(TEXT_Token))
Corpus_tm_token = tm_map(Corpus_token, removePunctuation)
Corpus_tm_token = tm_map(Corpus_token, removeNumbers)
Corpus_tm_token = tm_map(Corpus_token, removeWords, c(stopwords("English")))

TDM_Token = TermDocumentMatrix(Corpus_tm_token)
TDM_Matrix_Token = as.matrix(TDM_Token)
Freq_Token = rowSums(TDM_Matrix_Token)

data.frame(
  words = names(Freq_Token), 
  freq = Freq_Token
) %>% arrange(-freq) -> TERM_Token_df

nrow(TERM_Token_df)

wordcloud(words = TERM_Token_df$word, 
          freq = TERM_Token_df$freq, 
          max.words = 300, 
          random.order = FALSE, 
          random.color = TRUE, 
          colors = brewer.pal(8, "Dark2"))
