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

WITH order_revenue AS (
    SELECT
    order_payments_fact.order_id,
    SUM(order_payments_fact.payment_value) AS total_order_revenue
    FROM
        order_payments_fact
    GROUP BY
        order_payments_fact.order_id
)
