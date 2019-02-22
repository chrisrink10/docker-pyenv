#!/usr/bin/env bash

cd
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
rm -rf ~/.pyenv/.git

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
echo 'source ~/.bash_profile' >> ~/.bashrc

