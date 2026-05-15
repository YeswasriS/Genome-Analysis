#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -n 4
#SBATCH -t 24:00:00
#SBATCH -J canu_assembly
#SBATCH -e canu_%j.err
#SBATCH --mem=64G
#SBATCH --mail-type=ALL
#SBATCH --output=/home/yesi4977/genome_analyses/analyses/02_genome_assembly/canu/canu.log

# Load modules (Pelle system)
module load Canu
module load SAMtools

# Base directory
BASE_DIR=/home/yesi4977/genome_analyses

RAW_DATA=$BASE_DIR/data/raw_data/pacbio
OUT_DIR=$BASE_DIR/analyses/02_genome_assembly/canu

mkdir -p $OUT_DIR
cd $OUT_DIR

# -----------------------------
# Use correct file pattern
# -----------------------------
READS=$(ls $RAW_DATA/*.fastq.gz)

# Debug print (VERY useful)
echo "Using these input files:"
echo $READS

# -----------------------------
# Run Canu
# -----------------------------
canu \
-p pacbio_canu \
-d $OUT_DIR \
genomeSize=3m \
useGrid=false \
maxThreads=4 \
-pacbio $READS

echo "successfully"

