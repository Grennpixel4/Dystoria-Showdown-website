#!/usr/bin/env bash
set -euo pipefail

SHA="${SSH_ORIGINAL_COMMAND:-${1:-}}"
MODE="restart"
if [[ "$SHA" == *" hotpatch" ]]; then
	MODE="hotpatch"
	SHA="${SHA% hotpatch}"
fi
[[ "$SHA" =~ ^[0-9a-f]{7,40}$ ]] || { echo "usage: deploy.sh <commit-sha> [hotpatch]"; exit 1; }

cd /home/showdown/Dystoria-Showdown-website
git fetch --quiet origin
PREV=$(git rev-parse HEAD)
echo "$PREV" > /home/showdown/previous-deploy-sha
git checkout --quiet --force "$SHA"
if ! git diff --quiet "$PREV" HEAD -- package-lock.json; then
	npm ci
fi
node build

if [[ "$MODE" == "restart" ]]; then
	sudo /bin/systemctl restart showdown
	echo "deployed $(git rev-parse --short HEAD) and restarted"
else
	echo "deployed $(git rev-parse --short HEAD); run /hotpatch in chat to load it"
fi
