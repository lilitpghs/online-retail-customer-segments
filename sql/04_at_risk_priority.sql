-- Q4: Which At Risk customers should the team contact first?
-- Splits At Risk customers into 4 equal groups by past spending (1 = top quarter). Uses NTILE().
-- Table: customers (the result of 01_customer_segments.sql)

SELECT  customer_id, days_since_purchase, orders, ROUND(net_spending, 2) AS net_spending,
        NTILE(4) OVER (ORDER BY net_spending DESC) AS spending_group
FROM    customers
WHERE   segment = 'At Risk'
ORDER BY net_spending DESC;
