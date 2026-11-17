-- Q2: Put every customer into one of 5 groups
-- For each customer: days since last purchase, number of orders and net spending (sales minus returns),
-- then a simple rule assigns the group. Uses two CTEs, CASE WHEN and date maths.
-- The date '2011-12-10' is the day after the last transaction. In the notebook it is a parameter (as_of),
-- so the same query also groups customers at earlier dates for the comeback test.
-- Table: sales (see README.md in this folder)

WITH customer_totals AS (
    SELECT  customer_id,
            MAX(CASE WHEN invoice NOT LIKE 'C%' THEN invoice_date END)      AS last_purchase,
            COUNT(DISTINCT CASE WHEN invoice NOT LIKE 'C%' THEN invoice END) AS orders,
            SUM(revenue)                                                    AS net_spending
    FROM    sales
    WHERE   invoice_date < '2011-12-10'
    GROUP BY customer_id
),
with_days AS (
    SELECT  *, CAST(julianday('2011-12-10') - julianday(last_purchase) AS INTEGER) AS days_since_purchase
    FROM    customer_totals
    WHERE   orders >= 1 AND ROUND(net_spending, 2) > 0
)
SELECT  customer_id, days_since_purchase, orders, net_spending,
        CASE WHEN days_since_purchase <= 90 AND orders >= 5 THEN 'Best'
             WHEN days_since_purchase <= 90 AND orders >= 2 THEN 'Regular'
             WHEN days_since_purchase <= 90                 THEN 'New'
             WHEN days_since_purchase <= 365 AND orders >= 2 THEN 'At Risk'
             ELSE 'Inactive' END AS segment
FROM    with_days;
