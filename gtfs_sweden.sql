-- MySQL Script for GTFS Data

USE `gtfs`;

-- Drop tables if exist
DROP TABLE IF EXISTS `agency`, `calendar`, `calendar_dates`, `feed_info`, `routes`, `stops`, `stop_times`, `trips`, `transfers`;


-- -----------------------------------------------------
-- Table `agency`
-- -----------------------------------------------------
CREATE TABLE `agency` (
  `agency_id` VARCHAR(255) NOT NULL,
  `agency_name` VARCHAR(255) NOT NULL,
  `agency_url` VARCHAR(255) NOT NULL,
  `agency_timezone` VARCHAR(255) NOT NULL,
  `agency_lang` VARCHAR(255),
  PRIMARY KEY (`agency_id`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `calendar`
-- -----------------------------------------------------
CREATE TABLE `calendar` (
  `service_id` VARCHAR(255) NOT NULL,
  `monday` TINYINT NOT NULL,
  `tuesday` TINYINT NOT NULL,
  `wednesday` TINYINT NOT NULL,
  `thursday` TINYINT NOT NULL,
  `friday` TINYINT NOT NULL,
  `saturday` TINYINT NOT NULL,
  `sunday` TINYINT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `calendar_dates`
-- -----------------------------------------------------
CREATE TABLE `calendar_dates` (
  `service_id` VARCHAR(255) NOT NULL,
  `date` DATE NOT NULL,
  `exception_type` TINYINT NOT NULL,
  PRIMARY KEY (`service_id`, `date`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `feed_info`
-- -----------------------------------------------------
CREATE TABLE `feed_info` (
  `feed_id` VARCHAR(255) NOT NULL,
  `feed_publisher_name` VARCHAR(255) NOT NULL,
  `feed_publisher_url` VARCHAR(255) NOT NULL,
  `feed_lang` VARCHAR(255) NOT NULL,
  `feed_version` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`feed_id`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `routes`
-- -----------------------------------------------------
CREATE TABLE `routes` (
  `route_id` VARCHAR(255) NOT NULL,
  `agency_id` VARCHAR(255) NOT NULL,
  `route_short_name` VARCHAR(255),
  `route_long_name` VARCHAR(255) NOT NULL,
  `route_type` INT NOT NULL,
  `route_url` VARCHAR(255),
  PRIMARY KEY (`route_id`),
  FOREIGN KEY (`agency_id`) REFERENCES `agency`(`agency_id`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `stops`
-- -----------------------------------------------------
CREATE TABLE `stops` (
  `stop_id` VARCHAR(255) NOT NULL,
  `stop_name` VARCHAR(255) NOT NULL,
  `stop_lat` DECIMAL(9,6) NOT NULL,
  `stop_lon` DECIMAL(9,6) NOT NULL,
  `location_type` TINYINT,
  PRIMARY KEY (`stop_id`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `stop_times`
-- -----------------------------------------------------
CREATE TABLE `stop_times` (
  `trip_id` VARCHAR(255) NOT NULL,
  `arrival_time` TIME NOT NULL,
  `departure_time` TIME NOT NULL,
  `stop_id` VARCHAR(255) NOT NULL,
  `stop_sequence` INT NOT NULL,
  `pickup_type` TINYINT,
  `drop_off_type` TINYINT,
  PRIMARY KEY (`trip_id`, `stop_sequence`),
  FOREIGN KEY (`trip_id`) REFERENCES `trips`(`trip_id`),
  FOREIGN KEY (`stop_id`) REFERENCES `stops`(`stop_id`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `trips`
-- -----------------------------------------------------
CREATE TABLE `trips` (
  `route_id` VARCHAR(255) NOT NULL,
  `service_id` VARCHAR(255) NOT NULL,
  `trip_id` VARCHAR(255) NOT NULL,
  `trip_headsign` VARCHAR(255),
  `trip_short_name` VARCHAR(255),
  PRIMARY KEY (`trip_id`),
  FOREIGN KEY (`route_id`) REFERENCES `routes`(`route_id`),
  FOREIGN KEY (`service_id`) REFERENCES `calendar`(`service_id`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `transfers`
-- -----------------------------------------------------
CREATE TABLE `transfers` (
  `from_stop_id` VARCHAR(255) NOT NULL,
  `to_stop_id` VARCHAR(255) NOT NULL,
  `transfer_type` TINYINT NOT NULL,
  `min_transfer_time` INT,
  `from_trip_id` VARCHAR(255),
  `to_trip_id` VARCHAR(255),
  PRIMARY KEY (`from_stop_id`, `to_stop_id`),
  FOREIGN KEY (`from_stop_id`) REFERENCES `stops`(`stop_id`),
  FOREIGN KEY (`to_stop_id`) REFERENCES `stops`(`stop_id`)
) ENGINE=InnoDB;

