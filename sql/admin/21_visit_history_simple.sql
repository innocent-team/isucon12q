DROP TABLE IF NOT EXISTS `visit_history_simple`;

CREATE TABLE `visit_history_simple` (
  `player_id` VARCHAR(255) NOT NULL,
  `competition_id` VARCHAR(255) NOT NULL,
  `created_at` BIGINT NOT NULL,
  -- NOTE: 実際にはある時点のcreated_atの値が欲しいのでdumpに詰め込む
  PRIMARY KEY (`player_id`, `competition_id`),
  KEY (`competition_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

-- visit_historyからマイグレーション
INSERT INTO `visit_history_simple`
SELECT player_id, competition_id, MIN(created_at) AS created_at
FROM `visit_history`
GROUP BY player_id, competition_id;

-- CREATE INDEX player_id_competition_id_created_at ON visit_history (player_id, competition_id, created_at);
