##################### set working directory
setwd("/Users/jileilin/Desktop/Research/thymomal case reports/")

##################### load packages
library("strucchange")
library('nnet')
library('quantreg')
library('multcomp')
library('forestplot')
library('ggplot2')

#################### read data
data <- read.csv('data2.csv')[, -1]






#################### forest plot
#################### testing bias for Anti-AChR
test.achr <- ifelse(is.na(data$AChR) == TRUE, 0, 1)

# combining odds ratio and p-values
pp <- c()
oddss <- c()

# Isolated myositis
# logistic regression
Op.ind <- ifelse(data$Op == '+', 1, 0)
mod <- glm(Op.ind ~ test.achr + Sex + Age, data = data, 
           subset = which(data$mm == 'Myositis (no D and no C)'),
           family = 'binomial')

# p-value
p <- coef(summary(mod))[2, 4]
print(p)
# odds ratio
odds <- coef(summary(mod))[2, 1]
ses <- coef(summary(mod))[2, 2] 
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)
# combine
oddss <- rbind(oddss, odds)
pp <- c(pp, p)


# Isolated myocarditis
# logistic regression
mod <- glm(Op.ind ~ test.achr + Sex + Age, data = data, 
           subset = which(data$mm == 'Myocarditis (only C)'),
           family = 'binomial')
# p-value
p <- coef(summary(mod))[2, 4]
# odds ratio
odds <- coef(summary(mod))[2, 1]
ses <- coef(summary(mod))[2, 2] 
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)
# combine
oddss <- rbind(oddss, odds)
pp <- c(pp, p)


# concurrent myositis & myocarditis
# logistic regression
mod <- glm(Op.ind ~ test.achr + Sex + Age, data = data,
           subset = which(data$mm == 'Myositis with myocarditis'),
           family = 'binomial')

# p-value
p <- coef(summary(mod))[2, 4]
# odds ratio
odds <- coef(summary(mod))[2, 1]
ses <- coef(summary(mod))[2, 2] 
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)
oddss <- rbind(oddss, odds)
pp <- c(pp, p)


# forest plot
mean <- oddss[, 1]
lower <- oddss[, 2]
upper <- oddss[, 3]
pvs <- pp
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean,
                            lower = lower,
                            upper = upper,
                            OR = round(mean, 2),
                            pvs = pvs,
                            variable = c('Isolated myositis', 
                                         'Isolated myocarditis',
                                         'Concurrent myositis & myocarditis'))


base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     
             xlim = c(0, 100),
             title = expression(bold("Testing Bias for Anti-AChR")),  
             xlab = expression(bold("Association with MG-like ocular symptoms")),
             xlog = TRUE,
             boxsize = 0.2,
             lwd.ci = 5,                       
             xticks = c(0.5, 1, 2, 5, 100),
             zero = 1,       
             lty.zero = 2, 
             col = fpColors(zero = "black"),  
             lwd.zero = 4,                     
             txt_gp = fpTxtGp(
               xlab = gpar(fontsize = 12),
               ticks = gpar(fontsize = 12),    
               label = gpar(fontsize = 12)
             ) 
  ) |>
  fp_set_style(box = "royalblue",
               line = "darkblue",
               summary = "royalblue") |>
  fp_add_header(variable = c("", "Subgroup"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")



#################### forest plot
#################### testing bias for StrAbs
test.Striated <- ifelse(is.na(data$Striated) == TRUE, 0, 1)

# combine odds ratio and p-value
oddss <- c()
pp <- c()

# logistic regression
# isolated myositis
Op.ind <- ifelse(data$Op == '+', 1, 0)
mod <- glm(Op.ind ~ test.Striated + Sex + Age, data = data,
           subset = which(data$mm == 'Myositis (no D and no C)'),
           family = 'binomial')

# p-value
p <- coef(summary(mod))[2, 4]
# odds
odds <- coef(summary(mod))[2, 1]
ses <- coef(summary(mod))[2, 2] 
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)
# combine
oddss <- rbind(oddss, odds)
pp <- c(pp, p)


# logistic regression
# isolated myocarditis
mod <- glm(Op.ind ~ test.Striated + Sex + Age, data = data,
           subset = which(data$mm == 'Myocarditis (only C)'),
           family = 'binomial')

# p-value
p <- coef(summary(mod))[2, 4]
# odds ratio
odds <- coef(summary(mod))[2, 1]
ses <- coef(summary(mod))[2, 2] 
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)
# combine
oddss <- rbind(oddss, odds)
pp <- c(pp, p)

# logistic regression
# concurrent myositis & myocarditis
mod <- glm(Op.ind ~ test.Striated + Sex + Age, data = data, 
           subset = which(data$mm == 'Myositis with myocarditis'),
           family = 'binomial')

# p-value
p <- coef(summary(mod))[2, 4]
# odds ratio
odds <- coef(summary(mod))[2, 1]
ses <- coef(summary(mod))[2, 2] 
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)
# combine
oddss <- rbind(oddss, odds)
pp <- c(pp, p)

# forest plot
mean <- oddss[, 1]
lower <- oddss[, 2]
upper <- oddss[, 3]
pvs <- pp
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean,
                            lower = lower,
                            upper = upper,
                            OR = round(mean, 2),
                            pvs = pvs,
                            variable = c('Isolated myositis', 
                                         'Isolated myocarditis',
                                         'Concurrent myositis & myocarditis'))
base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     
             xlim = c(0, 100),
             title = expression(bold("Testing Bias for StrAbs")),  
             xlab = expression(bold("Association with MG-like ocular symptoms")),
             xlog = TRUE,
             boxsize = 0.2,
             lwd.ci = 5,                       
             xticks = c(0.5, 1, 2, 5, 100),
             zero = 1,       
             lty.zero = 2, 
             col = fpColors(zero = "black"),  
             lwd.zero = 4,                    
             txt_gp = fpTxtGp(
               xlab = gpar(fontsize = 12),
               ticks = gpar(fontsize = 12),    
               label = gpar(fontsize = 12)
             ) 
  ) |>
  fp_set_style(box = "royalblue",
               line = "darkblue",
               summary = "royalblue") |>
  fp_add_header(variable = c("", "Subgroup"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")



#################### forest plot
#################### Seropositivity
subset <- which(is.na(data$mm) == FALSE)

# combine odds ratio and p-value
oddss <- c()
pp <- c()

# logistic regression
# Anti-AChR
Op.ind <- ifelse(data$Op == '+', 1, 0)
mod <- glm(Op.ind ~ achr + Sex + Age, data = data, subset = subset, family = 'binomial')

# p-value
p <- coef(summary(mod))[2, 4]
pp <- c(pp, p)
# odds ratio
odds <- coef(summary(mod))[2, 1]
ses <- coef(summary(mod))[2, 2] 
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)
oddss <- rbind(oddss, odds)

# logistic regression
# StrAb
mod <- glm(Op.ind ~ Striated + Sex + Age, data = data, subset = subset, family = 'binomial')

# p-value
p <- coef(summary(mod))[2, 4]
pp <- c(pp, p)
# odds ratio
odds <- coef(summary(mod))[2, 1]
ses <- coef(summary(mod))[2, 2] 
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)
oddss <- rbind(oddss, odds)


# forest plot
mean <- oddss[, 1]
lower <- oddss[, 2]
upper <- oddss[, 3]
pvs <- pp
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean,
                            lower = lower,
                            upper = upper,
                            OR = round(mean, 2),
                            pvs = pvs,
                            variable = c('Anti-AChR', 'StrAb'))
base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     
             xlim = c(0, 36),
             title = expression(bold("Seropositivity")),  
             xlab = expression(bold("Association with MG-like ocular symptoms")),
             xlog = TRUE,
             boxsize = 0.2,
             lwd.ci = 5,                       
             xticks = c(0.1, 0.2, 0.5, 1, 2, 5, 10),
             zero = 1,       
             lty.zero = 2, 
             col = fpColors(zero = "black"),  
             lwd.zero = 4,                     
             txt_gp = fpTxtGp(
               xlab = gpar(fontsize = 12),
               ticks = gpar(fontsize = 12),    
               label = gpar(fontsize = 12)
             ) 
  ) |>
  fp_set_style(box = "royalblue",
               line = "darkblue",
               summary = "royalblue") |>
  fp_add_header(variable = c("", "Autoantibody"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")