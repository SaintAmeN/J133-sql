USE `codeme_homework`;
-- 1. Wyświetl strukturę tabeli employees.
desc `employees`;

-- 2. Wyświetl zawartość tabeli employees.
select * from `employees`;

-- 3. Wyświetl imiona, nazwiska oraz pensje pracowników.
select `first_name`,`last_name`,`salary` from `employees`;

-- 4. Wyświetl imiona, nazwiska pracowników. Nadaj aliasy „imie", „nazwisko" odpowiednim kolumnom.
select `first_name` as 'Imie',`last_name` as 'Nazwisko' from `employees`;

-- 5. Popraw błędy w zapytaniach:
-- select * from depart;
select * from `departments`;

-- select name, from employees;
select `first_name` from `employees`;

-- select hire_date as 'data zatrudnienia' from employees;
select `hire_date` as 'data zatrudnienia' from `employees`;

-- select name nazwisko pracownika from employees;
select `last_name` as 'nazwisko pracownika' from `employees`;