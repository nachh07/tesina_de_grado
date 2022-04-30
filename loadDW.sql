
GO
DECLARE @FechaDesde as datetime, @FechaHasta as datetime
DECLARE @FechaAAAAMMDD int
DECLARE @Año as smallint, @Semestre as smallint, @Trimestre smallint, @Mes smallint
DECLARE @Semana smallint, @Dia smallint, @DiaSemana smallint
DECLARE @NSemestre varchar(15), @NTrimestre varchar(15), @NMes varchar(15)
DECLARE @NMes3l varchar(15)
DECLARE @NSemana varchar(15), @NDia varchar(15), @NDiaSemana varchar(15)

BEGIN TRANSACTION



	SELECT @FechaDesde = CAST('20070101' AS Datetime)
	SELECT @FechaHasta = CAST(CAST(YEAR(GETDATE())+2 AS CHAR (4)) + '1231' AS datetime)
	WHILE (@FechaDesde <= @FechaHasta) BEGIN
	SELECT @FechaAAAAMMDD = YEAR (@FechaDesde) *10000+
							MONTH (@FechaDesde) *100+
							DATEPART (dd, @FechaDesde)
	SELECT @Año = DATEPART (yy, @FechaDesde)
	SELECT @Semestre = MONTH(GETDATE())/6+1 
	SELECT @Trimestre = DATEPART(qq, @FechaDesde)
	SELECT @Mes = DATEPART (m, @FechaDesde)
	SELECT @Semana = DATEPART (wk, @FechaDesde)
	SELECT @Dia = RIGHT('0' + DATEPART (dd, @FechaDesde), 2)
	SELECT @DiaSemana = DATEPART (DW, @FechaDesde)
	SELECT @NMes = DATENAME (mm, @FechaDesde) 
	SELECT @NMes3l = LEFT (@NMes, 3)
	SELECT @NSemestre = concat('Semestre' ,@SEMESTRE)
	SELECT @NTrimestre = 'T' + CAST (@Trimestre as CHAR (1)) + '/' + RIGHT(@Año, 2)
	SELECT @NSemana = 'Sem' +CAST(@Semana AS CHAR(2)) + '/' + RIGHT(RTRIM(CAST(@Año AS CHAR(4))), 2)
	SELECT @NDia = CAST (@Dia as CHAR(2)) + ' ' + RTRIM (@NMes)
	SELECT @NDiaSemana = DATENAME(dw, @FechaDesde)
	INSERT INTO DW_VENTAS.dbo.D_Tiempo
	(
	id_fecha, 
	fecha,
	anio,
	semestre,
	trimestre,
	mes, 
	semana, 
	dia, 
	dia_semana, 
	nsemestre,
	ntrimestre, 
	nmes, 
	nmes3l, 
	nsemana, 
	ndia,
	ndiasemana
	)
	VALUES
	( 
	@FechaAAAAMMDD, 
	@FechaDesde, 
	@Año, 
	@Semestre,
	@Trimestre,
	@Mes, 
	@Semana, 
	@Dia, 
	@DiaSemana,
	@NSemestre,
	@NTrimestre,
	@NMes,
	@NMes3l,
	@NSemana,
	@NDia,
	@NDiaSemana
	)
	SELECT @FechaDesde = DATEADD(DAY, 1, @FechaDesde)
	END 
COMMIT TRANSACTION

GO
INSERT INTO DW_VENTAS.dbo.F_Ventas
SELECT dc.id_cliente, dp.id_producto, ds.id_sucursal, dt.id_fecha,
	SUM(tvd.CANTIDAD) AS CANTIDAD,
	SUM(tvd.CANTIDAD*tvd.COSTO) AS COSTO,
	SUM(tvd.CANTIDAD*tvd.VALOR) AS FACTURACION,
	SUM(tvd.CANTIDAD*tvd.VALOR-tvd.CANTIDAD*tvd.COSTO) AS [UTILIDAD BRUTA]
FROM BDVentas.dbo.tblVentas tv 
	INNER JOIN 
	DW_VENTAS.dbo.D_Clientes dc on tv.COD_ID = dc.cod_cliente COLLATE DATABASE_DEFAULT  
	INNER JOIN 
	DW_VENTAS.dbo.D_Productos dp ON tvd.COD_PROD = dp.cod_producto COLLATE DATABASE_DEFAULT 
	INNER JOIN 
	DW_VENTAS.dbo.D_Sucursales ds ON tv.COD_SUC = ds.cod_sucursal COLLATE DATABASE_DEFAULT  
	INNER JOIN 
	DW_VENTAS.dbo.D_Tiempo dt ON tv.FECHA = dt.FECHA
GROUP BY dc.id_cliente, dp.id_producto, ds.id_sucursal, dt.id_fecha;