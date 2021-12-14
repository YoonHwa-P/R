install.packages("dplyr")
library(dplyr)

# 요소수 문제 - 자동차
def_car <- readLines("data/def_news_car.txt", 
                     encoding = "UTF-8")

car <- def_car %>% 
  as_tibble() %>% 
  mutate(category = "def_car")

def_china <- readLines("data/def_news_china.txt", 
                       encoding = "UTF-8")

china <- def_china %>% 
  as_tibble() %>% 
  mutate(category = "def_china")
#  concat과   같은 
bind_news <- bind_rows(car, china) %>% 
  select(category, value)

head(bind_news)
tail(bind_news)


# --- data 수집--- 
# --- data 전처리 --- 

library(stringr)
news_df <- bind_news %>% 
  mutate(value = str_replace_all(value, "[^가-힣]", " "), 
         value = str_squish(value))


# 특수문자, 한자, 숫자 등이 사라지고 순수한 한글만 남는다. 


# --- 토큰화 --- : Tokenize 
news_df
# tokenize 
# https://www.tidytextmining.com/
install.packages("tidytext")
library(tidytext)
library(KoNLP)
useNIADic()


# 사전 구축
userDic <- data.frame(term = c('요소수', '저감장치'), tag ='ncn')

?buildDictionary
buildDictionary(ext_dic = c('sejong', 'woorimalsam'), user_dic = userDic, replace_usr_dic = T)

extractNoun("요소수 ")



# 형태소 분리기
news_df <- news_df %>% 
  unnest_tokens(input = value, 
                output = word, 
                token = extractNoun) # 형태소 분리기 투입

# news_df %>% count(category, word)
frequency <- news_df %>% 
  count(category, word) %>%
  filter(str_count(word) > 1) # 두 글자 이상 추출, 결측치 처리


# --- EDA --- 
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

  
