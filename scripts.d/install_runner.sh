#!/bin/bash

# Create a folder
mkdir $HOME/actions-runner && cd $HOME/actions-runner

# Initialize variables
ARCH=""
case $(uname -m) in
    aarch64) ARCH="arm64" ;;
    arm) ARCH="arm" ;;
    *) ARCH="x64" ;; # or x86_64
esac

GH_USER_REPO=actions/runner 
GH_RELEASE_LATEST_QUERY_API=https://api.github.com/repos/${GH_USER_REPO}/releases/latest
GH_RELEASE_LATEST_VERSION=$(curl -s ${GH_RELEASE_LATEST_QUERY_API} | grep "tag_name" | grep -Eo 'v[^\"]*')
GH_RELEASE_LATEST_URL=$(curl -s ${GH_RELEASE_LATEST_QUERY_API} | grep "browser_download_url.*linux-${ARCH}-[0-9.]*.tar.gz" | grep -Eo 'https://[^\"]*')
GH_RELEASE_BINARY=$(basename ${GH_RELEASE_LATEST_URL})

# Download the latest runner package
curl -o ${GH_RELEASE_BINARY} -L ${GH_RELEASE_LATEST_URL}

# Extract the installer
tar xzf ./${GH_RELEASE_BINARY}

# Install github actions runner - dependencies
sudo ./bin/installdependencies.sh
