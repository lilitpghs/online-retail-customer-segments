# SQL queries

The SQL used in the analysis, as standalone files. The same queries run inside the notebook ([`customer_segments.ipynb`](../customer_segments.ipynb), sections 6 to 8), where you can see their results.

| File | Business question | SQL techniques |
|---|---|---|
| [`01_customer_segments.sql`](01_customer_segments.sql) | Which group does each customer belong to? | CTEs, `CASE WHEN`, conditional aggregation, date maths (`julianday`) |
| [`02_segment_summary.sql`](02_segment_summary.sql) | How many customers are in each group and how much do they bring in? | aggregation, window functions (`SUM() OVER ()`) |
| [`03_later_purchases.sql`](03_later_purchases.sql) | Who bought again in the following 6 months? | conditional aggregation, date filters |
| [`04_at_risk_priority.sql`](04_at_risk_priority.sql) | Which At Risk customers should be contacted first? | `NTILE()` window function |

## The tables

**`sales`**: the cleaned transactions (794,163 rows), one row per product line on an invoice.

| Column | Meaning |
|---|---|
| `invoice` | invoice number (starts with `C` for a return) |
| `invoice_date` | date and time of the invoice |
| `customer_id` | customer identifier |
| `revenue` | quantity × price in £ (negative for returns) |

**`customers`**: the result of `01_customer_segments.sql`, one row per customer (5,832 rows) with `days_since_purchase`, `orders`, `net_spending` and `segment`.
