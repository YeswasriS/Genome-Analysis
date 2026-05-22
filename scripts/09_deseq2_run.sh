#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J deseq2
#SBATCH -e deseq2_%j.err
#SBATCH --mail-type=ALL
#SBATCH --output=/home/yesi4977/genome_analyses/analyses/08_differential_expression/deseq2/deseq2.log

# Load R module
module load R/4.4.2-gfbf-2024a

# Run DESeq2 script
Rscript /home/yesi4977/genome_analyses/code/09_deseq2.R

echo "DESeq2 finished!"
