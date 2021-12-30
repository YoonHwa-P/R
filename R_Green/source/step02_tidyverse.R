#Install tidverse : packages를 CRAN에서 내려 받음.
#경로 : C:\Users\GREEN\AppData\Local\Temp\RtmpauPN6o\downloaded_packages


install.packages("tidyverse", dependencies = TRUE)
install.packages("lubridate", dependencies = TRUE)
library(tidyverse)
library(lubridate)


# data import, 변수명 확인 
iris <- iris
glimpse(iris)


#graph x축, y축 확인 
ggplot(iris, aes(x= Sepal.Length, y= Sepal.Width, colour= Species, size = Petal.Length))+
  
  #시각화 그래프 종류 입력
  #geom_point(colour = "orange", size = 4, shape = 1) +
  geom_point() +
  #옵션 변경
  labs(title = "your_title",
       subtitile = "yr_subtitle",
       x = "ur_x",
       y = "ur_y",
       caption = "Created by YH"
       )+
  theme_minimal()


---
  
# library
library(ggridges)
library(ggplot2)
library(viridis)
library(hrbrthemes)

# Plot
ggplot(lincoln_weather, aes(x = `Mean Temperature [F]`, y = `Month`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_fill_viridis(name = "Temp. [F]", option = "C") +
  labs(title = 'Temperatures in Lincoln NE in 2016') +
  theme_ipsum() +
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8)
  )

  
  

install.packages("gganimate", dependencies = TRUE)
library(ggplot2)
library(gganimate)
mtcars
glimpse(mtcars)

ggplot(mtcars, aes(factor(cyl), mpg)) + 
  geom_boxplot() + 
  # Here comes the gganimate code
  transition_states(
    gear,
    transition_length = 2,
    state_length = 1
  ) +
  enter_fade() + 
  exit_shrink() +
  ease_aes('sine-in-out')


library(gapminder)
