--CTE 1, Finding cohort month
WITH cohort_months AS (
    SELECT 
        customer_info.customer_unique_id,
        DATE_TRUNC('month', MIN(orders.order_purchase_timestamp)) AS cohort_month
    FROM
        orders_fact AS orders
    INNER JOIN customer_info_dim AS customer_info
        ON orders.customer_id = customer_info.customer_id
    GROUP BY
        customer_info.customer_unique_id
),

--CTE 2, using cohort month to calculate a cohort index
index AS (
    SELECT
        cm.customer_unique_id,
        cm.cohort_month,
        DATE_TRUNC('month',orders.order_purchase_timestamp) AS order_month,
        ((EXTRACT(YEAR FROM(DATE_TRUNC('month',orders.order_purchase_timestamp))) - EXTRACT(YEAR FROM cm.cohort_month)) * 12) +
        (EXTRACT(MONTH FROM(DATE_TRUNC('month',orders.order_purchase_timestamp))) - EXTRACT(MONTH FROM cm.cohort_month)) AS cohort_index
    FROM
        orders_fact AS orders
    INNER JOIN customer_info_dim AS customer_info
        ON orders.customer_id = customer_info.customer_id
    INNER JOIN cohort_months AS cm
        ON customer_info.customer_unique_id = cm.customer_unique_id
)

--Main query, retention tracking how many months until users returned after first order.
SELECT
    index.cohort_month,
    index.cohort_index,
    COUNT(DISTINCT index.customer_unique_id) AS unique_customer_count
FROM
    index
GROUP BY
    index.cohort_month,
    index.cohort_index