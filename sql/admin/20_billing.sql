DROP TABLE IF EXISTS `billing`;

CREATE TABLE `billing` (
  `tenant_id` BIGINT UNSIGNED NOT NULL,
  `competition_id` VARCHAR(255) NOT NULL UNIQUE,
  `player_count` INT NOT NULL,
  `visitor_count` INT NOT NULL
);
