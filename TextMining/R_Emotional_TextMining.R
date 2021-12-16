# 텍스트 마이닝
# 감정 사전 불러오기
# 사전에 여러분들이 감정 사전 구축
library(readr)
library(dplyr)
dic <- read_csv("data/knu_sentiment_lexicon.csv")
# 긍정 단어
dic %>%
  filter(polarity == 2) %>%
  arrange(word)
# 부정 단어
dic %>%
  filter(polarity == -2) %>%
  arrange(word)
# 이모티콘
library(stringr)
dic %>%
  filter(!str_detect(word, "[가-힣]")) %>%
  arrange(word)
# sentiment 변수 추가 / 3개의 value로 재 가공
dic %>%
  mutate(sentiment = ifelse(polarity >= 1, "pos",
                            ifelse(polarity <= -1, "neg", "neu"))) %>%
  count(sentiment)
df <- tibble(sentence = c("이 옷 디자인이 매우 예쁘고 좋습니다.",
                          "이 옷 디자인은 매우 잘못되었습니다. , 마감이 안 좋고, 가격도 넘 비싸요"))
df
# 토크나이징 (word)
library(tidytext)
glimpse(df)
df <- df %>%
  unnest_tokens(input = sentence,
                output = word,
                token = "words",
                drop = F)
df <- df %>%
  left_join(dic, by = "word") %>%
  mutate(polarity = ifelse(is.na(polarity), 0, polarity))
df
score_df <- df %>%
  group_by(sentence) %>%
  summarise(score = sum(polarity))
score_df
# ---- 새로운 데이터 불러오기 ----
raw_news_comment <- read_csv("data/news_comment_tada.csv")
# install.packages("textclean")
glimpse(raw_news_comment)
# ----- 데이터 전처리 ----
# html 제거
# 별점 데이터 수집
library(textclean)
news_comment <- raw_news_comment %>%
  mutate(id = row_number(),
         reply = str_squish(replace_html(reply)))
glimpse(news_comment)
# ---- 토큰화 ----
library(tidytext)
library(dplyr)
word_comment <- news_comment %>%
  unnest_tokens(input = reply,
                output = word,
                token = "words",
                drop = F)
word_comment %>%
  select(word, reply)
# 감정 점수 부여
word_comment <- word_comment %>%
  left_join(dic, by = "word") %>%
  mutate(polarity = ifelse(is.na(polarity), 0, polarity))
word_comment %>% select(word, polarity) %>%
  arrange(polarity)
word_comment <- word_comment %>%
  mutate(sentiment = ifelse(polarity == 2, "pos",
                            ifelse(polarity == -2, "neg", "neu")))
word_comment %>%
  count(sentiment)
top10_sentiment <- word_comment %>%
  filter(sentiment != "neu") %>%
  count(sentiment, word) %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10)
top10_sentiment
# 막대 그래프 만들기
library(ggplot2)
ggplot(top10_sentiment, aes(x = reorder(word, n),
                            y = n,
                            fill = sentiment)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust = -0.3) +
  facet_wrap(~ sentiment, scales = "free") +
  theme_minimal()
score_comment <- word_comment %>%
  group_by(id, reply) %>%
  summarise(score = sum(polarity)) %>%
  ungroup()
glimpse(score_comment)
score_comment %>%
  select(score, reply)