#!/bin/bash
# Script para organizar arquivos FASTQ por amostra
# Uso: ./organize.sh sample1_R1.fastq sample1_R2.fastq

for file in "$@"; do
	sample=$(basename "$file" | cut -d'_' -f1)
	mkdir -p "output/$sample/"
	mv "$file" "output/$sample"
	echo "Arquivo $file movido para output/$sample"
done

echo "Organizacao concluida"
