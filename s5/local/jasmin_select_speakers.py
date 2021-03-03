# This code is based on a speaker to (age|gender|group|dialectregion| etc) file, and select a subset of lines that fulfill required property
# The output file has two fields, "speakerid property".
# If you want to only use the first field, try "cut -d ' ' -f 1 $filename |"
# Example of use:
# python3 jasmin_select_speakers.py data/local/data/spk2gender_nl f data/local/data/spklist_female_nl.txt
# Caution: In the input filie e.g. spk2gender_nl the delimiter is '\t' due to JASMIN original format. The output e.g. spklist_female_nl.txt uses space delimiter for convenience in Kaldi


import sys
input_file = sys.argv[1]
propert = sys.argv[2]
output_file = sys.argv[3]

with open(input_file, 'r') as f_input:
    with open(output_file, 'w') as f_output:
        count = 0
        for line_input in f_input:
#            print(line_input.strip())
            if len(line_input.strip().split('\t')) == 1:
                continue # In this case the property does not apply to this speaker
            if line_input.strip().split('\t')[1] == propert:
                f_output.write(line_input.strip().replace('\t',' ') + '\n')
                count += 1

print("Succeeded in generating " + output_file + "  containing " + str(count) +  " lines")

