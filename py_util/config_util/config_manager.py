import os
import re
import json
from . import CONFIG_PATH 

__config = {}

def get_config(file_path=CONFIG_PATH):
    with open(file_path, 'r') as f:
        __config = json.load(f)
    return __config