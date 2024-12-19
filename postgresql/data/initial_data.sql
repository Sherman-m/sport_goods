INSERT INTO sport_goods.categories (name)
VALUES ('basketball'),
       ('football')
ON CONFLICT (name)
DO NOTHING;
