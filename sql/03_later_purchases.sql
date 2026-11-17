-- Q3: Do the groups tell us who will buy again?
-- Orders and spending in the 6 months after the test date (9 June 2011). In the notebook, these results
-- are joined to the groups made with data up to 9 June 2011, to see which groups came back.
-- Table: sales

SELECT  customer_id,
        COUNT(DISTINCT CASE WHEN invoice NOT LIKE 'C%' THEN invoice END) AS later_orders,
        SUM(revenue) AS later_spending
FROM    sales
WHERE   invoice_date >= '2011-06-09' AND invoice_date < '2011-12-09'
GROUP BY customer_id;
