-- однократные действия в dbeaver
DROP TABLE IF EXISTS mart.f_customer_retention;

CREATE TABLE mart.f_customer_retention (
    new_customers_count INT,          -- Количество новых клиентов
    returning_customers_count INT,    -- Количество вернувшихся клиентов
    refunded_customer_count INT,      -- Количество клиентов с возвратами
    period_name VARCHAR(10),          -- Название периода, например, 'weekly'
    period_id INT,                    -- Идентификатор периода (номер недели или месяца)
    item_id INT,                      -- Идентификатор товара (категории товара)
    new_customers_revenue DECIMAL(10, 2),  -- Доход с новых клиентов (сумма)
    returning_customers_revenue DECIMAL(10, 2), -- Доход с вернувшихся клиентов (сумма)
    customers_refunded INT            -- Количество возвратов от клиентов
);