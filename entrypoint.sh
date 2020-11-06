#!/bin/sh

set -eu

source /gh-toolkit/shell.sh

gh_validate_env "GITHUB_TOKEN" "SET GITHUB_TOKEN ENV Variable"
gh_validate_input "DOMAIN" "Textdomain Is Not SET !"

gitconfig "WordPress Bot" "githubactionbot+wp@gmail.com"

DOMAIN="$(gh_input "DOMAIN")"
LOCAL_PATH="$(gh_input "PATH")"

gh_log ""
gh_log_group_start "💬 Updating Textdomain : $DOMAIN"
php /add-textdomain.php -i "$DOMAIN" "${GITHUB_WORKSPACE}/${LOCAL_PATH}"
gh_log_group_end

if [ "$(git status --porcelain)" != "" ]; then
  gh_log_group_start "👌 Pushing To Github"
  git add -A
  git commit -m "💬 Text Domain Updated"
  git push "https://x-access-token:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY"
  gh_log_group_end
else
  echo "✅ Nothing To Push"
fi
