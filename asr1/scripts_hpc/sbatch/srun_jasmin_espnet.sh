#!/bin/sh
#you can control the resources and scheduling with '#SBATCH' settings
# (see 'man sbatch' for more information on setting these parameters)
# The default partition is the 'general' partition
#SBATCH --partition=general
# The default Quality of Service is the 'short' QoS (maximum run time: 4 hours)
#SBATCH --qos=short
# The default run (wall-clock) time is 1 minute
#SBATCH --time=00:50:00
# The default number of parallel tasks per job is 1
#SBATCH --ntasks=1
# Request 1 CPU per active thread of your program (assume 1 unless you specifically set this)
# The default number of CPUs per task is 1 (note: CPUs are always allocated per 2)
#SBATCH --cpus-per-task=52
# The default memory per node is 1024 megabytes (1GB) (for multiple tasks, specify --mem-per-cpu instead)
#SBATCH --mem=70G
# Set mail type to 'END' to receive a mail when the job finishes
# Do not enable mails when submitting large numbers (>20) of jobs at once
##SBATCH --gres=gpu
#SBATCH --mail-type=END


#srun bash scripts_hpc/run/run_decode_espnet.sh --stage 1 --stop-stage 2 --eval-set test_read_group2_N1_female_hires --decode-tag "_intermed_asrepoch_43" --asr-model-folder-base "exp_no_unk/train_pytorch_train_pytorch_conformer_large/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 5000 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode 52 # [deprecated] --train-cmvn false


#increase beam size
srun bash scripts_hpc/run/run_decode_espnet.sh --decode-config "conf/tuning/decode_pytorch_transformer_beam25.yaml" --stage 1 --stop-stage 2 --eval-set test_read_group2_N1_female_hires --decode-tag "_intermed_asrepoch_43" --asr-model-folder-base "exp_no_unk/train_pytorch_train_pytorch_conformer_large/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 5000 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode 52 # [deprecated] --train-cmvn false
