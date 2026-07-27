#!/usr/bin/env bash
set -euo pipefail
source ~/.aiat_secrets.env
CHAT_ID="$1"; LABEL="$2"; TEXT="$3"
FULL="[→ ${LABEL}] ${TEXT}"
curl -s "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -d chat_id="${CHAT_ID}" \
  -d parse_mode="HTML" \
  --data-urlencode text="${FULL}" >/dev/null \
  && echo "sent → ${LABEL} (${CHAT_ID})"
