-- Количество покупателей
SELECT COUNT(*) AS customers_count
FROM customers;

-- Количество заказов и общая сумма
SELECT
    COUNT(*) AS orders_count,
    SUM(amount) AS orders_total
FROM orders;

-- SHA-256 покупателей
SELECT
    encode(
        sha256(
            convert_to(
                string_agg(
                    customer_id || '|' ||
                    full_name || '|' ||
                    email,
                    E'\n' ORDER BY customer_id
                ),
                'UTF8'
            )
        ),
        'hex'
    ) AS customers_sha256
FROM customers;

-- SHA-256 заказов
SELECT
    encode(
        sha256(
            convert_to(
                string_agg(
                    order_id || '|' ||
                    customer_id || '|' ||
                    amount || '|' ||
                    to_char(created_at, 'YYYY-MM-DD HH24:MI:SS'),
                    E'\n' ORDER BY order_id
                ),
                'UTF8'
            )
        ),
        'hex'
    ) AS orders_sha256
FROM orders;