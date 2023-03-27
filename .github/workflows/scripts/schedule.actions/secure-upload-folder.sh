#!/bin/bash

set -euo pipefail

compare_trees() {
    local upload_tree="$1"
    local download_tree="$2"
    if [[ "${upload_tree}" != "${download_tree}" ]]; then
        echo "Folder trees differ: ${upload_tree} != ${download_tree}"
        echo "Upload tree: ${upload_tree}"
        echo "Download tree: ${download_tree}"
        exit 1
    fi
}

original_wd="$PWD"

# Folder at the root of GITHUB_WORKSPACE.
tree "${DOWNLOAD_FOLDER_NAME}"
cd "${UPLOAD_FOLDER_NAME}"
upload_tree=$(tree .)
cd "${original_wd}"
cd "${DOWNLOAD_FOLDER_NAME}/${UPLOAD_FOLDER_NAME}"
download_tree=$(tree .)

compare_trees "${upload_tree}" "${download_tree}"

# Folder not at the root of GITHUB_WORKSPACE.
cd "${original_wd}"
tree
tree "${DOWNLOAD_FOLDER_NO_ROOT_NAME}"
cd "${UPLOAD_FOLDER_NO_ROOT_NAME}"
upload_tree=$(tree .)
cd "${original_wd}"
cd "${DOWNLOAD_FOLDER_NO_ROOT_NAME}/${UPLOAD_FOLDER_NO_ROOT_NAME}"
download_tree=$(tree .)

compare_trees "${upload_tree}" "${download_tree}"
