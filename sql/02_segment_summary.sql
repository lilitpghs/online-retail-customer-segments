-- Q2: How many customers are in each group and how much do they bring in?
-- Share of customers and share of revenue per group. Uses window functions (SUM() OVER ()).
-- Table: customers (the result of 01_customer_segments.sql)

SELECT  segment,
        COUNT(*)                                                AS customers,
        ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1)      AS pct_of_customers,
        ROUND(SUM(net_spending), 0)                             AS revenue,
        ROUND(100.0 * SUM(net_spending) / SUM(SUM(net_spending)) OVER (), 1) AS pct_of_revenue,
        ROUND(AVG(net_spending), 0)                             AS avg_spending,
        ROUND(AVG(orders), 1)                                   AS avg_orders,
        ROUND(AVG(days_since_purchase), 0)                      AS avg_days_since_purchase
FROM    customers
GROUP BY segment;
