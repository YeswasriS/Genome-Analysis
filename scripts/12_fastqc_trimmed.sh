#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 4
#SBATCH -t 02:00:00
#SBATCH -J fastqc_trimmed
#SBATCH -e /home/yesi4977/genome_analyses/logs/fastqc_trimmed_%j.err
#SBATCH --output=/home/yesi4977/genome_analyses/logs/fastqc_trimmed_%j.out
#SBATCH --mail-type=ALL

module load FastQC/0.12.1-Java-11
module load MultiQC/1.28-gfbf-2024a

BHI_TRIMMED=/home/yesi4977/genome_analyses/data/trimmed_data
SERUM_TRIMMED=/proj/uppmax2026-1-61/uppmax2026-1-61/nobackup/yesi4977/trimmed_serum
OUT=/home/yesi4977/genome_analyses/analyses/05_RNA_quality_control/fastqc_trimmed
RAW_QC=/home/yesi4977/genome_analyses/analyses/05_RNA_quality_control/fastqc_raw

mkdir -p $OUT

echo "Running FastQC on BHI trimmed reads..."
fastqc -t 4 -o $OUT $BHI_TRIMMED/*_paired.fastq.gz

echo "Running FastQC on Serum trimmed reads..."
fastqc -t 4 -o $OUT $SERUM_TRIMMED/*_paired.fastq.gz

echo "Running MultiQC combining raw and trimmed..."
multiqc $RAW_QC $OUT -o $OUT -n multiqc_before_after_trim

echo "DONE"
