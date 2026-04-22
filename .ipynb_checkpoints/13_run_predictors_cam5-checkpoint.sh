#!/bin/bash
#SBATCH --job-name=dask_all_preds_cam5
#SBATCH --account=ac_stallerlab
#SBATCH --partition=savio3
#
# Number of nodes:
#SBATCH --nodes=1
#
# Number of tasks (array size, adjust as needed):
#SBATCH --ntasks=1
#
# Processors per task:
#SBATCH --cpus-per-task=24 
#
# Wall clock limit:
#SBATCH --time=30:00
#
#SBATCH --export=ALL
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sanjana.kotha@berkeley.edu
#SBATCH --output=/global/scratch/projects/fc_mvslab/OpenProjects/Sanjana/collaborations/GrENEnet_TF_hits/14_cam5_predictor_log.out
## Command(s) to run:

echo "Setting variables"

unset SLURM_MEM_PER_CPU
unset SLURM_MEM_PER_GPU
unset SLURM_MEM_PER_NODE

export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export MKL_NUM_THREADS=1
export VECLIB_MAXIMUM_THREADS=1
export NUMEXPR_NUM_THREADS=1

export TF_NUM_INTRAOP_THREADS=1
export TF_NUM_INTEROP_THREADS=1

# Define the input file based on the task array index
INPUT_FILE="/global/scratch/projects/fc_mvslab/OpenProjects/Sanjana/collaborations/GrENEnet_TF_hits/12_cam5.fasta"
OUTPUT_DIR="/global/scratch/projects/fc_mvslab/OpenProjects/Sanjana/collaborations/GrENEnet_TF_hits/15_cam5_predictor_results"

echo "Running script"

# Run the Python script with the correct input file for each task in the array
srun /global/scratch/projects/fc_mvslab/OpenProjects/Sanjana/conda/new_dask/bin/python \
    "/global/scratch/projects/fc_mvslab/predictors/all_predictors/running_all_in_parallel_w_dask/run_all_dask.py" \
    -f "$INPUT_FILE" \
    -o "$OUTPUT_DIR" 