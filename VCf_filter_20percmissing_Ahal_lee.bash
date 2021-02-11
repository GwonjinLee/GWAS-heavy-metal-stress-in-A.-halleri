#!/bin/bash

# Description
# This uses vcftools to filter the .vcf
## file for high-quality SNPs. Be sure to have vcftools installed
## for this script to work.

#Move to working directory
cd /homes/gwonjin/pflaphy-gwas/



# Other parameters can be changed as well. You may edit the script after the line beginning
## with "bcftools reheader...". Please see https://vcftools.github.io/man_latest.html for
## a list of adjustable parameters.


####################################################
##### USE CAUTION WHEN EDITING BELOW THIS LINE #####
####################################################

set -e
set -u
set -o pipefail



#### Step 1 create list of high confidence SNPs from Lyrata 



# Minimum mapping quality score (phred scaled) # to include that variant originally: 40
MinQ=40
# Minimum genotype quality score (phred scaled) to include that genotype originally: 40
MinGQ=30
# The minimum average read depth for a variant to include that variant
#MinMeanDP=20
# The minimum per-genotype read depth to include that genotype #Originally 30, maybe 20 would be easier?
MinDP=8
# The maximum per-genotype read depth to include that genotype #JEA added, from Karl's group
MaxDP=3000
# The minimum minor allele frequency to retain a site
MinMAF=0.01
# The minimum non-missing data proportion to retain a site (where 0 allows 
## completely missing data and 1 restricts to no missing data)
MaxMISS=.2
#Non-reference Minor allele count and Minor allele count
#MinMAC=5



# Use bcftools reheader to change the sample names, then pipe the output to vcftools for filtering
echo -e "\nStarting VCF filtering. $MaxMISS"
#bcftools reheader --samples new_vcf_sample_names.txt $VCFIN | 

#exit


#### Step 2 Repeat for A. halleri


# The complete filepath to the VCF file
VCFIN=software/LinkimputeR/20170901_linkimputer-src/output_dp8_0.2_0.3_case1.vcf

# The desired name of the VCF file (including the .vcf extension)
VCFOUT=VCFfiles/Ahal_ken_case1_miss20_maf1_remove9genos.vcf

./software/vcftools --vcf $VCFIN  \
	--remove-filtered-all \
	--remove-indels \
	--min-alleles 2 \
	--max-alleles 2 \
	--minQ $MinQ \
	--remove scripts/Remove.txt \
	--minGQ $MinGQ \
	--minDP $MinDP \
	--maxDP $MaxDP \
	--recode \
	--recode-INFO-all \
	--maf $MinMAF \
	--max-missing $MaxMISS  \
	--out $VCFOUT

mv $VCFOUT.recode.vcf $VCFOUT

