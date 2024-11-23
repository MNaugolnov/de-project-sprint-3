-- Уважаемый ревьюер! Пожалуйста, извини за наглость, но я не могу самостоятельно до конца разобраться с тем, что нужно сделать в проекте.
-- Буду очень благодарен, если кратко подскажешь, что еще надо сделать. И как написать правильный SQL-запрос на заполнение новой витрины.

INSERT INTO mart.f_customer_retention (
    new_customers_count, 
    returning_customers_count, 
    refunded_customer_count, 
    period_name, 
    period_id, 
    item_id, 
    new_customers_revenue, 
    returning_customers_revenue, 
    customers_refunded
)
SELECT 
    -- Подсчёт новых клиентов (сделавших только один заказ)
    COUNT(DISTINCT CASE 
                    WHEN order_count = 1 THEN customer_id 
                    ELSE NULL 
                  END) AS new_customers_count,
    
    -- Подсчёт возвращающихся клиентов (сделавших больше одного заказа)
    COUNT(DISTINCT CASE 
                    WHEN order_count > 1 THEN customer_id 
                    ELSE NULL 
                  END) AS returning_customers_count,
    
    -- Подсчёт клиентов, которые оформили возврат
    COUNT(DISTINCT CASE 
                    WHEN refunded_count > 0 THEN customer_id 
                    ELSE NULL 
                  END) AS refunded_customer_count,
    
    -- Установим период как "weekly"
    'weekly' AS period_name,
    
    -- Период: номер недели
    EXTRACT(week FROM o.date_time) AS period_id,
    
    -- Идентификатор товара
    o.item_id,
    
    -- Доход с новых клиентов
    SUM(CASE 
            WHEN order_count = 1 THEN o.payment_amount 
            ELSE 0 
        END) AS new_customers_revenue,
    
    -- Доход с вернувшихся клиентов
    SUM(CASE 
            WHEN order_count > 1 THEN o.payment_amount 
            ELSE 0 
        END) AS returning_customers_revenue,
    
    -- Количество возвратов
    SUM(CASE 
            WHEN o.status = 'refunded' THEN 1 
            ELSE 0 
        END) AS customers_refunded

FROM (
    SELECT 
        customer_id, 
        item_id, 
        COUNT(DISTINCT uniq_id) AS order_count, 
        SUM(payment_amount) AS payment_amount,
        SUM(CASE WHEN status = 'refunded' THEN 1 ELSE 0 END) AS refunded_count,
        date_time
    FROM staging.user_order_log
    WHERE status IN ('shipped', 'refunded')
    GROUP BY customer_id, item_id, EXTRACT(week FROM date_time), EXTRACT(year FROM date_time)
) o
GROUP BY period_id, o.item_id
ORDER BY period_id, o.item_id;
