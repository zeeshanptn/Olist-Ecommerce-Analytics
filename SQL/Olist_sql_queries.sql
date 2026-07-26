-- ==========================================================
-- OLIST E-COMMERCE ANALYTICS PROJECT
-- PostgreSQL Database Setup Script
-- Author: Zeeshan Ahmad
-- ==========================================================


-- ==========================================================
-- 1. DROP EXISTING TABLES
-- ==========================================================

DROP TABLE IF EXISTS olist_order_reviews_dataset CASCADE;
DROP TABLE IF EXISTS olist_order_payments_dataset CASCADE;
DROP TABLE IF EXISTS olist_order_items_dataset CASCADE;
DROP TABLE IF EXISTS olist_orders_dataset CASCADE;
DROP TABLE IF EXISTS olist_products_dataset CASCADE;
DROP TABLE IF EXISTS olist_sellers_dataset CASCADE;
DROP TABLE IF EXISTS olist_customers_dataset CASCADE;
DROP TABLE IF EXISTS olist_geolocation_dataset CASCADE;
DROP TABLE IF EXISTS product_category_name_translation CASCADE;


-- ==========================================================
-- 2. CREATE TABLES
-- ==========================================================

CREATE TABLE olist_customers_dataset (
    customer_id TEXT PRIMARY KEY,
    customer_unique_id TEXT,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state TEXT
);

CREATE TABLE olist_geolocation_dataset (
    geolocation_zip_code_prefix TEXT,
    geolocation_lat NUMERIC,
    geolocation_lng NUMERIC,
    geolocation_city TEXT,
    geolocation_state TEXT
);

CREATE TABLE olist_products_dataset (
    product_id TEXT PRIMARY KEY,
    product_category_name TEXT,
    product_name_lenght INTEGER,
    product_description_lenght INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

CREATE TABLE olist_sellers_dataset (
    seller_id TEXT PRIMARY KEY,
    seller_zip_code_prefix TEXT,
    seller_city TEXT,
    seller_state TEXT
);

CREATE TABLE olist_orders_dataset (
    order_id TEXT PRIMARY KEY,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE olist_order_items_dataset (
    order_id TEXT,
    order_item_id INTEGER,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC
);

CREATE TABLE olist_order_payments_dataset (
    order_id TEXT,
    payment_sequential INTEGER,
    payment_type TEXT,
    payment_installments INTEGER,
    payment_value NUMERIC
);

CREATE TABLE olist_order_reviews_dataset (
    review_id TEXT,
    order_id TEXT,
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

CREATE TABLE product_category_name_translation (
    product_category_name TEXT PRIMARY KEY,
    product_category_name_english TEXT
);


-- ==========================================================
-- 3. ADD FOREIGN KEY CONSTRAINTS
-- ==========================================================

ALTER TABLE olist_orders_dataset
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES olist_customers_dataset(customer_id);

ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT fk_items_orders
FOREIGN KEY (order_id)
REFERENCES olist_orders_dataset(order_id),

ADD CONSTRAINT fk_items_products
FOREIGN KEY (product_id)
REFERENCES olist_products_dataset(product_id),

ADD CONSTRAINT fk_items_sellers
FOREIGN KEY (seller_id)
REFERENCES olist_sellers_dataset(seller_id);

ALTER TABLE olist_order_payments_dataset
ADD CONSTRAINT fk_payments_orders
FOREIGN KEY (order_id)
REFERENCES olist_orders_dataset(order_id);

ALTER TABLE olist_order_reviews_dataset
ADD CONSTRAINT fk_reviews_orders
FOREIGN KEY (order_id)
REFERENCES olist_orders_dataset(order_id);


-- ==========================================================
-- 4. IMPORT DATA
-- ==========================================================
-- Replace the file paths below with the location of the CSV
-- files on your local machine before executing the COPY commands.

COPY olist_customers_dataset
FROM '/path/to/olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY olist_geolocation_dataset
FROM '/path/to/olist_geolocation_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY olist_products_dataset
FROM '/path/to/olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY olist_sellers_dataset
FROM '/path/to/olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY olist_orders_dataset
FROM '/path/to/olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY olist_order_items_dataset
FROM '/path/to/olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY olist_order_payments_dataset
FROM '/path/to/olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY olist_order_reviews_dataset
FROM '/path/to/olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY product_category_name_translation
FROM '/path/to/product_category_name_translation.csv'
DELIMITER ','
CSV HEADER;


-- ==========================================================
-- 5. DATA VALIDATION
-- ==========================================================

SELECT
    'olist_customers_dataset' AS table_name,
    COUNT(*) AS total_records
FROM olist_customers_dataset

UNION ALL

SELECT 'olist_geolocation_dataset', COUNT(*)
FROM olist_geolocation_dataset

UNION ALL

SELECT 'olist_orders_dataset', COUNT(*)
FROM olist_orders_dataset

UNION ALL

SELECT 'olist_order_items_dataset', COUNT(*)
FROM olist_order_items_dataset

UNION ALL

SELECT 'olist_order_payments_dataset', COUNT(*)
FROM olist_order_payments_dataset

UNION ALL

SELECT 'olist_order_reviews_dataset', COUNT(*)
FROM olist_order_reviews_dataset

UNION ALL

SELECT 'olist_products_dataset', COUNT(*)
FROM olist_products_dataset

UNION ALL

SELECT 'olist_sellers_dataset', COUNT(*)
FROM olist_sellers_dataset

UNION ALL

SELECT 'product_category_name_translation', COUNT(*)
FROM product_category_name_translation;


-- ==========================================================
-- 6. SAMPLE QUERIES
-- ==========================================================

-- Preview Customer Data
SELECT *
FROM olist_customers_dataset
LIMIT 10;

-- Preview Orders
SELECT *
FROM olist_orders_dataset
LIMIT 10;

-- Preview Products
SELECT *
FROM olist_products_dataset
LIMIT 10;

-- Preview Geolocation
SELECT *
FROM olist_geolocation_dataset
LIMIT 10;