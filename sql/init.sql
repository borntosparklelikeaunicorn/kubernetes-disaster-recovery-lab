BEGIN;

-- Таблица покупателей
CREATE TABLE IF NOT EXISTS customers (
    customer_id INTEGER PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);

-- Таблица заказов
CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    amount NUMERIC(12, 2) NOT NULL,
    created_at TIMESTAMP NOT NULL,

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- Создаём 100 покупателей
INSERT INTO customers (
    customer_id,
    full_name,
    email
)
SELECT
    i,
    'Покупатель ' || i,
    'customer' || i || '@example.test'
FROM generate_series(1, 100) AS s(i)
ON CONFLICT (customer_id) DO NOTHING;

-- Создаём 1000 заказов
INSERT INTO orders (
    order_id,
    customer_id,
    amount,
    created_at
)
SELECT
    i,
    ((i - 1) % 100) + 1,
    ROUND(((i * 37) % 10000)::NUMERIC / 100 + 1, 2),
    TIMESTAMP '2026-01-01 00:00:00'
        + i * INTERVAL '1 hour'
FROM generate_series(1, 1000) AS s(i)
ON CONFLICT (order_id) DO NOTHING;

COMMIT;