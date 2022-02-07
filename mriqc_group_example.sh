#!/bin/bash
#SBATCH -N 1
#SBATCH -c 2
#SBATCH --mem=24G
#SBATCH --time 01:00:00
#SBATCH -J mriqc
#SBATCH --output /gpfs/scratch/%u/mriqc-log%A_%a.out

#---------CONFIGURE THESE VARIABLES--------------------

bids_root=/gpfs/data/nmclaugh/conte    #the study folder
nthreads=2
mem=24 #gb

#---------END OF VARIABLES-----------------------------
#--------------------RUN MRIQC-------------------------
  
singularity run --cleanenv                          \
  --bind ${bids_root}:/data    		            \
  --bind /gpfs/scratch/$USER:/scratch               \
  /gpfs/data/bnc/simgs/poldracklab/mriqc-0.16.1.sif \
  /data/rawdata                                     \
  /data/derivatives/mriqc			    \
  group                                             \
  --no-sub                                          \
  --n_proc $nthreads				    \
  --mem_gb $mem 				    \
  --float32					    \
  --ants-nthreads $nthreads 			    \
  -m T1w bold                                       \
  -w /scratch/mriqc
