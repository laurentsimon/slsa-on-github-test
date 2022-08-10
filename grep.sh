#!/usr/bin/env bash
set -euo pipefail


# Verify that no internal Actions are using `actions/checkout`
# See reasoning in ./github/actions/README.md

# Note: splitting command in two to avoid using pipe because
# we set -o pipefail option and grep returns 1 when there is no match

this_file="e2e.generic.tag.main.annotated.slsa3.yml"
echo "THIS_FILE: $this_file"
echo "blo"
which grep
ls -l "$(which grep)"
echo "done"
#annotated_tags=$(echo "$this_file" | cut -d '.' -f5 | grep annotated)
echo "hello"
echo "hello"
echo "$this_file" | grep "hello"
echo "hi"

# results=$(grep -r --include='*.yml' --include='*.yaml' -e 'dactions/checkout@\|dactions/checkout-go@' .github/workflows/* | grep -v 'checkout-go\|generate-builder')
# if [[ "$results" != "" ]]; then
#     echo "Some Actions are using 'actions/checkout'"
#     echo "$results"
#     exit -1
# fi
