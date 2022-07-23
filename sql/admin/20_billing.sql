DROP TABLE IF EXISTS `billing`;

CREATE TABLE `billing` (
  `tennant_id` BIGINT UNSIGNED NOT NULL,
  `competition_id` VARCHAR(255) NOT NULL UNIQUE,
  `player_count` INT NOT NULL,
  `visit_count` INT NOT NULL
);
