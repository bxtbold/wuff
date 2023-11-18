#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'

echo "Installing wuff..."

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
