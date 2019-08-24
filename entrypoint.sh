#!/bin/bash

set -eo

BRANCH=${GITHUB_REF#refs/heads/}
DOMAIN="$INPUT_DOMAIN"

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable"
	exit 1
fi

ls -la

cd /

ls -la

php addtextdomain.php -i "$DOMAIN" "$GITHUB_WORKSPACE"

cd "$GITHUB_WORKSPACE"

# Add File To Commit
git add -A

# Add Commit Message
git commit -m "WordPress Textdomains Updated"

# Push To Github
git push "https://x-access-token:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY" HEAD:$BRANCH