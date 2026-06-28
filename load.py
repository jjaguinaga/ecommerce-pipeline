import pandas as pd
import psycopg2

def load_data():
   customers = pd.read_csv('store_data/customers.csv')
   order_items = pd.read_csv('store_data/order_items.csv')
   orders = pd.read_csv('store_data/orders.csv')
   products = pd.read_csv('store_data/products.csv')
   reviews = pd.read_csv('store_data/reviews.csv')

   conn = psycopg2.connect(dbname='ecommerce', user='naga', host='localhost')
   cur = conn.cursor()
   
   cur.execute('DROP TABLE IF EXISTS customers CASCADE;')
   cur.execute('DROP TABLE IF EXISTS order_items CASCADE;')
   cur.execute('DROP TABLE IF EXISTS orders CASCADE;')
   cur.execute('DROP TABLE IF EXISTS products CASCADE;')
   cur.execute('DROP TABLE IF EXISTS reviews CASCADE;')
   
   cur.execute('''
               CREATE TABLE customers (
                  customer_id INTEGER,
                  first_name TEXT,
                  last_name TEXT,
                  email TEXT,
                  state TEXT,
                  city TEXT,
                  signup_date DATE,
                  segment TEXT,
                  is_active BOOLEAN
               )''')
   
   for _, row in customers.iterrows():
      cur.execute(
         'INSERT INTO customers VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)',
         tuple(row)
      )
      
   cur.execute('''
               CREATE TABLE order_items (
                  item_id INTEGER,
                  order_id INTEGER,
                  product_id INTEGER,
                  quantity INTEGER,
                  unit_price FLOAT,
                  discount_pct FLOAT,
                  line_total FLOAT
                  )''')
   
   for _, row in order_items.iterrows():
      cur.execute(
         'INSERT INTO order_items VALUES (%s, %s, %s, %s, %s, %s, %s)',
         tuple(row)
      )
      
   cur.execute('''
               CREATE TABLE orders (
                  order_id INTEGER,
                  customer_id INTEGER,
                  order_date DATE,
                  status TEXT,
                  shipping_state TEXT,
                  shipping_method TEXT
                  )''')
   
   for _, row in orders.iterrows():
      cur.execute(
         'INSERT INTO orders VALUES (%s, %s, %s, %s, %s, %s)',
         tuple(row)
      )
      
   cur.execute('''
               CREATE TABLE products (
                  product_id INTEGER,
                  product_name TEXT,
                  category TEXT,
                  price FLOAT,
                  stock_quantity INTEGER,
                  is_available BOOLEAN
                  )''')
   
   for _, row in products.iterrows():
      cur.execute(
         'INSERT INTO products VALUES (%s, %s, %s, %s, %s, %s)',
         tuple(row)
      )
      
   cur.execute('''
               CREATE TABLE reviews (
                  review_id INTEGER,
                  customer_id INTEGER,
                  product_id INTEGER,
                  rating INTEGER,
                  review_date DATE,
                  verified_purchase BOOLEAN
                  )''')
   
   for _, row in reviews.iterrows():
      cur.execute(
         'INSERT INTO reviews VALUES (%s, %s, %s, %s, %s, %s)',
         tuple(row)
      )
      
   conn.commit()
   cur.close()
   conn.close()
   
if __name__ == '__main__':
   load_data()
   print('Data loaded!')