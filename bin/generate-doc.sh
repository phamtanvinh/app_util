#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$( dirname $BASE_DIR)"
bash ./scripts/pldoc-1.5.19/pldoc.sh \
  -d ./pl_util/docs/api \
  -doctitle "APP_UTIL" \
  ./pl_util/src/*/*spec*.sql