#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc_raw
#SBATCH -e fastqc_raw_%j.err
#SBATCH --mail-type=ALL
#SBATCH --output=/home/yesi4977/genome_analyses/analyses/05_RNA_quality_control/fastqc_raw/fastqc_raw.log

# ============================================
# Phase 4 - RNA-seq Quality Control (FastQC)
# Input: Raw RNA-seq reads
# Output: 05_RNA_quality_control/fastqc_raw/
# ============================================

# Load module
module load FastQC/0.12.1-Java-17

# Define paths
RAW_DATA=/home/yesi4977/genome_analyses/data/raw_data/illumina
OUT_DIR=/home/yesi4977/genome_analyses/analyses/05_RNA_quality_control/fastqc_raw

# Create output folder
mkdir -p $OUT_DIR

# Run FastQC on all 12 raw files at once
fastqc \
    $RAW_DATA/ERR1797972_1.fastq.gz \
    $RAW_DATA/ERR1797972_2.fastq.gz \
    $RAW_DATA/ERR1797973_1.fastq.gz \
    $RAW_DATA/ERR1797973_2.fastq.gz \
    $RAW_DATA/ERR1797974_1.fastq.gz \
    $RAW_DATA/ERR1797974_2.fastq.gz \
    $RAW_DATA/ERR1797969_1.fastq.gz \
    $RAW_DATA/ERR1797969_2.fastq.gz \
    $RAW_DATA/ERR1797970_1.fastq.gz \
    $RAW_DATA/ERR1797970_2.fastq.gz \
    $RAW_DATA/ERR1797971_1.fastq.gz \
    $RAW_DATA/ERR1797971_2.fastq.gz \
    --outdir $OUT_DIR \
    --threads 2

echo "FastQC finished successfully!"
