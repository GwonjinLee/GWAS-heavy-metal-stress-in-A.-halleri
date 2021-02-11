#!/bin/bash

# This script uses BWAmem to align reads from Lara's data to reference genome of choice. For more information visit the BWA website http://bio-bwa.sourceforge.net/bwa.shtml

set -e
set -u
set -o pipefail

# Set working directory
cd prj/pflaphy-gwas/RawReads

#bwa mem -k 10 -B 4 -t 12 ReferenceGenome.fa IndividualX.fastq.gz > Outputfolder/IndividualX-GenomeY.sam
#-k 10 is a shortened seed size

#Example
bwa mem -k 10 -B 4 -t 12 \
	 /media/4EXT/Plant_genomic_ressources/Alyrata/v1.0/assembly/Alyrata_107_v1.fa \
	 CleanedReads/Fuzi_03_trimmedCleaned.fastq.gz \
	 > /home/justin/JustinGBS/LyrMappedFinal/Fuzi_03_B4_k10_mem.sam


# Sort and filter SAM file for IGV view

samtools view -bS IndividualX.sam > IndividualX.bam
samtools sort IndividualX.bam


# If you wanted to remove multi-mapped reads:
# samtools view -hF 4 Achr_01_B4_k10_mem.sam | grep -v "	XA:Z:" | samtools view -Su - | samtools sort -o Achr_01.bam