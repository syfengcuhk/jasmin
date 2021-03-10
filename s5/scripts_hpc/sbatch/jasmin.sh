#!/bin/sh
#you can control the resources and scheduling with '#SBATCH' settings
# (see 'man sbatch' for more information on setting these parameters)
# The default partition is the 'general' partition
#SBATCH --partition=general
# The default Quality of Service is the 'short' QoS (maximum run time: 4 hours)
#SBATCH --qos=short
# The default run (wall-clock) time is 1 minute
#SBATCH --time=01:00:00
# The default number of parallel tasks per job is 1
#SBATCH --ntasks=1
# Request 1 CPU per active thread of your program (assume 1 unless you specifically set this)
# The default number of CPUs per task is 1 (note: CPUs are always allocated per 2)
#SBATCH --cpus-per-task=20
# The default memory per node is 1024 megabytes (1GB) (for multiple tasks, specify --mem-per-cpu instead)
#SBATCH --mem=10G
# Set mail type to 'END' to receive a mail when the job finishes
# Do not enable mails when submitting large numbers (>20) of jobs at once
#SBATCH --gres=gpu
#SBATCH --mail-type=END

jasmin=/tudelft.net/staff-bulk/ewi/insy/SpeechLab/corpora/JASMIN/Data
lang=nl
comps="q;p"
#srun bash local/jasmin_data_prep.sh $jasmin $lang $comps

#srun bash scripts_hpc/run/run_decode_chain.sh --stage 11 --stop-stage 12 --nj 40
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 12 --stop-stage 13 --nj 40
# decode-stage 3: scoring
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 21 --stop-stage 22 --nj 80 --debug-subset "_subset3K" --use-gpu false #--decode-stage 3
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 21 --stop-stage 22 --nj 1 --num_threads-decode 40 --use-gpu true --decode-stage 3
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 22 --stop-stage 23 --nj 40 --debug-subset "_subset3K" --use-gpu false
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 22 --stop-stage 23 --nj 1 --num_threads-decode 40 --use-gpu true --decode-stage 3

test_group_ID=5
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 31 --stop-stage 32 --nj 1 --num-threads-decode 40 --use-gpu true --test-group-ID $test_group_ID --decode-stage 3 
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 32 --stop-stage 33 --nj 1 --num-threads-decode 40 --use-gpu true --test-group-ID $test_group_ID --decode-stage 3
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 33 --stop-stage 34 --nj 1 --num-threads-decode 40 --use-gpu true --test-gender female --decode-stage 3 #--test-group-ID 5
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 34 --stop-stage 35 --nj 1 --num-threads-decode 40 --use-gpu true --test-gender female --decode-stage 3 #--test-group-ID 5
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 42 --stop-stage 43 --nj 1 --num-threads-decode 40 --use-gpu true #--test-group-ID 5
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 43 --stop-stage 44 --nj 1 --num-threads-decode 20 --use-gpu true #--test-group-ID 5
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 44 --stop-stage 45 --nj 1 --num-threads-decode 20 --use-gpu true #--test-group-ID 5

test_group_ID=5
srun bash scripts_hpc/run/run_decode_chain.sh --stage 48 --stop-stage 49 --nj 1 --num-threads-decode 20 --use-gpu true --test-gender female --test-group-ID ${test_group_ID} # 1,2,5
#srun bash scripts_hpc/run/run_decode_chain.sh --stage 48 --stop-stage 49 --nj 1 --num-threads-decode 20 --use-gpu true --test-gender male --test-group-ID ${test_group_ID} # 1,2,5


#srun bash scripts_hpc/run/run_decode_chain.sh --stage 36 --stop-stage 37 --nj 1 --num-threads-decode 20 --use-gpu true --test-group-ID $test_group_ID
