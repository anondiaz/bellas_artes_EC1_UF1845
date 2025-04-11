CREATE DATABASE IF NOT EXISTS tienda_bellas_artes;
USE tienda_bellas_artes;

create table if not exists tbl_productos(
`id` int NOT NULL auto_increment primary key,
`code` varchar(10) not null,
`name_product` varchar(50) not null,
`date_insert` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
`price` decimal(4,2) NOT NULL DEFAULT '0.00',
`ud_disponibles` int not null default '0'
)
;

describe tienda_bellas_artes.tbl_productos;
-- drop database tienda_bellas_artes;