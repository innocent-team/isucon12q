#!/bin/sh

set -ex
cd `dirname $0`

ISUCON_DB_HOST=${ISUCON_DB_HOST:-127.0.0.1}
ISUCON_DB_PORT=${ISUCON_DB_PORT:-3306}
ISUCON_DB_USER=${ISUCON_DB_USER:-isucon}
ISUCON_DB_PASSWORD=${ISUCON_DB_PASSWORD:-isucon}
ISUCON_DB_NAME=${ISUCON_DB_NAME:-isuports}
ISUCON_SCORE_DB_HOST=${ISUCON_SCORE_DB_HOST:-127.0.0.1}
ISUCON_SCORE_DB_PORT=${ISUCON_SCORE_DB_PORT:-3306}

# MySQLを初期化
# mysql -u"$ISUCON_DB_USER" \
# 		-p"$ISUCON_DB_PASSWORD" \
# 		--host "$ISUCON_DB_HOST" \
# 		--port "$ISUCON_DB_PORT" \
# 		"$ISUCON_DB_NAME" < /home/isucon/dump/isuports.mysql
# mysql -u"$ISUCON_DB_USER" \
# 		-p"$ISUCON_DB_PASSWORD" \
# 		--host "$ISUCON_DB_HOST" \
# 		--port "$ISUCON_DB_PORT" \
# 		"$ISUCON_DB_NAME" < ./admin/20_billing.sql
mysql -u"$ISUCON_DB_USER" \
		-p"$ISUCON_DB_PASSWORD" \
		--host "$ISUCON_DB_HOST" \
		--port "$ISUCON_DB_PORT" \
		"$ISUCON_DB_NAME" < /home/isucon/dump/isuports.billing_visit_history_simple.dump
mysql -u"$ISUCON_DB_USER" \
		-p"$ISUCON_DB_PASSWORD" \
		--host "$ISUCON_DB_HOST" \
		--port "$ISUCON_DB_PORT" \
		"$ISUCON_DB_NAME" < ./10_add_index.sql

# player_score DB用の初期化
mysql -u"$ISUCON_DB_USER" \
		-p"$ISUCON_DB_PASSWORD" \
		--host "$ISUCON_SCORE_DB_HOST" \
		--port "$ISUCON_SCORE_DB_PORT" \
		"$ISUCON_DB_NAME" < /home/isucon/dump/isuports.billing_visit_history_simple.dump

# テナントごとの情報もMySQLに流し込む
# ./sqlite3-to-sql ../../master.db | mysql -u"$ISUCON_DB_USER" -p"$ISUCON_DB_PASSWORD" --host "$ISUCON_DB_HOST" --port "$ISUCON_DB_PORT" "$ISUCON_DB_NAME"

# # SQLiteのデータベースを初期化
# rm -f ../tenant_db/*.db
# cp -r ../../initial_data/*.db ../tenant_db/
