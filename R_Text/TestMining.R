#install.packaged("multilinguer")

#install.packages("remotes")
#remotes::install_github("mrchypark/multilinguer")

install_jdk()

write('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', 
      file = "~/.Renviron", append = TRUE)
Sys.which("make")


install.packages("jsonlite", type = "source")

install.packages(c("stringr", "hash", "tau", "Sejong", "RSQLite", "devtools"),
                 type = "binary")

# install.packages("remotes")
remotes::install_github("haven-jeon/KoNLP",
                        upgrade = "never",
                        force = TRUE,
                        INSTALL_opts = c("--no-multiarch"))

library(KoNLP)
useNIADic()

text = "뿌리산업’의 기반이 되는 공정기술의 범위가 관련법 제정 10년 만에 확대 개편된다. 뿌리기업 우대 지원과 청년층 등 신규인력 유입 지원을 강화하기 위한 법적 토대도 마련된다.

산업통상자원부는 이 같은 내용을 담은 ‘뿌리산업 진흥과 첨단화에 관한 법률(뿌리산업법) 시행령’ 개정안이 14일 국무회의에서 의결돼 오는 16일부터 시행된다고 밝혔다.

먼저 뿌리산업법 기반 공정기술(뿌리기술)의 범위가 기존 6개(주조, 금형, 소성가공, 용접, 표면처리, 열처리)에서 14개로 늘어난다.

구체적으로 소재 다원화 공정기술에 사출·프레스, 정밀가공, 적층제조, 산업용 필름 및 지류 등 4개 기술이 포함된다. 산업부는 이를 통해 세라믹, 플라스틱, 탄성소재, 탄소, 펄프 등 다양한 소재 기반 제조 공정을 확산할 계획이다. 또 지능화 공정기술로 로봇, 센서, 산업 지능형 소프트웨어, 엔지니어링 설계 등 4개 기술이 추가된다.

뿌리기술 범위가 확대되면서 뿌리산업의 범위도 기존 6대 산업, 76개 업종에서 14대 산업, 111개 업종으로 늘어난다.

이번 개정을 통해 뿌리기업 확인 절차, 확인서 유효기간(3년), 사후관리 등에 관한 규정도 신설됐다. 뿌리기업은 뿌리기술을 활용해 사업을 영위하는 업종 또는 뿌리기술에 활용되는 장비 제조 분야를 말한다.

뿌리기업 확인 제도는 외국인 근로자 고용 우대 혜택 등이 주어지는 뿌리산업 관련 우대 지원 대상을 명확히 정하기 위한 것으로 국가뿌리산업진흥센터에서 확인서를 발급해오고 있다. 2012년부터 1만1766건이 발급됐으며 현재 5843건이 유효한 것으로 집계됐다.

‘일하기 좋은 뿌리기업’ 선정을 위한 기준과 절차, 지원 내용 등에 관한 규정도 새로 만들어졌다. ‘일하기 좋은 뿌리기업’은 뿌리산업에 청년층 등 신규 인력 유입을 촉진하기 위해 근로·복지 환경, 성장 역량 등이 우수한 기업을 산업부가 선정해 홍보 등을 지원하는 제도다.

산업부는 이번 개정 사항이 원활히 시행될 수 있도록 업종별 협·단체, 뿌리기업, 지자체 등을 대상으로 적극 홍보할 방침이다. 아울러 매년 발간하는 뿌리산업 백서를 통해 새롭게 추가되는 8대 차세대 공정기술에 대한 내용, 기술 동향 등을 상세하게 제공하기로 했다．

산업부 관계자는 “이번 개정은 2011년 뿌리산업법 제정 후 10년 만에 뿌리기술을 소재다원화와 지능화 중심으로 확장한 것으로, 뿌리산업의 기술 융복합화와 첨단화를 촉진하고 신규 인력 유입 지원을 강화하기 위한 법적 토대를 마련하였다는 데에 의의가 있다”고 말했다."

extractNoun(text)


# library(remotes)
remotes::install_github("junhewk/RcppMeCab", force = TRUE)

library(RcppMeCab)


text1 = "안녕하세요?!"
pos(sentence = text1)

text2 = enc2utf8(text1)
pos(sentence = text2)
