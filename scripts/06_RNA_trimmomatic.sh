#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 2
#SBATCH -t 05:00:00
#SBATCH -J trimmomatic_RNA
#SBATCH -e trimmomatic_%j.err
#SBATCH --mail-type=ALL
#SBATCH --output=/home/yesi4977/genome_analyses/analyses/05_RNA_quality_control/trimmomatic/trimmomatic.log

# ============================================
# Phase 4 - RNA-seq Trimming with Trimmomatic
# Input: Raw RNA-seq reads
# Output: 05_RNA_quality_control/trimmomatic/
# ============================================

# Load module
module load Trimmomatic/0.39-Java-17

# Define paths
RAW_DATA=/home/yesi4977/genome_analyses/data/raw_data/illumina
OUT_DIR=/home/yesi4977/genome_analyses/analyses/05_RNA_quality_control/trimmomatic

# Create output folder
mkdir -p $OUT_DIR

# ---- BHI samples ----

echo "Trimming ERR1797972 (BHI rep1)..."
trimmomatic PE \
    $RAW_DATA/ERR1797972_1.fastq.gz \
    $RAW_DATA/ERR1797972_2.fastq.gz \
    $OUT_DIR/ERR1797972_1_paired.fastq.gz \
    $OUT_DIR/ERR1797972_1_unpaired.fastq.gz \
    $OUT_DIR/ERR1797972_2_paired.fastq.gz \
    $OUT_DIR/ERR1797972_2_unpaired.fastq.gz \
    ILLUMINACLIP:$TRIMMOMATIC_ROOT/adapters/TruSeq3-PE.fa:2:30:10 \
    LEADING:3 \
    TRAILING:3 \
    SLIDINGWINDOW:4:15 \
    MINLEN:36

echo "Trimming ERR1797973 (BHI rep2)..."
trimmomatic PE \
    $RAW_DATA/ERR1797973_1.fastq.gz \
    $RAW_DATA/ERR1797973_2.fastq.gz \
    $OUT_DIR/ERR1797973_1_paired.fastq.gz \
    $OUT_DIR/ERR1797973_1_unpaired.fastq.gz \
    $OUT_DIR/ERR1797973_2_paired.fastq.gz \
    $OUT_DIR/ERR1797973_2_unpaired.fastq.gz \
    ILLUMINACLIP:$TRIMMOMATIC_ROOT/adapters/TruSeq3-PE.fa:2:30:10 \
    LEADING:3 \
    TRAILING:3 \
    SLIDINGWINDOW:4:15 \
    MINLEN:36

echo "Trimming ERR1797974 (BHI rep3)..."
trimmomatic PE \
    $RAW_DATA/ERR1797974_1.fastq.gz \
    $RAW_DATA/ERR1797974_2.fastq.gz \
    $OUT_DIR/ERR1797974_1_paired.fastq.gz \
    $OUT_DIR/ERR1797974_1_unpaired.fastq.gz \
    $OUT_DIR/ERR1797974_2_paired.fastq.gz \
    $OUT_DIR/ERR1797974_2_unpaired.fastq.gz \
    ILLUMINACLIP:$TRIMMOMATIC_ROOT/adapters/TruSeq3-PE.fa:2:30:10 \
    LEADING:3 \
    TRAILING:3 \
    SLIDINGWINDOW:4:15 \
    MINLEN:36

# ---- Serum samples ----

echo "Trimming ERR1797969 (Serum rep1)..."
trimmomatic PE \
    $RAW_DATA/ERR1797969_1.fastq.gz \
    $RAW_DATA/ERR1797969_2.fastq.gz \
    $OUT_DIR/ERR1797969_1_paired.fastq.gz \
    $OUT_DIR/ERR1797969_1_unpaired.fastq.gz \
    $OUT_DIR/ERR1797969_2_paired.fastq.gz \
    $OUT_DIR/ERR1797969_2_unpaired.fastq.gz \
    ILLUMINACLIP:$TRIMMOMATIC_ROOT/adapters/TruSeq3-PE.fa:2:30:10 \
    LEADING:3 \
    TRAILING:3 \
    SLIDINGWINDOW:4:15 \
    MINLEN:36

echo "Trimming ERR1797970 (Serum rep2)..."
trimmomatic PE \
    $RAW_DATA/ERR1797970_1.fastq.gz \
    $RAW_DATA/ERR1797970_2.fastq.gz \
    $OUT_DIR/ERR1797970_1_paired.fastq.gz \
    $OUT_DIR/ERR1797970_1_unpaired.fastq.gz \
    $OUT_DIR/ERR1797970_2_paired.fastq.gz \
    $OUT_DIR/ERR1797970_2_unpaired.fastq.gz \
    ILLUMINACLIP:$TRIMMOMATIC_ROOT/adapters/TruSeq3-PE.fa:2:30:10 \
    LEADING:3 \
    TRAILING:3 \
    SLIDINGWINDOW:4:15 \
    MINLEN:36

echo "Trimming ERR1797971 (Serum rep3)..."
trimmomatic PE \
    $RAW_DATA/ERR1797971_1.fastq.gz \
    $RAW_DATA/ERR1797971_2.fastq.gz \
    $OUT_DIR/ERR1797971_1_paired.fastq.gz \
    $OUT_DIR/ERR1797971_1_unpaired.fastq.gz \
    $OUT_DIR/ERR1797971_2_paired.fastq.gz \
    $OUT_DIR/ERR1797971_2_unpaired.fastq.gz \
    ILLUMINACLIP:$TRIMMOMATIC_ROOT/adapters/TruSeq3-PE.fa:2:30:10 \
    LEADING:3 \
    TRAILING:3 \
    SLIDINGWINDOW:4:15 \
    MINLEN:36

