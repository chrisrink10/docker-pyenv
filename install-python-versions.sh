#!/usr/bin/env bash

source ~/.bash_profile

: ${INSTALL_PY_VERSIONS?Must specify Python versions to install}
: ${INSTALL_PY_VERSIONS_SEP?Must specify Python version separator}

IFS="$INSTALL_PY_VERSIONS_SEP" read -ra PY_VERSIONS <<< "$INSTALL_PY_VERSIONS"
for version in "${PY_VERSIONS[@]}"; do
    pyenv install "$version"
done

pyenv global $(echo "$INSTALL_PY_VERSIONS" | sed 's/,/ /g')
