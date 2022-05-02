-- # 1. Узнайте какие телефоны из Kivano стоят столько же сколько и компьютеры из Sulpak.

-- SELECT DISTINCT
-- kivano.product_name,
-- kivano.price,
-- sulpak.product_name,
-- sulpak.price
-- FROM kivano INNER JOIN sulpak
-- ON kivano.price = sulpak.price
-- WHERE kivano.category_id = 1
-- AND sulpak.category_id = 2;

----------------------------------------

-- #2. Узнайте самую последнюю модель Iphone в магазинах.

-- SELECT
-- kivano.product_name as kivano,
-- produsers.prodused_date,
-- sulpak.product_name as sulpak,
-- produsers.prodused_date
-- FROM kivano
-- INNER JOIN produsers
-- ON produsers.produser_id = kivano.produser_id
-- INNER JOIN sulpak
-- ON produsers.produser_id = sulpak.produser_id
-- WHERE kivano.product_name LIKE '%Iphone%'
-- AND sulpak.product_name LIKE '%Iphone%'
-- ORDER BY produsers.prodused_date DESC LIMIT 1;

----------------------------------------

-- #3.Выведите на экран список всех ноутбуков из sulpak и только тех телефонов которые имеют одинаковую дату выхода с компьютером из таблицы kivano.

-- (SELECT DISTINCT
-- category_id,
-- product_name
-- FROM sulpak
-- WHERE category_id = 2)

-- UNION

-- (SELECT DISTINCT
-- sulpak.category_id,
-- sulpak.product_name
-- FROM sulpak INNER JOIN kivano
-- ON sulpak.produser_id = kivano.produser_id
-- AND sulpak.category_id = 1 
-- AND kivano.category_id = 2);

----------------------------------------

-- #4.Выведите все китайские продукты.

-- SELECT DISTINCT 
-- kivano.product_name,
-- produsers.produser_country
-- FROM kivano
-- INNER JOIN produsers
-- ON produsers.produser_country = 'China';

----------------------------------------

-- #5.Напишите запрос, который выводит продукты любого магазина в порядке их добавления.

-- SELECT item_id, product_name, price 
-- FROM kivano
-- ORDER BY item_id;

----------------------------------------

-- #6.Найдите товары, которые есть в kivano но нет в sulpak.

-- SELECT DISTINCT kivano.product_name 
-- FROM kivano
-- WHERE kivano.product_name NOT IN (
--     SELECT sulpak.product_name FROM sulpak
-- );

----------------------------------------

-- # 7. Найдите все товары в магазине sulpak, где компания-производитель содержит букву "m" в имени.

-- SELECT 
-- sulpak.product_name,
-- produsers.produser_company
-- FROM sulpak
-- INNER JOIN produsers
-- ON produsers.produser_id = sulpak.produser_id
-- WHERE produsers.produser_company
-- LIKE '%m%';

----------------------------------------

-- # 8. Найдите товары, которые есть и в kivano u sulpak.

-- SELECT DISTINCT
-- kivano.product_name,
-- sulpak.product_name
-- FROM sulpak
-- INNER JOIN kivano
-- ON kivano.product_name = sulpak.product_name;

----------------------------------------

-- # 9. Найдите китайские товары из kivano, которые в названии содержат "k".

-- SELECT kivano.product_name
-- FROM kivano
-- INNER JOIN produsers
-- ON produsers.produser_id = kivano.produser_id
-- WHERE produsers.produser_country =
-- 'China' AND kivano.product_name LIKE '%k%';

----------------------------------------

-- # 10. Найдите самый последний добавленный товар в таблице produsers, и поменяйте компанию на Apple, и страну на kyrgyzstan.

-- UPDATE produsers
-- SET produser_company = 'Apple',
-- produser_country = 'Kyrgyzstan'
-- WHERE prodused_date = (
--     SELECT MAX(prodused_date) from produsers
-- );

----------------------------------------

-- #11.Нужно объеденить 2 магазина по product_name и вывести на экран имя продукта и его цену из обоих магазинов, однако не факт что в обоих магазинах будут одинаковые товары, поэтому нужно joinить по полной.

-- SELECT
-- kivano.product_name,
-- kivano.price,
-- kivano.product_name,
-- kivano.price
-- FROM kivano
-- FULL OUTER JOIN sulpak
-- ON kivano.product_name = sulpak.product_name;

----------------------------------------

-- # 12. Найдите самый последний японский товар который был добавлен в produsers.

-- SELECT * FROM produsers
-- WHERE produser_country = 'Japan'
-- ORDER BY created_at DESC LIMIT 1;

----------------------------------------

-- #13.Напишите запрос, который прибавит 1000 к цене всех продуктов в sulpak.

-- UPDATE sulpak
-- SET price = price + 1000;

----------------------------------------

-- #14.Узнать разницу между самой высокой ценой в sulpak и самой низкой ценой товар в kivano.

-- SELECT 
-- MAX(price) AS MAX,
-- MIN(price) AS MIN,
-- MAX(price) - MIN(price) AS DIFFERENT
-- FROM kivano;

----------------------------------------

-- #15.Выведите на экран цены самых дешёвых телефонов из обоих магазинов.

-- SELECT DISTINCT
-- product_name, price
-- FROM kivano
-- WHERE category_id = 1
-- AND price = 
-- (SELECT MIN(price) FROM kivano)
-- UNION
-- SELECT
-- product_name, price
-- FROM sulpak
-- WHERE category_id = 1
-- AND price = 
-- (SELECT MIN(price) FROM sulpak);

----------------------------------------

-- #16.Удалить все записи где есть NULL в product_name в обоих магазинах.

-- DELETE FROM sulpak
-- WHERE product_name = NULL;

-- DELETE FROM kivano
-- WHERE product_name = NULL;

----------------------------------------

-- #17. Все телефоны у которых год меньше 1998 изменить на 2000 (Выполнить с помощью psycopg2).

-- Тащите сюда плюсик)

----------------------------------------

-- # 18. Acer закрыл свою фабрику в Бразилии после 2012 года и переехал в Германию, у всех записей в produsers где Acer был произведен в Brazil после 2012 поставьте Germany.

-- UPDATE produsers
-- SET produser_country = 'Germany'
-- WHERE produser_company = 'Acer' 
-- AND prodused_date > '2012-1-1';

----------------------------------------

-- #19.Выведите первые 16 записей без id, из kivano.

-- SELECT product_name FROM kivano
-- WHERE item_id < 17
-- ORDER BY item_id;

----------------------------------------

-- #20.Выведите на экран все product_name которые относятся к категории laptops в kivano.

-- SELECT COUNT(product_name)
-- FROM kivano
-- WHERE category_id = 2;

----------------------------------------

-- #21.Найдите товары в sulpak, цена которых больше среднего на 2000 и меньше средний на 2000

-- SELECT product_name, price FROM sulpak
-- WHERE 
-- price > (SELECT AVG(price) FROM sulpak) + 2000
-- OR
-- price < (SELECT AVG(price) FROM sulpak) - 2000;

----------------------------------------

-- #22.Найдите product_company, чьи товары дороже среднего в kivano.

-- SELECT produsers.produser_company 
-- FROM produsers
-- INNER JOIN kivano
-- ON kivano.produser_id = produsers.produser_id
-- WHERE kivano.price > (
--     SELECT AVG(price) FROM kivano
-- );

----------------------------------------

-- #23.Найдите товар который лежит посередине в таблице sulpak.

-- SELECT * FROM sulpak
-- WHERE item_id = (
--     SELECT ROUND(AVG(item_id), -1) FROM sulpak
-- );

----------------------------------------

-- # 24. Поменяйте страну на South Korea везде где страна Korea и компания Asus.

-- UPDATE produsers
-- SET produser_country = 'South Korea'
-- WHERE produser_company = 'Asus' 
-- AND produser_country = 'Korea';

----------------------------------------

-- # 25. В producers поменяйте Nokia на Microsoft везде где у компании Nokia указана страна USA.

-- UPDATE produsers
-- SET produser_company = 'Microsoft'
-- WHERE produser_company = 'Nokia' 
-- AND produser_country = 'USA';