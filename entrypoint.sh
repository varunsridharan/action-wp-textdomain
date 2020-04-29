#!/bin/bash

set -eo

BRANCH=${GITHUB_REF#refs/heads/}
DOMAIN="$INPUT_DOMAIN"

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "Set the GITHUB_TOKEN env variable"
  exit 1
fi
echo " "
echo "##[group] 💬 Updating Textdomain : $DOMAIN"
php /add-textdomain.php -i "$DOMAIN" "$GITHUB_WORKSPACE"
echo "##[endgroup]"
echo " "

if [[ "$(git status --porcelain)" != "" ]]; then
  echo "##[group] 👌 Pushing To Github"
  git config --global user.email "githubactionbot+wp@gmail.com" && git config --global user.name "WP Textdomain Github Bot"
  git add -A
  git commit -m "💬 #$GITHUB_RUN_NUMBER - WP Textdomain Updated / ⚡ Triggered By $GITHUB_SHA"
  git push "https://x-access-token:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY" HEAD:$BRANCH
  echo "##[endgroup]"
else
  echo "✅ Nothing To Push"
fi
