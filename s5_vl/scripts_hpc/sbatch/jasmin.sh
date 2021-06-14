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
#SBATCH --cpus-per-task=40
# The default memory per node is 1024 megabytes (1GB) (for multiple tasks, specify --mem-per-cpu instead)
#SBATCH --mem=10G
# Set mail type to 'END' to receive a mail when the job finishes
# Do not enable mails when submitting large numbers (>20) of jobs at once
##SBATCH --gres=gpu
#SBATCH --mail-type=END

jasmin=/tudelft.net/staff-bulk/ewi/insy/SpeechLab/corpora/JASMIN/Data
comps="q;p"
#srun bash local/jasmin_data_prep.sh $jasmin $lang $comps

#srun bash scripts_hpc/run/run_decode_chain.sh --lang "vl" --stage 22 --stop-stage 23 --nj 1 --num_threads_decode 28 --use-gpu true

 
#srun bash scripts_hpc/run/run_decode_chain.sh --lang "vl" --stage 22 --stop-stage 23 --nj 1 --num_threads_decode 28 --use-gpu true

#srun bash scripts_hpc/run/run_decode_chain.sh --lang "vl" --stage 32 --stop-stage 33 --nj 1 --num_threads_decode 10 --use-gpu true --test_group_ID 4
#for gender in  female; do
#  srun bash scripts_hpc/run/run_decode_chain.sh --lang "vl" --stage 33 --stop-stage 34 --nj 1 --num_threads_decode 18 --use-gpu true --test_group_ID  5 --test-gender $gender
#  #srun bash scripts_hpc/run/run_decode_chain.sh --lang "vl" --stage 34 --stop-stage 35 --nj 1 --num_threads_decode 28 --use-gpu true --test_group_ID  5 --test-gender $gender
#done
#srun bash scripts_hpc/run/run_decode_chain.sh --lang "vl" --stage 36 --stop-stage 37 --nj 1 --num_threads_decode 6 --use-gpu true --test_group_ID 3
#srun bash scripts_hpc/run/run_decode_chain.sh --lang "vl" --stage 35 --stop-stage 36 --nj 1 --num_threads_decode 28 --use-gpu true --test_group_ID 4

#nj=1; nt=20; use_gpu=true;
nj=20; nt=2; use_gpu=false;
## A different, TDNNF model, plus it doesn't apply noise+reverb augmentation
#srun bash scripts_hpc/run/run_decode_chain.sh --lang "vl" --cgn-model-path "exp/chain/tdnnf_related" --label-delay "" --cgn-architecture-spec "tdnn1g" --ivector-suffix "" --stage 12 --stop-stage 13 --nj 20 # extract ivectors
test_group_ID=5
#srun bash scripts_hpc/run/run_decode_chain.sh --lang "vl" --cgn-model-path "exp/chain/tdnnf_related" --label-delay "" --cgn-architecture-spec "tdnn1g" --ivector-suffix "" --stage 31 --stop-stage 32 --nj $nj --num-threads-decode $nt --use-gpu $use_gpu --test-group-ID $test_group_ID
srun bash scripts_hpc/run/run_decode_chain.sh --lang "vl" --cgn-model-path "exp/chain/tdnnf_related" --label-delay "" --cgn-architecture-spec "tdnn1g" --ivector-suffix "" --stage 32 --stop-stage 33 --nj $nj --num-threads-decode $nt --use-gpu $use_gpu --test-group-ID $test_group_ID
