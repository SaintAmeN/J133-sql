USE `kontrola`;

-- Podstawowe zapytania
-- 1) Wyświetlenie wszystkich strażników z tym, że zamiast kolumna 'imie' 
-- chciałbym żeby była kolumna imie_strażnika
select *,`imie` as 'imie_straznika' from `straznik`;

-- 2) Wyświetlić strażników którzy mają pensje (bez uwzględniania składni na ubezpieczenia) 
-- większe niż 1500zł
select * from `straznik` where (`pensja` + `skladka_na_ubezpieczenie`) > 1500;

-- 3) Wyświetlić strażników z pensją większą od 1500zł ale mniejszą niż 2500zł
select * from `straznik` where `pensja` > 1500 and `pensja` < 2500;
select * from `straznik` where `pensja` between 1500 and 2500;

-- 4) Wyświetlić strażników ale bez strażników o nazwisku Nowak i Kowalczyk
select * from `straznik` where `nazwisko` not in ('Nowak', 'Kowalczyk');

-- 5) Wyświetlić strażników ale bez strażników o id 1,6,5 (z użyciem IN)
select * from `straznik` where `id` not in (1,5,6);

-- 6) Wyświetlić strazników i pensje które są większe od 1500 ale po odjęciu "skladka_na_ubezpieczenie"
select * from `straznik` where `pensja`-`skladka_na_ubezpieczenie` > 1500;

-- 7) Wyświetlić pasażerów posortowanych po nazwisku i imieniu
select * from `straznik` order by `nazwisko`, `imie`;

-- 8) Wyświetlić strażników którzy mają nazwisko rozpoczynające się od "Kowal"
select * from `straznik` where `nazwisko` like 'Kowal%';

-- 9) Wyświetlić strażników o nazwisku Nowak i którzy zostali zatrudnieni w tym roku (year - extract year from datetime)
select * from `straznik` where `nazwisko` = 'Nowak' and year(`data_zatrudnienia`) = year(curdate());

-- 10) Wyświetlić nazwisko+pensje strażników pomniejszone skladka_na_ubezpieczenie, 
-- kolumna ma się nazywać pensja_do_wyplaty
select `nazwisko`,`pensja`-`skladka_na_ubezpieczenie` as 'pensja_do_wyplaty' from `straznik`;

-- 11) Wyświetlić wszystkich strażników aktualnych i archiwalnych (kontrola.straznik_archiwum) w jednej tabeli 
-- select * from 
-- 				tabela 
-- 					inner join
-- 					outer join
-- 					join
-- 					left join
-- 					right join
-- 				tabela2
--                 ...
-- 11. Przykład: select * from `kontrola` join `straznik`;
select * from `straznik` UNION (SELECT * from `straznik_archiwum`);

-- 12) Wyświetlić strażnika który nie ma ustawionego pola skladka_na_ubezpieczenie (jest to NULL)
select * from `straznik` where `skladka_na_ubezpieczenie` is null;

-- Używanie agregatów - Proszę 
-- ---------------------------
-- 1) Napisać zapytania które poda sumę  pensji (pola pensja) dla wszystkich strażników
select sum(`pensja`) from `straznik`;

-- 2) Podać średnią pensję strażników 
select avg(`pensja`) from `straznik`;

-- 3) Wyświetlić największą pensje
select max(`pensja`) from `straznik`;

-- 4) Podac liczbę  pasażerów w systemie
select count(*) from `pasazer`;

-- 5) Podać liczbę strażników ale tych którzy mają uzupełnione pole skladka_na_ubezpieczenie
select count(*) from `straznik` where `skladka_na_ubezpieczenie` is not null;

-- 
-- Zapytania z JOIN
-- -------------------
-- 1) Wyświetlić wszystkie kontrole przeprowadzone na  lotnisku Gdańsk
SELECT `k`.* FROM 
	`kontrola` `k`
    join 
    `numer_stanowiska` `ns` 
		on `k`.`id_numer_stanowiska`=`ns`.`id`
		where `ns`.`nazwa_portu`='Gdańsk';

-- 2) Wyświetlić wszystkie kontrole przeprowadzone dla lotnisku Gdańsk 
-- przez strażnika/ów który ma nazwisko 'Nowak'
SELECT `k`.* FROM `kontrola` `k`
    join `numer_stanowiska` `ns` on `k`.`id_numer_stanowiska`=`ns`.`id`
    join `straznik` `s` on `k`.`id_straznik` = `s`.`id`
		where 
			`ns`.`nazwa_portu`='Gdańsk' 
			and `s`.`nazwisko` = 'Nowak';

-- z podzapytaniem
SELECT `k`.* FROM 
	`kontrola` `k`
    join 
    `numer_stanowiska` `ns` 
		on `k`.`id_numer_stanowiska`=`ns`.`id`
		where 
			`ns`.`nazwa_portu`='Gdańsk' 
            and
            `k`.`id_straznik` in (select `id` from `straznik` where `nazwisko` = 'Nowak');

-- Podzieliliśmy zapytanie na podzapytania, podzapytanie o identyfikatory straznikow z danym nazwiskiem:

-- 3) Wyświetlić strażników i przeprowadzone przez nich kontrole jeśli strażnik nie ma kontroli to wyświetlamy informację 
-- o strażniku a w części kontroli wyświetlamy nulle 
select * from `kontrola` `k`
		left join `straznik` `s` on `k`.`id_straznik` = `s`.`id`;

-- 4) Wyświetlić wszystkie lotniska odwiedzone przez pasażera imie="Jan"  AND nazwisko="Brzechwa"
select distinct `ns`.* from `kontrola` `k`
		join `pasazer` `p` on `k`.`id_pasazer` = `p`.`id`
        join `numer_stanowiska` `ns` on `k`.`id_numer_stanowiska` = `ns`.`id`
        where `p`.`imie`='Jan' and `p`.`nazwisko` = 'Brzechwa';

-- PODZAPYTANIA
-- 1) Wyświetlić wszystkie kontrole przeprowadzone dla lotniksa Gdańsk przez 
-- strażnika który ma największe zarobki
select max(`pensja`) from `straznik`;
select `id` from `straznik` where `pensja` = (select max(`pensja`) from `straznik`);
SELECT * FROM `kontrola` 
		where `id_straznik` in  (select `id` from `straznik` where `pensja` = (select max(`pensja`) from `straznik`));

-- 2) Wyświetlić z użyciem podzapytania wszystkiich pasażerów skontrolowanych przez strażnika o nazwisku "Nowak"
-- Wszystkie kontrole wykonane przez 'Nowaków'
select `id` from `straznik` where `nazwisko`='Nowak'; -- (5,6)
select distinct `id_pasazer` from `kontrola` where `id_straznik` in (select `id` from `straznik` where `nazwisko`='Nowak');
-- ^^^^ (1,2)
SELECT * FROM `pasazer` where `id` in 
	(select distinct `id_pasazer` from `kontrola` where `id_straznik` in 
		(select `id` from `straznik` where `nazwisko`='Nowak'));

-- Podstawową tabelą do której wykonujemy zapytanie, jest tabela `pasazer` ponieważ zawiera imiona i nazwiska pasazerow o które musimy odpytać. 
-- Do niej robię podstawowe zapytanie. (stąd początek zapytania to: "select * from PASAZER....")
-- 
-- 3) Wyświetlić strażników a w ostatniej kolumnie kwotę najwyższej pensji strażnika
select *,(select max(`pensja`) from `straznik`) as 'max pensja' from `straznik`;

-- 4) Wyświetlić strażników a w ostatniej kolumnie informację o ile mniej/więcej zarabia dany strażnik od średniej  
select avg(`pensja`) from `straznik`;
select *,(`pensja`-(select avg(`pensja`) from `straznik`)) as 'ile mniej/wiecej' from `straznik`;

-- Zlozone
-- 1) Wyświetlić pasażera który  nigdy nie był kontrolowany. 
select p.* from pasazer  p left join kontrola k on p.id = k.id_pasazer where wynik_kontroli is null;

-- 2) Znaleźć pasażera który odwiedził największą ilość lotnisk (użyć LIMIT), wyświetlić jaką liczbę lotnisk odwiedzili.
 SELECT * FROM `pasazer` `p` 
		join (SELECT `id_pasazer`,count(*) as 'ilosc_kontroli' FROM `kontrola` group by `id_pasazer`) `k`
			on `p`.`id`=`k`.`id_pasazer` order by `ilosc_kontroli` desc limit 1;
            
SELECT `id_pasazer`,count(*) as 'ilosc_kontroli' FROM `kontrola` group by `id_pasazer`;
 
-- 3) Znaleźć 2 strażników którzy skontrolowali największą ilość klientów.
SELECT `id_straznik`,count(*) as 'ilosc' FROM `kontrola` group by `id_straznik` order by `ilosc` desc limit 2;
SELECT * FROM `straznik` where `id` in 
	(select `id_straznik` from 
		(SELECT `id_straznik`,count(*) as 'ilosc' FROM `kontrola` group by `id_straznik` order by `ilosc` desc limit 2) `d`);

SELECT s.*,count(*) as 'ilosc' 
	FROM `kontrola` `k`
		right join `straznik` `s` on `k`.`id_straznik`=`s`.`id`
			group by `id_straznik` 
			order by `ilosc` desc 
			limit 2;
        
-- 4) Znaleźć lotnisko przez które poleciała najmniejsza ilość pasażerów .
SELECT distinct `id_pasazer`,`nazwa_portu` as 'ilosc' FROM `kontrola` `k`
	join `numer_stanowiska` `ns` on `k`.`id_numer_stanowiska`=`ns`.`id`
    group by `id_numer_stanowiska`,`id_pasazer`;
    
select *,count(*) from `kontrola` group by `id_numer_stanowiska`,`id_pasazer`;

select * from `kontrola` `k`
	right join `numer_stanowiska` `ns` on `k`.`id_numer_stanowiska` = `ns`.`id`;

select *,count(*) as 'ilosc' from `kontrola` `k`
		right join `numer_stanowiska` `ns` on `k`.`id_numer_stanowiska` = `ns`.`id`
		where `k`.`wynik_kontroli` is not null
		group by `ns`.`nazwa_portu`;

select `ns1`.`nazwa_portu`,`pz`.`ilosc` from `numer_stanowiska` `ns1`
	left join (select *,count(*) as 'ilosc' from `kontrola` `k`
		right join `numer_stanowiska` `ns` on `k`.`id_numer_stanowiska` = `ns`.`id`
		where `k`.`wynik_kontroli` is not null
		group by `ns`.`nazwa_portu`) `pz` on `ns1`.`id`=`pz`.`id_numer_stanowiska`
	group by `ns1`.`nazwa_portu`
    order by `ilosc` asc
    limit 1;
    
-- 5) Znaleźć miesiac (w przeciagu całego okresu)  w którym był największy ruch na wszystkich lotniskach / wybranym lotnisku. Użyć
-- 	date_trunc('month', timestamp '2001-02-16 20:38:40')

-- 6) Wyświetlić  ilość pasażerów w kolejnych latach dla każdego lotniska  (lotnisko sortujemy według nazwy rosnąco a póxniej według roku)
--   Lotnisko ABC   2000   300
--   Lotnisko ABC   2001   400
--   Lotnisko BCD   2000   333
--   Lotnisko CDE   2000   323
--   Lotnisko CDE   2001   332
-- szukanie unikalnych pasażerów (jeśli Jan Brzechwa przelatywał przez lotnisk dwukrotnie w danym roku, to jest liczony jeden raz)

-- MODYFIKACJA DANYCH - NIE ROBIMY, CHYBA ŻE NAM SIĘ NUDZI
-- 1) Umieścić wiersz z swoimi danymi w tablicy pasażera i dodać kontrole na lotnisku Gdańsk przez strażnika id=1 w dniu dzisiejszym
-- 2) Zmienić nazwisko strażników z 'Nowak' na 'Nowakowski' przy okazji zwiększając im pensje o 10%
-- 3) Skasować wiersz  z swoim wpisem w tablicy pasażer.
-- 4) Skasoważ strażnika który skontrolował największa liczbę pasażerów.