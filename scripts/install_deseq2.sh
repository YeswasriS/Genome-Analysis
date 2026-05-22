#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J install_deseq2
#SBATCH -e install_deseq2_%j.err
#SBATCH --mail-type=ALL
#SBATCH --output=/home/yesi4977/genome_analyses/code/install_deseq2.log

# Load R module
module load R/4.4.2-gfbf-2024a

# Set personal R library path
export R_LIBS_USER=/home/yesi4977/R/library

# Install DESeq2
Rscript -e '
.libPaths(c("/home/yesi4977/R/library", .libPaths()))
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", 
                     repos="https://cloud.r-project.org",
                     lib="/home/yesi4977/R/library")
BiocManager::install("DESeq2", 
                     lib="/home/yesi4977/R/library",
                     ask=FALSE)
cat("DESeq2 installation complete!\n")
'
