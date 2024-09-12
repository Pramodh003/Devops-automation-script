#!/bin/bash
echo "Script to install git"
echo "Installation started"

if  [ "$(uname)" == "Linux" ]; then
        echo "This is linux flavor"
        sudo apt-get install -y git
elif  [ "$(uname)" == "Darwin" ]; then
        echo "This is macos"
        brew install git
else
        echo "Not installing"
fi