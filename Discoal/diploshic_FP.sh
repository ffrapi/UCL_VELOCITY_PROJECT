#!/bin/bash
#$ -S /bin/bash
#$ -N C3_Discoal  ##job name
#$ -l tmem=16G #RAM
#$ -l h_vmem=16G #enforced limit on shell memory usage
#$ -l h_rt=6:00:00 ##wall time.
#$ -j y  #concatenates error and output files (with prefix job1)

#Run on working directory
#Define variable
DIR=/SAN/ugi/LepGenomics/C3_Aricia_agestis_FP/05_DiploSHIC

#Run on working directory
cd $DIR
pwd

#Define discoal
discoal=/share/apps/genomics/discoal/discoal

#generating training data
$discoal 40 2000 220000 -Pt 0.464000 4.640000 -Pre 12.760000 38.280000 > train1/Neut.msOut
i=0
for x in 0.045454545454545456 0.13636363636363635 0.22727272727272727 0.3181818181818182 0.4090909090909091 0.5 0.5909090909090909 0.6818181818181818 0.7727272727272727 0.8636363636363636 0.9545454545454546;
do
    $discoal 40 2000 220000 -Pt 0.464000 4.640000 -Pre 12.760000 38.280000 -ws 0 -Pa 0.200000 10.000000 -Pu 0 0.050000 -x $x > train1/Hard_$i.msOut
    $discoal 40 2000 220000 -Pt 0.464000 4.640000 -Pre 12.760000 38.280000 -ws 0 -Pa 0.200000 10.000000 -Pu 0 0.050000 -Pf 0 0.100000 -x $x > train1/Soft_$i.msOut
    i=$((i + 1))
done


#generating test data

$discoal 40 1000 220000 -Pt 0.464000 4.640000 -Pre 12.760000 38.280000 > test1/Neut.msOut
i=0
for x in 0.045454545454545456 0.13636363636363635 0.22727272727272727 0.3181818181818182 0.4090909090909091 0.5 0.5909090909090909 0.6818181818181818 0.7727272727272727 0.8636363636363636 0.9545454545454546;
do
    $discoal 40 1000 220000 -Pt 0.464000 4.640000 -Pre 12.760000 38.280000 -ws 0 -Pa 0.200000 10.000000 -Pu 0 0.050000 -x $x > test1/Hard_$i.msOut
    $discoal 40 1000 220000 -Pt 0.464000 4.640000 -Pre 12.760000 38.280000 -ws 0 -Pa 0.200000 10.000000 -Pu 0 0.050000 -Pf 0 0.100000 -x $x > test1/Soft_$i.msOut
    i=$((i + 1))

time $discoal

done


