
## ---- include = FALSE----------------------------------------------------
library("ggplot2")
options(digits = 2)
library("ggvis")


## ---- echo=FALSE---------------------------------------------------------
library("knitr")


## ---- eval=FALSE---------------------------------------------------------
## install.packages("knitr", dependencies = TRUE)


## ---- echo = FALSE, comment = NA-----------------------------------------
cat("Generates PDF\nknit('knit_toy/knit_toy.Rnw')\n\nGenerates R script\npurl('purl_toy/purl_toy.Rnw')\n\nGenerates PDF\nstitch('stitch_toy/stitch_toy.R')\n\nGenerates Markdown\nspin('spin_toy/spin_toy.R')")


## ---- eval = FALSE-------------------------------------------------------
## if(!require("shiny"))
##   install.packages("shiny")
## demo("notebook", package = "knitr")


## ------------------------------------------------------------------------
length(opts_chunk$get())
opts_chunk$get("engine")


## ---- comment = NA, echo = FALSE-----------------------------------------
cat("\`r <insert R code for Markdown>`\n\n\\Sexpr{<insert R code for LaTeX>}")


## ---- comment = NA, echo = FALSE-----------------------------------------
cat("A realization of a $\\chi_2^2$ is `r rchisq(1, df = 2)`.")


## ---- comment=NA, echo = FALSE-------------------------------------------
    cat("```{r, cool_chunk, eval = -1, echo = c(1, 3), warning = FALSE, \nmessage = FALSE,align ='center'}\n\ncoef(lm(dist ~ speed, data = cars))[1]\n\nggplot(aes(x=speed, y = dist), data = cars) + geom_point(col = \"#56B4E9\") +\ngeom_smooth(col = \"999999\") + theme_bw() + ylab(\"Driving Speed\") +\nxlab(\"Distance to Stop\")\n\nrnorm(0, sd = -1) \n```")


## ---- cool_chunk, eval = -1, echo = c(1, 3), warning = FALSE, message = FALSE, fig.align ='center'----
coef(lm(dist ~ speed, data = cars))[1]
ggplot(aes(x=speed, y = dist), data = cars) + geom_point(col = "#56B4E9") + geom_smooth(col = "999999") + theme_bw() + ylab("Driving Speed") + xlab("Distance to Stop")
rnorm(0, sd = -1)


## ------------------------------------------------------------------------
foo <- 2
bar <- foo


## ----eval = foo < bar, echo = FALSE--------------------------------------
cat("foo is greater than bar")


## ----eval = foo == bar, echo = FALSE-------------------------------------
cat("they are the same")


## ---- comment=NA, echo = FALSE-------------------------------------------
cat("```{r}\nfoo <- 2\nbar <- foo\n```\n```{r eval = foo < bar, echo = FALSE}\ncat(\"foo is greater than bar\")\n```\n```{r eval = foo == bar, echo = FALSE}\ncat(\"they are the same\")\n```")


## ---- comment=NA, echo = FALSE-------------------------------------------
cat("```{r fig.width = 6, fig.align = 'center', echo = FALSE}\nplot(rnorm(10))\n```")


## ---- comment=NA, echo = FALSE-------------------------------------------
cat("```{r}\nopts_chunk$set(fig.width=6, fig.align = 'center', echo = FALSE))\n```")


## ---- results = "asis",echo=FALSE----------------------------------------
library(xtable)
mod1 <- lm(dist ~ speed, data = cars)
coef_tab <- summary(mod1)$coef
print(xtable(mod1), type = "html")


## ---- results = "hide", echo=TRUE----------------------------------------
library(xtable)
mod1 <- lm(dist ~ speed, data = cars)
coef_tab <- summary(mod1)$coef
print(xtable(mod1), type = "html")


## ----comment = NA, echo = FALSE------------------------------------------
cat("$\\hat{dist_i} = `r coef_tab[1,1]` + `r coef_tab[2,1] ` speed_i$")


## ----fig.height=3, fig.width=3, fig.align='center', echo = FALSE---------
mtcars %>% ggvis(~wt, ~mpg, size := 300, opacity := 0.4) %>% layer_points()


## ----comment = NA, echo = FALSE------------------------------------------
cat("```{r, foo_time = file.info('foo.csv')$mtime}\nfoo <- read.csv(\"foo\")\n...")



## ----comment = NA, echo = FALSE------------------------------------------
cat("```{r, A}\ny <- rcauchy(1)\n```\n```{r, B}\ny\n<<A>>\ny\n```")


## ----A-------------------------------------------------------------------
y <- rcauchy(1)

## ----B-------------------------------------------------------------------
y
y <- rcauchy(1)
y


## ----comment = NA, echo = FALSE------------------------------------------
cat("```{r, cau, include = FALSE, eval = FALSE}\ny <- rcauchy(1)\n```\n```{r, norm, include = FALSE, eval = FALSE}\ny\nx <- y + rnorm(1)\nx\n```\n```{r, C, ref.label = c('cau','norm')\n```")


## ---- cau, include = FALSE, eval = FALSE---------------------------------
## y <- rcauchy(1)

## ---- norm, include = FALSE, eval = FALSE--------------------------------
## y
## x <- y + rnorm(1)
## x

## ---- C, ref.label = c('cau','norm')-------------------------------------


## ----comment = NA, echo = FALSE------------------------------------------
cat("## @knitr nitrogen_conversion\ntons_mgN <- function(tons, unit){\nmgN <- (tons * 1e9) / 20 / 5.7 / unit\nreturn(mgN)\n}\n")






