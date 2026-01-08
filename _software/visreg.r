library(visreg)
library(ggplot2)
library(hrbrthemes)
theme_set(theme_ft_rc())

png("../assets/visreg.png", pointsize = 16, res = 72 * 2, type = "cairo-png")
airquality$Heat <- cut(airquality$Temp, 3, labels = c("Cool", "Mild", "Hot"))
fit <- lm(Ozone ~ Solar.R + Wind * Heat, data = airquality)
visreg(fit, "Wind", by = "Heat", overlay = TRUE, gg = TRUE) +
  guides(color = "none", fill = "none")
dev.off()
system("mogrify -resize 200x ../assets/visreg.png")
