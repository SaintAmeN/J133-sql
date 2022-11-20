-- 6. Wyświetl imiona i nazwiska pracowników w jednej kolumnie (konkatenacja).
select concat(`first_name`, ' ', `last_name`) from `employees`;

-- 7. Wyświetl alfabetyczną listę pracowników.
select `last_name` from `employees` order by `last_name` desc;
select `last_name` from `employees` order by `last_name` asc;

-- 8. Wyświetl nazwiska pracowników w porządku malejącym.
select `last_name` from `employees` order by `last_name` desc;

-- 9. Wyświetl nazwiska i pensje pracowników w porządku malejącym wg pensji.
select `last_name`,`salary` from `employees` order by `salary` desc;

-- 10. Wyświetl imiona, nazwiska i pensje pracowników w porządku rosnącym wg pensji i malejącym wg nazwisk.
select `first_name`,`last_name`,`salary` from `employees` order by `salary` asc, `last_name` desc;

-- 11. Wyświetl listę nazwisk. W wyniku nie mogą pojawić się duplikaty nazwisk.
select distinct `last_name` from `employees`;

-- 12. Wyświetl dane pracowników o nazwisku King.
select * from `employees` where `last_name`='King';

-- 13. Wyświetl nazwiska pracowników, którzy zarabiają poniżej 5000.
select `last_name` from `employees` where `salary` < 5000;

-- 14. Wyświetl imiona i nazwiska pracowników, których pensja znajduje się w przedziale [2000, 7 000].
SELECT `first_name`,`last_name` FROM `employees` where `salary` between 2000 and 7000;
SELECT `last_name` FROM `employees` where `salary`>2000 AND `salary`<7000;

-- 15. Wyświetl bez duplikatów identyfikatory stanowisk z tabeli employees.
SELECT DISTINCT `job_id` FROM `employees`;

-- 16. Wyświetl imię, nazwisko oraz datę zatrudnienia wszystkich pracowników, których pensja 
-- nie znajduje się w przedziale [5000, 10 000]. Wyniki posortuj rosnąco wg pensji.
SELECT `first_name`,`last_name`, `hire_date` FROM `employees` where `salary`not between 5000 and 10000 order by `salary` asc;
SELECT `first_name`,`last_name`, `hire_date` FROM `employees` where `salary`< 5000 or `salary` > 10000 order by `salary` asc;

-- 17. Wyświetl dane osób o identyfikatorach 100, 102, 105 i 107.
SELECT * FROM `employees` WHERE `employee_id` IN (100, 102, 105, 107);
SELECT * FROM `employees` WHERE `employee_id` = 100 
								or `employee_id` = 102 
								or `employee_id` = 105 
								or `employee_id` = 107;

-- 18. Wyświetl nazwisko, pensję i premię pracowników, których nazwisko zaczyna się na literę ‘K’.
SELECT `first_name`,`last_name` FROM `employees` WHERE `last_name` LIKE 'K%';

-- 19. Wyświetl imiona i nazwiska pracowników, w których nazwisku występuje litera ‘i’, ‘a’ lub ‘o’.
SELECT `first_name`, `last_name` FROM `employees` WHERE 
									`last_name` LIKE '%i%' or 
                                    `last_name` LIKE '%a%' or 
                                    `last_name` LIKE '%o%';

-- 20. Wyświetl imiona i nazwiska pracowników zatrudnionych w oddziale o identyfikatorze 60.
SELECT `first_name`,`last_name` FROM `employees` where `department_id`= 60;

-- 21. Wyświetl dane pracowników, którzy nie mają premii.
select * from `employees` where `commission_pct` is null;

-- 22. Wyświetl imiona i nazwiska pracowników, których druga litera imienia to ‘a’.
SELECT `first_name`,`last_name` FROM `employees` where `first_name` like '_a%';

-- 23. Wyświetl bez duplikatów identyfikatory oddziałów z tabeli employees.
SELECT DISTINCT `department_id` FROM `employees` where `department_id` is not null;

-- 24. Wyświetl imiona, nazwiska i pensje pracowników, którzy zarabiają powyżej 10000.
SELECT `first_name`,`last_name`, `salary` FROM `employees` where `salary`>10000;

-- 25. Wyświetl imiona, nazwiska i pensje powiększone o 20% pracowników zatrudnionych w oddziale o 
-- identyfikatorze 50.
SELECT `first_name`,`last_name`, `salary`*1.2 FROM `employees` where `department_id`=50;

-- 26. Wyświetl dane pracowników zatrudnionych w oddziale o identyfikatorze 100.
SELECT * FROM `employees` where `department_id`=100;

-- 27. Wyświetl dane oddziałów o identyfikatorze lokalizacji większym od 2000.
SELECT * FROM `departments` where `location_id`>2000;

-- 28. Wyświetl dane lokalizacji znajdujących się w miastach, których nazwy rozpoczynają się na literę ‘S’.
SELECT * FROM `locations` where `city`like 'S%';

-- 29. Wyświetl bez duplikatów identyfikatory krajów z tabeli countries.
SELECT DISTINCT `country_id` FROM `countries`;

-- 30. Wyświetl nazwy krajów posortowane w porządku rosnącym.
SELECT `country_name` FROM `countries` order by `country_name` asc;

-- 31. Wyświetl nazwiska, daty zatrudnienia pracowników, 
-- pensje i pensje po podwydepartmentsdepartmentsżce ( powiększone o 1000) nadaj kolumnom aliasy.
SELECT 	`FIRST_NAME` AS 'imie', 
		`HIRE_DATE` AS 'zatrudnienie', 
        `SALARY` AS 'wyplata', 
        `SALARY`+1000 AS 'wyplata po podwyzce' FROM `employees`;

