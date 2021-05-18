#!/bin/bash

if [ $# -le 1 ]; then
   echo "Arguments should be <language> <comps>, see ../run.sh for example."
   echo "$0: Dump Jasmin data into ESPnet format"
   echo "comps for -p (dialogue) and -q (read)"
   echo "language: nl (dutch) or vl (flemish)"
   exit 1;
fi
lang=$1
comps=$2
base=`pwd`
stage=0
stop_stage=1
nj_dump_feats=1
do_delta=false
debug_subset=
local_dir=data/local/data
cgn_root=/tudelft.net/staff-bulk/ewi/insy/SpeechLab/siyuanfeng/software/espnet/egs/cgn/asr1
dumpdir=dump
use_gpu=false
#test_group_ID=1
#style=read # or hmi
#test_gender=female
train_cmvn=true # if true, use cmvn.ark from CGN training data applied to JASMIN eval data
. utils/parse_options.sh
. ./cmd.sh
. ./path.sh

# To do: dump JASMIN evaluation data into dump/ following ESPnet format
# do not generate data_unigram*.json as it depends on the specific ASR model


# overall: test_{read,hmi}_all_hires
#          test_{read,hmi}_{female,male}_hires

# group wise: test_{read,hmi}_group[1-5]_hires; test_{read,hmi}_group[1-5]_{female,male}_hires

# region wise: test_{read,hmi}_group[1-5]_N[1-4]_hires; test_{read,hmi}_group[1-5]_N[1-4]_{female,male}_hires

if [ $stage -le 0 ] && [ $stop_stage -gt 0 ]; then
  echo "Region wise data: dump"
  for gender in _hires _female_hires _male_hires; do
    for style in read hmi ; do
      for group_ID in 1 2 5; do
        for region in 1 2 3 4; do
          rtask=test_${style}_group${group_ID}_N${region}${gender}
          mkdir -p $dumpdir/$rtask/delta${do_delta} || exit 1
          if $train_cmvn; then
            cmvn_file=$cgn_root/data/train/cmvn.ark
            cmvn_tag=""
          else
            compute-cmvn-stats scp:data/$rtask/feats.scp data/$rtask/cmvn.ark
            cmvn_file=data/$rtask/cmvn.ark
            cmvn_tag="_self_cmvn"
          fi
          # 3 native groups: child, teenagers and elderly
          dump.sh --cmd "run.pl" --nj $nj_dump_feats --do_delta ${do_delta} \
            data/$rtask/feats.scp $cmvn_file exp/dump_feats/recog/${rtask}${cmvn_tag} $dumpdir/$rtask/delta${do_delta}${cmvn_tag}/
        done
      done 
    done
  done
fi

# To do: implement group wise and overall
echo "succeeded"
