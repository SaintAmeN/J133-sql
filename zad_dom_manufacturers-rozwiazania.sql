-- 1.1 Select the names of all the products in the store.
select `name` from `products`;

-- 1.2 Select the names and the prices of all the products in the store.
select `name`,`price` from `products`;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
select `name`,`price`*100 as 'price in cents' from `products`;

-- 1.6 Compute the average price of all the products.
select avg(`price`) from `products`;