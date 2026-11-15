#!/usr/bin/env bash
set -euo pipefail

DIR=/home/showdown/backups
STAMP=$(date +%F)
mkdir -p "$DIR"

pg_dump replays | gzip > "$DIR/replays-$STAMP.sql.gz"
tar czf "$DIR/server-$STAMP.tgz" -C /home/showdown/Dystoria-Showdown-website databases logs config
find "$DIR" -type f -mtime +14 -delete

if command -v rclone > /dev/null && rclone listremotes | grep -qx 'r2:'; then
	rclone copy "$DIR" r2:dystoria-backups --max-age 2d
fi
