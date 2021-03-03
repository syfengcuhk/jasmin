#!/bin/bash
# Copyright 2021 Siyuan Feng (TU Delft)
# Based on egs/cgn/s5/local/cgn_data_prep.sh by Laurens van der Werff
# Preparation for Jasmin
if [ $# -le 2 ]; then
   echo "Arguments should be <CGN root> <language> <comps>, see ../run.sh for example."
   echo "$0: Preparation of Jasmin data"
   echo "comps for -p (dialogue) and -q (read)"
   echo "language: nl (dutch) or vl (flemish)"
   exit 1;
fi
jasmin=$1
lang=$2
comps=$3
base=`pwd`
dir=`pwd`/data/local/data
lmdir=`pwd`/data/local/jasmin_lm
dictdir=`pwd`/data/local/dict_nosp
mkdir -p $dir $lmdir
local=`pwd`/local
utils=`pwd`/utils
. ./path.sh     # Needed for KALDI_ROOT

if [ -z $SRILM ] ; then
  export SRILM=$KALDI_ROOT/tools/srilm
fi

export PATH=${PATH}:$SRILM/bin/i686-m64
if ! command -v ngram-count >/dev/null 2>&1 ; then
  echo "$0: Error: SRILM is not available or compiled" >&2
  echo "$0: Error: To install it, go to $KALDI_ROOT/tools" >&2
  echo "$0: Error: and run extras/install_srilm.sh" >&2
  exit 1
fi

cd $dir

rm -f temp.flist
IFS=';'
for l in $lang; do
        for i in $comps; do
                find ${jasmin}/data/audio/wav/comp-${i}/${l} -name '*.wav' >>temp_${lang}.flist
        done
done
IFS=' '

for l in $lang; do
    grep 'comp-p' temp_${lang}.flist | sort > test_${lang}_comp_p.flist
    grep 'comp-q' temp_${lang}.flist | sort > test_${lang}_comp_q.flist
done

for l in $lang; do
    # create segments and text files
    python3 local/jasmin_create_transcripts_segments.py ${jasmin}/data/annot/text/ort . 'q' $l
    sed -i 's/één/een/g' text_comp_q_${lang}
    cut -d '-' -f1 text_comp_q_${lang} > spklist_comp_q_${lang}
    cut -d ' ' -f1 text_comp_q_${lang} | paste -d ' ' - spklist_comp_q_${lang} > utt2spk_comp_q_${lang} 
    cat test_${lang}_comp_q.flist | rev | cut -d '/' -f1  | rev | sed 's/\.wav//g' > temp_wavid.txt
    paste -d ' ' temp_wavid.txt test_${lang}_comp_q.flist > test_${lang}_wav_comp_q.scp
    rm -f temp_wavid.txt 

    python3 local/jasmin_create_transcripts_segments.py ${jasmin}/data/annot/text/ort . 'p' $l
    sed -i 's/één/een/g' text_comp_p_${lang}
    cut -d '-' -f1 text_comp_p_${lang} > spklist_comp_p_${lang}
    cut -d ' ' -f1 text_comp_p_${lang} | paste -d ' ' - spklist_comp_p_${lang} > utt2spk_comp_p_${lang}
    cat test_${lang}_comp_p.flist | rev | cut -d '/' -f1  | rev | sed 's/\.wav//g' > temp_wavid.txt
    paste -d ' ' temp_wavid.txt test_${lang}_comp_p.flist > test_${lang}_wav_comp_p.scp
    # we only do sox ... remix 1 because towards comp_p because comp_p contains stereo wav; comp_q contains mono channel wav. 
    sed -e 's/ / sox -t wav /g' -e 's/$/ -b 16 -t wav - remix 1 |/g' test_${lang}_wav_comp_p.scp > test_${lang}_wav_comp_p.scp.sox
    rm -f temp_wavid.txt 
done

for l in $lang; do
  # create spk2gender, spk2age (some doesn't have age info), spk2group (1:native 7-11; 2:native 12-16; 3:non-native child; 4:non-native adults; 5: native >65),  spk2CEF (A1, A2 and B1, non-native adult) spk2dialectregion (only to native speakers)
  tail -n +2 $jasmin/data/meta/text/$l/speakers.txt | cut -d$'\t' -f 1,3 > spk2gender_${l}
  tail -n +2 $jasmin/data/meta/text/$l/speakers.txt | cut -d$'\t' -f 1,4 > spk2age_${l}
  tail -n +2 $jasmin/data/meta/text/$l/speakers.txt | cut -d$'\t' -f 1,6 > spk2group_${l}
  tail -n +2 $jasmin/data/meta/text/$l/speakers.txt | cut -d$'\t' -f 1,9 > spk2CEF_${l} # applicable to part of adult non-native speakers only
  tail -n +2 $jasmin/data/meta/text/$l/speakers.txt | cut -d$'\t' -f 1,13 > spk2dialectregion_${l} # only applicable to native
done
#for l in $lang; do
#  # create spklist_female/male, _
#done

