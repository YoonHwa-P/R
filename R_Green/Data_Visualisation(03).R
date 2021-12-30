install.packages("tidyverse")
library(tidyverse)

#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
#> ✔ ggplot2 3.3.2     ✔ purrr   0.3.4
#> ✔ tibble  3.0.3     ✔ dplyr   1.0.2
#> ✔ tidyr   1.1.2     ✔ stringr 1.4.0
#> ✔ readr   1.4.0     ✔ forcats 0.5.0
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()

install.packages(c("nycflights13", "gapminder", "Lahman"))

# how to visualise your data using ggplot2. R 
# ggplot2는 그래프를 그려주는 프로그램 
#https://byrneslab.net/classes/biol607/readings/wickham_layered-grammar.pdf

# 3.1.1 Prerequisites
# ggplot2 설치

#3.2 First steps
#US Environmental Protection Agency on 38 models of car
# A data frame is a rectangular
mpg

ggplot(data = mpg) +
  geom_point(mapping = aes(x= displ, y = hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y= hwy, alpha = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ <5))


