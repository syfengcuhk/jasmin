#!/bin/bash
jasmin_path=/tudelft.net/staff-bulk/ewi/insy/SpeechLab/corpora/JASMIN/Data
lang=nl
comp=q # q for read speech p for dialogue (Human machine In)
bash local/jasmin_data_prep.sh $jasmin_path $lang $comp
