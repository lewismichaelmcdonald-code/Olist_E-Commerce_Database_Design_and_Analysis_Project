COPY customer_info_dim
FROM 'C:\Users\lewis\Desktop\Olist_E-Commerce_Database_Design_and_Analysis_Project\csv_files\customer_info_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY geolocation_dim
FROM 'C:\Users\lewis\Desktop\Olist_E-Commerce_Database_Design_and_Analysis_Project\csv_files\geolocation_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY product_info_dim
FROM 'C:\Users\lewis\Desktop\Olist_E-Commerce_Database_Design_and_Analysis_Project\csv_files\product_info_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY sellers_dim
FROM 'C:\Users\lewis\Desktop\Olist_E-Commerce_Database_Design_and_Analysis_Project\csv_files\sellers_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY product_category_name_dim
FROM 'C:\Users\lewis\Desktop\Olist_E-Commerce_Database_Design_and_Analysis_Project\csv_files\product_category_name_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY orders_fact
FROM 'C:\Users\lewis\Desktop\Olist_E-Commerce_Database_Design_and_Analysis_Project\csv_files\orders_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY order_items_fact
FROM 'C:\Users\lewis\Desktop\Olist_E-Commerce_Database_Design_and_Analysis_Project\csv_files\order_items_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY order_payments_fact
FROM 'C:\Users\lewis\Desktop\Olist_E-Commerce_Database_Design_and_Analysis_Project\csv_files\order_payments_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY reviews_dim
FROM 'C:\Users\lewis\Desktop\Olist_E-Commerce_Database_Design_and_Analysis_Project\csv_files\reviews_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');