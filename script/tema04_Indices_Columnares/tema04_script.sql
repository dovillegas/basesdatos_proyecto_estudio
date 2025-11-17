USE proyecto;
DROP TABLE venta_con_indice
DROP TABLE venta_sin_indice
--Creacion de una tabla para la prueba

SELECT *
INTO venta_con_indice
FROM venta
WHERE 1 = 0; -- Esto asegura que solo se copie la estructura


--Carga de un millon de datos

DECLARE @fechaInicio DATE = '2015-01-01';
DECLARE @diasTotales INT = 3650;    -- 10 años (2015–2025)
DECLARE @i INT = 0;				    -- Se declara una variable de contador
WHILE @i < 1000000				    -- Luego se inicia un bucle que se repetirá un millón de veces
BEGIN
    INSERT INTO venta_con_indice(
        total,
        fecha,
        estado_pago_id,
        usuario_id
    )
    --Cargamos valores aleatorios a los campos pertenecientes a la tabla venta_con_indice
    VALUES (
        ROUND(RAND(CHECKSUM(NEWID())) * 10000, 2), -- Valores aleatorios
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % @diasTotales, @fechaInicio), -- fechas aleatorias que van desde 2015 hasta 2025
        1,
        1
    );
    SET @i = @i + 1;			-- Incrementa la variable @i en cada iteración del bucle
END;

SELECT * 
FROM venta_con_indice

SET STATISTICS TIME ON; -- Muestra el tiempo el tiempo de CPU y tiempo total de ejecucion.
SET STATISTICS IO ON; -- Muestra la cantidad de operaciones de lectura de pagina para monitorear la entrada/salida.

-- Creamos una copia de la tabla con indice, para hacer la busqueda sin indice.
SELECT *
INTO venta_sin_indice
FROM venta_con_indice

-- Creamos un indice columnar en la tabla venta_con_indice
CREATE COLUMNSTORE INDEX IDX_columnstore_venta
ON venta_con_indice(total,fecha);

-- Primero, probemos el tiempo de ejecucion de la tabla sin indice columnar
SELECT venta_id, YEAR(fecha) AS Año, MONTH(fecha) AS Mes, SUM(total) AS Total_Ventas
FROM venta_sin_indice
WHERE fecha BETWEEN '2015-01-01' AND '2020-12-31'  -- Filtra directamente por rango de fecha
GROUP BY venta_id, YEAR(fecha), MONTH(fecha)
ORDER BY Total_Ventas DESC;

-- Segundo, probemos el tiempo de ejecucion de la tabla con indice
SELECT venta_id, YEAR(fecha) AS Año, MONTH(fecha) AS Mes, SUM(total) AS Total_Ventas
FROM venta_con_indice
WHERE fecha BETWEEN '2015-01-01' AND '2020-12-31'  -- Filtra directamente por rango de fecha
GROUP BY venta_id, YEAR(fecha), MONTH(fecha)
ORDER BY Total_Ventas DESC;

------------------------------------------ RESULTADOS --------------------------------------------------------


-------- 1er prueba:
-- 599.652 registros
-- Sin indice: CPU time = 5813 ms,  elapsed time = 26556 ms.
-- Con indice: CPU time = 2578 ms,  elapsed time = 27409 ms.

-------- 2da prueba:
-- 599.652 registros
-- Sin indice: CPU time = 5687 ms,  elapsed time = 25766 ms.
-- Con indice: CPU time = 2672 ms,  elapsed time = 24376 ms.

-------- 3era prueba:
-- 599.652 registros
-- Sin indice: CPU time = 6063 ms,  elapsed time = 33660 ms.
-- Con indice: CPU time = 2906 ms,  elapsed time = 22726 ms.

-------- 4ta prueba:
-- 599.652 registros
-- Sin indice: CPU time = 5797 ms,  elapsed time = 37129 ms.
-- Con indice: CPU time = 2719 ms,  elapsed time = 40282 ms.

-------- 5ta prueba:
-- 599.652 registros
-- Sin indice: CPU time = 6016 ms,  elapsed time = 26336 ms.
-- Con indice: CPU time = 2890 ms,  elapsed time = 22542 ms.




