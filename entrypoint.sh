#!/bin/bash

set -eo

BRANCH=${GITHUB_REF#refs/heads/}
DOMAIN="$INPUT_DOMAIN"

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable"
	exit 1
fi

# Update Github Config.
git config --global user.email "githubactionbot+wp@gmail.com" && git config --global user.name "WP Pot Generator"

php /add-textdomain.php -i "$DOMAIN" "$GITHUB_WORKSPACE"

# Add File To Commit
git add -A

# Add Commit Message
git commit -m "WordPress Textdomains Updated"

# Push To Github
git push "https://x-access-token:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY" HEAD:$BRANCH