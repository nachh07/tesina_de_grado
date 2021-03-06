CREATE DATABASE DW_VENTAS 
GO
USE DW_VENTAS

/*COMIENZA LA CREACI�N DE LAS DIMENSIONES*/

--------------- D_Clientes --------------

CREATE TABLE dbo.D_Clientes
(
   id_cliente INT IDENTITY(1,1) NOT NULL,
   cod_cliente VARCHAR(7),
   nombre VARCHAR(50) NOT NULL,
   apellido VARCHAR(50) NOT NULL,
   provincia VARCHAR(50) NOT NULL, 
   edad INT NOT NULL,
   genero VARCHAR(10) NOT NULL,
   CONSTRAINT [PK_Clientes_id_cliente]  PRIMARY KEY NONCLUSTERED  (id_cliente)
)

--------------- D_Productos --------------

GO
CREATE TABLE dbo.D_Productos
(
 id_producto  INT NOT NULL IDENTITY(1,1), 
 cod_producto VARCHAR(50) NOT NULL,
 nombre       VARCHAR(255) NOT NULL,
 marca        VARCHAR(255), 
 CONSTRAINT [PK_Productos_id_producto] PRIMARY KEY NONCLUSTERED (id_producto)
)

-------------- D_Sucursales ------------

CREATE TABLE D_Sucursales(
	id_sucursal INT NOT NULL IDENTITY(1,1),
	cod_sucursal VARCHAR(50) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	provincia VARCHAR(50) NOT NULL
	CONSTRAINT [PK_Sucursal_id_sucursal] PRIMARY KEY NONCLUSTERED (id_sucursal)
)


/* COMIENZA LA CREACIÓN DE LA FACT TABLE */ 

CREATE TABLE F_Ventas(
    id_cliente      INT NOT NULL, 
    id_producto     INT NOT NULL,
    id_sucursal     INT NOT NULL,
    id_tiempo       INT NOT NULL,
    cantidad        FLOAT NOT NULL,
    costo           FLOAT NOT NULL, 
    precio          FLOAT NOT NULL,
    utilidad        FLOAT NOT NULL 
   CONSTRAINT [FK_F_id_cliente] FOREIGN KEY (id_cliente) REFERENCES D_Clientes(id_cliente),
   CONSTRAINT [FK_F_cod_producto] FOREIGN KEY (id_producto) REFERENCES D_Productos(id_producto),
   CONSTRAINT [FK_F_cod_sucursal] FOREIGN KEY (id_sucursal) REFERENCES D_Sucursales(id_sucursal),
   CONSTRAINT [FK_F_id_tiempo] FOREIGN KEY (id_tiempo) REFERENCES D_Tiempo(id_fecha)
)
