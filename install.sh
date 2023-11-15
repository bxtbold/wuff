#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'

echo "Installing woof..."

# check if the woof command already exists in ~/.bashrc
if grep -q "source ${PWD}/src/woof.sh" ~/.bashrc; then
    echo "woof command already exists in ~/.bashrc. Skipping..."
    exit 0
else
    echo "" >> ~/.bashrc
    echo "source $PWD/src/woof.sh" >> ~/.bashrc
    echo -e "${GREEN}woof installed successfully :D yuhuuu"
fi
