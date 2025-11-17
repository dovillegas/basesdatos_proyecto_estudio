/*
   TEMA 2: Optimización de Consultas a través de Índices
   BASE DE DATOS: PruebasIndices
   TABLA: venta
*/
-- 1. CREACIÓN DE LA BASE Y TABLA

IF DB_ID('indices') IS NOT NULL
    DROP DATABASE PruebasIndices;
GO

CREATE DATABASE indices;
GO

USE indices;
GO

CREATE TABLE venta
(
  venta_id INT IDENTITY,
  total FLOAT NOT NULL,
  fecha DATE NOT NULL,
  CONSTRAINT PK_venta PRIMARY KEY (venta_id)
);
GO

-- 2. CARGA MASIVA DE 1 MILLÓN DE REGISTROS
SET NOCOUNT ON;

PRINT 'Insertando 1.000.000 de registros...';

DECLARE @fechaInicio DATE = '2015-01-01';
DECLARE @diasTotales INT = 3650; -- 10 años (2015–2025)

-- Este método usa una tabla del sistema para generar muchas filas rápidamente:
WHILE (SELECT COUNT(*) FROM venta) < 1000000
BEGIN
    INSERT INTO venta (total, fecha)
    SELECT TOP (10000)
        ROUND(RAND(CHECKSUM(NEWID())) * 10000, 2),
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % @diasTotales, @fechaInicio)
    FROM sys.all_objects a CROSS JOIN sys.all_objects b;
END;

PRINT 'Carga completada correctamente.';
GO

SELECT * FROM venta;

-- 3. CONSULTA SIN ÍNDICES
CHECKPOINT; 
DBCC DROPCLEANBUFFERS; -- Limpia el buffer.
DBCC FREEPROCCACHE; -- Limpia la cache.
GO

PRINT 'Consulta sin índice (fase inicial)';

SET STATISTICS TIME ON; -- Mide el tiempo que tarda en ejecutarse una consulta.
SET STATISTICS IO ON; -- Mide las operaciones de entrada/salida (I/O) del motor de SQL Server.


SELECT *
FROM venta
WHERE fecha BETWEEN '2017-01-01' AND '2023-12-31';

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

GO

-- 4. CREAR ÍNDICE AGRUPADO EN COLUMNA FECHA

ALTER TABLE venta DROP CONSTRAINT PK_venta; -- ELIMINA LA RESTRICCION PK_venta

PRINT 'Creando índice agrupado sobre la columna fecha...';

CREATE CLUSTERED INDEX IX_venta_fecha
ON Venta(fecha);
GO

-- Busqueda con indice agrupado:
SET STATISTICS TIME ON; 
SET STATISTICS IO ON; 

SELECT *
FROM venta
WHERE fecha BETWEEN '2017-01-01' AND '2023-12-31';

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

GO

-- 5. ELIMINAR EL ÍNDICE

PRINT 'Eliminando el índice agrupado...';
DROP INDEX IX_venta_fecha ON venta;
GO


-- 6. CREAR ÍNDICE NO AGRUPADO CON COLUMNAS INCLUIDAS
PRINT 'Creando índice no agrupado con columnas incluidas...';

CREATE NONCLUSTERED INDEX IX_venta_fecha_incl -- Creacion de un indice no agrupado.
ON venta(fecha)
INCLUDE (total);
GO

PRINT 'Consulta con índice no agrupado e inclusión de columnas';
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT *
FROM venta
WHERE fecha BETWEEN '2017-01-01' AND '2023-12-31';

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO
