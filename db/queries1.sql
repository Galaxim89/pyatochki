USE pyatochki;

-- Авторизация пользователя: проверка логина и пароля с учётом регистра
SELECT u.id, u.full_name, r.name AS role
FROM users u
JOIN roles r ON r.id = u.role_id
WHERE u.login = '94d5ous@gmail.com' AND BINARY u.password = 'uzWC67';

-- Полный список товаров с расшифровкой категории, производителя и поставщика
SELECT p.id, p.article, p.name, p.unit, p.price, p.discount, p.stock_qty,
       p.description, p.photo,
       c.name AS category, m.name AS manufacturer, s.name AS supplier
FROM products p
JOIN categories c ON c.id = p.category_id
JOIN manufacturers m ON m.id = p.manufacturer_id
JOIN suppliers s ON s.id = p.supplier_id;

-- Поиск товаров по названию и поставщику с сортировкой по остатку
SELECT p.id, p.article, p.name, p.unit, p.price, p.discount, p.stock_qty,
       p.description, p.photo,
       c.name AS category, m.name AS manufacturer, s.name AS supplier
FROM products p
JOIN categories c ON c.id = p.category_id
JOIN manufacturers m ON m.id = p.manufacturer_id
JOIN suppliers s ON s.id = p.supplier_id
WHERE p.name LIKE '%Туфли%' AND p.supplier_id = 1
ORDER BY p.stock_qty DESC;

-- Справочники для наполнения выпадающих списков в форме товара
SELECT id, name FROM categories;
SELECT id, name FROM manufacturers;
SELECT id, name FROM suppliers;

-- Создание новой записи о товаре
INSERT INTO products
    (article, name, unit, price, discount, stock_qty, description, photo, category_id, manufacturer_id, supplier_id)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

-- Открыть товар для редактирования — заполнить все поля сразу
SELECT * FROM products WHERE id = ?;

-- Применение изменений к товару
UPDATE products
SET article = ?, name = ?, unit = ?, price = ?, discount = ?, stock_qty = ?, description = ?, photo = ?,
    category_id = ?, manufacturer_id = ?, supplier_id = ?
WHERE id = ?;

-- Проверка связей товара с заказами (первые 5 записей)
SELECT DISTINCT product_id FROM prodorders LIMIT 5;

DELETE FROM products WHERE id = 1;