#!/usr/bin/env bash

chmod -R +x .git
chown -R $(whoami) .git

git clean -dfx
git fetch origin
git checkout $(git rev-parse --abbrev-ref HEAD)
git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)
git config --unset http.https://github.com/.extraheader
git config --unset-all http.https://github.com/.extraheader
git config --global --unset http.https://github.com/.extraheader
git config --system --unset http.https://github.com/.extraheader
