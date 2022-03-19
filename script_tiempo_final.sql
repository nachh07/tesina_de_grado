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

-- script TLSQL --------

GO
DECLARE @FechaDesde as datetime, @FechaHasta as datetime
DECLARE @FechaAAAAMMDD int
DECLARE @Año as smallint, @Semestre as smallint, @Trimestre smallint, @Mes smallint
DECLARE @Semana smallint, @Dia smallint, @DiaSemana smallint
DECLARE @NSemestre varchar(15), @NTrimestre varchar(15), @NMes varchar(15)
DECLARE @NMes3l varchar(15)
DECLARE @NSemana varchar(15), @NDia varchar(15), @NDiaSemana varchar(15)

BEGIN TRANSACTION

--Borrar datos actuales, si fuese necesario

--TRUNCATE TABLE FROM DI TIEMPO

--Rango de fechas a generar: del 01/01/2006 al 31/12/Año actual+2

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
	-- Incremento de bucle. 
	SELECT @FechaDesde = DATEADD(DAY, 1, @FechaDesde)
	END 
COMMIT TRANSACTION
