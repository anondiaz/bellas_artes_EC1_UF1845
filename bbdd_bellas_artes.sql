-- ----- Parte 1 -----
-- Qué hay que hacer:
-- Crear una tabla para BD en la cual insertar los elementos proporcionados
-- Modificar elemento
-- Añadir elemento
-- Borrar elementos
-- Tarea
-- Estás creando una BD de una tienda de bellas artes.
-- 1.​ Se te pide que crees una tabla, productos, donde figuren los siguiente
-- campos
-- a. id
-- b. código producto
-- c. nombre producto
-- d. fecha de inserción
-- e. precio
-- f. unidades disponibles en stock
-- La tabla tendrá que aparecer de la siguiente forma y contener los siguientes ítems:
-- 
-- 2. La tienda necesita añadir tres productos más a su stock:
-- a. Pasteles blandos Sennelier, 100 ud, 355,00 €, disponibilidad 30 unidades
-- b. Pinturas al óleo Van Gogh, 10 ud, 72,00 €, disponibilidad 24 unidades
-- c. Papel de Dibujo Fabriano, 50 ud, 15,00 €, disponibilidad 30 unidades
-- 
-- 3.​ Después de un tiempo decide reemplazar el set de rotuladores Da Vinci
-- por uno de mayor calidad el:
-- a. Caja de rotuladores Copic Ciao 36 A​, 174,25 €, disponibilidad 30 unidades
-- 
-- 4. La empresa que le proporcionaba los lienzo_cotton_50_70 cierra por
-- jubilación, hasta que no encuentren otra empresa deciden borrar este
-- producto de la BD.
-- -----  -----
-- Creamos la Base de Datos 
CREATE DATABASE IF NOT EXISTS tienda_bellas_artes;

-- Explicitamos su uso
USE tienda_bellas_artes;

-- Si fuera necesario borrar la BBDD
-- DROP DATABASE tienda_bellas_artes;

-- Creamos la tabla productos con:
-- id_product = Integer, No Nulo, Autoincremental, clave primaria
-- codigo_producto = VarChar, Único, No Nulo, Asumimos que es un EAN, como código interno se puede utilizar el producto_id o se deberia añadir otra columna
-- nombre_producto = VarChar, No Nulo
-- fecha_insercion = Timestamp, Se creará la fecha en el momento de la inserción
-- precio_producto = Decimal longitud de 6, incluyendo 2 decimales, No Nulo y valor por defecto de 0.00
-- unidades_disponibles = Integer, No Nulo y valor por defecto de 0

CREATE TABLE IF NOT EXISTS productos(
id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
codigo_producto VARCHAR(9) UNIQUE NOT NULL,
nombre_producto VARCHAR(50) NOT NULL,
fecha_insercion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
precio_producto DECIMAL(6,2) NOT NULL DEFAULT '0.00',
unidades_disponibles INT NOT NULL DEFAULT '0'
)
;

-- Si fuera necesario borrar la tabla
-- DROP TABLE productos;
-- Vemos que se han aplicado correctamente los parametros
-- DESCRIBE tienda_bellas_artes.productos;

-- Insertamos los articulos de la tabla
INSERT INTO tienda_bellas_artes.productos ( codigo_producto, nombre_producto, precio_producto, unidades_disponibles )
VALUES ('001', 'caja_pinceles_da_Vinci', '142.50', 20),
('002', 'set_rotuladore_TM_18pz', 54.90, 14),
('003', 'pinturas_acrilicas_WN_10pz', 35.00, 35),
('004', 'lienzo_cotton_50_70', 15.00, 123),
('005', 'tela_oleo_80_60', 20.00, 45)
;

-- Comprobamos el resultado
-- SELECT * FROM tienda_bellas_artes.productos;

-- Insertamos los articulos de la siguiente ronda en la tabla
INSERT INTO tienda_bellas_artes.productos (  codigo_producto, nombre_producto, precio_producto, unidades_disponibles  )
VALUES ('006', 'pasteles_blandos_Sennelier_100pz', 355.00, 30),
('007', 'pinturas_al_oleo_Van_Gogh_10pz', 72.00, 24),
('008', 'papel_de_dibujo_Fabriano_50pz', 15.00, 30)
;

-- Comprobamos el resultado
-- SELECT * FROM tienda_bellas_artes.productos;

-- Buscamos obtener el code para realizar una actualización del artículo posteriormente
-- SELECT codigo_producto, nombre_producto FROM tienda_bellas_artes.productos WHERE nombre_producto = 'caja_pinceles_da_Vinci' ;
 
-- Hacemos un update del artículo solicitado
-- Lo correcto seria enviar este articulo a una tabla de articulos descatalogados
-- De esta forma se podrán consultar las ventas anteriores
UPDATE tienda_bellas_artes.productos 
SET nombre_producto = 'caja_de_rotuladores_Copic_Ciao_36_A', precio_producto = 174.25, unidades_disponibles = 30 
WHERE nombre_producto = 'caja_pinceles_da_Vinci';
 
-- Comprobamos el resultado
-- SELECT * FROM tienda_bellas_artes.productos;

-- Borramos los articulos solicitados de la tabla
-- Lo correcto seria enviar este articulo a una tabla de articulos descatalogados
-- De esta forma se podrán consultar las ventas anteriores
DELETE FROM tienda_bellas_artes.productos WHERE nombre_producto = 'lienzo_cotton_50_70' ;

-- Comprobamos el resultado
-- SELECT * FROM tienda_bellas_artes.productos;

-- ----- Parte 2 -----
-- Ahora que tenemos ya creada y modificada la BD de nuestro cliente, la tienda
-- necesitará almacenar y sacar más datos útiles para su negocio.
-- Tarea
-- Crear tres tablas más, una que se llame proveedores, otra que se llame clientes
-- y una última que se llame facturas.
-- 
-- 1. En la tabla proveedores tendrán que aparecer los siguientes campos:
-- a. Id del proveedor
-- b. Nombre del proveedor
-- Además de crear la tabla proveedores habrá que modificar la tabla productos de
-- forma que aparezca el id del proveedor
-- 
-- 2. En la tabla clientes tendrán que aparecer los siguientes campos:
-- a. Id del cliente
-- b. Nombre del cliente
-- c. Fecha de alta del cliente
-- -----  -----

-- Creamos la tabla de proveedores
CREATE TABLE IF NOT EXISTS proveedores(
id_proveedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre_proveedor VARCHAR(50) NOT NULL
)
;

-- Si fuera necesario borrar la tabla
-- DROP TABLE proveedores;
-- Vemos que se han aplicado correctamente los parametros
-- DESCRIBE tienda_bellas_artes.proveedores;

-- Como vamos a relacionar productos y proveedores, pues añado la columna a los productos
ALTER TABLE productos ADD COLUMN id_proveedor INT NOT NULL;
-- Añadimos la constraint que relacionara los campos
-- ALTER TABLE productos
-- ADD CONSTRAINT fk_productos_proveedor
-- FOREIGN KEY (id_proveedor)
-- REFERENCES proveedores(id_proveedor)
-- ON DELETE RESTRICT
-- ON UPDATE RESTRICT
-- ;

-- Nos da un error porque no existen id's de proveedor en la tabla de productos y no se pueden relacionar las tablas
-- vamos a introducir algunos valores
UPDATE tienda_bellas_artes.productos SET id_proveedor = 3 WHERE id_producto = 1 ;
UPDATE tienda_bellas_artes.productos SET id_proveedor = 1 WHERE id_producto = 2 ;
UPDATE tienda_bellas_artes.productos SET id_proveedor = 5 WHERE id_producto = 3 ;
UPDATE tienda_bellas_artes.productos SET id_proveedor = 2 WHERE id_producto = 5 ;
UPDATE tienda_bellas_artes.productos SET id_proveedor = 1 WHERE id_producto = 6 ;
UPDATE tienda_bellas_artes.productos SET id_proveedor = 4 WHERE id_producto = 7 ;
UPDATE tienda_bellas_artes.productos SET id_proveedor = 3 WHERE id_producto = 8 ;

-- Y añadimos datos de muestra para insertar en las tablas de proveedor, que es otro motivo para el error
INSERT INTO tienda_bellas_artes.proveedores ( nombre_proveedor )
VALUES ('Distribuciones DaVinci'),
('Lienzos Goya'),
('Articulos ARTE'),
('Productos para el arte creativo'),
('Acuarelas Marquez')
;

-- SELECT * FROM tienda_bellas_artes.proveedores;

-- Ahora sí,añadimos la constraint
ALTER TABLE productos
ADD CONSTRAINT fk_productos_proveedor
FOREIGN KEY (id_proveedor)
REFERENCES proveedores(id_proveedor)
ON DELETE RESTRICT
ON UPDATE RESTRICT
;

-- Creamos la tabla de clientes
CREATE TABLE IF NOT EXISTS clientes(
id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre_cliente VARCHAR(50) NOT NULL,
fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
;

-- Si fuera necesario borrar la tabla
-- DROP TABLE clientes;
-- Vemos que se han aplicado correctamente los parametros
-- DESCRIBE tienda_bellas_artes.clientes;

-- Añadimos datos de muestra para insertar en la tabla de clientes
INSERT INTO tienda_bellas_artes.clientes ( nombre_cliente)
VALUES ("Marta Azuara"),
("Elena Garcia Garcia"),
("Adria Diaz Martinez"),
("Andres Vazquez Martinez"),
("Jordi Lopez Nicolau"),
("Manuela Cuchillo Martinez"),
("Juan Martinez Gomez"),
("Eduardo Cunchillo Vivar"),
("Manuela Cuchillo Birba"),
("Pedro Rodriguez Cebolla")
;

-- SELECT * FROM tienda_bellas_artes.clientes;

-- Como no hay especificaciones, creo la tabla de facturas con los siguientes campos
CREATE TABLE IF NOT EXISTS facturas(
id_factura INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
codigo_factura VARCHAR(10) UNIQUE NOT NULL,
id_cliente INT NOT NULL
)
;

-- Si fuera necesario borrar la tabla
-- DROP TABLE facturas;
-- Vemos que se han aplicado correctamente los parametros
-- DESCRIBE tienda_bellas_artes.facturas;

-- Crearemos una tabla para los articulos de la factura, no lo indico, pero es necesario
CREATE TABLE IF NOT EXISTS articulos_facturas(
id_art_factura INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_producto INT NOT NULL,
id_factura INT NOT NULL
)
;

-- Añadimos las constraints que relacionaran los campos
ALTER TABLE articulos_facturas
ADD CONSTRAINT fk_facturas_art_fra
FOREIGN KEY (id_factura)
REFERENCES facturas(id_factura)
ON DELETE RESTRICT
ON UPDATE RESTRICT
;
ALTER TABLE articulos_facturas
ADD CONSTRAINT fk_art_fra_productos
FOREIGN KEY (id_producto)
REFERENCES productos(id_producto)
ON DELETE RESTRICT
ON UPDATE RESTRICT
;

-- Si fuera necesario borrar la tabla
-- DROP TABLE articulos_facturas;
-- Vemos que se han aplicado correctamente los parametros
-- DESCRIBE tienda_bellas_artes.articulos_facturas;

-- ---Parte 3 -----
-- Crear una tabla más que se llame facturas.
--
-- 1. En la tabla facturas tendrán que aparecer los siguientes campos:
-- a. Id factura
-- b. Id cliente
-- c. Id producto comprado
-- d. Fecha de generación de la factura
-- e. Unidades de producto compradas
-- f. Total de la compra
-- 
-- 2. En este punto del proyecto habrá que
-- a. Verificar que el producto que el cliente quiere comprar esté en stock,
-- si así fuera proceder a verificar que la cantidad de producto que el
-- cliente quiere comprar esté disponible y si finalmente se cumplen
-- todas las verificaciones pasar a introducir el producto en facturas.
-- b. Insertar un producto en la tabla de productos con un procedimiento
-- almacenado
-- -----  -----

-- Los requerimientos han cambiado
-- entonces, lo primero es modificar la tabla de facturas, que es un pelin distinta
ALTER TABLE facturas DROP COLUMN codigo_factura;
ALTER TABLE facturas ADD COLUMN id_producto_comprado INT NOT NULL,
ADD COLUMN fecha_factura  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN unidades_producto INT NOT NULL,
ADD COLUMN total_factura DECIMAL(8,2) NOT NULL;

-- Ahora vamos a eliminar las constraints de articulos_facturas
ALTER TABLE articulos_facturas DROP FOREIGN KEY fk_art_fra_productos;
ALTER TABLE articulos_facturas DROP FOREIGN KEY fk_facturas_art_fra;

-- Y ahora eliminamos la tabla de articulos_facturas
DROP TABLE articulos_facturas;

-- Añadimos las constraints que relacionaran los campos
ALTER TABLE facturas
ADD CONSTRAINT fk_facturas_clientes
FOREIGN KEY (id_cliente)
REFERENCES clientes(id_cliente)
ON DELETE RESTRICT
ON UPDATE RESTRICT
;
ALTER TABLE facturas
ADD CONSTRAINT fk_facturas_productos
FOREIGN KEY (id_producto_comprado)
REFERENCES productos(id_producto)
ON DELETE RESTRICT
ON UPDATE RESTRICT
;

-- Vamos a utilizar un SP para realizar la tarea de comprobación, inserción en la BBDD y actualización del stock
-- Esto ultimo no se pide, pero como empezamos a hablar de stock lo vamos a realizar
-- Pruebas varias
-- SELECT id_cliente FROM clientes WHERE nombre_cliente = 'Elena Garcia Garcia';
-- SELECT id_producto, unidades_disponibles, precio_producto
-- FROM productos
-- WHERE nombre_producto = 'caja_de_rotuladores_Copic_Ciao_36_A';


DELIMITER //
CREATE PROCEDURE sp_facturar_por_nombre(
sp_nombre_cliente VARCHAR(50),
sp_nombre_producto VARCHAR(50),
sp_cantidad INT
)
BEGIN
    DECLARE idCliente INT;
    DECLARE idProducto INT;
    DECLARE stockDispo INT;
    DECLARE precioProd DECIMAL(8,2);
    DECLARE idFactura INT;
    -- Obtenemos los datos que necesitamos para proceder, todos los de las variables declaradas arriba
	SELECT id_cliente
    INTO idCliente 
    FROM clientes 
    WHERE nombre_cliente = sp_nombre_cliente;
    
	SELECT id_producto, unidades_disponibles, precio_producto 
    INTO idProducto, stockDispo, precioProd -- En una sola querie ya lo tenemos todo!
    FROM productos 
    WHERE nombre_producto = sp_nombre_producto;
    -- Comprobación, si no existe lanzamos un mensaje de alerta, si no pues continuamos
    IF idCliente IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Cliente no encontrado';
	ELSE
		-- Aquí deberiamos proceder a dar de alta la compra
        IF idProducto IS NULL THEN -- Si el producto no existe
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Producto no encontrado';
		ELSEIF stockDispo = 0 THEN -- ELSEIF viejo amigo, si no hay stock del producto
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Producto fuera de stock';
		ELSEIF stockDispo < sp_cantidad THEN -- Si no hay suficiente stock del producto
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'No hay suficientes unidades en stock';
		ELSE
			-- Insertamos datos de la factura
			INSERT INTO facturas ( id_cliente, id_producto_comprado, fecha_factura, unidades_producto, total_factura )
			VALUES ( idCliente, idProducto, NOW(), sp_cantidad, sp_cantidad * precioProd );
			-- Actualizamos el stock en la tabla productos
			UPDATE productos SET unidades_disponibles = unidades_disponibles - sp_cantidad WHERE id_producto = idProducto;
        END IF;
    END IF;
END //
DELIMITER ;

-- DROP PROCEDURE sp_facturar_por_nombre;

-- CALL sp_facturar_por_nombre( 'Elena Garcia Garcia', 'caja_de_rotuladores_Copic_Ciao_36_A', 5); -- Compra realizada ok
-- CALL sp_facturar_por_nombre( 'Marta Azuara', 'caja_de_rotuladores_Copic_Ciao_36_A', 25); -- Compra realizada ok
-- CALL sp_facturar_por_nombre( 'Paco Martinez Soria', 'set_rotuladore_TM_18pz', 20); -- No existe el cliente
-- CALL sp_facturar_por_nombre( 'Andres Vazquez Martinez', 'set_pinceles_TMZ_5pz', 5); -- No existe el articulo
-- CALL sp_facturar_por_nombre( 'Eduardo Cunchillo Vivar', 'set_rotuladore_TM_18pz', 20); -- No hay suficiente stock
-- CALL sp_facturar_por_nombre( 'Andres Vazquez Martinez', 'caja_de_rotuladores_Copic_Ciao_36_A', 20); -- Insuficiente stock


-- Vamos a insertar un producto con un procedimiento almacenado tal como se pide
DELIMITER //
CREATE PROCEDURE sp_insertar_producto(
sp_codigo_producto VARCHAR(9),
sp_nombre_producto VARCHAR(50),
sp_precio_producto DECIMAL(6,2),
sp_unidades INT,
sp_id_proveedor INT
)
BEGIN
    DECLARE contadorProd INT;
    DECLARE contadorProv INT;
	-- Obtenemos los datos que necesitamos para proceder, todos los de las variables declaradas arriba
    -- usaremos un contador para variar un poco
    -- básicamente que sea mayor de 0 (Ya existe) o igual a 0 (No existe) True or False
    SELECT COUNT(id_producto) 
    INTO contadorProd 
    FROM productos 
    WHERE codigo_producto = sp_codigo_producto;
    
    SELECT COUNT(id_proveedor) 
    INTO contadorProv 
    FROM proveedores 
    WHERE id_proveedor = sp_id_proveedor;
    
   -- Verificamos que no exista ya un producto con el mismo código
    IF contadorProd > 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El código de producto ya está en uso';
	ELSE
        -- Verificamos que el proveedor exista
		IF contadorProv = 0 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Proveedor no encontrado';
        ELSE
			-- Finalmente insertamos el producto
			INSERT INTO productos ( codigo_producto, nombre_producto, precio_producto, unidades_disponibles, id_proveedor )
			VALUES ( sp_codigo_producto, sp_nombre_producto, sp_precio_producto, sp_unidades, sp_id_proveedor );
        END IF;
    END IF;
END //
DELIMITER ;

-- DROP PROCEDURE sp_facturar_por_nombre;

-- CALL sp_insertar_producto( '009', 'set_de_pinceles_profesionales', 29.95, 15, 2); -- Nuevo producto
-- CALL sp_insertar_producto( '001', 'caja_de_rotuladores_Copic_Ciao_36_B', 170.00, 20, 6); -- Ya existe el producto
-- CALL sp_insertar_producto( '010', 'caja_de_rotuladores_Copic_Ciao_36_B', 170.00, 20, 6); -- No existe el proveedor

