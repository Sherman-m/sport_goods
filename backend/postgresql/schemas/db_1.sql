DROP SCHEMA IF EXISTS sport_goods CASCADE;

CREATE SCHEMA IF NOT EXISTS sport_goods;

CREATE TABLE IF NOT EXISTS sport_goods.orders (
    id serial PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    date TIMESTAMPTZ NOT NULL DEFAULT now()
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
    image_url TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INTEGER NOT NULL
);