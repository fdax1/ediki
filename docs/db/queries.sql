-- запрос для входа в приложение
SELECT u.id, u.full_name, r.name AS role
FROM users u
JOIN roles r ON r.id = u.role_id
WHERE u.login = '94d5ous@gmail.com' AND u.password = 'uzWC67';


-- запрос каталога товаров
SELECT p.id, p.article, p.name, p.unit, p.price, p.discount, p.stock_qty,
p.description, p.photo,
c.name AS category, m.name AS manufacturer, s.name AS supplier
FROM products p
JOIN categories c ON c.id = p.category_id
JOIN manufacturers m ON m.id = p.manufacturer_id
JOIN suppliers s ON s.id = p.supplier_id;

-- поиск, фильтр и сортировку
SELECT p.id, p.article, p.name, p.unit, p.price, p.discount, p.stock_qty,
p.description, p.photo,
c.name AS category, m.name AS manufacturer, s.name AS supplier
FROM products p
JOIN categories c ON c.id = p.category_id
JOIN manufacturers m ON m.id = p.manufacturer_id
JOIN suppliers s ON s.id = p.supplier_id
WHERE p.name LIKE CONCAT('%', 'ботинки', '%') AND p.supplier_id = '2'
ORDER BY p.stock_qty DESC;



-- справочники для выпадающих списков в форме
SELECT id, name FROM categories;
SELECT id, name FROM manufacturers;
SELECT id, name FROM suppliers;

-- открыть товар для редактирования — заполнить все поля сразу
INSERT INTO products
(article, name, unit, price, discount, stock_qty, description, photo, category_id,
manufacturer_id, supplier_id)
VALUES ('A112T4', 'Ботинки', 'шт.', 4990.00, 3, 6, 'Женские Ботинки демисезонные kari', '1.jpg', 1, 1, 1);

-- открыть товар для редактирования — заполнить все поля сразу
SELECT * FROM products WHERE id = 1;

-- сохранить изменения
UPDATE products
SET article='A112T4', name='Ботинки', unit='шт.', price=4990.00, discount=3, stock_qty=6, description='Женские Ботинки демисезонные kari', photo='1.jpg', category_id=1, manufacturer_id=1, supplier_id=1;

-- защиту от удаления купленного товара
SELECT COUNT(*) AS used_in_orders FROM prodorders WHERE product_id = 2;
DELETE FROM products WHERE id = 2;
