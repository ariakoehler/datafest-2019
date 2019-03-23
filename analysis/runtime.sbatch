#!/bin/bash
#SBATCH -J jupyter
#SBATCH -o jupyter_%j.out
#SBATCH -p standard-mem-s
#SBATCH --mem=30G

module purge
module load python/3
module load tensorflow/1.2_gpu

login_node="login01.m2.smu.edu"

unset XDG_RUNTIME_DIR
port=$(echo "49152+$(echo ${SLURM_JOBID} | tail -c 4)" | bc)
jupyter notebook --no-browser --ip=127.0.0.1 --port=${port} &
sleep 5s
ssh -N -R ${port}:localhost:${port} ${login_node} &
echo "  \"ssh -L ${port}:localhost:${port} ${USER}@${login_node}\""
wait

