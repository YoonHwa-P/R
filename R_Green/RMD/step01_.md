---
title: "by RMD file in R-studio"
author: "YH"
date: '2021 11 30 '
output: 
  html_document:
    keep_md: true
    toc : true
---

## 옵션

- 여기서 option을 변경 할 수 있다. 




```r
# install.packages("tidyverse")
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
```

```
## v ggplot2 3.3.5     v purrr   0.3.4
## v tibble  3.1.6     v dplyr   1.0.7
## v tidyr   1.1.4     v stringr 1.4.0
## v readr   2.1.0     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
# install.packages(c("nycflights13", "gapminder", "Lahman"))
```




## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
summary(cars)
```

```
##      speed           dist       
##  Min.   : 4.0   Min.   :  2.00  
##  1st Qu.:12.0   1st Qu.: 26.00  
##  Median :15.0   Median : 36.00  
##  Mean   :15.4   Mean   : 42.98  
##  3rd Qu.:19.0   3rd Qu.: 56.00  
##  Max.   :25.0   Max.   :120.00
```

## Including Plots

You can also embed plots, for example:

![](step01__files/figure-html/pressure-1.png)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.


## \'##'이건 테이블 목차


Ctrl + Alt + I = 

```r
a= 1
```

소스코드를 입력하는 박스가 나온다. 


### 3.5 Facets

- multiple plot을 한 plot에 넣기
- python의 subplot과 같은 느낌.



```r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 3)
```

![](step01__files/figure-html/unnamed-chunk-3-1.png)<!-- -->

  > mpg$class
mpg data 안에 있는 class column을 볼 수 있다. 


두 변수의 조합에서 플롯을 면으로 표시하려면 플롯 호출에 facet_grid(). pacet_grid()의 첫 번째 인수도 공식이다. 이때 공식에는 ~로 구분된 두 개의 변수 이름이 포함되어야 합니다.



```r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
```

![](step01__files/figure-html/unnamed-chunk-4-1.png)<!-- -->

행 또는 열 차원에서 면을 표시하지 않으려면 변수 이름(예: + facet_grid()) 대신 .를 사용합니다. ~ 사이얼)


```r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
```

![](step01__files/figure-html/unnamed-chunk-5-1.png)<!-- -->


