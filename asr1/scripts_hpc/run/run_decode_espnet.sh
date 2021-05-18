#!/bin/bash
# Copyright 2021 Siyuan Feng (Delft University of Technology)
# Based on a Dutch Attention encoder-decoder (AED) ASR system trained using CGN training material using ESPnet,
# Do decoding and scoring on JASMIN data
# JASMIN contains Dutch spoken by native children, non-native children, non-native adults and the native elderly
# JASMIN has two speech types, read speech (comp-q) and human-machine interaction (comp-p)
# JASMIN has NL Dutch and VL Dutch
# In jasmin/asr1/ we focus on NL Dutch in Jasmin;

stage=0
stop_stage=1
backend=pytorch
nj_decode=1
lang="nl" # or 'vl'
debug_subset=
local_dir=data/local/data
cgn_root=/tudelft.net/staff-bulk/ewi/insy/SpeechLab/siyuanfeng/software/espnet/egs/cgn/asr1
if_gpu_decoding=false
ngpu_decode=0
decode_config=conf/tuning/decode_pytorch_transformer.yaml
extra_rec_config="" # e.g. "--lm-weight 0.5 --ctc-weight 0.3"
decode_tag=
#test_group_ID=1
#test_gender=female
eval_set="test_read_group2_N1_female_hires"
do_delta=false 
bpemode=unigram
nbpe=5000
train_set=train
batchsize_decoding=0
dumpdir=dump
train_cmvn=true
asr_model_folder_base=exp_no_unk/train_pytorch_train_pytorch_conformer_large/
lm_model_folder_base=exp_no_unk/train_rnnlm_pytorch_lm_2l1024 #_unigram5000/
n_average=5
lm_n_average=6
lmtag=
lm_config=conf/tuning/lm_2l1024.yaml #conf/tuning/lm.yaml
. utils/parse_options.sh
. ./cmd.sh
. ./path.sh
decode_tag="_lm_no_unk${decode_tag}"
if [ -z $lmtag ] ; then
  lmtag=$(basename  ${lm_config%.*} )
fi
if [ ! "$nbpe" = 5000 ]; then
  asr_model_folder=${asr_model_folder_base}_nbpe${nbpe}
else
  asr_model_folder=$asr_model_folder_base
fi
lm_model_folder=${lm_model_folder_base}_unigram${nbpe}
work_dir=$asr_model_folder

# Please first run local/jasmin_espnet_dump_feat.sh to create espnet format folders dump/*/delta_false/
bpemodel=$cgn_root/data/lang_char/${train_set}_${bpemode}${nbpe}
dict=$cgn_root/data/lang_char/${train_set}_${bpemode}${nbpe}_units.txt
if ! $train_cmvn; then
  dump_tag="_self_cmvn"
else
  dump_tag=""
fi
if [ $stage -le 0 ] && [ $stop_stage -gt 0 ]; then
  echo "$0: generate data_${bpemode}${nbpe}.json to $dumpdir/$eval_set/delta${do_delta}${dump_tag}/"
  if [ ! -d $dumpdir/$eval_set/delta${do_delta}${dump_tag}/ ]; then
    echo "$dumpdir/$eval_set/delta${do_delta}${dump_tag}/ not found, exit"
    exit 0
  fi
  if [ ! -f data/$eval_set/text_utf8 ]; then
    iconv -f latin1 -t utf-8 data/$eval_set/text > data/$eval_set/text_utf8
    mv data/$eval_set/text data/$eval_set/text.latin1.bkp
    mv data/$eval_set/text_utf8 data/$eval_set/text
  fi
  data2json.sh --feat $dumpdir/$eval_set/delta${do_delta}${dump_tag}/feats.scp --bpecode ${bpemodel}.model \
    data/$eval_set $dict > $dumpdir/$eval_set/delta${do_delta}${dump_tag}/data_${bpemode}${nbpe}.json
fi

if [ $stage -le 1 ] && [ $stop_stage -gt 1 ]; then
  recog_model=model.val${n_average}.avg.best
  lang_model=rnnlm.last${lm_n_average}.avg.best
  model=$cgn_root/${asr_model_folder}/results/$recog_model
  rnnlm=$cgn_root/${lm_model_folder}/$lang_model
  nj=$nj_decode
  decode_dir=${work_dir}/decode_${eval_set}_${recog_model}_$(basename ${decode_config%.*})_${lmtag}${decode_tag}${dump_tag}
  feat_recog_dir=$dumpdir/$eval_set/delta${do_delta}${dump_tag}/
  if $if_gpu_decoding; then
    ngpu=${ngpu_decode}
    api=v2
  else
    # Default:
    api=v1
    ngpu=0
    batchsize_decoding=0
  fi
  echo "Use GPU to decode: ${if_gpu_decoding}; api: $api"
  echo "ngpu: ${ngpu}; batch size in decoding: ${batchsize_decoding}"
  echo "num jobs: $nj"
  echo "ASR model: $model"
  echo "LM model: $rnnlm"
  echo "Eval data: $feat_recog_dir/data_${bpemode}${nbpe}.json"
  echo "Output directory: ${decode_dir}"
  splitjson.py --parts ${nj} ${feat_recog_dir}/data_${bpemode}${nbpe}.json
  ${decode_cmd} JOB=1:${nj} ${decode_dir}/log/decode.JOB.log \
    asr_recog.py \
      --config ${decode_config} ${extra_rec_config} \
      --ngpu ${ngpu} \
      --backend ${backend} \
      --batchsize $batchsize_decoding \
      --api $api \
      --recog-json ${feat_recog_dir}/split${nj}utt/data_${bpemode}${nbpe}.JOB.json \
      --result-label ${decode_dir}/data.JOB.json \
      --model $model \
      --rnnlm $rnnlm \

  echo "Scoring:"
  score_sclite.sh --bpe ${nbpe} --bpemodel ${bpemodel}.model --wer true ${decode_dir} $dict
  echo "Finished ${feat_recog_dir}"

fi

echo "succeeded"
