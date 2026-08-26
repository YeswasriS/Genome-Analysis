#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 4
#SBATCH -t 02:00:00
#SBATCH -J fastqc_trimmed
#SBATCH -e /home/yesi4977/genome_analyses/logs/fastqc_trimmed_%j.err
#SBATCH --output=/home/yesi4977/genome_analyses/logs/fastqc_trimmed_%j.out
#SBATCH --mail-type=ALL

module load bioinfo-tools FastQC/0.11.9
module load MultiQC/1.12

TRIMMED=/home/yesi4977/genome_analyses/data/trimmed_data
OUT=/home/yesi4977/genome_analyses/analyses/05_RNA_quality_control/fastqc_trimmed
RAW_QC=/home/yesi4977/genome_analyses/analyses/05_RNA_quality_control/fastqc_raw

mkdir -p $OUT

echo "Running FastQC on trimmed paired reads..."
fastqc -t 4 -o $OUT $TRIMMED/*_paired.fastq.gz

echo "Running MultiQC combining raw and trimmed..."
multiqc $RAW_QC $OUT -o $OUT -n multiqc_before_after_trim

echo "DONE"
