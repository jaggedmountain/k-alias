#!/bin/bash
set -e

source dev-container-features-test-lib

for script in kk hls azs; do
    check "$script in custom path" test -x "/usr/local/k-alias/bin/$script"
done

check "not in default path" bash -c "! test -e /usr/local/bin/kk"

reportResults
