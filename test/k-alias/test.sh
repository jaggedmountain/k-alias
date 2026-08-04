#!/bin/bash
set -e

source dev-container-features-test-lib

for script in kk kns kls klg kex krl kup kdn kap krm hls hin hun azs aksme; do
    check "$script on PATH" bash -c "command -v $script"
    check "$script executable" bash -c "test -x \"\$(command -v $script)\""
    check "$script parses" bash -n "$(command -v $script)"
done

check "kk installed to default path" test -x /usr/local/bin/kk

reportResults
