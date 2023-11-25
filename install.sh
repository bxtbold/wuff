#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'

echo "Installing wuff..."

# install dependencies
sudo apt update -y
sudo apt install python3-pip -y
pip3 install -r $PWD/requirement.txt

os=""
shell=$SHELL
os_name=$(uname)

# check OS
if [[ "$os_name" == "Darwin" ]]; then
    os="MacOS"
elif [[ "$os_name" == "Linux" ]]; then
    os="Linux"
else
    echo -e "${RED}Operating system ($uname) is not supported yet."
    exit 1
fi

# check if python version is at least 3.8
if python3 $PWD/src/check_version.py; then
    :
else
    echo -e "${RED}Please upgrade or change python 3 version to at least 3.8 or higher."
    exit 1
fi

# select shell source
if [[ "$shell" == "/bin/bash" ]]; then
    src=~/.bashrc
elif [[ "$shell" == "/bin/zsh" ]]; then
    src=~/.zshrc
else
    echo -e "${RED}Shell ($shell) is not supported yet."
    exit 1
fi

echo "Operating System: ${os}, Selected Shell: $SHELL"

# check if the wuff command already exists in shell source (~/.bashrc or ~/.zshrc)
if grep -q "source ${PWD}/src/wuff.sh" $src; then
    echo "wuff command already exists in $src. Skipping..."
    exit 0
else
    echo "" >> $src
    echo "source $PWD/src/wuff.sh" >> $src
    echo -e "${GREEN}wuff installed successfully :D yuhuuu"
fi
