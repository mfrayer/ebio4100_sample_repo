#!/bin/bash

#SBATCH --nodes=1 --ntasks=1
#SBATCH --time=24:00:00
#SBATCH --partition=amilan 
#SBATCH --output=vcfs.out

module purge
module load picard 
module load samtools
module load bcftools 

for birds in /projects/mefr3284/bamfiles/*.filtered.sorted.bam ; do
        out=$(basename ${birds%%.*})
        bcftools mpileup -f /scratch/alpine/mefr3284/ebio4100/reference/moch.dovetail.reference.hap1.scaffolds.renamed.fasta ../bamfiles/$out.filtered.sorted.nodup.bam -a DP,AD -Ou | bcftools call -mv -Oz -f GQ -o /scratch/alpine/mefr3284/vcf/$out.vcf.gz
        tabix -fp vcf /scratch/alpine/mefr3284/vcf/$out.vcf.gz
done

