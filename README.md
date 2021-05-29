This repo contains code to implement experiments in our paper submitted to INTERSPEECH 2021:
  S. Feng, O. Kudina, B. M. Halpern and O. Scharenborg, "Quantifying Bias in Automatic Speech Recognition", submitted to INTERSPEECH 2021.

Update 24 May:
  
  This repo has been updated to include experiments using ESPnet based attention encoder-decoder (AED) ASR systems to recognize JASMIN data. See asr1/ for details.

Jasmin is a spoken Dutch corpus containing children, elderly and non-native Dutch speakers. We benchmark a standard Dutch ASR system (trained on non-children, non-elderly native speakers) in various types of speech in Jasmin. The Jasmin corpus can be found here: (https://www.aclweb.org/anthology/L06-1141/). It available for academic research. Please contact the developers for the access to this corpus.

This repo requires a trained Dutch ASR system using Kaldi. In this repo the Dutch ASR training recipe is not included. We basically follow [https://github.com/laurensw75/kaldi_egs_CGN] by laurensw75 in training a Dutch ASR system. CGN (Spoken Dutch Corpus) (http://lands.let.ru.nl/cgn/) is used to train such an ASR system

s5/ contains experiments on evaluating Jasmin Netherlands (NL) Dutch data partition

s5_vl/ contains experiments on evaluating Jasmin Flanders (VL) Dutch data partition

asr1/ contains experiments on evaluating Jasmin Netherlands (NL) Dutch data partition, by using an E2E trained Dutch ASR system, and the training material i.e. CGN is identical to the setting in the hybrid ASR system used in s5/ and s5_vl/.

Prerequisites for using this repo:
Software:

A pre-trained Dutch ASR system by Kaldi (ASR models are not included in this repo).

An installed Kaldi toolkit

numpy

Corpus:
Jasmin corpus (https://www.aclweb.org/anthology/L06-1141/)

Update 18 May:
asr1/ contains experiments on evaluating Jasmin Netherlands (NL) Dutch data partition using a ESPnet trained Attention encoder-decoder ASR model.

If you have any questions in using this repo, please contact:

Dr. Siyuan Feng (s.feng@tudelft.nl),

Postdoctoral Researcher,

Multimedia Computing Group,

Delft University of Technology

