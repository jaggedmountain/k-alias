#!/bin/bash
set -e

source dev-container-features-test-lib

for script in kk kns kls klg kex krl kup kdn kap krm; do
    check "$script installed" bash -c "command -v $script"
done

for script in hls hin hun azs aksme; do
    check "$script not installed" bash -c "! command -v $script"
done

reportResults
