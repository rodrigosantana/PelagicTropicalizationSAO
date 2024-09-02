########################################################################
## Description: R code to the implementation of the MTC analysis...
##
## Maintainer: UNIVALI / EP / LEMA - iAtlantic
## Author: Rodrigo Sant'Ana
## Created: seg set 2 14:01:03 2024 (-0300)
## Version: 0.0.1
##
## URL: 
## Doc URL:
##
## Database info:
##
### Commentary:
##
### Code:
########################################################################

########################################################################
######@> Setup R...

######@> Loading R packages...
library(dplyr)
library(lubridate)
library(ggplot2)
library(tidyr)
library(stringr)
library(patchwork)
library(tsibble)
library(viridisLite)
library(readxl)
library(segmented)
library(dynlm)
library(viridis)
library(extrafont)
library(hnp)

######@> Importing fonts...
loadfonts(device = "postscript")

######@> Custom theme for ggplot...
rgb01 <- "black"
rgb02 <- "black"
seta <- grid::arrow(length = grid::unit(0.2, "cm"), type = "open")
seta2 <- grid::arrow(length = grid::unit(0.2, "cm"), type = "open",
                     ends = "both")
my_theme <- function(base_size = 18, base_family = "Helvetica") {
    theme_bw(base_size = base_size, base_family = base_family) %+replace%
        theme(axis.ticks = element_line(colour = rgb01),
              axis.line = element_line(colour = rgb01, size = 0.2),
              axis.text = element_text(colour = rgb02, size = 14),
              axis.title = element_text(size = 18),
              legend.background = element_blank(),
              legend.key = element_blank(),
              panel.background = element_blank(),
              panel.grid = element_line(linetype = "solid",
                                        size = 0.2,
                                        colour = "gray90"),
              plot.background = element_blank(),
              complete = TRUE)
}

#####@> Testing ggplot theme...
df <- data.frame(x = rnorm(10), y = rnorm(10),
                 z = rep(c("A", "B"), each = 5))
ggplot(data = df, aes(x = x, y = y, fill = z)) +
    geom_point(pch = 21, size = 5) +
    my_theme()

######@> Standardizing decimal marks...
options(scipen = 10)

########################################################################
######@> Loading datasets...

######@> [Environment dataset] Time-series...

#####@> SEAO...
load("Data/Environmental_Oceanographic_Fisheries_Time_Series_SEAO.RData")

#####@> SWAO...
load("Data/Environmental_Oceanographic_Fisheries_Time_Series_SWAO.RData")

########################################################################
######@> Exploring dataset...

######@>----------------------------------------------------------------
######@> SEAO...

######@> Time-series distribution of each variable...

#####@> MTC...
p00 <- ggplot(data = SEAO.out) +
    geom_line(aes(x = YearC, y = MTC), linetype = "dashed") +
    geom_point(aes(x = YearC, y = MTC), pch = 21, fill = "white",
               colour = "black", size = 6) +
    geom_hline(yintercept = mean(SEAO.out$MTC), linetype = "dashed",
               alpha = 0.5) +
    labs(x = "Year",
         y = "Mean Temperature of the Catch (ºC)") +
    scale_x_continuous(breaks = seq(1976, 2020, 4)) +
    scale_y_continuous(breaks = seq(24.8, 26.2, 0.2),
                       limits = c(24.8, 26.2)) +
    my_theme() +
    theme(axis.text = element_text(size = 18),
          axis.title = element_text(size = 20))
p00

#####@> SST...
p01 <- ggplot(data = SEAO.out) +
    geom_line(aes(x = YearC, y = SST), linetype = "dashed") +
    geom_point(aes(x = YearC, y = SST), pch = 21, fill = "white",
               colour = "black", size = 6) +
    geom_hline(yintercept = mean(SEAO.out$SST), linetype = "dashed",
               alpha = 0.5) +
    labs(x = "Year",
         y = "Sea Surface Temperature (ºC)") +
    scale_x_continuous(breaks = seq(1976, 2020, 4)) +
    scale_y_continuous(breaks = seq(22, 23.2, 0.2),
                       limits = c(22, 23.2)) +
    my_theme() +
    theme(axis.text = element_text(size = 18),
          axis.title = element_text(size = 20))
p01

######@>----------------------------------------------------------------
######@> SWAO...

######@> Time-series distribution of each variable...

#####@> MTC...
p02 <- ggplot(data = SWAO.out) +
    geom_line(aes(x = YearC, y = MTC), linetype = "dashed") +
    geom_point(aes(x = YearC, y = MTC), pch = 21, fill = "white",
               colour = "black", size = 6) +
    geom_hline(yintercept = mean(SWAO.out$MTC), linetype = "dashed",
               alpha = 0.5) +
    labs(x = "Year",
         y = "Mean Temperature of the Catch (ºC)") +
    scale_x_continuous(breaks = seq(1976, 2020, 4)) +
    scale_y_continuous(breaks = seq(24.2, 26.2, 0.2),
                       limits = c(24.2, 26.2)) +
    my_theme() +
    theme(axis.text = element_text(size = 18),
          axis.title = element_text(size = 20))
p02

#####@> SST...
p03 <- ggplot(data = SWAO.out) +
    geom_line(aes(x = YearC, y = SST), linetype = "dashed") +
    geom_point(aes(x = YearC, y = SST), pch = 21, fill = "white",
               colour = "black", size = 6) +
    geom_hline(yintercept = mean(SWAO.out$SST), linetype = "dashed",
               alpha = 0.5) +
    labs(x = "Year",
         y = "Sea Surface Temperature (ºC)") +
    scale_x_continuous(breaks = seq(1976, 2020, 4)) +
    scale_y_continuous(breaks = seq(23, 24.2, 0.2),
                       limits = c(23, 24.2)) +
    my_theme() +
    theme(axis.text = element_text(size = 18),
          axis.title = element_text(size = 20))
p03

#####@> BCt...
p04 <- ggplot(data = SWAO.out) +
    geom_line(aes(x = YearC, y = BC_transport * (-1)), linetype = "dashed") +
    geom_point(aes(x = YearC, y = BC_transport * (-1)), pch = 21, fill = "white",
               colour = "black", size = 6) +
    geom_hline(yintercept = mean(SWAO.out$BC_transport * (-1), na.rm = TRUE),
               linetype = "dashed", alpha = 0.5) +
    labs(x = "Year",
         y = "Brazil Current Transport Volume (Sv)") +
    scale_x_continuous(breaks = seq(1976, 2020, 4)) +
    scale_y_continuous(breaks = seq(-12, -32, -2),
                       limits = c(-32, -12)) +
    my_theme() +
    theme(axis.text = element_text(size = 18),
          axis.title = element_text(size = 20))
p04

########################################################################
######@> Applied models...

######@>----------------------------------------------------------------
######@> SEAO...

######@> General model - Look for general tendency...
m0 <- lm(MTC ~ YearC, data = SEAO.out)

#####@> Summary of the model and diagnostics...

####@> Summary table...
summary(m0)

####@> Diags - Residual analysis - Envelope...
res <- fortify(m0); res$id <- 1:nrow(res)
res$.studresid <- rstudent(m0)
res02 <- hnp::hnp(m0, halfnormal = FALSE, plot.sim = FALSE, sim = 200)
tmp01 <- data.frame(x = res02$x, res02$all.sim)
names(tmp01) <- c("X", paste0("Run", 1:(ncol(tmp01) - 1)))
tmp01 <- tmp01 %>%
    gather(., key = "Run", value = "Res", 2:ncol(tmp01))
tmp02 <- data.frame(X = res02$x, m = res02$median, l = res02$lower,
                    u = res02$upper, res = res02$residuals)
p05 <- ggplot() +
    geom_line(data = tmp01, aes(x = X, y = Res, group = Run),
              alpha = 0.1, colour = "black") +
    stat_qq(data = tmp02, aes(sample = res),
            pch = 21, fill = "white", colour = rgb01, size = 4,
            alpha = 0.9) +
    geom_line(data = tmp02, aes(x = X, y = m), colour = "red") +
    geom_line(data = tmp02, aes(x = X, y = l), colour = "red",
              linetype = "dashed") +
    geom_line(data = tmp02, aes(x = X, y = u), colour = "red",
              linetype = "dashed") +
    labs(x = "Theorical quantiles", y = "Residuals") +
    my_theme()
p06 <- ggplot(data = res, aes(x = .stdresid)) +
    geom_histogram(binwidth = 1, close = "right",
                   boundary = 1, fill = "white", colour = rgb01) +
    labs(x = "Standardized residuals", y = "Frenquency") +
    scale_x_continuous(breaks = seq(-4, 4, 1)) +
    ## scale_y_continuous(limits = c(0, 10), expand = c(0, 0)) +
    expand_limits(y = 0) +
    my_theme()
plot01 <- (p06 | p05)
plot01

######@> Detailed models...

#####@> SST...
m2 <- lm(SST ~ YearC, data = SEAO.out)
summary(m2)

######@> Time-lag models...

#####@> Converte data.frame in to TS...
db01 <- ts(SEAO.out, start = 1978, end = 2018, frequency = 1)

######@> Models...

####@> SST...
mod0a <- dynlm(MTC ~ L(SST, 0), data = db01)
mod1a <- dynlm(MTC ~ L(SST, 1), data = db01)
mod2a <- dynlm(MTC ~ L(SST, 2), data = db01)
mod3a <- dynlm(MTC ~ L(SST, 3), data = db01)
mod4a <- dynlm(MTC ~ L(SST, 4), data = db01)

###@> Summary...
summary(mod0a)$coefficients
summary(mod0a)$r.squared
AIC(mod0a)
summary(mod1a)$coefficients
summary(mod1a)$r.squared
AIC(mod1a)
summary(mod2a)$coefficients
summary(mod2a)$r.squared
AIC(mod2a)
summary(mod3a)$coefficients
summary(mod3a)$r.squared
AIC(mod3a)
summary(mod4a)$coefficients
summary(mod4a)$r.squared
AIC(mod4a)

###@> AIC...
AIC(mod0a, mod1a, mod2a, mod3a, mod4a)

######@>----------------------------------------------------------------
######@> SWAO...

######@> General model - Look for general tendency...
m1 <- lm(MTC ~ YearC, data = SWAO.out)

#####@> Summary of the model and diagnostics...

####@> Summary table...
summary(m1)

####@> Diags - Residual analysis - Envelope...
res <- fortify(m1); res$id <- 1:nrow(res)
res$.studresid <- rstudent(m1)
res02 <- hnp::hnp(m1, halfnormal = FALSE, plot.sim = FALSE, sim = 200)
tmp01 <- data.frame(x = res02$x, res02$all.sim)
names(tmp01) <- c("X", paste0("Run", 1:(ncol(tmp01) - 1)))
tmp01 <- tmp01 %>%
    gather(., key = "Run", value = "Res", 2:ncol(tmp01))
tmp02 <- data.frame(X = res02$x, m = res02$median, l = res02$lower,
                    u = res02$upper, res = res02$residuals)
p07 <- ggplot() +
    geom_line(data = tmp01, aes(x = X, y = Res, group = Run),
              alpha = 0.1, colour = "black") +
    stat_qq(data = tmp02, aes(sample = res),
            pch = 21, fill = "white", colour = rgb01, size = 3,
            alpha = 0.9) +
    geom_line(data = tmp02, aes(x = X, y = m), colour = "red") +
    geom_line(data = tmp02, aes(x = X, y = l), colour = "red",
              linetype = "dashed") +
    geom_line(data = tmp02, aes(x = X, y = u), colour = "red",
              linetype = "dashed") +
    labs(x = "Theorical quantiles", y = "Residuals") +
    my_theme()
p08 <- ggplot(data = res, aes(x = .stdresid)) +
    geom_histogram(binwidth = 1, close = "right",
                   boundary = 1, fill = "white", colour = rgb01) +
    labs(x = "Standardized residuals", y = "Frenquency") +
    scale_x_continuous(breaks = seq(-4, 4, 1)) +
    ## scale_y_continuous(limits = c(0, 10), expand = c(0, 0)) +
    expand_limits(y = 0) +
    my_theme()
plot02 <- (p07 | p08)
plot02

######@> Detailed models...

#####@> SST...
m4 <- lm(SST ~ YearC, data = SWAO.out)
summary(m4)

#####@> BCt...
m5 <- lm((BC_transport * (-1)) ~ YearC, data = SWAO.out)
summary(m5)

######@> Time-lag models...

#####@> Converte data.frame in to TS...
db01 <- ts(SWAO.out, start = 1978, end = 2018, frequency = 1)

######@> Models...

####@> SST...
mod0a <- dynlm(MTC ~ L(SST, 0), data = db01)
mod1a <- dynlm(MTC ~ L(SST, 1), data = db01)
mod2a <- dynlm(MTC ~ L(SST, 2), data = db01)
mod3a <- dynlm(MTC ~ L(SST, 3), data = db01)
mod4a <- dynlm(MTC ~ L(SST, 4), data = db01)

###@> Summary...
summary(mod0a)$coefficients
summary(mod0a)$r.squared
AIC(mod0a)
summary(mod1a)$coefficients
summary(mod1a)$r.squared
AIC(mod1a)
summary(mod2a)$coefficients
summary(mod2a)$r.squared
AIC(mod2a)
summary(mod3a)$coefficients
summary(mod3a)$r.squared
AIC(mod3a)
summary(mod4a)$coefficients
summary(mod4a)$r.squared
AIC(mod4a)

###@> AIC...
AIC(mod0a, mod1a, mod2a, mod3a, mod4a)

####@> BCt...
mod0c <- dynlm(MTC ~ L(BC_transport, 0), data = db01)
mod1c <- dynlm(MTC ~ L(BC_transport, 1), data = db01)
mod2c <- dynlm(MTC ~ L(BC_transport, 2), data = db01)
mod3c <- dynlm(MTC ~ L(BC_transport, 3), data = db01)
mod4c <- dynlm(MTC ~ L(BC_transport, 4), data = db01)

###@> Resumo dos resultados...
summary(mod0c)$coefficients
summary(mod0c)$r.squared
AIC(mod0c)
summary(mod1c)$coefficients
summary(mod1c)$r.squared
AIC(mod1c)
summary(mod2c)$coefficients
summary(mod2c)$r.squared
AIC(mod2c)
summary(mod3c)$coefficients
summary(mod3c)$r.squared
AIC(mod3c)
summary(mod4c)$coefficients
summary(mod4c)$r.squared
AIC(mod4c)

###@> AIC...
AIC(mod0c, mod1c, mod2c, mod3c, mod4c)

########################################################################
##
##                  Creative Commons License 4.0
##                       (CC BY-NC-SA 4.0)
##
##  This is a humam-readable summary of (and not a substitute for) the
##  license (https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode)
##
##  You are free to:
##
##  Share - copy and redistribute the material in any medium or format.
##
##  The licensor cannot revoke these freedoms as long as you follow the
##  license terms.
##
##  Under the following terms:
##
##  Attribution - You must give appropriate credit, provide a link to
##  license, and indicate if changes were made. You may do so in any
##  reasonable manner, but not in any way that suggests the licensor
##  endorses you or your use.
##
##  NonCommercial - You may not use the material for commercial
##  purposes.
##
##  ShareAlike - If you remix, transform, or build upon the material,
##  you must distributive your contributions under the same license
##  as the  original.
##
##  No additional restrictions — You may not apply legal terms or
##  technological measures that legally restrict others from doing
##  anything the license permits.
##
########################################################################
