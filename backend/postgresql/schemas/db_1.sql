DROP SCHEMA IF EXISTS sport_goods CASCADE;

CREATE SCHEMA IF NOT EXISTS sport_goods;

CREATE TABLE IF NOT EXISTS sport_goods.customers (
    id serial PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS sport_goods.categories (
    id serial PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS sport_goods.products (
    id serial PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    category_id INTEGER NOT NULL REFERENCES sport_goods.categories (id),
    price DECIMAL(10, 2) NOT NULL,
    quantity INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS sport_goods.orders (
  id serial PRIMARY KEY,
  customers_id INTEGER NOT NULL REFERENCES sport_goods.customers (id),
  date TIMESTAMPTZ NOT NULL DEFAULT now(),
  status TEXT NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS sport_goods.order_items (
    product_id INTEGER NOT NULL REFERENCES sport_goods.products (id),
    order_id INTEGER NOT NULL REFERENCES sport_goods.orders (id),
    quantity INTEGER NOT NULL
);
