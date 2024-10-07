import os
import sys
import pandas as pd

url1 = "https://storage.yandexcloud.net/s3-sprint3/cohort_29/mikhail_naugolnov/TWpBeU5DMHhNQzB3TjFReU1Eb3pORG95T0FsdGFXdG9ZV2xzWDI1aGRXZHZiRzV2ZGc9PQ==/customer_research.csv"
url2 = "https://storage.yandexcloud.net/s3-sprint3/cohort_29/mikhail_naugolnov/TWpBeU5DMHhNQzB3TjFReU1Eb3pORG95T0FsdGFXdG9ZV2xzWDI1aGRXZHZiRzV2ZGc9PQ==/user_order_log.csv"
url3 = "https://storage.yandexcloud.net/s3-sprint3/cohort_29/mikhail_naugolnov/TWpBeU5DMHhNQzB3TjFReU1Eb3pORG95T0FsdGFXdG9ZV2xzWDI1aGRXZHZiRzV2ZGc9PQ==/user_activity_log.csv"


c1 = pd.read_csv(url1)
print(c1.head())
c1.to_csv('/lessons/2. Анализ вводных по задаче/7. Использование файлов и подключение к БД/Задание 1/stage/customer_research.csv')

c2 = pd.read_csv(url2)
print(c2.head())
c2 = c2.drop(['uniq_id','id'], axis=1)
c2.to_csv('/lessons/2. Анализ вводных по задаче/7. Использование файлов и подключение к БД/Задание 1/stage/user_order_log.csv')

c3 = pd.read_csv(url3)
print(c3.head())
c3 = c3.drop(['uniq_id','id'], axis=1)

c3.to_csv('/lessons/2. Анализ вводных по задаче/7. Использование файлов и подключение к БД/Задание 1/stage/user_activity_log.csv')
