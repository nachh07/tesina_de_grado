
#Ventas

productos = "SELECT NOM_PROD, COD_PROD, MARCA FROM tblProductos"


#Creates

D_Clientes = "CREATE TABLE dbo.D_Clientes ( id_cliente INT IDENTITY(1,1) NOT NULL, cod_cliente VARCHAR(7), nombre VARCHAR(50) NOT NULL, apellido VARCHAR(50) NOT NULL, provincia VARCHAR(50) NOT NULL,  CONSTRAINT [PK_Clientes_id_cliente]  PRIMARY KEY NONCLUSTERED  (id_cliente) )"
D_Productos = "CREATE TABLE dbo.D_Productos ( id_producto  INT NOT NULL IDENTITY(1,1), cod_producto VARCHAR(50) NOT NULL, nombre  VARCHAR(255) NOT NULL, marca VARCHAR(255), CONSTRAINT [PK_Productos_id_producto] PRIMARY KEY NONCLUSTERED (id_producto) )"
D_Sucursales = "CREATE TABLE D_Sucursales(id_sucursal INT NOT NULL IDENTITY(1,1),cod_sucursal VARCHAR(50) NOT NULL,nombre VARCHAR(50) NOT NULL,provincia VARCHAR(50) NOT NULL, CONSTRAINT [PK_Sucursal_id_sucursal] PRIMARY KEY NONCLUSTERED (id_sucursal) )"
F_Ventas = "CREATE TABLE F_Ventas(id_cliente INT NOT NULL,  id_producto INT NOT NULL, id_sucursal INT NOT NULL, id_tiempo INT NOT NULL, cantidad  FLOAT NOT NULL, costo  FLOAT NOT NULL,precio FLOAT NOT NULL, utilidad  FLOAT NOT NULL  CONSTRAINT [FK_F_id_cliente] FOREIGN KEY (id_cliente) REFERENCES D_Clientes(id_cliente), CONSTRAINT [FK_F_cod_producto] FOREIGN KEY (id_producto) REFERENCES D_Productos(id_producto), CONSTRAINT [FK_F_cod_sucursal] FOREIGN KEY (id_sucursal) REFERENCES D_Sucursales(id_sucursal), CONSTRAINT [FK_F_id_tiempo] FOREIGN KEY (id_tiempo) REFERENCES D_Tiempo(id_fecha) )"
D_Tiempo = "CREATE TABLE dbo.D_Tiempo(id_fecha INT NOT NULL, fecha DATETIME NOT NULL, anio SMALLINT NOT NULL, semestre SMALLINT NOT NULL, trimestre SMALLINT NOT NULL, mes SMALLINT NOT NULL, semana SMALLINT NOT NULL, dia SMALLINT NOT NULL, dia_semana SMALLINT NOT NULL, nsemestre VARCHAR(15) NOT NULL, ntrimestre VARCHAR(15) NOT NULL,nmes VARCHAR(15) NOT NULL,  nmes3l VARCHAR(15) NOT NULL,  nsemana VARCHAR(15) NOT NULL, ndia VARCHAR(15) NOT NULL, ndiasemana VARCHAR(15) NOT NULL,CONSTRAINT [PK_Tiempo_id_fecha] PRIMARY KEY NONCLUSTERED (id_fecha) )"


lista_tablas = [D_Clientes, D_Productos, D_Sucursales, D_Tiempo, F_Ventas]

#inserts

insert_Clientes = "INSERT INTO D_Clientes (cod_cliente, nombre, apellido, provincia) VALUES (?,?,?,?) "
insert_sucursal = "INSERT INTO D_Sucursal (cod_sucursal, nombre, provincia) VALUES (02, Sucursal 504 - CABA, Buenos Aires - CABA), (04, Sucursal 211 - La Plata (LP), Buenos Aires - GBA ),(03, Sucursal 512 - Arroyito, Córdoba), (06, Sucursal 212 - Rosario), (13, Sucursal 775 - Chubut, Chubut), (07, Sucursal 1001 - Salta, Salta)" 
insert_productos = "INSERT INTO D_Productos (cod_producto, nombre, marca) VALUES(?,?,?)"
