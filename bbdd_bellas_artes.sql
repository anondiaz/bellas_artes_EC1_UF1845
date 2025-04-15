-- Creamos la Base de Datos 
CREATE DATABASE IF NOT EXISTS tienda_bellas_artes;

-- Explicitamos su uso
USE tienda_bellas_artes;

-- Si fuera necesario borrar la BBDD
-- DROP DATABASE tienda_bellas_artes;

-- Creamos la tabla productos con:
-- id = Integer, No Nulo, Autoincremental, clave primaria
-- código producto = VarChar, Único, No Nulo
-- nombre producto = VarChar, No Nulo
-- fecha de inserción = Timestamp, Se creará la fecha en el momento de la inserción
-- precio = Decimal longitud de 6, incluyendo 2 decimales, No Nulo y valor por defecto de 0.00
-- unidades disponible en stock = Integer, No Nulo y valor por defecto de 0

CREATE TABLE IF NOT EXISTS productos(
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
`code` VARCHAR(10) UNIQUE NOT NULL,
`name_product` VARCHAR(50) NOT NULL,
`date_insert` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
`price` DECIMAL(6,2) NOT NULL DEFAULT '0.00',
`ud_disponibles` INT NOT NULL DEFAULT '0'
)
;

-- Si fuera necesario borrar la tabla
-- DROP TABLE productos;
-- Vemos que se han aplicado correctamente los parametros
DESCRIBE tienda_bellas_artes.productos;

-- Insertamos los articulos de la tabla
INSERT INTO tienda_bellas_artes.productos ( code, name_product, price, ud_disponibles )
VALUES ('001', 'caja_pinceles_da_Vinci', '142.50', 20),
('002', 'set_rotuladore_TM_18pz', 54.90, 14),
('003', 'pinturas_acrilicas_WN_10pz', 35.00, 35),
('004', 'lienzo_cotton_50_70', 15.00, 123),
('005', 'tela_oleo_80_60', 20.00, 45)
;

-- Comprobamos el resultado
SELECT * FROM tienda_bellas_artes.productos;

-- Insertamos los articulos de la siguiente ronda en la tabla
INSERT INTO tienda_bellas_artes.productos ( code, name_product, price, ud_disponibles )
VALUES ('006', 'pasteles_blandos_Sennelier_100pz', 355.00, 30),
('007', 'pinturas_al_oleo_Van_Gogh_10pz', 72.00, 24),
('008', 'papel_de_dibujo_Fabriano_50pz', 15.00, 30)
;

-- Comprobamos el resultado
SELECT * FROM tienda_bellas_artes.productos;

-- Buscamos obtener el code para realizar una actualización del artículo posteriormente
SELECT code, name_product FROM tienda_bellas_artes.productos WHERE name_product = 'caja_pinceles_da_Vinci' ;
 
-- Hacemos un update del artículo solicitado
-- Lo correcto seria enviar este articulo a una tabla de articulos descatalogados
-- De esta forma se podrán consultar las ventas anteriores
UPDATE tienda_bellas_artes.productos SET name_product = 'caja_de_rotuladores_Copic_Ciao_36_A' WHERE code = 001;
UPDATE tienda_bellas_artes.productos SET price = 174.25 WHERE code = 001;
UPDATE tienda_bellas_artes.productos SET ud_disponibles = 30 WHERE code = 001;

-- Comprobamos el resultado
SELECT * FROM tienda_bellas_artes.productos;

-- Borramos los articulos solicitados de la tabla
-- Lo correcto seria enviar este articulo a una tabla de articulos descatalogados
-- De esta forma se podrán consultar las ventas anteriores
DELETE FROM tienda_bellas_artes.productos WHERE name_product = 'lienzo_cotton_50_70' ;

-- Comprobamos el resultado
SELECT * FROM tienda_bellas_artes.productos;