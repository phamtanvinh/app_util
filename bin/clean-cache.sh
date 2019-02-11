#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$( dirname $BASE_DIR)"
find . -name *pyc -print0 -type f | xargs -0 rm
find . -name *pycache* -print0 | xargs -0 rm -rf