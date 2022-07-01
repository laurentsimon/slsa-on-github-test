set -e

# Verify that no internal Actions are using `actions/checkout`
# See reasoning in ./github/actions/README.md

# Note: splitting command in two to avoid using pipe because
# we set -o pipefail option and grep returns 1 when there is no match

results=$(grep -r --include='*.yml' --include='*.yaml' -e 'actions/checkout@\|actions/checkout-go@' .github/actions/* | grep -v 'checkout-go\|generate-builder')
if [[ "$results" != "" ]]; then
    echo "Some Actions are using 'actions/checkout'"
    echo "$results"
    exit -1
fi
