import requests
import time
generate_report_response = requests.post(
    "https://d5dg1j9kt695d30blp03.apigw.yandexcloud.net/generate_report", # точка входа
    headers={
    "X-API-KEY": "5f55e6c0-e9e5-4a9c-b313-63c01fc31460", # ключ API
    "X-Nickname": "mikhail_naugolnov", # авторизационные данные
    "X-Cohort": "29" # авторизационные данные
    }
).json()
task_id = generate_report_response["task_id"] 

print(task_id)

time.sleep(120)


get_report_response = requests.get(
    f"https://d5dg1j9kt695d30blp03.apigw.yandexcloud.net/get_report?task_id={task_id}", 
    headers={
    "X-API-KEY": "5f55e6c0-e9e5-4a9c-b313-63c01fc31460", # ключ API
    "X-Nickname": "mikhail_naugolnov", # авторизационные данные
    "X-Cohort": "29"
    }
).json()
print(get_report_response)

task_id = 'MjAyNC0wOS0yNVQxNDo0Nzo1OAltaWtoYWlsX25hdWdvbG5vdg=='
nickname = 'mikhail_naugolnov'
cohort = '29'
