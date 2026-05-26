CREATE TABLE customer_info_dim (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code INT,
    customer_city TEXT,
    customer_state CHAR(2)
);

CREATE TABLE geolocation_dim (
    geolocation_zip_code_prefix INT,
    geolocation_lat NUMERIC(11,8) NOT NULL,
    geolocation_lng NUMERIC(11,8) NOT NULL,
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);

CREATE TABLE product_info_dim (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g NUMERIC(10,2),
    product_length_cm NUMERIC(10,2),
    product_height_cm NUMERIC(10,2),
    product_width_cm NUMERIC(10,2)
);

CREATE TABLE sellers_dim (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);

CREATE TABLE product_category_name_dim (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100),
    PRIMARY KEY (product_category_name, product_category_name_english)
);

CREATE TYPE order_tracking AS ENUM ('delivered','invoiced','shipped','processing','unavailable','canceled','created','approved');

CREATE TABLE orders_fact (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) REFERENCES customer_info_dim(customer_id),
    order_status order_tracking,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP 
);

CREATE TABLE order_items_fact (
    order_id VARCHAR(50) REFERENCES orders_fact(order_id),
    order_item_id INT,
    product_id VARCHAR(50) REFERENCES product_info_dim(product_id),
    seller_id VARCHAR(50) REFERENCES sellers_dim(seller_id),
    shipping_limit_date TIMESTAMP, 
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (order_id, order_item_id)
);

CREATE TYPE payment_options AS ENUM ('credit_card', 'debit_card', 'voucher', 'boleto', 'not_defined');

CREATE TABLE order_payments_fact ( 
    order_id VARCHAR(50) REFERENCES orders_fact(order_id),
    payment_type payment_options,
    payment_installments INT, 
    payment_value NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE reviews_dim (
    review_id VARCHAR(50),
    order_id VARCHAR(50) REFERENCES orders_fact(order_id),
    review_score INT NOT NULL CHECK (review_score BETWEEN 1 AND 5),
    review_comment_title VARCHAR(50),
    review_comment_message VARCHAR(500),
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    PRIMARY KEY (review_id, order_id)
);