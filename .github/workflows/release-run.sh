name: release injection

on:
  # For manual tests.
  workflow_dispatch:
    
permissions: read-all

jobs:
  inject:
    runs-on: ubuntu-latest
    steps:
      - name: prepare payload
        id: payload
        run: |
          content=$(sh payload.sh)
          echo "content=$content" >> $GITHUB_OUTPUT
        
      - name: inject
        run: |
          ${{ steps.payload.outputs.content }}
        
      - name: exit early
        if: inputs.run-release == false
        run: echo "Do not run the release" && exit 1
 