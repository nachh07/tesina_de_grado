USE DW_VENTAS;

/*INSERT D_Clientes */
GO
INSERT INTO D_Clientes
SELECT nombre, apellido, provincia 
FROM DW_TESINAPRUEBA.dbo.D_Clientes; 



/*INSERT D_Sucursales */
GO
INSERT INTO DW_VENTAS.dbo.D_Sucursales
SELECT cod_sucursal, provincia, direccion
FROM DW_TESINAPRUEBA.dbo.D_Sucursal;



/*INSERT D_Productos */
GO
INSERT INTO DW_VENTAS.dbo.D_Productos 
SELECT cod_producto, nombre_p, marca
FROM FINAL.dbo.D_Productos



