# Diff-COVID19-Impact-on-GI
Contains R code supporting publication titled "Differential Impact of COVID-19 Pandemic on Laboratory Reporting of Norovirus and Campylobacter in England"

### Prerequisites

* Basic knowledge of R programming language.
* R or RStudio is installed on your machine.
* Familiarity with R Markdown.

### How to use

* Clone/download the repository.<br>
```
git clone 'https://github.com/NikolaOndrikova/Diff-COVID19-Impact-on-GI.git'
```
* Set your working directory from R/RStudio.<br>
```
setwd('Location_on_your_machine/Diff-COVID19-Impact-on-GI/')
```
* Knit main_report.Rmd from R/RStudio.<br>
```
rmarkdown::render('./main_report.Rmd')
```

**Note:** In this repository, dummy data are used instead of the raw laboratory reports of norovirus and Campylobacter due to data sharing policy of Public Health England. Raw data are available upon reasonable request from EEDD@phe.gov.uk. 


### References
Liboschik, T., Fokianos, K. and Fried, R. (2017). tscount: An R package for analysis of count
time series following generalized linear models. Journal of Statistical Software 82(5), 1–51, doi:
[10.18637/jss.v082.i05](https://www.jstatsoft.org/article/view/v082i05).