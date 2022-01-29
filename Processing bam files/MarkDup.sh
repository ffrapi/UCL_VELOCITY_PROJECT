#!/bin/bash
#$ -S /bin/bash
#$ -N C3.MODE.MarkDups  ##job name
#$ -l tmem=16G #RAM
#$ -l h_vmem=16G #enforced limit on shell memory usage
#$ -l h_rt=1:00:00 ##wall time.
#$ -j y  #concatenates error and output files (with prefix job1)
#$ -t 1-41


#Run on working directory
cd $SGE_O_WORKDIR

#Call software
export PATH=/share/apps/java/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/java/lib:$LD_LIBRARY_PATH
PICARD=/share/apps/genomics/picard-2.20.3/bin/picard.jar


#Define variables
SHAREDFOLDER=/SAN/ugi/LepGenomics
SPECIES=C3_Aricia_agestis_FP
REF=$SHAREDFOLDER/$SPECIES/RefGenome2/GCA_905147365.1_ilAriAges1.1_genomic.fna
INPUT=$SHAREDFOLDER/$SPECIES/02a_rpts_AJvR/MODE/TEST
OUTPUT=$SHAREDFOLDER/$SPECIES/02a_rpts_AJvR/MODE/TEST
TAIL="RG.bam"

#Set up ARRAY job
#ls $INPUT/*RG.bam | awk -F "/" '{print $NF}' | awk -F "." '{print $1}' >> mus.names3
NAME=$(sed "${SGE_TASK_ID}q;d" mode.names)

echo "java -Xmx6g -Xms6g -jar $PICARD MarkDuplicates \
INPUT=$INPUT/${NAME}.$TAIL \
OUTPUT=$OUTPUT/${NAME}.rmdup.bam \
METRICS_FILE=$OUTPUT/${NAME}.dup.txt \
REMOVE_DUPLICATES=false \
VALIDATION_STRINGENCY=SILENT \
CREATE_INDEX=true" >> 02b.1_MarkDup_mode.log


time java -Xmx6g -Xms6g -jar $PICARD MarkDuplicates \
INPUT=$INPUT/${NAME}.$TAIL \
OUTPUT=$OUTPUT/${NAME}.rmdup.bam \
METRICS_FILE=$OUTPUT/${NAME}.dup.txt \
REMOVE_DUPLICATES=false \
VALIDATION_STRINGENCY=SILENT \
CREATE_INDEX=true

