# сохраните код здесь
# сохраните код здесь

import psycopg2
import pandas as pd
import numpy as np

conn = psycopg2.connect("host='localhost' port='5432' dbname='de' user='jovyan' password='jovyan'")
# переменная conn создаёт подключение к БД
cur = conn.cursor()

cur.close()

conn.close()
