import os
import re
from datetime import datetime
__excludes = ['requirements', 'test-suite']
def merge_files(in_dir, out_dir, out_file='out', ext='sql', excludes=[]):
    files = []
    excludes += __excludes
    for (dirpath, dirnames, filenames) in os.walk(in_dir):
        filenames = list(filter(lambda filename: re.match(r'[^9].*.{ext}'.format(ext=ext), filename), filenames))
        files.extend(list(map(lambda filename: os.path.join(dirpath, filename), filenames)))
        for exclude in excludes:
            files = list(filter(lambda filename: exclude not in filename, files))
    files.sort()
    out_file = '{out_file}_{dt}.{ext}'.format(out_file=out_file,dt=datetime.today().strftime(r'%Y%m%d'),ext=ext)
    outpath = os.path.join(out_dir, out_file)
    with open(outpath, 'w+') as of:
        for infile in files:
            with open(infile, 'r') as f:
                of.write(f.read())
            of.write('\n\n')

def test():
    print('This is cli')
