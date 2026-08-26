#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 4
#SBATCH -t 05:00:00
#SBATCH -J trimmomatic_rerun
#SBATCH -e /home/yesi4977/genome_analyses/logs/trimmomatic_rerun_%j.err
#SBATCH --output=/home/yesi4977/genome_analyses/logs/trimmomatic_rerun_%j.out
#SBATCH --mail-type=ALL

module load Trimmomatic/0.39-Java-17

RAW=/home/yesi4977/genome_analyses/data/raw_data/illumina
OUT=/home/yesi4977/genome_analyses/data/trimmed_data

mkdir -p $OUT

for SAMPLE in ERR1797972 ERR1797973 ERR1797974 ERR1797969 ERR1797970 ERR1797971; do
    echo "Trimming $SAMPLE..."
    trimmomatic PE \
        $RAW/${SAMPLE}_1.fastq.gz \
        $RAW/${SAMPLE}_2.fastq.gz \
        $OUT/${SAMPLE}_1_paired.fastq.gz \
        $OUT/${SAMPLE}_1_unpaired.fastq.gz \
        $OUT/${SAMPLE}_2_paired.fastq.gz \
        $OUT/${SAMPLE}_2_unpaired.fastq.gz \
        ILLUMINACLIP:$TRIMMOMATIC_ROOT/adapters/TruSeq3-PE.fa:2:30:10 \
        LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
    echo "$SAMPLE done."
done

echo "ALL SAMPLES TRIMMED"
