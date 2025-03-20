library(visreg)
library(ggplot2)
library(data.table)
library(magrittr)
library(stringr)
theme_set(hrbrthemes::theme_ft_rc())
res <- arrow::read_parquet('biglasso.pqt') |> as.data.table()

png('../img/biglasso.png', pointsize=16, res=72*2, type='cairo-png')
res[str_detect(Method, 'cores', negate = TRUE)] %>%
  ggplot(aes(Which.vary, time, group=Method, color=Method)) +
  geom_line() +
  xlab('Number of features') +
  ylab('Time (s)') +
  guides(color='none')
dev.off()
system('mogrify -resize 200x ../img/biglasso.png')
