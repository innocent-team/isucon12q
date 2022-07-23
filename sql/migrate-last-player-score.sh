#!/bin/sh
set -exu

ISUCON_DB_HOST=${ISUCON_DB_HOST:-127.0.0.1}
ISUCON_DB_PORT=${ISUCON_DB_PORT:-3306}
ISUCON_DB_USER=${ISUCON_DB_USER:-isucon}
ISUCON_DB_PASSWORD=${ISUCON_DB_PASSWORD:-isucon}
ISUCON_DB_NAME=${ISUCON_DB_NAME:-isuports}

cd `dirname $0`

for tenant_db in ../../initial_data/*.db; do
    sqlite3 $tenant_db < tenant/20_last_player_score.sql
	./sqlite3-to-sql $tenant_db | mysql -u"$ISUCON_DB_USER" -p"$ISUCON_DB_PASSWORD" --host "$ISUCON_DB_HOST" --port "$ISUCON_DB_PORT" "$ISUCON_DB_NAME"
done
