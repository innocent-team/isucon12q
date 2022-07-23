CREATE TABLE last_player_score (
  tenant_id BIGINT NOT NULL,
  player_id VARCHAR(255) NOT NULL,
  competition_id VARCHAR(255) NOT NULL,
  score BIGINT NOT NULL,
  -- row_num BIGINT NOT NULL,
  created_at BIGINT NOT NULL,
  updated_at BIGINT NOT NULL,
  PRIMARY KEY (tenant_id, player_id, competition_id)
);

INSERT INTO last_player_score (tenant_id, player_id, competition_id, score, created_at, updated_at)
SELECT tenant_id, player_id, competition_id, score, created_at, updated_at
FROM player_score
GROUP BY tenant_id, player_id, competition_id
HAVING row_num = MAX(row_num);

DROP TABLE player_score;
ALTER TABLE last_player_score RENAME TO player_score;
