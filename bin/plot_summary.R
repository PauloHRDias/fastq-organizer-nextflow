#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
output_dir <- args[1]

samples <- list.dirs(output_dir, recursive = FALSE)
sample_names <- basename(samples)
n_files <- sapply(samples, function(s) length(list.files(s, pattern = "\\.fastq$")))

# Gera o gráfico na pasta de trabalho atual (não no output_dir)
png("summary.png", width = 800, height = 500)
barplot(n_files,
        names.arg = sample_names,
        col = "steelblue",
        main = "FASTQ files per sample",
        xlab = "Sample",
        ylab = "Number of files",
        ylim = c(0, max(n_files) + 1))
dev.off()

cat("Amostras processadas:", length(samples), "\n")
cat("Total de arquivos:", sum(n_files), "\n")