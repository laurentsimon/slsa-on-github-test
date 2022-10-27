#!bin/bash
set -euo pipefail

cat <<EOF >DATA

jobs:
  provenance:
    permissions:
      id-token: write # For signing.
      contents: write # For asset uploads.
      actions: read # For the entrypoint.
    uses: slsa-framework/slsa-github-generator/.github/workflows/generator_generic_slsa3.yml@v1.2.1
    with:
      base64-subjects: "NmJmNmNkMDA0YTI2MjVmZTFjYjkyZWY0NzlmN2IyMjQ1NTkwNTU5NmM2Y2IzY2EwMzc5NmU3ZTY1ZDU2NmI5NCBOQS50eHQK"

EOF

cat ./DATA
