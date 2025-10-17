##################### set working directory
setwd("/Users/jileilin/Desktop/Research/thymomal case reports/")

##################### load packages
library("strucchange")
library('nnet')
library('quantreg')
library('multcomp')
library('forestplot')

#################### read data
data <- read.csv('data2.csv')[, -1]
n <- nrow(data)
subset <- which(data$non.derm.IBM == '-')
cancer.detailed <- data$cancer.detailed
ll <- c()
for (i in 1:n) {
  if (is.na(cancer.detailed[i]) == TRUE) {
    ll[i] <- NA
  } else if (cancer.detailed[i] == 'thymic') {
    ll[i] <- 1
  } else if (cancer.detailed[i] == 'lung') {
    ll[i] <- 2
  } else if (cancer.detailed[i] == 'melanoma') {
    ll[i] <- 3
  } else if (cancer.detailed[i] == 'gastrointestinal') {
    ll[i] <- 4
  } else if (cancer.detailed[i] == 'genitourinary') {
    ll[i] <- 5
  } else if (cancer.detailed[i] == 'others') {
    ll[i] <- 6
  }
}
cancer.detailed <- reorder(cancer.detailed, ll)
contrasts(cancer.detailed) <- contr.sum(6)
data$cancer.detailed <- cancer.detailed

#################### forest plot for myositis
my.ind <- ifelse(data$inflam.myopathy == '+', 1, 0)
mod <- glm(my.ind ~ cancer.detailed + Sex + Age + CTLA4_PD1, family = 'binomial', 
           data = data, subset = subset)

# p-value
p <- coef(summary(mod))[2:6, 4]

# odds ratio
odds <- coef(summary(mod))[2:6, 1]
ses <- coef(summary(mod))[2:6, 2]
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)

# forest plot
mean <- odds[, 1]
lower <- odds[, 2]
upper <- odds[, 3]
pvs <- p
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean, lower = lower, upper = upper,
                            OR = round(mean, 2), pvs = pvs,
                            variable = c('TET', 'Lung cancer', 
                                         'Melanoma', 'Gastrointestinal cancer',
                                         'Genitourinary cancer'))

base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     
             xlim = c(0, 12),
             title = expression(bold("Myositis")),
             xlab = expression(bold("Association with myositis")),
             xlog = TRUE,
             boxsize = 0.35,
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
  fp_add_header(variable = c("", "Cancer type"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")


#################### forest plot for myocarditis
myocarditis.ind <- ifelse(data$myocarditis == '+', 1, 0)
mod <- glm(myocarditis.ind ~ cancer.detailed + Sex + Age + CTLA4_PD1, 
           family = 'binomial', subset = subset, data = data)

# p-value
p <- coef(summary(mod))[2:6, 4]
# odds ratio
odds <- coef(summary(mod))[2:6, 1]
ses <- coef(summary(mod))[2:6, 2]
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)

# forest plot
mean <- odds[, 1]
lower <- odds[, 2]
upper <- odds[, 3]
pvs <- p
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean, lower = lower, upper = upper,
                            OR = round(mean, 2), pvs = pvs,
                            variable = c('TET', 'Lung cancer', 
                                         'Melanoma', 'Gastrointestinal cancer',
                                         'Genitourinary cancer'))

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


#################### forest plot for MG
mg.ind <- ifelse(data$MG == '+', 1, 0)
mod <- glm(mg.ind ~ cancer.detailed + Sex + Age + CTLA4_PD1, 
           family = 'binomial', subset = subset, data = data)

# p-value
p <- coef(summary(mod))[2:6, 4]

# odds ratio
odds <- coef(summary(mod))[2:6, 1]
ses <- coef(summary(mod))[2:6, 2]
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)

# forest plot
mean <- odds[, 1]
lower <- odds[, 2]
upper <- odds[, 3]
pvs <- p
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean, lower = lower, upper = upper,
                            OR = round(mean, 2), pvs = pvs,
                            variable = c('TET', 'Lung cancer', 
                                         'Melanoma', 'Gastrointestinal cancer',
                                         'Genitourinary cancer'))

base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     
             xlim = c(0, 12),
             title = expression(bold("MG")),
             xlab = expression(bold("Association with MG")),
             xlog = TRUE,
             boxsize = 0.35,
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
             ) # Enlarge axis tick labels
  ) |>
  fp_set_style(box = "royalblue",
               line = "darkblue",
               summary = "royalblue") |>
  fp_add_header(variable = c("", "Cancer type"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")


#################### forest plot for concurrent myositis & myocarditis
mwm.ind <- ifelse(data$mwm == '+', 1, 0)
mod <- glm(mwm.ind ~ cancer.detailed + Sex + Age + CTLA4_PD1, family = 'binomial', 
           subset = subset, data = data)

# p-value
p <- coef(summary(mod))[2:6, 4]

# odds ratio
odds <- coef(summary(mod))[2:6, 1]
ses <- coef(summary(mod))[2:6, 2]
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)

# forest plot
mean <- odds[, 1]
lower <- odds[, 2]
upper <- odds[, 3]
pvs <- p
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean, lower = lower, upper = upper,
                            OR = round(mean, 2), pvs = pvs,
                            variable = c('TET', 'Lung cancer', 
                                         'Melanoma', 'Gastrointestinal cancer',
                                         'Genitourinary cancer'))

base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     # <-- Align columns
             xlim = c(0, 12),
             title = expression(bold("Concurrent myositis & myocarditis")),
             xlab = expression(bold("Association with concurrent myositis & myocarditis")),
             xlog = TRUE,
             boxsize = 0.35,
             lwd.ci = 5,                       # Thicker CI lines
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
  fp_add_header(variable = c("", "Cancer type"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")


#################### forest plot for concurrent MG & myositis/myocarditis
mgmm.ind <- ifelse(data$mgmm == '+', 1, 0)
mod <- glm(mgmm.ind ~ cancer.detailed + Sex + Age + CTLA4_PD1, family = 'binomial', 
           data = data, subset = subset, control = glm.control(maxit = 50))

# p-value
p <- coef(summary(mod))[2:6, 4]

# odds ratio
odds <- coef(summary(mod))[2:6, 1]
ses <- coef(summary(mod))[2:6, 2]
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)

# forest plot
mean <- odds[, 1]
lower <- odds[, 2]
upper <- odds[, 3]
pvs <- p
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean, lower = lower, upper = upper,
                            OR = round(mean, 2), pvs = pvs,
                            variable = c('TET', 'Lung cancer', 
                                         'Melanoma', 'Gastrointestinal cancer',
                                         'Genitourinary cancer'))
base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     # <-- Align columns
             xlim = c(0, 12),
             title = expression(bold("Concurrent MG & myositis/myocarditis")),
             xlab = expression(bold("Association with concurrent MG & myositis/myocarditis")),
             xlog = TRUE,
             boxsize = 0.35,
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
  fp_add_header(variable = c("", "Cancer type"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")



#################### forest plot for Immunomodulators
imm.ind <- ifelse(data$imm == '+', 1, 0)
mod <- glm(imm.ind ~ cancer.detailed + Sex + Age + CTLA4_PD1, family = 'binomial', 
           data = data, subset = subset, control = glm.control(maxit = 50))

# p-value
p <- coef(summary(mod))[2:6, 4]

# odds ratio
odds <- coef(summary(mod))[2:6, 1]
ses <- coef(summary(mod))[2:6, 2]
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)

# forest plot
mean <- odds[, 1]
lower <- odds[, 2]
upper <- odds[, 3]
pvs <- p
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean, lower = lower, upper = upper,
                            OR = round(mean, 2), pvs = pvs,
                            variable = c('TET', 'Lung cancer', 
                                         'Melanoma', 'Gastrointestinal cancer',
                                         'Genitourinary cancer'))

base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),    
             xlim = c(0, 12),
             title = expression(bold("Immunomodulators")),
             xlab = expression(bold("Association with immunomodulators")),
             xlog = TRUE,
             boxsize = 0.35,
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
             )  ) |>
  fp_set_style(box = "royalblue",
               line = "darkblue",
               summary = "royalblue") |>
  fp_add_header(variable = c("", "Cancer type"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")



#################### forest plot for plasmapheresis
plasmapheresis.ind <- ifelse(data$plasmapheresis == '+', 1, 0)
mod <- glm(plasmapheresis.ind ~ cancer.detailed + Sex + Age + CTLA4_PD1, 
           family = 'binomial', control = glm.control(maxit = 50), data = data,
           subset = subset)

# p-value
p <- coef(summary(mod))[2:6, 4]

# odds ratio
odds <- coef(summary(mod))[2:6, 1]
ses <- coef(summary(mod))[2:6, 2]
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)

# forest plot
mean <- odds[, 1]
lower <- odds[, 2]
upper <- odds[, 3]
pvs <- p
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean, lower = lower, upper = upper,
                            OR = round(mean, 2), pvs = pvs,
                            variable = c('TET', 'Lung cancer', 
                                         'Melanoma', 'Gastrointestinal cancer',
                                         'Genitourinary cancer'))
base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     
             title = expression(bold("Plasmapheresis")), 
             xlim = c(0, 12),
             xlab = expression(bold("Association with plasmapheresis")),
             xlog = TRUE,
             boxsize = 0.35,
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
  fp_add_header(variable = c("", "Cancer type"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")

#################### forest plot for respiratory support
rs.ind <- ifelse(data$rs == '+', 1, 0)
mod <- glm(rs.ind ~ cancer.detailed + Sex + Age + CTLA4_PD1, family = 'binomial', 
           control = glm.control(maxit = 50), data = data,
           subset = subset)

# p-value
p <- coef(summary(mod))[2:6, 4]

# odds ratio
odds <- coef(summary(mod))[2:6, 1]
ses <- coef(summary(mod))[2:6, 2]
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)

# forest plot
mean <- odds[, 1]
lower <- odds[, 2]
upper <- odds[, 3]
pvs <- p
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean, lower = lower, upper = upper,
                            OR = round(mean, 2), pvs = pvs,
                            variable = c('TET', 'Lung cancer', 
                                         'Melanoma', 'Gastrointestinal cancer',
                                         'Genitourinary cancer'))
base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     
             xlim = c(0, 12),
             title = expression(bold("Respiratory support")), 
             xlab = expression(bold("Association with respiratory support")),
             xlog = TRUE,
             boxsize = 0.35,
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
  fp_add_header(variable = c("", "Cancer type"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")


#################### forest plot for cardiovascular treatments
ct.ind <- ifelse(data$ct == '+', 1, 0)
mod <- glm(ct.ind ~ cancer.detailed + Sex + Age + CTLA4_PD1, family = 'binomial', data = data,
           control = glm.control(maxit = 50), subset = subset)

# p-value
p <- coef(summary(mod))[2:6, 4]

# odds ratio
odds <- coef(summary(mod))[2:6, 1]
ses <- coef(summary(mod))[2:6, 2]
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)

# forest plot
mean <- odds[, 1]
lower <- odds[, 2]
upper <- odds[, 3]
pvs <- p
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean, lower = lower, upper = upper,
                            OR = round(mean, 2), pvs = pvs,
                            variable = c('TET', 'Lung cancer', 
                                         'Melanoma', 'GGastrointestinal cancer',
                                         'Genitourinary cancer'))
base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     
             xlim = c(0, 12),
             title = expression(bold("Cardiovascular treatments")),
             xlab = expression(bold("Association with cardiovascular treatments")),
             xlog = TRUE,
             boxsize = 0.35,
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
  fp_add_header(variable = c("", "Cancer type"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")


#################### forest plot for death
death.ind <- ifelse(data$outcome == 'Death', 1, 0)
mod <- glm(death.ind ~ cancer.detailed + Sex + Age + CTLA4_PD1, family = 'binomial', data = data,
           control = glm.control(maxit = 50), subset = subset)

# p-value
p <- coef(summary(mod))[2:6, 4]

# odds ratio
odds <- coef(summary(mod))[2:6, 1]
ses <- coef(summary(mod))[2:6, 2]
odds <- cbind(odds, odds - qnorm(.975) * ses, odds + qnorm(.975) * ses)
odds <- exp(odds)

# forest plot
mean <- odds[, 1]
lower <- odds[, 2]
upper <- odds[, 3]
pvs <- p
pvs <- round(pvs, 4)
base_data <- tibble::tibble(mean  = mean, lower = lower, upper = upper,
                            OR = round(mean, 2), pvs = pvs,
                            variable = c('TET', 'Lung cancer', 
                                         'Melanoma', 'Gastrointestinal cancer',
                                         'Genitourinary cancer'))
base_data |>
  forestplot(labeltext = c(variable, OR, pvs),
             align = c("l", "c", "c"),     
             xlim = c(0, 12),
             title = expression(bold("irAE-related death & hospice care")), 
             xlab = expression(bold("Association with irAE-related death & hospice care")),
             xlog = TRUE,
             boxsize = 0.35,
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
  fp_add_header(variable = c("", "Cancer type"),
                OR = c("", "Adj-OR"),
                pvs = c("", "p-value")) |>
  fp_set_zebra_style("#EFEFEF")
