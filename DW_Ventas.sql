CREATE DATABASE DW_VENTAS 
GO
USE DW_VENTAS

/*COMIENZA LA CREACI�N DE LAS DIMENSIONES*/

--------------- D_Clientes --------------

CREATE TABLE dbo.D_Clientes
(
   id_cliente INT IDENTITY(1,1) NOT NULL,
   nombre VARCHAR(50) NOT NULL,
   apellido VARCHAR(50) NOT NULL,
   provincia VARCHAR(50) NOT NULL, 
   CONSTRAINT [PK_Clientes_id_cliente]  PRIMARY KEY NONCLUSTERED  (id_cliente)
)

--------------- D_Productos --------------

GO
CREATE TABLE dbo.D_Productos
(
 id_producto  INT NOT NULL IDENTITY(1,1) NOT NULL, 
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

--------- D_Tiempo -----------------

CREATE TABLE dbo.D_Tiempo
    (
    id_fecha         INT      NOT NULL,
    fecha			 DATETIME NOT NULL,
    anio			 SMALLINT NOT NULL,
	semestre		 SMALLINT NOT NULL,
	trimestre		 SMALLINT NOT NULL,
    mes              SMALLINT NOT NULL,
    semana           SMALLINT NOT NULL,
    dia              SMALLINT NOT NULL,
    dia_semana		 SMALLINT NOT NULL,
	nsemestre	     VARCHAR(15) NOT NULL,
	ntrimestre	     VARCHAR(15) NOT NULL,
    nmes			 VARCHAR(15) NOT NULL,  -- representa el nombre del mes ---
    nmes3l			 VARCHAR(15) NOT NULL,  -- nombre del mes 3L
    nsemana			 VARCHAR(15) NOT NULL, -- numero de semana
    ndia             VARCHAR(15) NOT NULL, -- numero del día
    ndiasemana       VARCHAR(15) NOT NULL,
    CONSTRAINT [PK_Tiempo_id_fecha] PRIMARY KEY NONCLUSTERED (id_fecha)

 )

-------------- D_Motivodevolucion --------

CREATE TABLE D_Motivodevolucion(
    id_motivo INT IDENTITY(1,1) NOT NULL,
    motivo VARCHAR(50),
    detalle  TEXT
    CONSTRAINT [PK_id_motivo] PRIMARY KEY NONCLUSTERED(id_motivo)
)



/* COMIENZA LA CREACIÓN DE LAS FACTS TABLES */ 

CREATE TABLE F_Ventas(
    id_cliente      INT NOT NULL, 
    id_producto     INT NOT NULL,
    id_sucursal     INT NOT NULL,
    id_tiempo       INT NOT NULL,
    costo           FLOAT NOT NULL, 
    precio          FLOAT NOT NULL,
    utilidad        FLOAT NOT NULL 
   CONSTRAINT [FK_F_id_cliente] FOREIGN KEY (id_cliente) REFERENCES D_Clientes(id_cliente),
   CONSTRAINT [FK_F_cod_producto] FOREIGN KEY (id_producto) REFERENCES D_Productos(id_producto),
   CONSTRAINT [FK_F_cod_sucursal] FOREIGN KEY (id_sucursal) REFERENCES D_Sucursales(id_sucursal),
   CONSTRAINT [FK_F_id_tiempo] FOREIGN KEY (id_tiempo) REFERENCES D_Tiempo(id_fecha)
)

CREATE TABLE dbo.F_Devoluciones
(
   id_cliente         INT NOT NULL,
   cod_producto       INT NOT NULL, 
   id_tiempo         INT NOT NULL, 
   id_sucursal        INT NOT NULL, 
   id_motivo          INT NOT NULL,
   importe_devuelto FLOAT NOT NULL, 
   unidades_devueltas INT NOT NULL,
   CONSTRAINT [FK_F_id_cliente_devolucion] FOREIGN KEY (id_cliente) REFERENCES D_Clientes(id_cliente),
   CONSTRAINT [FK_F_cod_producto_devolucion] FOREIGN KEY (cod_producto) REFERENCES D_Productos(id_producto),
   CONSTRAINT [FK_F_id_tiempo__devolucion] FOREIGN KEY (id_tiempo) REFERENCES D_Tiempo(id_fecha),
   CONSTRAINT [FK_F_cod_sucursal_devolucion] FOREIGN KEY (id_sucursal) REFERENCES D_Sucursales(id_sucursal),
   CONSTRAINT [FK_F_id_motivo_devolucion] FOREIGN KEY (id_motivo) REFERENCES D_Motivodevolucion(id_motivo)
)
