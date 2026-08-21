#!/usr/bin/env bash
# Usage: notify_assignee.sh <chat_id> "<message>"
set -euo pipefail
source ~/.aiat_secrets.env
CHAT_ID="$1"; TEXT="$2"

RESP=$(curl -s "https://api.telegram.org/bot${TELEGRAM_BOT_TOKENcl}/sendMessage" \
  -d chat_id="${CHAT_ID}" \
  -d parse_mode="HTML" \
  --data-urlencode text="${TEXT}")

if echo "$RESP" | grep -q '"ok":true'; then
  echo "sent → ${CHAT_ID}"
else
  echo "FAILED → ${CHAT_ID} :: ${RESP}" >&2
  exit 1
fi
