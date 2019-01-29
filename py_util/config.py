import os
import re
import ntpath
import json

BASE_DIR, BASE_NAME = ntpath.split(ntpath.realpath(__file__))
config_file = os.path.join(BASE_DIR,'config.json')
with open(config_file, 'r') as f:
    config = json.load(f)

APP_NAME    = config['app_name']
APP_DIR     = ntpath.join(re.search('(.*)' + APP_NAME, BASE_DIR).group(1), APP_NAME)
STAGE_NAME  = config['stage_name']
STAGE_DIR   = ntpath.join(APP_DIR, STAGE_NAME)
ROOT_DIR    = APP_DIR

def test():
    print('test')
