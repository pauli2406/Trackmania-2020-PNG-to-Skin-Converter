import os
import glob
import re

files = [f for f in glob.glob("*.png")]
exportDir = "export"
os.system("mkdir export")

regex_B = re.compile(r"_B")
regex_R = re.compile(r"_R")
regex_I = re.compile(r"_I")
regex_N = re.compile(r"_N")

for file in files:
    if regex_B.search(file):
        os.system(f'texconv -f BC1_UNORM -o {exportDir} {file}')
    elif regex_I.search(file):
        os.system(f'texconv -f BC3_UNORM  -o {exportDir} {file}')
    elif regex_R.search(file) or regex_N.search(file):
        os.system(f'texconv -f BC5_UNORM  -o {exportDir} {file}')