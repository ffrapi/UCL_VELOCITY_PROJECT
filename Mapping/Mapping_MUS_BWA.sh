#!/bin/bash
#$ -S /bin/bash
#$ -N C3.BWAmem_mod  ##job name
#$ -l tmem=16G #RAM
#$ -l h_vmem=16G #enforced limit on memory shell usage
#$ -l h_rt=15:00:00 ##wall time.
#$ -j y  #concatenates error and output files (with prefix job1)
#$ -t 1-1

#run job in working directory
cd $SGE_O_WORKDIR


##Software
BWA=/share/apps/genomics/bwa-0.7.17/bwa
export PATH=/share/apps/genomics/samtools-1.9/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/genomics/samtools-1.9/lib:$LD_LIBRARY_PATH

#Define variables
SHAREDFOLDER=/SAN/ugi/LepGenomics
SPECIES=C3_Aricia_agestis_FP
REF=$SHAREDFOLDER/$SPECIES/RefGenome2/GCA_905147365.1_ilAriAges1.1_genomic.fna
INPUT=$SHAREDFOLDER/$SPECIES/01b_AdapterRemoval_museum/TEST
OUTPUT=$SHAREDFOLDER/$SPECIES/02a_mapped_mus_FP
TAIL=collapsed

##Define ARRAY names
NAME=$(sed "${SGE_TASK_ID}q;d" mus.tomap)


##Map using array

sample_name=`echo ${NAME1} | awk -F "." '{print $1}'`
echo "[mapping running for] $sample_name"
printf "\n"
echo "time $BWA mem $REF $INPUT/${NAME}| samtools sort -o  $OUTPUT/${NAME}.bam" >> $OUTPUT/map_mus_MERGED.log
time $BWA mem $REF $INPUT/${NAME} | samtools sort -o  $OUTPUT/${NAME}.bam

