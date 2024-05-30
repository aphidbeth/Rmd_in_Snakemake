# script to make an R plot

# Redirects the R errors to the snakemake log file
log <- file(snakemake@log$log_file, open = "wt")
sink(log)
sink(log, type = "message")


library(tidyverse)

# Using the mtcars dataset
a_plot <- ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()

tiff(filename=snakemake@output[["a_plot"]], width = 5.6 , height = 4.1, units="in", res=300)
a_plot
dev.off()