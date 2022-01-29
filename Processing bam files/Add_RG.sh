#!/bin/bash
#$ -S /bin/bash
#$ -N C3.MODC_AddRG  ##job name
#$ -l tmem=16G #RAM
#$ -l h_vmem=16G #enforced limit on shell memory usage
#$ -l h_rt=1:00:00 ##wall time.
#$ -j y  #concatenates error and output files (with prefix job1)
#$ -t 1-40

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
INPUT=$SHAREDFOLDER/$SPECIES/02a_mapped_MODC/02a_mapped_MODC
OUTPUT=$SHAREDFOLDER/$SPECIES/02a_mapped_MODC/02a_mapped_MODC

#Set up ARRAY job
#ls 02a_mapped_MODC/*bam | awk -F "/" '{print $NF}' | awk -F "_" '{print $1}' > modc.names
NAME=$(sed "${SGE_TASK_ID}q;d" modc.names)


##Add readgroups

echo "java -Xmx6g -Xms6g -jar $PICARD AddOrReplaceReadGroups \
       I=$INPUT/${NAME}.bam \
       O=$OUTPUT/${NAME}.RG.bam \
       RGID=C3mus \
       RGLB=mus0204 \
       RGPL=ILLUMINA \
       RGPU=unit1 \
       RGSM=${NAME}" >> 02b.0_AddRG_modc.log


time java -Xmx6g -Xms6g -jar $PICARD AddOrReplaceReadGroups \
       I=$INPUT/${NAME}.bam \
       O=$OUTPUT/${NAME}.RG.bam \
       RGID=C3modc \
       RGLB=mod02 \
       RGPL=ILLUMINA \
       RGPU=unit1 \
       RGSM=${NAME}
