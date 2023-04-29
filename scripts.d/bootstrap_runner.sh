#!/bin/bash

# Non-interactive configurations
$HOME/actions-runner/config.sh \
--unattended \
--url https://github.com/${REPO} \
--token ${TOKEN} \
--name ${RUNNER_NAME}
