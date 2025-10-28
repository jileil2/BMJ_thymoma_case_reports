##################### set working directory
setwd("/Users/jileilin/Desktop/Research/thymomal case reports/")

##################### load packages
library("strucchange")
library('nnet')
library('quantreg')
library('multcomp')
library('forestplot')

#################### read data
data <- read.csv('data1.csv')[, -1]


#################### forest plot (Figure 3A)
thymoma.ind <- ifelse(data$thymoma == '+', 1, 0)
# covariates
death <- ifelse(data$outcome == 'Death', 1, 0)
covariates <- with(data, data.frame(Sex, EOMG, Oplus, 
                                    Striated, GG, Cardiac, death))
covariates$GG[which(covariates$GG == 'nobiopsy')] <- NA
# subset
subset <- which(data$year >= 1993)

# plot
mean <- c()
lower <- c()
upper <- c()
pvs <- c()
for (j in 1:7) {
  
  # logistic regression
  if (j == 1) {
    mod.j <- glm(thymoma.ind ~ covariates[, j] + Age.TP, data = data, 
                 family = 'binomial',
                 subset = subset, control = glm.control(maxit = 50))
  } else if (j == 2) {
    mod.j <- glm(thymoma.ind ~ covariates[, j] + Sex, family = 'binomial',
                 subset = subset, data = data, control = glm.control(maxit = 50))
    
  } else if (j >= 7) {
    mod.j <- glm(thymoma.ind ~ covariates[, j] + Age.TP + Sex, family = 'binomial',
                 subset = subset, data = data, control = glm.control(maxit = 50))
  } else {
    mod.j <- glm(thymoma.ind ~ covariates[, j] + Age.TP + Sex, family = 'binomial',
                 data = data, control = glm.control(maxit = 50))
  }
  
  # confidence intervals
  cis.j <- apply(confint(mod.j), 2, exp)[2, ]
  mean[j] <- exp(coef(mod.j))[-1][1]
  lower[j] <- cis.j[1]
  upper[j] <- cis.j[2]
  
  # p-values
  pvs[j] <- coef(summary(mod.j))[2, 4]
}

# p-value
pvs <- round(pvs, 4)

# forest plot
base_data <- tibble::tibble(mean  = mean, lower = lower, upper = upper,
                            OR = round(mean, 2), pvs = pvs,
                            variable = c('Female', 'LOMG', 
                                         'MG-like Ocular symptoms', 
                                         'StrAb', 'Giant cells/granulomas', 
                                         'Cardiac involvement', 'Death (after 1993)'))
base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     # <-- Align columns
             xlim = c(0, 25),
             title = expression(bold("Thymoma")),
             xlab = expression(bold("Association with thymoma versus no thymoma")),
             xlog = TRUE,
             boxsize = 0.5,
             lwd.ci = 5,                       # Thicker CI lines
             xticks = c(0.2, 0.5, 1, 2, 10, 40),
             zero = 1,       
             lty.zero = 2, 
             col = fpColors(zero = "black"),  # Location of vertical line
             lwd.zero = 5,                     # <--- Thicker vertical line
             txt_gp = fpTxtGp(
               xlab = gpar(fontsize = 12),
               ticks = gpar(fontsize = 12),    # <--- Larger axis tick labels
               label = gpar(fontsize = 12)
             ) # Enlarge axis tick labels
  ) |>
  fp_set_style(box = "royalblue",
               line = "darkblue",
               summary = "royalblue") |>
  fp_add_header(variable = c("", "Variable"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")


#################### forest plot (Figure 3B)
# subset
subset <- which(data$year >= 1993)
myocarditis.ind <- ifelse(data$myocarditis == 'Myocarditis', 1, 0)

# covariates
death <- ifelse(data$outcome == 'Death', 1, 0)
covariates <- with(data, data.frame(scale(Age), Sex, EOMG, thymoma, GG, 
                                    cort, imm, rs,
                                    death))
covariates$GG[which(covariates$GG == 'nobiopsy')] <- NA

# logistic regression
mean <- c()
lower <- c()
upper <- c()
pvs <- c()
for (j in 1:9) {
  if (j %in% c(1, 3)) {
    mod.j <- glm(myocarditis.ind ~ covariates[, j] + Sex, family = 'binomial',
                 subset = subset, data = data, control = glm.control(maxit = 50))
    
  } else if (j == 2) {
    mod.j <- glm(myocarditis.ind ~ covariates[, j] + Age, family = 'binomial',
                 subset = subset, data = data, control = glm.control(maxit = 50))
  } else if (j >= 6) {
    mod.j <- glm(myocarditis.ind ~ covariates[, j] + Sex + Age, family = 'binomial',
                 subset = subset, data = data, control = glm.control(maxit = 50))
  } else {
    mod.j <- glm(myocarditis.ind ~ covariates[, j] + Sex + Age, family = 'binomial',
                 data = data, control = glm.control(maxit = 50))
  }
  cis.j <- apply(confint(mod.j), 2, exp)[2, ]
  
  # confidence intervals
  mean[j] <- exp(coef(mod.j))[-1][1]
  lower[j] <- cis.j[1]
  upper[j] <- cis.j[2]
  
  # p-value
  pvs[j] <- coef(summary(mod.j))[2, 4]
}
pvs <- round(pvs, 4)

# forest plot
base_data <- tibble::tibble(mean  = mean,
                            lower = lower,
                            upper = upper,
                            OR = round(mean, 2),
                            pvs = pvs,
                            variable = c('Age', 'Female', 'LOMG', 'Thymoma', 
                                         'Giant cells/granulomas',  'Corticosteroids (after 1993)',
                                         'Immunomodulators (after 1993)',
                                         'Respiratory support (after 1993)',
                                         'Death (after 1993)'))

base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     
             xlim = c(0, 50),
             title = expression(bold("Myocarditis")),
             xlab = expression(bold("Association with myocarditis versus no myocarditis")),
             xlog = TRUE,
             boxsize = .5,
             lwd.ci = 5,                       
             xticks = c(0.25, 0.5, 1, 2, 5, 50),
             zero = 1,       
             lty.zero = 2, 
             col = fpColors(zero = "black"),  
             lwd.zero = 5,                     
             txt_gp = fpTxtGp(
               xlab = gpar(fontsize = 12),
               ticks = gpar(fontsize = 12),    
               label = gpar(fontsize = 12)
             ) # Enlarge axis tick labels
  ) |>
  fp_set_style(box = "royalblue",
               line = "darkblue",
               summary = "royalblue") |>
  fp_add_header(variable = c("", "Variable"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")