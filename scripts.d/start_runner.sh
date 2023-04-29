#!/bin/bash

SCRIPT_CURRENT_DIR=$(dirname -- ${BASH_SOURCE[0]})

if [[ ! -f $HOME/actions-runner/.runner ]]; then
    ${SCRIPT_CURRENT_DIR}/bootstrap_runner.sh
fi

cd $HOME/actions-runner && ./run.sh
