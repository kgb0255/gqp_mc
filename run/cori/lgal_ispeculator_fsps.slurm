#!/bin/bash
#SBATCH --qos=regular
#SBATCH --time=24:00:00
#SBATCH --constraint=knl
#SBATCH -N 1
#SBATCH -J lgal_ispec_fsps
#SBATCH -o ofiles/lgal_ispec_fsps.o
#SBATCH -L SCRATCH,project

now=$(date +"%T")
echo "start time ... $now"

conda activate gqp

sim=lgal
i0=0
i1=96
n_cpu=64

export OMP_NUM_THREADS=1

# run MCMC with adaptive convergence and maxiter=50000 
python -W ignore /global/homes/c/chahah/projects/gqp_mc/run/mini_mocha.py \
    specphoto $sim $i0 $i1 bgs0_legacy ispeculator fsps $n_cpu 40 200 \
    adaptive 50000 True False 

# postprocess the MC chains 
#python -W ignore /global/homes/c/chahah/projects/gqp_mc/run/mini_mocha.py \
#    specphoto $sim $i0 $i1 bgs0_legacy ispeculator fsps $n_cpu 40 200 \
#    adaptive 100000 False True 




now=$(date +"%T")
echo "end time ... $now"
