#!/bin/sh
set -exu
cd `dirname $0`

MASTER_DB=../../master.db

for tenant_db in ../../initial_data/*.db; do
    cat <<SQL | sqlite3 $MASTER_DB
attach '$tenant_db' as fromMerge;           
BEGIN; 
insert into competition select * from fromMerge.competition; 
insert into player select * from fromMerge.player; 
insert into player_score select * from fromMerge.player_score; 
COMMIT; 
detach fromMerge;
SQL
done
