-- ================ Ćwiczenie =============
-- Dodać do wcześniejszej utowrzonej tabeli ograniczenia 
-- NULL / UNIQUE / PRIMARY KEY / FOREIGN KEY
-- UWAGA!! W niektórych tabelach warto dodać klucze główne w postaci ID (INT8) czyli nie będziemy mieli pięknej 3NF !!!


DROP SCHEMA IF EXISTS kontrola;
CREATE SCHEMA kontrola;
CREATE TABLE kontrola.straznik (
	id		    INT PRIMARY KEY auto_increment, 	
	imie		    CHAR(200) NOT NULL,
	nazwisko	    CHAR(200) NOT NULL,
	stopien		    CHAR(50)  NOT NULL CHECK (stopien='Szeregowiec' OR stopien='Starszy szeregowiec' OR stopien='Kapral' OR stopien='Starszy kapral'),
	data_zatrudnienia   DATETIME      NOT NULL DEFAULT NOW(),
	pensja		    NUMERIC(8,2) NOT NULL CHECK(pensja>=0),
	skladka_na_ubezpieczenie NUMERIC(8,2)
);

CREATE TABLE kontrola.straznik_archiwum (
	id		    INT PRIMARY KEY auto_increment, 	
	imie		    CHAR(200) NOT NULL,
	nazwisko	    CHAR(200) NOT NULL,
	stopien		    CHAR(50)  NOT NULL CHECK (stopien='Szeregowiec' OR stopien='Starszy szeregowiec' OR stopien='Kapral' OR stopien='Starszy kapral'),
	data_zatrudnienia   DATETIME      NOT NULL default NOW(),
	pensja		    NUMERIC(8,2) NOT NULL CHECK(pensja>=0),
	skladka_na_ubezpieczenie NUMERIC(8,2)
);

CREATE TABLE kontrola.przyznane_nagrody (
	straznik_id	    INT8  NOT NULL REFERENCES kontrola.straznik(id),
	nazwa	            CHAR(200) NOT NULL,
	data_przyznania	    DATE,
	PRIMARY KEY (straznik_id, nazwa, data_przyznania)
);


CREATE TABLE kontrola.port_lotniczy (
	nazwa_portu	CHAR(200) PRIMARY KEY
);

CREATE TABLE kontrola.numer_stanowiska (
	id		INT PRIMARY KEY auto_increment, 
	nazwa_portu	CHAR(200) NOT NULL REFERENCES kontrola.port_lotniczy(nazwa_portu),
	numer  		INT NOT NULL 
);


CREATE TABLE kontrola.pasazer (
	id		INT PRIMARY KEY auto_increment, 
	imie		CHAR(100) NOT NULL,
	nazwisko	CHAR(100) NOT NULL
);

CREATE TABLE kontrola.kontrola (
	id_straznik		INT8 NOT NULL REFERENCES kontrola.straznik(id),
	id_pasazer		INT8 NOT NULL REFERENCES kontrola.pasazer(id),
	id_numer_stanowiska     INT8 NOT NULL REFERENCES kontrola.numer_stanowiska(id),
	wynik_kontroli		BOOLEAN NOT NULL,
	czas_kontroli 		TIMESTAMP NOT NULL default NOW(),
	PRIMARY KEY kontrola_pk (id_straznik,id_pasazer,id_numer_stanowiska,czas_kontroli)
);

-- przykładowe dane
INSERT INTO kontrola.straznik (imie, nazwisko, stopien, data_zatrudnienia, pensja,skladka_na_ubezpieczenie) 
VALUES 
	('Jan', 'Kowalski', 'Szeregowiec',        now()-interval 32 month, 1500, 300),
	('Marek', 'Nowak'   , 'Starszy szeregowiec', now()-interval 12 month, 2300, 3320),
	('Franciszek', 'Kowalczyk', 'Szeregowiec',        now()-interval 50 month, 1300,290),
	('Zdzisław', 'Nowak'   , 'Starszy szeregowiec', now()-interval 11 month, 2200,500),
	('Teofil', 'Kowalski', 'Szeregowiec',        now()-interval 1 month, 2500,200),
	('Jan', 'Nowak'   , 'Starszy szeregowiec', now()-interval 2 month, 3000,200),
	('Jan', 'Nowakowski'   , 'Starszy szeregowiec', now()-interval 2 month, 3000,200);

INSERT INTO kontrola.straznik_archiwum (imie, nazwisko, stopien, data_zatrudnienia, pensja,skladka_na_ubezpieczenie) 
VALUES 
	('Stefan', 'Jeziorański', 'Szeregowiec',        now()-interval 32 month, 1500, 300);

INSERT INTO kontrola.przyznane_nagrody (straznik_id,nazwa, data_przyznania) VALUES 
	(1, 'Przepracowane 10 lat pracy', now()-interval 20 month) , 
	(2, 'Nagroda generała', now()-interval 11 month),
	(3, 'Przepracowane 15 lat pracy', now()-interval 23 month) , 
	(4, 'Nagroda pułkownika', now()-interval 43 month),
	(5, 'Przepracowane 20 lat pracy', now()-interval 23 month) , 
	(6, 'Nagroda generała', now()-interval 5 month);

INSERT INTO kontrola.port_lotniczy (nazwa_portu) VALUES ('Gdańsk'), ('Warszawa'), ('Szczecin');

INSERT INTO kontrola.numer_stanowiska (nazwa_portu, numer) VALUES
	('Gdańsk', 1), ('Gdańsk',2), ('Gdańsk',3),
	('Warszawa',1), ('Warszawa',2), ('Warszawa',3), ('Warszawa',4),
	('Szczecin',1), ('Szczecin',2), ('Szczecin',3)	
	;

INSERT INTO kontrola.pasazer (imie, nazwisko) 
VALUES 
	('Jan', 'Brzechwa'), 
	('Stanisław', 'Wyspański'), 
	('Henryk','Sienkiewicz'),
	('Władysław', 'Bartoszewski'),
	('Stefan', 'Żeromski'),
	('Maria', 'Konopnicka'),
	('Maria', 'Kownacka');

INSERT INTO kontrola.kontrola (id_straznik, id_pasazer, id_numer_stanowiska, wynik_kontroli, czas_kontroli) VALUES 
 (1, 1, 1, true, now()-interval 5 month),
 (1, 2, 1, false, now()),
 (2, 2, 4, true, now()-interval 5 month),
 (2, 2, 5, true, now()-interval 15 month),
 (3, 1, 1, true, now()-interval 2 month),
 (3, 2, 1, false, now()-interval 25 month),
 (4, 2, 4, true, now()),
 (5, 2, 5, true, now()-interval 5 month),
 (6, 1, 1, true, now()-interval 25 month),
 (3, 2, 1, false, now()-interval 45 month),
 (4, 2, 4, true, now()-interval 1 month),
 (5, 2, 5, true, now()-interval 15 month);