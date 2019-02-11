#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$( dirname $BASE_DIR)"
python -m py_util merge_files
bash ./bin/clean-cache.sh