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
        orders.order_id,
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
),

--CTE 3, calculating total revenue or each order
order_revenue AS (
    SELECT
    order_payments_fact.order_id,
    SUM(order_payments_fact.payment_value) AS total_order_revenue
    FROM
        order_payments_fact
    GROUP BY
        order_payments_fact.order_id
),

-- CTE 4: Calculate the total starting size of each cohort
cohort_sizes AS (
    SELECT 
        cohort_month,
        COUNT(DISTINCT customer_unique_id) AS total_starting_customers
    FROM 
        cohort_months
    GROUP BY 
        cohort_month
)

-- Main query link cohort index with order revenue and cohort sizes
SELECT
    index.cohort_month,
    cs.total_starting_customers,
    index.cohort_index,
    SUM(order_revenue.total_order_revenue) AS total_revenue,
    COUNT(DISTINCT index.order_id) AS total_orders 
FROM
    index
INNER JOIN order_revenue
    ON index.order_id = order_revenue.order_id
INNER JOIN cohort_sizes AS cs 
    ON index.cohort_month = cs.cohort_month
GROUP BY
    index.cohort_month,
    cs.total_starting_customers,
    index.cohort_index
ORDER BY
    index.cohort_month ASC,
    index.cohort_index ASC;