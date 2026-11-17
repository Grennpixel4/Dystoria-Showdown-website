#!/usr/bin/env bash
set -euo pipefail

REPO=/home/showdown/Dystoria-Showdown-website
RUNNING_FILE=/home/showdown/running-sha
BATTLES_FILE="$REPO/logs/active-battles.txt"
BUSY_EXIT=75

read -r SHA MODE <<< "${SSH_ORIGINAL_COMMAND:-$*}"

if [[ "$SHA" == "status" ]]; then
	cat "$RUNNING_FILE" 2>/dev/null || echo none
	exit 0
fi

MODE="${MODE:-restart}"

if ! [[ "$SHA" =~ ^[0-9a-f]{7,40}$ && "$MODE" =~ ^(restart|hotpatch|whenidle)$ ]]; then
	echo "usage: deploy.sh <commit-sha> [hotpatch|whenidle] | status"
	exit 1
fi

battles_running() {
	systemctl is-active --quiet showdown || return 1
	[[ -f "$BATTLES_FILE" ]] || return 1
	local stamp='' count=''
	read -r stamp count < "$BATTLES_FILE" || true
	[[ "$stamp" =~ ^[0-9]+$ && "$count" =~ ^[0-9]+$ ]] || return 1
	(( $(date +%s) * 1000 - stamp < 120000 )) || return 1
	(( count > 0 ))
}

if [[ "$MODE" == "whenidle" ]] && battles_running; then
	echo "BUSY: battles in progress, nothing deployed"
	exit $BUSY_EXIT
fi

cd "$REPO"
git fetch --quiet origin
PREV=$(git rev-parse HEAD)
if [[ "$PREV" != "$(git rev-parse "$SHA^{commit}")" ]]; then
	echo "$PREV" > /home/showdown/previous-deploy-sha
fi
git checkout --quiet --force "$SHA"
if ! git diff --quiet "$PREV" HEAD -- package-lock.json; then
	npm ci
fi
node build

FULL=$(git rev-parse HEAD)

if [[ "$MODE" == "hotpatch" ]]; then
	echo "$FULL" > "$RUNNING_FILE"
	echo "deployed $(git rev-parse --short HEAD); run /hotpatch in chat to load it"
	exit 0
fi

if [[ "$MODE" == "whenidle" ]] && battles_running; then
	echo "BUSY: battles started during the build, restart skipped"
	exit $BUSY_EXIT
fi

sudo /bin/systemctl restart showdown
echo "$FULL" > "$RUNNING_FILE"
echo "deployed $(git rev-parse --short HEAD) and restarted"
