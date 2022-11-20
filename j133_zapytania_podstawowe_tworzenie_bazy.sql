-- komentarz w kodzie
-- CREATE DATABASE (stwórz bazę)
-- IF NOT EXISTS (jeśli taka nie istnieje - uniwersalne) 
CREATE DATABASE IF NOT EXISTS `hello_world`;

-- po stworzeniu bazy danych wybieramy ją jako aktywną
-- dzięki temu wszystkie komendy które są wykonane po use będą
-- na pewno odwoływać się do tej bazy
USE `hello_world`;

-- CREATE TABLE - tworzy tabelę
-- w nawiasie podajemy strukturę (kolumny) tabeli
CREATE TABLE IF NOT EXISTS `student` (
	`id` 				INT PRIMARY KEY AUTO_INCREMENT 	NOT NULL,
    `imie` 				VARCHAR(255) 					NOT NULL,
    `nazwisko` 			VARCHAR(255) 					NOT NULL,
    `data_urodzenia` 	DATE 						DEFAULT NULL
);

-- Wstawianie rekordu do tabeli
-- nawiasy pierwsze zawierają nazwy kolumn
-- nawiasy drugie zawierają wartości kolumn w kolejności podanej w nawiasach pierwszych
INSERT INTO `hello_world`.`student` (`imie`, `nazwisko`) VALUES 
									('Paweł', 'Gaweł');

-- tutaj zamienione kolejności
-- wiele rekordów dodanych w jednej komendzie
INSERT INTO `hello_world`.`student` (`nazwisko`, `imie`) VALUES 
									('Nowak', 'Rafał'),
                                    ('Kowalski', 'Marian');

-- tutaj dodana data urodzenia
INSERT INTO `hello_world`.`student` (`nazwisko`, `imie`, `data_urodzenia`) VALUES 
									('Rak', 'Jan', '2003-10-30');