#!/bin/bash

gzip Ahal_postFinalFilter_Imputed_BadSampsRemoved_1perSite.vcf 
zcat Ahal_postFinalFilter_Imputed_BadSampsRemoved_1perSite.vcf.gz | ./software/vcftools-vcftools-1d27c24/src/perl/vcf-to-tab > Ahal_postFinalFilter_Imputed_BadSampsRemoved_Copy.tab
perl vcf_tab_to_fasta_alignment.pl --output_ref -i Ahal_postFinalFilter_Imputed_BadSampsRemoved_Copy.tab > Ahal_postFinalFilter_Imputed_BadSampsRemoved_Copy.fasta

