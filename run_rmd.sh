#!/bin/bash

#SBATCH --out MY-BASE-PATH/logs/slurm_rmd.out


cd MY-BASE-PATH/snakefiles

source activate my_snakemake_env

snakemake --cores 4 --use-conda --snakefile "snakefile.smk" --latency-wait 60
