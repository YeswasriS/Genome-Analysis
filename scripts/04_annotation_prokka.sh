#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J prokka_annotation
#SBATCH -e prokka_%j.err
#SBATCH --mail-type=ALL
#SBATCH --output=/home/yesi4977/genome_analyses/analyses/04_annotation/prokka/prokka.log

# ============================================
# Phase 4 - Genome Annotation with Prokka
# Input: Canu assembly contigs
# Output: 04_annotation/prokka/
# ============================================

# Load module
module load prokka/1.14.5-gompi-2024a

# Define paths
ASSEMBLY=/home/yesi4977/genome_analyses/analyses/02_genome_assembly/canu/pacbio_canu.contigs.fasta
OUT_DIR=/home/yesi4977/genome_analyses/analyses/04_annotation/prokka

# Create output folder
mkdir -p $OUT_DIR

# Run Prokka
prokka \
    --outdir $OUT_DIR \
    --prefix efaecium_E745 \
    --genus Enterococcus \
    --species faecium \
    --strain E745 \
    --kingdom Bacteria \
    --cpus 2 \
    --force \
    $ASSEMBLY

echo "Prokka finished successfully!"
