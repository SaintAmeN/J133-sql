CREATE DATABASE IF NOT EXISTS `rentals`;
USE `rentals`;

CREATE TABLE IF NOT EXISTS `customer`(
	`cust_id` 		SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
	`first_name` 	VARCHAR(15) NOT NULL,
	`last_name` 	VARCHAR(15) NOT NULL,
	`address` 		VARCHAR(30) NOT NULL,
	`postal_code` 	VARCHAR(6) NOT NULL
);

CREATE TABLE IF NOT EXISTS `car`(
	`reg_number` 		VARCHAR(8) PRIMARY KEY NOT NULL,
	`mark` 				VARCHAR(15) NOT NULL,
	`model` 			VARCHAR(15) NOT NULL,
	`rate` 				TINYINT DEFAULT 1
);

CREATE TABLE IF NOT EXISTS `rent`(
	`rent_id` 			SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
	`cust_id` 			SMALLINT UNSIGNED 	NOT NULL,
	`reg_number` 		VARCHAR(8) 			NOT NULL,
	`rent_date` 		DATE 				NOT NULL,
	`return_date` 		DATE,
    FOREIGN KEY(`cust_id`) REFERENCES `customer`(`cust_id`),
    FOREIGN KEY(`reg_number`) REFERENCES `car`(`reg_number`)
);

-- customer
INSERT IGNORE INTO `customer` 	VALUES 	(10, 'Pawel', 'Gawel', 'Dunno', '80-801');
INSERT IGNORE INTO `customer` 	VALUES 	(11, 'Michał', 'Gawel', 'Gdańsk', '80-802');
INSERT IGNORE INTO `customer` 	VALUES 	(12, 'Marian', 'Brzęczyszczykiewicz', 'Warszawa', '80-803');
INSERT IGNORE INTO `customer` 	VALUES 	(13, 'Waldek', 'Nowak', 'Wrocław', '80-804');
INSERT IGNORE INTO `customer` 	VALUES 	(14, 'Bogusia', 'Kowalska', 'Kraków', '80-809');
INSERT IGNORE INTO `customer` 	VALUES 	(15, 'Zosia', 'Nowak', 'Wrocław', '80-804');

-- car
INSERT IGNORE INTO `car` 		VALUES 	('WWW10003', 'Mazda', 'MX-5', 1);
INSERT IGNORE INTO `car` 		VALUES 	('WWW10004', 'Mazda', 'CX-3', 1);
INSERT IGNORE INTO `car` 		VALUES 	('WWW10005', 'BMW', 'M3', 1);
INSERT IGNORE INTO `car` 		VALUES 	('WWW10006', 'Citroen', 'C3', 2);

-- rent
INSERT IGNORE INTO `rent` 		VALUES  (NULL, 10, 'WWW10003', now(), NULL);

