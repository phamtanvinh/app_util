import os
import re

BASE_NAME = 'app_util'
CWD = os.path.dirname(os.path.realpath(__file__))
base_dir = re.search('(.*)'+ BASE_NAME, CWD).group(1) + BASE_NAME
ext = '.sql'

files = os.listdir(base_dir)
files = list(filter(lambda file_name: file_name.endswith(ext), files))
files.sort()

print(os.getcwd())