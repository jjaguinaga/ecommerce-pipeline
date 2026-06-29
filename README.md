# E-Commerce EL Pipeline with SQL Analytics

**EL pipeline using SQL to help an e-commerce store find revenue trend from past 12 months, top spenders and other related questions using five csv files.**

---

## Motivation

This project was built to help an e-commerce store answer questions about customer behavior, product performance and revenue trends. This project uses csv files to build a database and relational tables then uses SQL to answer those questions.

--- 

## What this Project Does

This pipeline extracts data from five csv files consisting of customers, products, orders and others. It stores it all in a relational database and produces SQL views that allows analysts to explore product performance and revenue. 

--- 

## Key Findings 

**Which product category produces the most revenue** The 'revenue_by_category' view shows that electronics produced the most revenue. This view is set up as categories and their total revenue for the data given.


**Which customer segment spends the most** The 'customers_per_segment' view shows that customers under the regular segment accounted for most total revenue since it has a bigger customer base compared to other segments.


**Top spending state** The 'state_most_orders' view shows that Texas was the top spending state across the board. 


**Top five products sold** The 'top_5_products' view shows that mascara, resistance bands, dish rack, mechanical keyboard and water filter were the top products sold. 

## Architecture

```
CSV Files (faker-generated synthetic data)
↓
load.py → PostgreSQL (relational database with 5 tables)
↓
analytics.sql → SQL views (business insights)
```

---

## Tech Stack

| Tool | Purpose |
|---|---|
| Python | Core pipeline logic |
| Pandas | Reading and loading CSV files |
| PostgreSQL | Relational database |
| Psycopg2 | PostgreSQL connection |
| SQL | Analytics views |
| Git | Version control |

---

## Project Structure 

```
store-pipeline/
├── store_data
      ├── customers.csv
      ├── order_items.csv
      ├── orders.csv
      ├── products.csv
      └── reviews.csv
├── load.py
├── README.md
└── analytics.sql
```

---

## How to Run 

1. Clone the repo
2. Install dependencies:
```bash
pip install pandas psycopg2-binary
```
3. Make sure PostgreSQL is running locally
4. Create the PostgreSQL database:
```sql
CREATE DATABASE ecommerce;
```
5. Run the pipeline:
```bash
python3 load.py
```
6. Open TablePlus or any SQL client, connect to the `ecommerce` database, and run the views in `analytics.sql`
