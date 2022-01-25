#!/bin/bash
#$ -S /bin/bash
#$ -N C3.modc.SplitMerge  ##job name
#$ -l tmem=16G #RAM
#$ -l h_vmem=16G #enforced limit on shell memory usage
#$ -l h_rt=10:00:00 ##wall time.
#$ -j y  #concatenates error and output files (with prefix job1)
#$ -t 1-40

#Run on working directory
cd $SGE_O_WORKDIR


#Path to software
export LD_LIBRARY_PATH=/share/apps/openblas-0.3.6/lib:/share/apps/armadillo-9.100.5/lib64:$LD_LIBRARY_PATH
ATLAS=/share/apps/genomics/atlas-0.9/atlas


#Define variables
SHAREDFOLDER=/SAN/ugi/LepGenomics
SPECIES=C3_Aricia_agestis_FP
FOLDER=C3_Aricia_agestis_FP
REF=$SHAREDFOLDER/$SPECIES/RefGenome2/GCA_905147365.1_ilAriAges1.1_genomic.fna
INPUT=$SHAREDFOLDER/$FOLDER/02a_mapped_MODC/02a_mapped_MODC/modc.bamlist.splitmerge
OUTPUT=$SHAREDFOLDER/$FOLDER/02a_mapped_MODC/02a_mapped_MODC
TASK=splitMerge

NAME=$(sed "${SGE_TASK_ID}q;d" modc.bamlist.splitmerge)


#Run analysis
#while IFS= read -r line; do $ATLAS task=$TASK bam=$line readGroupSettings=RG.txt; done < $INPUT
$ATLAS task=$TASK bam=${NAME} readGroupSettings=$SHAREDFOLDER/$FOLDER/02a_mapped_MODC/02a_mapped_MODC/RG.txt


