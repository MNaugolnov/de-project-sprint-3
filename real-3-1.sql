DROP TABLE IF EXISTS stage.d_city;
DROP TABLE IF EXISTS stage.d_customer;
DROP TABLE IF EXISTS stage.d_calendar;

CREATE TABLE stage.d_city (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(50)
);

INSERT INTO stage.d_city (city_id, city_name)
	SELECT DISTINCT city_id, city_name
	FROM stage.user_order_log
ON CONFLICT (city_id) DO NOTHING;

CREATE TABLE stage.d_customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city_id INT
);

INSERT INTO stage.d_customer (customer_id, first_name, last_name, city_id)
	SELECT DISTINCT customer_id, first_name, last_name, max(city_id) 
	FROM stage.user_order_log
	group by customer_id , first_name, last_name
ON CONFLICT (customer_id) DO NOTHING;


CREATE TABLE stage.d_calendar (
    date DATE PRIMARY KEY,
    day_num INT,
    month_num INT,
    month_name VARCHAR(50),
    year_num INT
);

INSERT INTO stage.d_calendar (date, day_num, month_num, month_name, year_num)
SELECT
    date::date,
    EXTRACT(DAY FROM date) AS day_num,
    EXTRACT(MONTH FROM date) AS month_num,
    TO_CHAR(date, 'Month') AS month_name,
    EXTRACT(YEAR FROM date) AS year_num
FROM generate_series(
    DATE '2020-01-01',
    DATE '2022-01-01',
    INTERVAL '1 day'
) AS t(date);
