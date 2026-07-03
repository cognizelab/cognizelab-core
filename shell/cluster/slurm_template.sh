#!/bin/bash
#SBATCH --job-name=JOB_NAME
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --partition=your_partition

# Generic SLURM job template. Copy into a project's code/00_setup/ and
# customize job name, resources, and the command below.
#
# Usage: sbatch slurm_template.sh <arg1> <arg2>

set -euo pipefail
mkdir -p logs

module load your_module   # e.g. fsl, freesurfer, matlab, anaconda3
# source activate your_env

echo "Running on $(hostname), job $SLURM_JOB_ID"
# your command here, e.g.:
# python code/01_preprocessing/run_preproc.py --subject "$1"
