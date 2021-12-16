# install.packages("dplyr")

# ---- 데이터 수집 -----
library(dplyr)

# 요소수 문제 - 자동차
def_car <- readLines("data/def_news_car.txt", 
                     encoding = "UTF-8")

car <- def_car %>% 
  as_tibble() %>% 
  mutate(category = "article01")

def_china <- readLines("data/def_news_china.txt", 
                       encoding = "UTF-8")

china <- def_china %>% 
  as_tibble() %>% 
  mutate(category = "article02")

bind_news <- bind_rows(car, china) %>% 
  select(category, value)

head(bind_news)
tail(bind_news)

# ---- 데이터 전처리 -----
library(stringr)
news_df <- bind_news %>% 
  mutate(value = str_replace_all(value, "[^가-힣]", " "), 
         value = str_squish(value))

news_df
# tokenize 
# https://www.tidytextmining.com/
# install.packages("tidytext")
library(tidytext)
library(KoNLP)

# 사전 구축
# userDic <- data.frame(term = c('요소수', '저감장치'), tag ='ncn')

# ?buildDictionary
# buildDictionary(ext_dic = c('sejong', 'woorimalsam'), user_dic = userDic, replace_usr_dic = T)


# 형태소 분리기
news_df <- news_df %>% 
  unnest_tokens(input = value, 
                output = word, 
                token = extractNoun) # 형태소 분리기 투입

# news_df %>% count(category, word)
frequency <- news_df %>% 
  count(category, word) %>%
  filter(str_count(word) > 1) # 두 글자 이상 추출

# ---- 탐색적 자료 분석 ----
top10 <- frequency %>% 
  group_by(category) %>% 
  slice_max(n, n = 10)

library(ggplot2)

top10 %>% 
  # filter(category == "def_car") %>% 
  ggplot(aes(x = reorder(word, n), y = n, fill = category)) + 
  geom_col(fill = "pink") + 
  coord_flip() + 
  facet_wrap(~ category, scales = "free_y") + 
  theme_minimal()

# 키워드: 요소수
frequency %>% 
  # filter(word != "요소") %>% 
  group_by(category) %>% 
  slice_max(n, n = 10) %>% 
  ggplot(aes(x = reorder(word, n), y = n, fill = category)) + 
  geom_col(fill = "pink") + 
  coord_flip() + 
  facet_wrap(~ category, scales = "free_y") + 
  theme_minimal()

df_long <- frequency %>% 
  group_by(category) %>% 
  slice_max(n, n = 10) 
df_long

library(tidyr)
df_wide <- df_long %>% 
  pivot_wider(names_from = category, 
              values_from = n, 
              values_fill = list(n = 0))

df_wide

frequency_wide <- frequency %>% 
  pivot_wider(names_from = category, 
              values_from = n, 
              values_fill = list(n = 0))

frequency_wide %>% 
  mutate(ratio_article01 = ((article01 + 1) / sum(article01 + 1)), 
         ratio_article02 = ((article02 + 1) / sum(article02 + 1))) -> 
  frequency_wide2

frequency_wide2 %>% 
  mutate(odds_ratio = ratio_article01 / ratio_article02) %>%
  filter(odds_ratio != 1) -> frequency_wide3

temp_df <- tibble(x = c(2, 5, 10))
temp_df %>% mutate(y = rank(x))
temp_df %>% mutate(y = rank(-x))


top10 <- frequency_wide3 %>% 
  filter(rank(odds_ratio) <= 10 | rank(-odds_ratio) <= 10)

top10 %>% 
  mutate(category = ifelse(odds_ratio > 1, "article01", "article02"), 
         n = ifelse(odds_ratio > 1, article01, article02)) -> top10

ggplot(top10, aes(x = reorder_within(word, n, category), 
                  y = n, 
                  fill = category)) + 
  geom_col() + 
  coord_flip() + 
  facet_wrap(~ category, scales = "free_y") + 
  scale_x_reordered()


frequency_wide3 %>% 
  mutate(log_odds_ratio = log(odds_ratio), 
         category = ifelse(log_odds_ratio > 0, "article01", "article02")) %>%
  slice_max(abs(log_odds_ratio), n = 20, with_ties = F) -> top20

ggplot(top20, aes(x = reorder(word, log_odds_ratio), 
                  y = log_odds_ratio, 
                  fill = category)) + 
  geom_col() + 
  coord_flip() + 
  theme_minimal()