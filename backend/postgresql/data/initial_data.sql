INSERT INTO sport_goods.categories (name)
VALUES ('basketball'),
       ('football'),
       ('common')
ON CONFLICT (name)
DO NOTHING;

CREATE TEMP TABLE IF NOT EXISTS all_goods (
  name TEXT NOT NULL,
  description TEXT,
  category_name TEXT NOT NULL,
  image_url TEXT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  quantity INTEGER NOT NULL,
  UNIQUE(name, category_name)
);

INSERT INTO all_goods (name, description, category_name, image_url, price, quantity) 
VALUES ('Кроссовки утепленные женские Kappa Giusto Mid', 'Да, это нормально, что ты не готова к наступающим морозам. Главное, что Kappa Giusto готовы. Благодаря этим кроссовкам и твое настроение, и твой стиль будут в полном порядке всю зиму.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/1bb/1008_800_b811/130314190299.jpg', 7139 , 100),
       ('Кеды женские Termit Azalea Mid 2', 'Утепленные женские кеды Termit Azalea Mid 2 отлично подходят для прогулок, если на улице стало прохладно.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/7b3/1008_800_b283/87912690299.jpg', 4949, 100),
       ('Сапоги утепленные женские Termit Storm Boot WTR', 'Стильные зимние сапоги от Termit для тех, кто не впадает в спячку, а продолжает активно проводить время в холодные дни.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/04c/1008_800_93fc/139451340299.jpg', 8799, 100),
       ('Перчатки Outventure', 'Комфортные флисовые перчатки Outventure для активного отдыха и путешествий. Резинка на запястье с тыльной стороны ладони помогает лучше сохранить тепло и защищает от снега.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/d54/1008_800_3229/127927470299.jpg', 599, 100),
       ('Шапка Demix', 'Вязаная шапка от Demix — отличный выбор, чтобы дополнить спортивную экипировку для тренировок на свежем воздухе в холодную погоду. Модель выполнена из мягкой акриловой пряжи, которая хорошо удерживает тепло, сохраняет форму и устойчива к износу.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/93a/1008_800_ba5e/92676930299.jpg', 899, 100),
       ('Шапка женская FILA', 'Хочешь — тренируйся, а хочешь — просто гуляй. В удобной шапке от FILA бродить по улицам — одно удовольствие. Модель выполнена из теплой и мягкой пряжи с добавлением шерсти.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/a44/1008_800_5588/126512070299.jpg', 1259, 100),
       ('Куртка утепленная женская Volkl', 'Утепленная технологичная куртка от Volkl удачно дополнит вашу горнолыжную экипировку.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/170/1008_800_7c44/136267990299.jpg', 13999, 100),
       ('Куртка утепленная женская FILA', 'Длинное пальто FILA позаботится о твоем комфорте и стиле в холода.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/48b/1008_800_d141/125920630299.jpg', 9799, 100),
       ('Куртка утепленная женская Volkl', 'Утепленная технологичная куртка от Volkl удачно дополнит вашу горнолыжную экипировку.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/dde/1008_800_717b/135413980299.jpg', 15119, 100),
       ('Куртка утепленная женская Volkl', 'Технологичная куртка от Volkl — выбор тех, кто активно катается на горных лыжах.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/627/1008_800_74c7/135413960299.jpg', 10499, 100),
       ('Кроссовки утепленные мужские GSD ONE 2 MID WTR', 'Теплые и мягкие кроссовки ONE 2 MID WTR незаменимы для долгих прогулок или насыщенного дня.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/e1b/1008_800_c93d/136460300299.jpg', 2499, 100),
       ('Кроссовки утепленные мужские PUMA St Runner V3 Mid L', 'Легендарный и вневременной дизайн ST Runner всегда будет в моде. Высокие кроссовки PUMA ST Runner v3 — это культовый силуэт, теперь готовый к суровым условиям.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/47b/1008_800_2bf9/73490590299.jpg', 9039, 100),
       ('Сапоги утепленные мужские Demix Stitcher Boot', 'Сапоги Demix станут лучшим выбором для создания стильного спортивного образа зимой.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/b41/1008_800_756d/81177940299.jpg', 3849, 100),
       ('Панама Kappa', 'С уютной флисовой панамой от Kappa тебе будут не страшны прогулки в холодную погоду. Подкладка обеспечивает дополнительную защиту от непогоды.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/f1f/1008_800_a038/121207060299.jpg', 1259, 100),
       ('Гейтор детский Demix', 'Флисовый снуд с регулировочным шнурком от Demix. Модель надежно сохраняет тепло и защищает от ветра во время активных тренировок.', 'common', 'https://cdn.sportmaster.ru/upload/mdm/media_content/resize/238/1008_800_497d/50195570299.jpg', 349, 100)
ON CONFLICT (name, category_name)
DO NOTHING;

INSERT INTO sport_goods.products (name, description, category_id, image_url, price, quantity)
SELECT ag.name, ag.description, c.id, ag.image_url, ag.price, ag.quantity FROM all_goods AS ag
JOIN sport_goods.categories AS c ON c.name = ag.category_name 
ON CONFLICT (name)
DO NOTHING;


