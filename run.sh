#!/bin/sh

# Checks if python3 is installed, installs it if it isn't
if ! [ -x "$(command -v python3)" ]; then
  echo 'Error: python3 is not installed.' >&2
  sudo apt update
  sudo apt install python3 -y
fi

# Checks if pip is installed, installs it if it isn't
if ! [ -x "$(command -v pip)" ]; then
  echo 'Error: pip is not installed.' >&2
  sudo apt update
  sudo apt install python3-pip -y
fi

# Checks if flask is installed, installs it if it isn't
if ! [ -x "$(command -v flask)" ]; then
  echo 'Error: flask is not installed.' >&2
  sudo apt install python3-flask -y
fi

# Checks if git is installed, installs it if it isn't
if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  sudo apt install git -y
fi

pip install flask

pip install marshmallow

# Check if the cashman directory exists
if [ ! -d "cashman" ]; then
  echo 'Error: cashman directory does not exist.' >&2
  # Repository URL
  REPO_URL="https://github.com/erimyr/serverless-flask-restful-apis.git"
  # Branch to checkout, adjust as needed
  BRANCH="master"
  # Directory you want to checkout from the repository
  DIRECTORY="cashman"

  # Clone the repository -- no checkout is performed to avoid fetching the whole repo content
  git clone --filter=blob:none --no-checkout $REPO_URL

  # Change into the repository directory
  cd flask-restful-apis

  # Initialize sparse-checkout
  git sparse-checkout init --cone

  # Set the directory to be checked out
  git sparse-checkout set $DIRECTORY

  # Checkout the branch
  git checkout $BRANCH

  echo "The '$DIRECTORY' directory has been checked out."
  
fi


export FLASK_APP=./cashman/index.py
flask run -h 0.0.0.0
