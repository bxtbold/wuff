#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_help() {
    echo -e "Usage:"
    echo -e "${RED}\twoof <python_script.py> [TAGS]"

    echo -e "${NC}Description:"
    echo -e "\tLint the python script using ruff and black."
    echo -e "\tIf no tags are specified, both --ruff and --black will be used as default."

    echo -e "${NC}Tags:"
    echo -e "${GREEN}  --help: ${NC}print this help message"
    echo -e "${GREEN}  --fix: ${NC}fix the linting errors using ruff"
    echo -e "${GREEN}  --black: ${NC}use black only (default)"
    echo -e "${GREEN}  --ruff: ${NC}use ruff only (default)"
}


woof() {
    # check if the number of arguments is less than 1
    if [ "$#" -lt 1 ]; then
        echo -e "${RED}Usage: woof <python_script.py> [TAGS]"
        echo -e "${NC}Use --help for more information."
        return 0
    fi

    if [[ "$1" == "--help" ]]; then
        print_help
        return 0
    else
        # check if the file exists
        if [ -e "$1" ]; then
            filename=$1
        else
            echo -e "${RED}File does asdfnot exist: ${NC}'$filename'"
            return 0
        fi
    fi

    shift  # Remove the first argument (filename) from the list of arguments

    # initialize tag variables
    is_fix=false
    is_ruff_only=true
    is_black_only=true
    unknown_tag=false

    # loop through the remaining arguments (check for tags)
    for tag in "$@"; do
        if [ "$tag" == "--help" ]; then
            print_help
            return 0
        elif [ "$tag" == "--fix" ]; then
            is_fix=true
        elif [ "$tag" == "--ruff" ]; then
            is_black_only=false
        elif [ "$tag" == "--black" ]; then
            is_ruff_only=false
        else
            echo -e "${RED}Unknown tag detected:${NC}" $tag
            unknown_tag=true
        fi
    done

    if [ "$unknown_tag" == true ]; then
        echo -e "Skipping unknown tag and continue..."
    fi

    # check if ruff and black tags are disabled at the same time
    if [ "$is_ruff_only" == false ] && [ "$is_black_only" == false ]; then
        is_ruff_only=true
        is_black_only=true
    fi

    # black
    if [ "$is_black_only" == true ]; then
        echo -e "============ ${YELLOW}RUNNING BLACK${NC} ==============="
        black "$filename"
        echo -e "${GREEN}Black is completed for: ${NC}'$filename'"
    fi

    # ruff
    if [ "$is_ruff_only" == true ]; then
        echo -e "============= ${YELLOW}RUNNING RUFF${NC} ================"
        if [ is_fix == true ]; then
            echo "Fixing available linting errors..."
            ruff "$filename" --fix
        else
            ruff "$filename"
        fi
        echo -e "${GREEN}Ruff is completed for: ${NC}'$filename'"
    fi
}
