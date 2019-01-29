import os
import re
from .config_util import config_manager

ROOT_DIR = os.path.dirname(os.path.realpath(__file__))
APP_CONFIG = config_manager.get_config()
APP_NAME =  APP_CONFIG['app_name']
STAGE_NAME = APP_CONFIG['stage_name']

APP_DIR = re.search('(.*{app_name}).*'.format(app_name=APP_NAME), ROOT_DIR).group(1)
STAGE_DIR = os.path.join(APP_DIR, STAGE_NAME)