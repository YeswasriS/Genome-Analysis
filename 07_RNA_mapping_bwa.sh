#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 2
#SBATCH -t 05:00:00
#SBATCH -J bwa_mapping
#SBATCH -e bwa_%j.err
#SBATCH --mail-type=ALL
#SBATCH --output=/home/yesi4977/genome_analyses/analyses/06_RNA_mapping/bwa/bwa.log

# ============================================
# Phase 4 - RNA mapping with BWA
# Input: Pre-trimmed RNA-seq reads
# Reference: Prokka annotated genome
# Output: 06_RNA_mapping/bwa/
# ============================================

# Load modules
module load BWA/0.7.19-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

# Define paths
GENOME=/home/yesi4977/genome_analyses/analyses/04_annotation/prokka/efaecium_E745.fna
BHI_TRIMMED=/proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/transcriptomics_data/RNA-Seq_BH/trimmed
SERUM_TRIMMED=/proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/transcriptomics_data/RNA-Seq_Serum/trimmed
OUT_DIR=/home/yesi4977/genome_analyses/analyses/06_RNA_mapping/bwa

# Create output folder
mkdir -p $OUT_DIR

# ============================================
# STEP 1 - Index the genome
# ============================================
echo "Indexing genome..."
bwa index $GENOME

# ============================================
# STEP 2 - Map BHI samples
# ============================================

echo "Mapping ERR1797972 (BHI rep1)..."
bwa mem -t 2 $GENOME \
    $BHI_TRIMMED/trim_paired_ERR1797972_pass_1.fastq.gz \
    $BHI_TRIMMED/trim_paired_ERR1797972_pass_2.fastq.gz \
    | samtools sort -o $OUT_DIR/ERR1797972.bam
samtools index $OUT_DIR/ERR1797972.bam

echo "Mapping ERR1797973 (BHI rep2)..."
bwa mem -t 2 $GENOME \
    $BHI_TRIMMED/trim_paired_ERR1797973_pass_1.fastq.gz \
    $BHI_TRIMMED/trim_paired_ERR1797973_pass_2.fastq.gz \
    | samtools sort -o $OUT_DIR/ERR1797973.bam
samtools index $OUT_DIR/ERR1797973.bam

echo "Mapping ERR1797974 (BHI rep3)..."
bwa mem -t 2 $GENOME \
    $BHI_TRIMMED/trim_paired_ERR1797974_pass_1.fastq.gz \
    $BHI_TRIMMED/trim_paired_ERR1797974_pass_2.fastq.gz \
    | samtools sort -o $OUT_DIR/ERR1797974.bam
samtools index $OUT_DIR/ERR1797974.bam

# ============================================
# STEP 3 - Map Serum samples
# ============================================

echo "Mapping ERR1797969 (Serum rep1)..."
bwa mem -t 2 $GENOME \
    $SERUM_TRIMMED/trim_paired_ERR1797969_pass_1.fastq.gz \
    $SERUM_TRIMMED/trim_paired_ERR1797969_pass_2.fastq.gz \
    | samtools sort -o $OUT_DIR/ERR1797969.bam
samtools index $OUT_DIR/ERR1797969.bam

echo "Mapping ERR1797970 (Serum rep2)..."
bwa mem -t 2 $GENOME \
    $SERUM_TRIMMED/trim_paired_ERR1797970_pass_1.fastq.gz \
    $SERUM_TRIMMED/trim_paired_ERR1797970_pass_2.fastq.gz \
    | samtools sort -o $OUT_DIR/ERR1797970.bam
samtools index $OUT_DIR/ERR1797970.bam

echo "Mapping ERR1797971 (Serum rep3)..."
bwa mem -t 2 $GENOME \
    $SERUM_TRIMMED/trim_paired_ERR1797971_pass_1.fastq.gz \
    $SERUM_TRIMMED/trim_paired_ERR1797971_pass_2.fastq.gz \
    | samtools sort -o $OUT_DIR/ERR1797971.bam
samtools index $OUT_DIR/ERR1797971.bam

echo "All mapping done successfully!"
