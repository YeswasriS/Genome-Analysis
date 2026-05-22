.libPaths(c("/home/yesi4977/R/library", .libPaths()))
# ============================================
# Phase 4 - Differential Expression Analysis
# Tool: DESeq2
# Input: HTSeq count tables
# Output: 08_differential_expression/deseq2/
# ============================================

# Load required libraries
library(DESeq2)

# ============================================
# STEP 1 - Set paths
# ============================================
count_dir <- "/home/yesi4977/genome_analyses/analyses/07_read_counting/htseq"
out_dir <- "/home/yesi4977/genome_analyses/analyses/08_differential_expression/deseq2"
dir.create(out_dir, showWarnings = FALSE)

# ============================================
# STEP 2 - Load count files
# ============================================
# List all count files
count_files <- c(
  file.path(count_dir, "ERR1797972_counts.txt"),  # BHI rep1
  file.path(count_dir, "ERR1797973_counts.txt"),  # BHI rep2
  file.path(count_dir, "ERR1797974_counts.txt"),  # BHI rep3
  file.path(count_dir, "ERR1797969_counts.txt"),  # Serum rep1
  file.path(count_dir, "ERR1797970_counts.txt"),  # Serum rep2
  file.path(count_dir, "ERR1797971_counts.txt")   # Serum rep3
)

# Sample information
sample_info <- data.frame(
  sampleName = c("BHI_rep1", "BHI_rep2", "BHI_rep3",
                 "Serum_rep1", "Serum_rep2", "Serum_rep3"),
  fileName = count_files,
  condition = factor(c("BHI", "BHI", "BHI",
                       "Serum", "Serum", "Serum"))
)

# ============================================
# STEP 3 - Create DESeq2 object
# ============================================
dds <- DESeqDataSetFromHTSeqCount(
  sampleTable = sample_info,
  directory = "",
  design = ~ condition
)

# Set BHI as reference condition
dds$condition <- relevel(dds$condition, ref = "BHI")

# ============================================
# STEP 4 - Filter low count genes
# ============================================
# Keep genes with at least 10 reads total
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

cat("Genes after filtering:", nrow(dds), "\n")

# ============================================
# STEP 5 - Run DESeq2
# ============================================
dds <- DESeq(dds)

# ============================================
# STEP 6 - Get results
# ============================================
# Serum vs BHI comparison
res <- results(dds, 
               contrast = c("condition", "Serum", "BHI"),
               alpha = 0.05)

# Summary of results
cat("\n=== DESeq2 Results Summary ===\n")
summary(res)

# ============================================
# STEP 7 - Save results
# ============================================
# All results
write.csv(as.data.frame(res), 
          file = file.path(out_dir, "deseq2_all_results.csv"),
          row.names = TRUE)

# Significant results only (padj < 0.05 and |log2FC| > 1)
res_sig <- subset(res, padj < 0.05 & abs(log2FoldChange) > 1)
write.csv(as.data.frame(res_sig),
          file = file.path(out_dir, "deseq2_significant_results.csv"),
          row.names = TRUE)

cat("\nTotal significant DEGs:", nrow(res_sig), "\n")
cat("Upregulated in serum:", 
    nrow(subset(res_sig, log2FoldChange > 0)), "\n")
cat("Downregulated in serum:", 
    nrow(subset(res_sig, log2FoldChange < 0)), "\n")

# ============================================
# STEP 8 - Generate plots
# ============================================

# MA plot
pdf(file.path(out_dir, "MA_plot.pdf"))
plotMA(res, main="DESeq2 MA Plot: Serum vs BHI", 
       ylim=c(-10,10))
dev.off()

# PCA plot
pdf(file.path(out_dir, "PCA_plot.pdf"))
vsd <- vst(dds, blind=FALSE)
plotPCA(vsd, intgroup="condition")
dev.off()

cat("\nDESeq2 analysis complete!\n")
cat("Results saved to:", out_dir, "\n")
