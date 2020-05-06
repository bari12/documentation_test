#!/bin/bash

set -e

function print_info() {
    echo -e "\e[36mINFO: ${1}\e[m"
}

REQUIREMENTS="${GITHUB_WORKSPACE}/requirements.txt"

if [ -f "${REQUIREMENTS}" ]; then
    pip install -r "${REQUIREMENTS}"
fi

if [ -n "${CUSTOM_DOMAIN}" ]; then
    print_info "Setting custom domain for github pages"
    echo "${CUSTOM_DOMAIN}" > "${GITHUB_WORKSPACE}/docs/CNAME"
fi

if [ -n "${GITHUB_TOKEN}" ]; then
    print_info "setup with GITHUB_TOKEN"
    remote_repo="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

elif [ -n "${PERSONAL_TOKEN}" ]; then
    print_info "setup with PERSONAL_TOKEN"
    remote_repo="https://x-access-token:${PERSONAL_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
fi

if ! git config --get user.name; then
    git config --global user.name "${GITHUB_ACTOR}"
fi

if ! git config --get user.email; then
    git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
fi

git remote rm origin
git remote add origin "${remote_repo}"

pip install mkdocs-material
pip install mkdocstrings
git clone https://github.com/rucio/rucio.git

python3 -c "import importlib; importlib.import_module('/github/workspace/rucio')"

mkdocs gh-deploy -v --config-file "${GITHUB_WORKSPACE}/mkdocs.yml" --force
