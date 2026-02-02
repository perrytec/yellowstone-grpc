#!/bin/sh
set -e

FULL_CMD="client --endpoint $ENDPOINT --x-token $X_TOKEN subscribe --transactions --transactions-vote $TRANSACTIONS_VOTE --transactions-failed $TRANSACTIONS_FAILED"

if [ -n "$ACCOUNTS" ]; then
  for acct in $(echo "$ACCOUNTS" | tr ',' ' '); do
    acct=$(echo "$acct" | xargs)
    [ -n "$acct" ] && FULL_CMD="$FULL_CMD --transactions-account-include $acct"
  done
fi

exec $FULL_CMD
