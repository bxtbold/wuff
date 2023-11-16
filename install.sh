#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'

echo "Installing wuff..."

# check if the wuff command already exists in ~/.bashrc
if grep -q "source ${PWD}/src/wuff.sh" ~/.bashrc; then
    echo "wuff command already exists in ~/.bashrc. Skipping..."
    exit 0
else
    echo "" >> ~/.bashrc
    echo "source $PWD/src/wuff.sh" >> ~/.bashrc
    echo -e "${GREEN}wuff installed successfully :D yuhuuu"
fi
