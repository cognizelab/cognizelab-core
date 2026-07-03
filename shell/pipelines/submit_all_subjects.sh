#!/bin/bash
# submit_all_subjects.sh <bids_dir> <slurm_script> [extra args...]
#
# Loops over BIDS subjects and submits one job per subject via sbatch.
# Generic — customize per-project by passing a different slurm_script.

set -euo pipefail

bids_dir="$1"
slurm_script="$2"
shift 2

for subj_path in "$bids_dir"/sub-*/; do
  subj=$(basename "$subj_path")
  echo "Submitting $subj"
  sbatch "$slurm_script" "$subj" "$@"
done
