write('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', file = "~/.Renviron", append = TRUE)

Sys.which("make")
## "C:\\rtools40\\usr\\bin\\make.exe"

install.packages("jsonlite", type = "source")

