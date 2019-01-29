import sys
import os
import getopt
from . import APP_DIR, STAGE_DIR
from . import cli

if __name__ == '__main__':
    if sys.argv[1] == 'merge_files':
        pl_dir = os.path.join(APP_DIR, 'pl_util', 'src')
        cli.merge_files(pl_dir, STAGE_DIR, out_file='app_util')
    else:
        print('Do nothing')