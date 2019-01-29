import sys
import os
import getopt
from . import APP_DIR, STAGE_DIR
from . import cli

print(sys.argv[1])
if __name__ == '__main__':
    print(len(sys.argv))
    if sys.argv[1] == 'merge_files':
        pl_dir = os.path.join(APP_DIR, 'pl_util', 'src')
        cli.merge_files(pl_dir, STAGE_DIR)
    else:
        print('Do nothing')