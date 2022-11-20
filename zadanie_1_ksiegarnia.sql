-- Stwórz bazę `księgarnia` 
CREATE DATABASE IF NOT EXISTS `ksiegarnia`;
USE `ksiegarnia`;

-- i tabelę `książka`. 
-- Tabela powinna posiadać: id, tytuł i co najmniej 2 kolumny podane przez Ciebie. 
-- Co najmniej jedna kolumna musi być opcjonalna.
CREATE TABLE IF NOT EXISTS `ksiazka`(
	`id` 			INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `tytul` 		VARCHAR(255)				   NOT NULL,
    `autor`     	VARCHAR(255) 				   NOT NULL,
    `ilosc_stron`   INT							  DEFAULT 0,
    `rok_wydania`	INT									   ,
    `isbn`			VARCHAR(255)			   DEFAULT NULL
);

-- Dodaj do bazy rekordy na wiele sposobów, koniecznie:
--  - raz sposobem bez podania kolumny opcjonalnej
INSERT INTO `ksiegarnia`.`ksiazka`  (`tytul`, `autor`, `rok_wydania`) VALUES 
									('Ogniem i mieczem', 'Mieckiewicz', 2000);

--  - raz sposobem z podaniem kolumny opcjonalnej
INSERT INTO `ksiegarnia`.`ksiazka`  (`tytul`, `autor`, `rok_wydania`, `ilosc_stron`, `isbn`) VALUES 
									('Bolek i Lolek', 'Autor nieznany', 1953, 53, 'ISBN-10. 8376727079');