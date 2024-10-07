import os
import sys
import pandas as pd
import psycopg2


customer_research = pd.read_csv('/lessons/2. Анализ вводных по задаче/7. Использование файлов и подключение к БД/Задание 1/stage/customer_research.csv')
user_orders_log = pd.read_csv('/lessons/2. Анализ вводных по задаче/7. Использование файлов и подключение к БД/Задание 1/stage/user_order_log.csv')
user_activity_log = pd.read_csv('/lessons/2. Анализ вводных по задаче/7. Использование файлов и подключение к БД/Задание 1/stage/user_activity_log.csv')


conn = psycopg2.connect("host='localhost' port='5432' dbname='de' user='jovyan' password='jovyan'")
# переменная conn создаёт подключение к БД
cur = conn.cursor()

sql1 = '''COPY stage.customer_research(id, date_id, category_id, geo_id, sales_qty, sales_amt)
FROM '/lessons/2. Анализ вводных по задаче/7. Использование файлов и подключение к БД/Задание 1/stage/customer_research.csv' 
DELIMITER ',' 
CSV HEADER;'''
cur.execute(sql1)
conn.commit()

sql2 = '''COPY stage.user_activity_log(id, date_time, action_id, customer_id, quantity)
FROM '/lessons/2. Анализ вводных по задаче/7. Использование файлов и подключение к БД/Задание 1/stage/user_activity_log.csv' 
DELIMITER ',' 
CSV HEADER;'''
cur.execute(sql2)
conn.commit()

sql3 = '''COPY stage.user_order_log(id, date_time, city_id, city_name, customer_id, first_name, last_name, item_id, item_name, quantity, payment_amount)
FROM '/lessons/2. Анализ вводных по задаче/7. Использование файлов и подключение к БД/Задание 1/stage/user_order_log.csv' 
DELIMITER ',' 
CSV HEADER;'''
cur.execute(sql3)
conn.commit()

cur.close()
conn.close()
