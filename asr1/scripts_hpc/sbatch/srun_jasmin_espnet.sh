#!/bin/sh
#you can control the resources and scheduling with '#SBATCH' settings
# (see 'man sbatch' for more information on setting these parameters)
# The default partition is the 'general' partition
#SBATCH --partition=general
# The default Quality of Service is the 'short' QoS (maximum run time: 4 hours)
#SBATCH --qos=short
# The default run (wall-clock) time is 1 minute
#SBATCH --time=01:50:00
# The default number of parallel tasks per job is 1
#SBATCH --ntasks=1
# Request 1 CPU per active thread of your program (assume 1 unless you specifically set this)
# The default number of CPUs per task is 1 (note: CPUs are always allocated per 2)
#SBATCH --cpus-per-task=30
# The default memory per node is 1024 megabytes (1GB) (for multiple tasks, specify --mem-per-cpu instead)
#SBATCH --mem=75G # 82G not enough
# Set mail type to 'END' to receive a mail when the job finishes
# Do not enable mails when submitting large numbers (>20) of jobs at once
##SBATCH --gres=gpu
##SBATCH --nodelist=awi10
#SBATCH --mail-type=END

# ASR model trained with FULL set
nj=75
read_or_hmi=read

#eval_set="test_${read_or_hmi}_group4_A1_female_hires"
#eval_set="test_${read_or_hmi}_group4_A1_male_hires"
#eval_set="test_${read_or_hmi}_group4_A2_female_hires"
#eval_set="test_${read_or_hmi}_group4_A2_male_hires"
#eval_set="test_${read_or_hmi}_group4_B1_female_hires"
#eval_set="test_${read_or_hmi}_group4_B1_male_hires"
#eval_set="test_${read_or_hmi}_group4_A1_hires"
#eval_set="test_${read_or_hmi}_group4_A2_hires"
#eval_set="test_${read_or_hmi}_group4_B1_hires"

groupid=2 #5 #2
#eval_set="test_${read_or_hmi}_group${groupid}_hires"
#eval_set="test_${read_or_hmi}_group${groupid}_female_hires"
#eval_set="test_${read_or_hmi}_group${groupid}_male_hires"

#eval_set="test_${read_or_hmi}_group${groupid}_N1_hires"
#eval_set="test_${read_or_hmi}_group${groupid}_N2_hires"
#eval_set="test_${read_or_hmi}_group${groupid}_N3_hires"
#eval_set="test_${read_or_hmi}_group${groupid}_N4_hires"

eval_set="test_${read_or_hmi}_group${groupid}_N1_female_hires"
#eval_set="test_${read_or_hmi}_group${groupid}_N1_male_hires"
#eval_set="test_${read_or_hmi}_group${groupid}_N2_female_hires"
#eval_set="test_${read_or_hmi}_group${groupid}_N2_male_hires"
#eval_set="test_${read_or_hmi}_group${groupid}_N3_female_hires"
#eval_set="test_${read_or_hmi}_group${groupid}_N3_male_hires"
#eval_set="test_${read_or_hmi}_group${groupid}_N4_female_hires"
#eval_set="test_${read_or_hmi}_group${groupid}_N4_male_hires"

#srun bash scripts_hpc/run/run_decode_espnet.sh --stage 1 --stop-stage 2 --eval-set ${eval_set} --decode-tag "_intermed_asrepoch_43" --asr-model-folder-base "exp_no_unk/train_pytorch_train_pytorch_conformer_large/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 5000 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode $nj # [deprecated] --train-cmvn false
#srun bash scripts_hpc/run/run_decode_espnet.sh --stage 1 --stop-stage 2 --eval-set $eval_set --decode-tag "_intermed_asrepoch_112" --asr-model-folder-base "exp_no_unk/train_pytorch_train_pytorch_transformer_large/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 5000 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode $nj --use-valbest-average false # [deprecated] --train-cmvn false

#srun bash scripts_hpc/run/run_decode_espnet.sh --stage 1 --stop-stage 2 --eval-set $eval_set --decode-tag "_intermed_asrepoch_27" --asr-model-folder-base "exp_no_unk/train_cleaned_pytorch_train_pytorch_transformer_large_nbpe7500/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 7500 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode $nj --use-valbest-average true # [deprecated] --train-cmvn false
srun bash scripts_hpc/run/run_decode_espnet.sh --stage 1 --stop-stage 2 --eval-set $eval_set --decode-tag "_intermed_asrepoch_64" --asr-model-folder-base "exp_no_unk/train_cleaned_full_pytorch_train_pytorch_conformer_large/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 5000 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode $nj --use-valbest-average false # [deprecated] --train-cmvn false
#srun bash scripts_hpc/run/run_decode_espnet.sh --stage 1 --stop-stage 2 --eval-set $eval_set --decode-tag "_intermed_asrepoch_15" --asr-model-folder-base "exp_no_unk/train_cleaned2nd_full_pytorch_train_pytorch_conformer_large/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 5000 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode $nj --n-average 2 --use-valbest-average false

#~~~~ By default, goes for Jasmin Netherlands speech recognition
#srun bash scripts_hpc/run/run_decode_espnet.sh --stage 0 --stop-stage 2 --eval-set $eval_set --decode-tag "_intermed_asrepoch_52" --asr-model-folder-base "exp_no_unk/train_cleaned_pytorch_train_pytorch_conformer_large/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 5000 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode $nj --use-valbest-average true # [deprecated] --train-cmvn false
#~~~~ --dumpdir dump_vl goes for Jasmin Flanders speech recognition
#srun bash scripts_hpc/run/run_decode_espnet.sh --stage 0 --stop-stage 2 --eval-set $eval_set --decode-tag "_intermed_asrepoch_52" --asr-model-folder-base "exp_no_unk/train_cleaned_pytorch_train_pytorch_conformer_large/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 5000 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode $nj --use-valbest-average true --dumpdir dump_vl # [deprecated] --train-cmvn false


#srun bash scripts_hpc/run/run_decode_espnet.sh --stage 1 --stop-stage 2 --eval-set test_read_group2_N1_female_hires --decode-tag "_intermed_asrepoch_38" --asr-model-folder-base "exp_no_unk/train_cleaned_pytorch_train_pytorch_conformer_large_nbpe7500/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 7500 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode $nj --use-valbest-average true # [deprecated] --train-cmvn false



# ASR model trained with _100k_utt subset 
#srun bash scripts_hpc/run/run_decode_espnet.sh --stage 1 --stop-stage 2 --eval-set test_read_group2_N1_female_hires --decode-tag "_asrepoch_100" --asr-model-folder-base "exp_no_unk/train_pytorch_train_pytorch_conformer_mini_train/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 5000 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode $nj --use-valbest-average false # [deprecated] --train-cmvn false

# + using _100k_utt_cleaned set to train the ASR
#srun bash scripts_hpc/run/run_decode_espnet.sh --stage 1 --stop-stage 2 --eval-set test_read_group2_N1_female_hires --decode-tag "_asrepoch_100" --asr-model-folder-base "exp_no_unk/train_cleaned_pytorch_train_pytorch_conformer_mini_train/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 5000 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode $nj --use-valbest-average true # [deprecated] --train-cmvn false

#[deprecated]increase beam size
# srun bash scripts_hpc/run/run_decode_espnet.sh --decode-config "conf/tuning/decode_pytorch_transformer_beam25.yaml" --stage 1 --stop-stage 2 --eval-set test_read_group2_N1_female_hires --decode-tag "_intermed_asrepoch_43" --asr-model-folder-base "exp_no_unk/train_pytorch_train_pytorch_conformer_large/" --lm-model-folder-base "exp_no_unk/train_rnnlm_pytorch_lm_2l1024" --nbpe 5000 --lm-config "conf/tuning/lm_2l1024.yaml" --nj-decode $nj # [deprecated] --train-cmvn false
