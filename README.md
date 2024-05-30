# Rmd_in_Snakemake
Example of running Rmarkdown in a snakemake pipeline. This is only tested on the crop diversity HPC at James Hutton Institute (Dundee, UK) and may not work in other environments. It assumes conda is being used as the package manager and snakemake is run via the slurm scheduler. 

## Overview
The goal of this snakemake pipeline is to make a plot using an Rscript (make_plot.R) and then output a html report using Rmarkdown. The snakemake pipeline has two rules to do this: 
1. rule plot: plots a graph from the test dataset
2. rule report : creates a html report with the plot embedded

## Set up

1. Create two conda enviroments: one for snakemake and one for R.
```
conda create -n my_snakemake_env snakemake=8.4.12

conda create -n my_r_env r-base=4.3.3 r-tiff=0.1_12 r-dt=0.33 r-tidyverse=2.0.0 r-markdown=1.12

```

2. Clone this repository
This should be done in a scratch filespace.
```
git clone https://github.com/aphidbeth/Rmd_in_Snakemake
```

3. Edit the config file and runner script filepaths
Change these to the location of your Rmd_in_snakemake folder.
```
# change your filepath to the location of the scratch folder eg. "mnt/scratch/username/Rmd_in_Snakemake"

sed -i 's#MY-BASE-PATH#<new_file_path>#' snakefiles/config.yaml

sed -i 's#MY-BASE-PATH#<new_file_path>#' run_rmd.sh

```
  
## Run the pipeline
The pipeline can be run by submitting a shell script that runs the smk pipeline.
```
sbatch run_rmd.sh
```


