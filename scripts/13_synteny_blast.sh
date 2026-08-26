#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 4
#SBATCH -t 02:00:00
#SBATCH -J synteny_blast
#SBATCH -e /home/yesi4977/genome_analyses/logs/synteny_blast_%j.err
#SBATCH --output=/home/yesi4977/genome_analyses/logs/synteny_blast_%j.out
#SBATCH --mail-type=ALL

module load bioinfo-tools blast/2.15.0+

OUTDIR=/home/yesi4977/genome_analyses/analyses/03_assembly_evaluation/synteny_ACT
ASSEMBLY=/home/yesi4977/genome_analyses/analyses/02_genome_assembly/canu/pacbio_canu.contigs.fasta
REF=$OUTDIR/efaecium_E745_reference.fna

mkdir -p $OUTDIR

echo "Downloading reference genome..."
cd $OUTDIR
wget -q "https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/250/945/GCF_000250945.1_Efa_E745/GCF_000250945.1_Efa_E745_genomic.fna.gz" \
     -O efaecium_E745_reference.fna.gz
gunzip efaecium_E745_reference.fna.gz
echo "Reference downloaded: $(grep -c '>' $REF) sequences"

echo "Making BLAST database..."
makeblastdb -in $REF -dbtype nucl -out $OUTDIR/refdb -title "Efaecium_E745_ref"

echo "Running BLASTn..."
blastn \
    -query $ASSEMBLY \
    -db $OUTDIR/refdb \
    -outfmt 6 \
    -evalue 1e-10 \
    -perc_identity 80 \
    -out $OUTDIR/assembly_vs_ref.crunch

echo "BLAST done. Hits: $(wc -l < $OUTDIR/assembly_vs_ref.crunch)"
