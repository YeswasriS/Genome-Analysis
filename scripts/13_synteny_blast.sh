#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -c 4
#SBATCH -t 02:00:00
#SBATCH -J synteny_blast
#SBATCH -e /home/yesi4977/genome_analyses/logs/synteny_blast_%j.err
#SBATCH --output=/home/yesi4977/genome_analyses/logs/synteny_blast_%j.out
#SBATCH --mail-type=ALL

module load BLAST+/2.16.0

OUTDIR=/home/yesi4977/genome_analyses/analyses/03_assembly_evaluation/synteny_ACT
ASSEMBLY=/home/yesi4977/genome_analyses/analyses/02_genome_assembly/canu/pacbio_canu.contigs.fasta
REF=$OUTDIR/GCA_000250945.1_ASM25094v1_genomic.fna

echo "Making BLAST database from reference..."
makeblastdb -in $REF -dbtype nucl -out $OUTDIR/refdb -title "Efaecium_Aus0004_ref"

echo "Running BLASTn: assembly vs reference..."
blastn \
    -query $ASSEMBLY \
    -db $OUTDIR/refdb \
    -outfmt 6 \
    -evalue 1e-10 \
    -perc_identity 80 \
    -num_threads 4 \
    -out $OUTDIR/assembly_vs_ref.crunch

echo "BLAST done!"
echo "Number of hits: $(wc -l < $OUTDIR/assembly_vs_ref.crunch)"
