#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J quast_evaluation
#SBATCH -e quast_%j.err
#SBATCH --mail-type=ALL
#SBATCH --output=/home/yesi4977/genome_analyses/analyses/03_assembly_evaluation/quast/quast.log

# ============================================
# Phase 3 - Assembly Evaluation with QUAST
# Input: Canu assembly contigs
# Output: 03_assembly_evaluation/quast/
# ============================================

# Load module
module load QUAST

# Define paths
ASSEMBLY=/home/yesi4977/genome_analyses/analyses/02_genome_assembly/canu/pacbio_canu.contigs.fasta
OUT_DIR=/home/yesi4977/genome_analyses/analyses/03_assembly_evaluation/quast

# Create output folder
mkdir -p $OUT_DIR

# Run QUAST
quast.py \
    $ASSEMBLY \
    -o $OUT_DIR \
    --threads 2

echo "QUAST finished successfully!"
