-- Drop the user_relationship_view if it exists since you want to discard this
DROP VIEW IF EXISTS `lbrpdb`.`user_relationship_view`;

-- Drop the old user_relationships table if it exists
DROP TABLE IF EXISTS `lbrpdb`.`user_relationship_view`;

-- Create users table (adjusting column names to be consistent with your script)
CREATE TABLE IF NOT EXISTS `lbrpdb`.`user` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`iduser`),
  UNIQUE INDEX `iduser_UNIQUE` (`iduser` ASC) VISIBLE
) ENGINE = InnoDB;

-- Create user_sessions table
CREATE TABLE IF NOT EXISTS `lbrpdb`.`user_sessions` (
  `session_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `start_time` TIMESTAMP NOT NULL,
  `end_time` TIMESTAMP NOT NULL,
  PRIMARY KEY (`session_id`),
  INDEX `fk_user_session_idx` (`user_id` ASC),
  FOREIGN KEY (`user_id`) REFERENCES `lbrpdb`.`user` (`iduser`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Create geodata table (renaming time to timestamp for clarity)
CREATE TABLE IF NOT EXISTS `lbrpdb`.`geodata` (
  `idgeo` INT NOT NULL AUTO_INCREMENT,
  `latitude` DOUBLE NULL DEFAULT NULL,
  `longitude` DOUBLE NULL DEFAULT NULL,
  `timestamp` TIMESTAMP NULL DEFAULT NULL,
  `user_id` INT NOT NULL,
  `session_id` INT NOT NULL,
  PRIMARY KEY (`idgeo`),
  UNIQUE INDEX `idgeo_UNIQUE` (`idgeo` ASC) VISIBLE,
  INDEX `fk_user_idx` (`user_id` ASC),
  INDEX `fk_session_idx` (`session_id` ASC),
  FOREIGN KEY (`user_id`) REFERENCES `lbrpdb`.`user` (`iduser`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  FOREIGN KEY (`session_id`) REFERENCES `lbrpdb`.`user_sessions` (`session_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Create routes table
CREATE TABLE IF NOT EXISTS `lbrpdb`.`routes` (
  `route_id` INT NOT NULL AUTO_INCREMENT,
  `session_id` INT NOT NULL,
  `optimized_route_data` TEXT,
  PRIMARY KEY (`route_id`),
  INDEX `fk_session_route_idx` (`session_id` ASC),
  FOREIGN KEY (`session_id`) REFERENCES `lbrpdb`.`user_sessions` (`session_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
