-- skrypt select do bazy: `rentals`
USE `rentals`;

-- podstawowe zapytania
SELECT * FROM `car`;
SELECT `mark` FROM `car`;

-- podstawowe zapytania
SELECT * FROM `customer`;
SELECT `first_name`,`last_name` FROM `customer`;

-- unique
SELECT `mark` FROM `car`;
SELECT DISTINCT `mark` FROM `car`;

-- count (zliczanie)
SELECT * FROM `customer`;
SELECT count(*) as 'Ilość klientów' FROM `customer`; 	-- ilość klientów
SELECT count(*) as 'Ilość pojazdów' FROM `car`; 		-- ilość samochodów

-- min/max wartość
SELECT MAX(`rate`) FROM `car`;
SELECT MIN(`rate`) FROM `car`;
SELECT AVG(`rate`) FROM `car`; -- średnia
SELECT SUM(`rate`) FROM `car`; -- suma

