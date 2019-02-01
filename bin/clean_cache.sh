#!/bin/bash

find . -name *pyc -print0 -type f | xargs -0 rm
find . -name *pycache* -print0 | xargs -0 rm -rf