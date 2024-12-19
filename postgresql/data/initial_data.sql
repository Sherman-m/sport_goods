INSERT INTO sport_goods.categories (name)
VALUES ('basketball'),
       ('football')
ON CONFLICT (name)
DO NOTHING;

CREATE TEMP TABLE IF NOT EXISTS all_goods (
  name TEXT NOT NULL,
  description TEXT,
  category_name TEXT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  quantity INTEGER NOT NULL,
  UNIQUE(name, category_name)
);

INSERT INTO all_goods (name, description, category_name, price, quantity) 
VALUES ('баскетбольный мяч Jordan', 'очень крутой мяч, у меня таки 10 тысяч', 'basketball', 123.123, 10000),
       ('Nike Air Jordan', 'очень крутой кроссы, у меня таких 5 тысяч', 'basketball', 123.123, 5000),
       ('баскетбольный мяч StreetBall', 'описание', 'basketball', 123.123, 1000),
       ('бутсы', 'описание', 'football', 123.123, 10000),
       ('олимпийка', 'описание', 'football', 123.123, 5000),
       ('бутсы', 'описание', 'football', 123.123, 1000)
ON CONFLICT (name, category_name)
DO NOTHING;

INSERT INTO sport_goods.products (name, description, category_id, price, quantity)
SELECT ag.name, ag.description, c.id, ag.price, ag.quantity FROM all_goods AS ag
JOIN sport_goods.categories AS c ON c.name = ag.category_name 
ON CONFLICT (name)
DO NOTHING;


