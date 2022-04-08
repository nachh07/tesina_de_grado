USE DW_VENTAS;

/*INSERT D_Clientes */
GO
INSERT INTO D_Clientes
SELECT COD_ID, nombre, apellido, provincia 
FROM FINAL.dbo.D_Clientes; 


/*INSERT D_Sucursales */
GO
INSERT INTO DW_VENTAS.dbo.D_Sucursales
SELECT cod_sucursal, nombre, provincia
FROM FINAL.dbo.D_Sucursales;



/*INSERT D_Productos */
GO
INSERT INTO DW_VENTAS.dbo.D_Productos 
SELECT cod_producto, nombre_p, marca
FROM FINAL.dbo.D_Productos


/* INSERT EN F_VENTAS */

INSERT INTO DW_VENTAS.dbo.F_Ventas
SELECT dc.id_cliente, dp.id_producto, ds.id_sucursal, dt.id_fecha,
	SUM(tvd.CANTIDAD) AS CANTIDAD,
	SUM(tvd.CANTIDAD*tvd.COSTO) AS COSTO,
	SUM(tvd.CANTIDAD*tvd.VALOR) AS PRECIO,
	SUM(tvd.CANTIDAD*tvd.VALOR-tvd.CANTIDAD*tvd.COSTO) AS [UTILIDAD BRUTA]
FROM BDVentas.dbo.tblVentas tv
	INNER JOIN														
	BDVentas.dbo.tblVentas_Detalle tvd on tv.ID = tvd.ID     -- DETALLE DE LAS VENTAS   
	INNER JOIN 
	DW_VENTAS.dbo.D_Clientes dc on tv.COD_ID = dc.cod_cliente COLLATE DATABASE_DEFAULT  
	INNER JOIN 
	DW_VENTAS.dbo.D_Productos dp ON tvd.COD_PROD = dp.cod_producto COLLATE DATABASE_DEFAULT 
	INNER JOIN 
	DW_VENTAS.dbo.D_Sucursales ds ON tv.COD_SUC = ds.cod_sucursal COLLATE DATABASE_DEFAULT  
	INNER JOIN 
	DW_VENTAS.dbo.D_Tiempo dt ON tv.FECHA = dt.FECHA
GROUP BY dc.id_cliente, dp.id_producto, ds.id_sucursal, dt.id_fecha;
