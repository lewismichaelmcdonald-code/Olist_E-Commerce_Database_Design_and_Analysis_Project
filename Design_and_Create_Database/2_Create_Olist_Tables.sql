CREATE TABLE customer_info_dim (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code INT,
    customer_city TEXT,
    customer_state CHAR(2)
);

CREATE TABLE geolocation_dim (
    geolocation_zip_code_prefix INT,
    geolocation_lat NUMERIC(11,8),
    geolocation_lng NUMERIC(11,8),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);

CREATE TABLE order_items_fact (
    order_id VARCHAR(50),
    order_item INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (order_id,product_id)
);

CREATE TYPE payment_options AS ENUM ('credit_card', 'debit_card', 'voucher', 'boleto', 'not_defined');

CREATE TABLE fact_order_payments (
    order_id VARCHAR(50) REFERENCES fact_orders(order_id),
    payment_sequential INT,
    payment_type payment_options,
    payment_installments INT, 
    payment_value NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY (order_id, payment_sequential)
);