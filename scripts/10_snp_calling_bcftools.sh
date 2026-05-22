#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 2
#SBATCH -t 03:00:00
#SBATCH -J snp_calling
#SBATCH -e snp_%j.err
#SBATCH --mail-type=ALL
#SBATCH --output=/home/yesi4977/genome_analyses/analyses/09_extra/resfinder/snp_calling.log

# ============================================
# Extra Analysis - SNP Calling with BCFtools
# Input: BWA BAM files
# Reference: Prokka annotated genome
# Output: 09_extra/resfinder/
# ============================================

# Load modules
module load BCFtools/1.22-GCC-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

# Define paths
GENOME=/home/yesi4977/genome_analyses/analyses/04_annotation/prokka/efaecium_E745.fna
BAM_DIR=/home/yesi4977/genome_analyses/analyses/06_RNA_mapping/bwa
OUT_DIR=/home/yesi4977/genome_analyses/analyses/09_extra/resfinder

mkdir -p $OUT_DIR

# Step 1 - Generate pileup and call variants
echo "Running mpileup..."
bcftools mpileup \
    -f $GENOME \
    $BAM_DIR/ERR1797972.bam \
    $BAM_DIR/ERR1797973.bam \
    $BAM_DIR/ERR1797974.bam \
    $BAM_DIR/ERR1797969.bam \
    $BAM_DIR/ERR1797970.bam \
    $BAM_DIR/ERR1797971.bam \
    | bcftools call -mv \
    -o $OUT_DIR/variants.vcf

# Step 2 - Filter variants
echo "Filtering variants..."
bcftools filter \
    -s LowQual \
    -e '%QUAL<20 || DP<10' \
    $OUT_DIR/variants.vcf \
    > $OUT_DIR/variants_filtered.vcf

# Step 3 - Get statistics
echo "Getting statistics..."
bcftools stats $OUT_DIR/variants_filtered.vcf \
    > $OUT_DIR/variants_stats.txt

echo "SNP calling complete!"
