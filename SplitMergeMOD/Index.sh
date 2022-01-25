#!/bin/bash
#$ -S /bin/bash
#$ -N mode.index  ##job name
#$ -l tmem=32G #RAM
#$ -l h_vmem=32G #enforced limit on memory shell usage
#$ -l h_rt=15:00:00 ##wall time.
#$ -j y  #concatenates error and output files (with prefix job1)
##$ -t 1-41 ## change number of samples accordingly

#run job in working directory
cd $SGE_O_WORKDIR


##Software
export PATH=/share/apps/genomics/samtools-1.9/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/genomics/samtools-1.9/lib:$LD_LIBRARY_PATH

for i in $(ls *bam); do samtools index $i; done

