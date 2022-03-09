#!/bin/bash
##################################
# Alexandra Jansen van Rensburg
# Last Modified 17/11/2021
##################################
#v1

# Generates submission script for second part of the trimming process using AdapterRemoval
# Romain found that the Cutadapt step (01a) does not remove all of the adapter sequence. We'v$
# AdapterRemoval will merge any overlapping reads as well, which is needed for the museum sam$


/SAN/ugi/LepGenomics/VelocityPipeline/wrapper/parallel_adapterremoval_UCL.sh \
-i /SAN/ugi/LepGenomics/C3_Aricia_agestis_FP/01a_Trimmomatic_modc \
-o /SAN/ugi/LepGenomics/C3_Aricia_agestis_FP/01b_AdapterRemoval_modc_unmerged \
-n 1 -t 1 -m 8 -N AdaptRem.modc.unmerged;
