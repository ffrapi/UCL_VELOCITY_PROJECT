#!/bin/bash
#$ -S /bin/bash
#$ -N C3.MODE.LocalRealignment  ##job name
#$ -l tmem=16G #RAM
#$ -l h_vmem=16G #enforced limit on shell memory usage
#$ -l h_rt=1:00:00 ##wall time.
#$ -j y  #concatenates error and output files (with prefix job1)
#$ -t 1-41

#Run on working directory
cd $SGE_O_WORKDIR

#Call software
export PATH=/share/apps/jdk1.8.0_131/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/jdk1.8.0_131/lib:$LD_LIBRARY_PATH


# Define variables
SHAREDFOLDER=/SAN/ugi/LepGenomics
SPECIES=C3_Aricia_agestis_FP
REF=$SHAREDFOLDER/$SPECIES/RefGenome2/GCA_905147365.1_ilAriAges1.1_genomic.fna
INPUT=$SHAREDFOLDER/$SPECIES/02a_rpts_AJvR/MODE/TEST
OUTPUT=$SHAREDFOLDER/$SPECIES/02a_rpts_AJvR/MODE/TEST

GenomeAnalysisTK=/share/apps/genomics/GenomeAnalysisTK-3.8.1.0/GenomeAnalysisTK.jar


#Set up ARRAY job
#ls $INPUT/*rmdup.bam |awk -F "/" '{print $NF}' | awk -F "." '{print $1}' > mode.names
NAME=$(sed "${SGE_TASK_ID}q;d" mode.names)


# Identify targets to realign
java -Xmx6g -Xms6g -jar $GenomeAnalysisTK -T RealignerTargetCreator \
-R $REF \
-o $OUTPUT/${NAME}.intervals \
-I $INPUT/${NAME}.rmdup.bam


# use IndelRealigner to realign the regions found in the RealignerTargetCreator step
java -Xmx6g -Xms6g -jar $GenomeAnalysisTK -T IndelRealigner \
-R $REF \
-targetIntervals $INPUT/${NAME}.intervals \
-I $INPUT/${NAME}.rmdup.bam \
-o $OUTPUT/${NAME}.realn.bam

