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
#SBATCH --cpus-per-task=2
# The default memory per node is 1024 megabytes (1GB) (for multiple tasks, specify --mem-per-cpu instead)
#SBATCH --mem=3G
# Set mail type to 'END' to receive a mail when the job finishes
# Do not enable mails when submitting large numbers (>20) of jobs at once
##SBATCH --gres=gpu
#SBATCH --mail-type=END

cgn_root=/tudelft.net/staff-bulk/ewi/insy/SpeechLab/siyuanfeng/software/kaldi/egs/cgn/s5
model_name=$cgn_root/exp/chain/tdnnf_related/aug_related/tdnn_blstm1a_sp_bi_epoch4_ld5

#input_data=test_read_all
#input_data=test_hmi_all

#input_data=test_read_female
#input_data=test_read_male
#input_data=test_hmi_female
#input_data=test_hmi_male

#input_data=test_read_group2
#input_data=test_read_group1
#input_data=test_read_group3
#input_data=test_read_group4
#input_data=test_read_group5
#input_data=test_hmi_group2
#input_data=test_hmi_group1
#input_data=test_hmi_group3
#input_data=test_hmi_group4
#input_data=test_hmi_group5

#input_data=test_read_group2_female
#input_data=test_read_group1_female
#input_data=test_read_group3_female
#input_data=test_read_group4_female
#input_data=test_read_group5_female
#input_data=test_read_group2_male
#input_data=test_read_group1_male
#input_data=test_read_group3_male
#input_data=test_read_group4_male
#input_data=test_read_group5_male
#input_data=test_hmi_group2_female
#input_data=test_hmi_group1_female
#input_data=test_hmi_group3_female
#input_data=test_hmi_group4_female
#input_data=test_hmi_group5_female
#input_data=test_hmi_group2_male
#input_data=test_hmi_group1_male
#input_data=test_hmi_group3_male
#input_data=test_hmi_group4_male
#input_data=test_hmi_group5_male
#srun bash local/rnnlm/tuning/run_lstm_tdnn_1b.sh --ac-model-dir $model_name --stage 4 --stop-stage 5   --epochs 20 --input-data "$input_data"


### Region-wise on Group 1,2,5
#input_data=test_read_group1_N2
#input_data=test_read_group1_N3
#input_data=test_read_group1_N4
#input_data=test_read_group2_N1
#input_data=test_read_group2_N2
#input_data=test_read_group2_N3
#input_data=test_read_group2_N4
#input_data=test_read_group5_N1
#input_data=test_read_group5_N2
#input_data=test_read_group5_N3
#input_data=test_read_group5_N4

#input_data=test_read_group1_N2_female
#input_data=test_read_group1_N3_female
#input_data=test_read_group1_N4_female
#input_data=test_read_group2_N1_female
#input_data=test_read_group2_N2_female
#input_data=test_read_group2_N3_female
#input_data=test_read_group2_N4_female
#input_data=test_read_group5_N1_female
#input_data=test_read_group5_N2_female
#input_data=test_read_group5_N3_female
#input_data=test_read_group5_N4_female
#input_data=test_read_group1_N2_male
#input_data=test_read_group1_N3_male
#input_data=test_read_group1_N4_male
#input_data=test_read_group2_N1_male
#input_data=test_read_group2_N2_male
#input_data=test_read_group2_N3_male
#input_data=test_read_group2_N4_male
#input_data=test_read_group5_N1_male
#input_data=test_read_group5_N2_male
#input_data=test_read_group5_N3_male
#input_data=test_read_group5_N4_male

#input_data=test_hmi_group1_N2_female
#input_data=test_hmi_group1_N3_female
#input_data=test_hmi_group1_N4_female
#input_data=test_hmi_group2_N1_female
#input_data=test_hmi_group2_N2_female
#input_data=test_hmi_group2_N3_female
#input_data=test_hmi_group2_N4_female
#input_data=test_hmi_group5_N1_female
#input_data=test_hmi_group5_N2_female
#input_data=test_hmi_group5_N3_female
input_data=test_hmi_group5_N4_female
#input_data=test_hmi_group1_N2_male
#input_data=test_hmi_group1_N3_male
#input_data=test_hmi_group1_N4_male
#input_data=test_hmi_group2_N1_male
#input_data=test_hmi_group2_N2_male
#input_data=test_hmi_group2_N3_male
#input_data=test_hmi_group2_N4_male
#input_data=test_hmi_group5_N1_male
#input_data=test_hmi_group5_N2_male
#input_data=test_hmi_group5_N3_male
#input_data=test_hmi_group5_N4_male

#input_data=test_hmi_group1_N2
#input_data=test_hmi_group1_N3
#input_data=test_hmi_group1_N4
#input_data=test_hmi_group2_N1
#input_data=test_hmi_group2_N2
#input_data=test_hmi_group2_N3
#input_data=test_hmi_group2_N4
#input_data=test_hmi_group5_N1
#input_data=test_hmi_group5_N2
#input_data=test_hmi_group5_N3
#input_data=test_hmi_group5_N4
## CEF on Group 4
#input_data=test_read_group4_A1
#input_data=test_read_group4_A2
#input_data=test_read_group4_B1
#input_data=test_hmi_group4_A1
#input_data=test_hmi_group4_A2
#input_data=test_hmi_group4_B1

#input_data=test_read_group4_A1_female
#input_data=test_read_group4_A2_female
#input_data=test_read_group4_B1_female
#input_data=test_hmi_group4_A1_female
#input_data=test_hmi_group4_A2_female
#input_data=test_hmi_group4_B1_female
#input_data=test_read_group4_A1_male
#input_data=test_read_group4_A2_male
#input_data=test_read_group4_B1_male
#input_data=test_hmi_group4_A1_male
#input_data=test_hmi_group4_A2_male
#input_data=test_hmi_group4_B1_male

bash local/rnnlm/tuning/run_lstm_tdnn_1b.sh --ac-model-dir $model_name --stage 4 --stop-stage 5   --epochs 20 --input-data "$input_data" 
