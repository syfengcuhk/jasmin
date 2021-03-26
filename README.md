This repo contains code to implement experiments in our paper submitted to INTERSPEECH 2021:
  S. Feng, O. Kudina, B. M. Halpern and O. Scharenborg, "Quantifying Bias in Automatic Speech Recognition", submitted to INTERSPEECH 2021.
Update 10 Mar:
  This repo is under construction

Jasmin is a spoken Dutch corpus containing children, elderly and non-native Dutch speakers. We benchmark a standard Dutch ASR system (trained on non-children, non-elderly native speakers) in various types of speech in Jasmin. The Jasmin corpus can be found here: (https://www.aclweb.org/anthology/L06-1141/). It available for academic research. Please contact the developers for the access to this corpus.

This repo requires a trained Dutch ASR system using Kaldi. In this repo the Dutch ASR training recipe is not included. We basically follow [https://github.com/laurensw75/kaldi_egs_CGN] by laurensw75 in training a Dutch ASR system. CGN (Spoken Dutch Corpus) (http://lands.let.ru.nl/cgn/) is used to train such an ASR system

s5/ contains experiments on evaluating Jasmin Netherlands (NL) Dutch data partition 
s5_vl/ contains experiments on evaluating Jasmin Flanders (VL) Dutch data partition

Prerequisites for using this repo:
Software:
An installed Kaldi toolkit
numpy

Corpus:
Jasmin corpus (https://www.aclweb.org/anthology/L06-1141/)


If you have any questions in using this repo, please contact:
Dr. Siyuan Feng (s.feng@tudelft.nl),
Postdoctoral Researcher,
Multimedia Computing Group,
Delft University of Technology

