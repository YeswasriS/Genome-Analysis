#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 2
#SBATCH -t 10:00:00
#SBATCH -J htseq_counting
#SBATCH -e htseq_%j.err
#SBATCH --mail-type=ALL
#SBATCH --output=/home/yesi4977/genome_analyses/analyses/07_read_counting/htseq/htseq.log

# ============================================
# Phase 4 - Read Counting with HTSeq
# Input: BAM files from BWA mapping
# Reference: Prokka GFF annotation file
# Output: 07_read_counting/htseq/
# ============================================

# Load module
module load HTSeq/2.1.2-gfbf-2024a

# Define paths
BAM_DIR=/home/yesi4977/genome_analyses/analyses/06_RNA_mapping/bwa
GFF=/home/yesi4977/genome_analyses/analyses/07_read_counting/htseq/efaecium_E745_clean.gff
OUT_DIR=/home/yesi4977/genome_analyses/analyses/07_read_counting/htseq

# Create output folder
mkdir -p $OUT_DIR

# ============================================
# Run HTSeq on all 6 samples
# ============================================

echo "Counting reads for ERR1797969 (Serum rep1)..."
htseq-count \
    -f bam \
    -r pos \
    -s yes \
    -t CDS \
    -i ID \
    $BAM_DIR/ERR1797969.bam \
    $GFF \
    > $OUT_DIR/ERR1797969_counts.txt

echo "Counting reads for ERR1797970 (Serum rep2)..."
htseq-count \
    -f bam \
    -r pos \
    -s yes \
    -t CDS \
    -i ID \
    $BAM_DIR/ERR1797970.bam \
    $GFF \
    > $OUT_DIR/ERR1797970_counts.txt

echo "Counting reads for ERR1797971 (Serum rep3)..."
htseq-count \
    -f bam \
    -r pos \
    -s yes \
    -t CDS \
    -i ID \
    $BAM_DIR/ERR1797971.bam \
    $GFF \
    > $OUT_DIR/ERR1797971_counts.txt

echo "Counting reads for ERR1797972 (BHI rep1)..."
htseq-count \
    -f bam \
    -r pos \
    -s yes \
    -t CDS \
    -i ID \
    $BAM_DIR/ERR1797972.bam \
    $GFF \
    > $OUT_DIR/ERR1797972_counts.txt

echo "Counting reads for ERR1797973 (BHI rep2)..."
htseq-count \
    -f bam \
    -r pos \
    -s yes \
    -t CDS \
    -i ID \
    $BAM_DIR/ERR1797973.bam \
    $GFF \
    > $OUT_DIR/ERR1797973_counts.txt

echo "Counting reads for ERR1797974 (BHI rep3)..."
htseq-count \
    -f bam \
    -r pos \
    -s yes \
    -t CDS \
    -i ID \
    $BAM_DIR/ERR1797974.bam \
    $GFF \
    > $OUT_DIR/ERR1797974_counts.txt

echo "All read counting done successfully!"
