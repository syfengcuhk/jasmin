import re
import sys
import os
# This code generates kaldi-format "text" and "segments" files. Output will be in sys.argv[2]
# In this code, '.', '...' and '?' are removed from transcripts. It is known Jasmin only uses the three punctuation marks
# In this code, 'xxx' are removed, as it is sugessted by JASMIN that don't waste time to understand
# In this code, special marks such as '*f, *u, *z etc' are replaced with '' 
input_dir= sys.argv[1] # should be /tudelft.net/staff-bulk/ewi/insy/SpeechLab/corpora/JASMIN/Data/data/annot/text/ort/      #comp-q/nl
output_dir= sys.argv[2] # 
comp = sys.argv[3] # 'p' or 'q'
language = sys.argv[4] # 'nl' or 'vl'
if language == 'nl':
    Speaker_ID_front='N'
else:
    Speaker_ID_front='V'
with open(os.path.join(output_dir, 'text_comp_' + comp + "_" + language), 'w', encoding='utf8') as f_w_text:
    with open(os.path.join(output_dir, 'segments_comp_' + comp + "_" + language ), 'w') as f_w_segments:
        for filename in os.listdir( os.path.join(input_dir, 'comp-'+ comp, language)  ):
            if filename.endswith('.ort'):
                speaker_ID = []
                with open(os.path.join( input_dir, 'comp-'+ comp, language , filename), encoding="ISO-8859-1") as f_read:
                #with open(os.path.join( input_dir, 'comp-'+ comp, language , filename), encoding="utf-8") as f_read:
                    content_per_wav = f_read.read().splitlines()
#                    print(content_per_wav[12] == '\"IntervalTier\"')
#                    print(content_per_wav[13][1] == Speaker_ID_front)
#                    print(filename + ' has ' + str(len(content_per_wav)) + "lines")
                    flag_do = False
                    for ort_this_line_index in range(len(content_per_wav)-2):
    #                    print(content_per_wav[ort_this_line_index])
                        if content_per_wav[ort_this_line_index] == "\"IntervalTier\"" and content_per_wav[ort_this_line_index+1] == 'TTS':
                            flag_do = False # because we in domain of TTS's transcripts
                        elif content_per_wav[ort_this_line_index] == "\"IntervalTier\"" and content_per_wav[ort_this_line_index+1][1] == Speaker_ID_front:
                            speaker_ID = content_per_wav[ort_this_line_index+1][1:-1]
                            flag_do = True # because we in domain of speaker's transcripts
#                            print("Speaker: " + speaker_ID)
                        elif flag_do and content_per_wav[ort_this_line_index+2].startswith("\"") and content_per_wav[ort_this_line_index+2].endswith("\"") and len(content_per_wav[ort_this_line_index+2]) > 2 and content_per_wav[ort_this_line_index].replace('.','').isnumeric() and content_per_wav[ort_this_line_index+1].replace('.','').isnumeric()  and content_per_wav[ort_this_line_index+2] != "\"IntervalTier\"" and content_per_wav[ort_this_line_index+2] != "\"TextTier\"" :
#                            print(content_per_wav[ort_this_line_index+2])
                            start_time_str =  content_per_wav[ort_this_line_index]
                            end_time_str = content_per_wav[ort_this_line_index+1]
                            text_str = content_per_wav[ort_this_line_index+2][1:-1].replace('.', '').replace('?', '').lower()
                            text_str_removed_marks = re.sub('\*[a-z]', '', text_str)
                            #if text_str == 'xxx':
                            if 'xxx' in text_str_removed_marks or not text_str_removed_marks  :
                                continue
                            else:
#                                print(text_str_removed_marks)
                                f_w_segments.write(speaker_ID + '-' + filename[:-4] + '-' + start_time_str + '-' + end_time_str + ' ' + filename[:-4] + ' ' + start_time_str + ' ' + end_time_str + '\n')
                                f_w_text.write(speaker_ID + '-' + filename[:-4] + '-' + start_time_str + '-' + end_time_str + ' ' +  text_str_removed_marks   + '\n')
                                
                        elif content_per_wav[ort_this_line_index].endswith("Tier\"")  and ( content_per_wav[ort_this_line_index+1][1:-1] == 'BACKGROUND' or content_per_wav[ort_this_line_index+1][1:-1] == 'COMMENTS'  )  :
                            break  
            
             

