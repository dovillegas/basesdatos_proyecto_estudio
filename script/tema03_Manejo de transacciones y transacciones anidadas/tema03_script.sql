/* 1) Escribir el código Transact SQL que permita definir una transacción consistente en: Insertar un registro en alguna tabla, 
luego otro registro en otra tabla y por último la actualización de uno o más registros en otra tabla. 
Actualizar los datos solamente si toda la operación es completada con éxito. */

-- Caso funcional de transacciones --

--inicio del bloque de prueba 1: Transacciones

BEGIN TRY
    -- Inicio del bloque de transaccion
    BEGIN TRANSACTION;

    -- Insert venta
    INSERT INTO venta (total, fecha, usuario_id, estado_pago_id)
    VALUES (15000.00, GETDATE(), 3, 1);

    -- Declara e intancia una variable con el id venta
    DECLARE @venta_id INT = SCOPE_IDENTITY(); -- obtener el ID de la venta recién creada

    -- Insert detalle_venta
    INSERT INTO detalle_venta (cantidad, precio_uni, talle_id, producto_id, venta_id)
    VALUES (2, 7500.00, 1, 1, @venta_id);

    -- Actualiza stock
    UPDATE stock_talle
    SET stock = stock - 2
    WHERE producto_id = 1 AND talle_id = 1;
    -- Termina la trasaccion con un mensaje
    COMMIT TRANSACTION;
    PRINT 'Transacción completada con exito';
END TRY
--En caso de darse un error realiza el siguiente bloque de codigo
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error en la transaccion' + ERROR_MESSAGE();
END CATCH;


-- Caso de fallo transaccion 1 --
    ;
BEGIN TRY
    -- Inicio del bloque de transaccion
    BEGIN TRANSACTION;

    -- Insert venta
    INSERT INTO venta (total, fecha, usuario_id, estado_pago_id)
    VALUES (15000.00, GETDATE(), 3, 4); -- Causa de fallo: el estado_pago_id  ingresado no existe en la tabla estado_pago

    -- Declara e intancia una variable con el id venta
    DECLARE @venta_id2 INT = SCOPE_IDENTITY(); -- obtener el ID de la venta recién creada

    -- Insert detalle_venta
    INSERT INTO detalle_venta (cantidad, precio_uni, talle_id, producto_id, venta_id)
    VALUES (2, 7500.00, 1, 1, @venta_id2);

    -- Actualiza stock
    UPDATE stock_talle
    SET stock = stock - 2
    WHERE producto_id = 1 AND talle_id = 1;
    -- Termina la trasaccion con un mensaje
    COMMIT TRANSACTION;
    PRINT 'Transacción completada con exito';
END TRY
--En caso de darse un error realiza el siguiente bloque de codigo
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error en la transaccion' + ERROR_MESSAGE();

    -- Verificacion caso de fallo 1 --
    --En caso de no existir venta_id devuelve 0 registros
    SELECT * FROM venta WHERE venta_id = ISNULL(@venta_id2, -1);
    SELECT * FROM detalle_venta WHERE venta_id = ISNULL(@venta_id2, -1);
    SELECT * FROM stock_talle WHERE producto_id = 1 AND talle_id = 1;
END CATCH;

-- Caso de fallo transaccion 2 --

BEGIN TRY
    -- Inicio del bloque de transaccion
    BEGIN TRANSACTION;

    -- Insert venta
    INSERT INTO venta (total, fecha, usuario_id, estado_pago_id)
    VALUES (15000.00, GETDATE(), 3, 2); 

    -- Declara e intancia una variable con el id venta
    DECLARE @venta_id3 INT = SCOPE_IDENTITY(); -- obtener el ID de la venta recién creada

    -- Insert detalle_venta
    INSERT INTO detalle_venta (cantidad, precio_uni, talle_id, producto_id, venta_id)
    VALUES (2, 7500.00, 1, 1, @venta_id3);

    -- Actualiza stock
    UPDATE stock_talle
    SET stock = stock - 99 -- Causa de fallo: el stock resultante es negativo, esto activa el check que restringe el valor de stock y causa un error
    WHERE producto_id = 1 AND talle_id = 1;
    -- Termina la trasaccion con un mensaje
    COMMIT TRANSACTION;
    PRINT 'Transacción completada con exito';
END TRY
--En caso de darse un error realiza el siguiente bloque de codigo
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error en la transaccion' + ERROR_MESSAGE();

    -- Verificacion caso de fallo 2 --
    --En caso de no existir venta_id devuelve 0 registros
    SELECT * FROM venta WHERE venta_id = ISNULL(@venta_id3, -1);
    SELECT * FROM detalle_venta WHERE venta_id = ISNULL(@venta_id3, -1);
    SELECT * FROM stock_talle WHERE producto_id = 1 AND talle_id = 1;
END CATCH;

-- Caso funcional de transacciones anidadas --

-- Inicio del bloque de prueba 2: Trasacciones anidadas

BEGIN TRY
    -- Transaccion principal
    BEGIN TRANSACTION;

    -- Insert venta
    INSERT INTO venta (total, fecha, usuario_id, estado_pago_id)
    VALUES (15000.00, GETDATE(), 3, 1);

    DECLARE @venta_id4 INT = SCOPE_IDENTITY(); -- obtener el ID de la venta recién creada

    -- Transacción anidada (incrementa @@TRANCOUNT)
    BEGIN TRANSACTION;
        -- Insert detalle_venta
        INSERT INTO detalle_venta (cantidad, precio_uni, talle_id, producto_id, venta_id)
        VALUES (2, 7500.00, 1, 1, @venta_id4);

        -- Savepoint para control parcial
        SAVE TRANSACTION punto_stock;

        -- Actualiza stock
        UPDATE stock_talle
        SET stock = stock - 2
        WHERE producto_id = 1 AND talle_id = 1;

        -- Si todo salio bien en la transaccion interna
        COMMIT TRANSACTION; -- reduce @@TRANCOUNT en 1
    -- Fin transacción anidada

    -- Confirma la transaccion principal
    COMMIT TRANSACTION; -- @@TRANCOUNT llega a 0 → se confirma todo
    PRINT 'Transacción completada con exito';
END TRY
BEGIN CATCH
    -- Si ocurre un error en cualquier nivel se revierte todo
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    PRINT 'Error en la transaccion: ' + ERROR_MESSAGE();

END CATCH;


-- Caso de fallo transaccion anidada 1 --

BEGIN TRY
    -- Transacción principal
    BEGIN TRANSACTION;

    -- Insert venta
    INSERT INTO venta (total, fecha, usuario_id, estado_pago_id)
    VALUES (15000.00, GETDATE(), 3, 1);

    DECLARE @venta_id5 INT = SCOPE_IDENTITY(); -- obtener el ID de la venta recién creada

    -- Transaccion anidada (incrementa @@TRANCOUNT)
    BEGIN TRANSACTION;
        -- Insert detalle_venta con un producto inexistente (violación de FK)
        INSERT INTO detalle_venta (cantidad, precio_uni, talle_id, producto_id, venta_id)
        VALUES (2, 7500.00, 1, 9999, @venta_id5);  -- producto_id = 9999 no existe

        -- Savepoint para control parcial
        SAVE TRANSACTION punto_stock;

        -- Actualiza stock
        UPDATE stock_talle
        SET stock = stock - 2
        WHERE producto_id = 1 AND talle_id = 1;

        -- Si todo salio bien en la transaccion interna
        COMMIT TRANSACTION; -- reduce @@TRANCOUNT en 1
    -- Fin transacción anidada

    -- Confirma la transacción principal
    COMMIT TRANSACTION; -- @@TRANCOUNT llega a 0 → se confirma todo
    PRINT 'Transacción completada con exito';
END TRY
BEGIN CATCH
    -- Si ocurre un error en cualquier nivel se revierte todo
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    PRINT 'Error en la transaccion: ' + ERROR_MESSAGE();

    -- Verificacion caso de fallo 3 --
    --En caso de no existir venta_id devuelve 0 registros
    SELECT * FROM venta WHERE venta_id = ISNULL(@venta_id5, -1);
    SELECT * FROM detalle_venta WHERE venta_id = ISNULL(@venta_id5, -1);
    SELECT * FROM stock_talle WHERE producto_id = 1 AND talle_id = 1;
END CATCH;


-- Caso de fallo transaccion anidada 2 --

BEGIN TRY
    -- Transacción principal
    BEGIN TRANSACTION;

    -- Insert venta con un usuario inexistente (violación de FK)
    INSERT INTO venta (total, fecha, usuario_id, estado_pago_id)
    VALUES (15000.00, GETDATE(), 9999, 1);  -- usuario_id = 9999 no existe

    DECLARE @venta_id6 INT = SCOPE_IDENTITY(); -- obtener el ID de la venta recién creada

    -- Transacción anidada (incrementa @@TRANCOUNT)
    BEGIN TRANSACTION;
        -- Insert detalle_venta
        INSERT INTO detalle_venta (cantidad, precio_uni, talle_id, producto_id, venta_id)
        VALUES (2, 7500.00, 1, 1, @venta_id6);

        -- Savepoint para control parcial
        SAVE TRANSACTION punto_stock;

        -- Actualiza stock
        UPDATE stock_talle
        SET stock = stock - 2
        WHERE producto_id = 1 AND talle_id = 1;

        -- Si todo salio bien en la transaccion interna
        COMMIT TRANSACTION; -- reduce @@TRANCOUNT en 1
    -- Fin transacción anidada

    -- Confirma la transacción principal
    COMMIT TRANSACTION; -- @@TRANCOUNT llega a 0 → se confirma todo
    PRINT 'Transacción completada con exito';
END TRY
BEGIN CATCH
    -- Si ocurre un error en cualquier nivel se revierte todo
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    PRINT 'Error en la transaccion: ' + ERROR_MESSAGE();

    -- Verificacion caso de fallo 4 --
    --En caso de no existir venta_id devuelve 0 registros
    SELECT * FROM venta WHERE venta_id = ISNULL(@venta_id6, -1);
    SELECT * FROM detalle_venta WHERE venta_id = ISNULL(@venta_id6, -1);
    SELECT * FROM stock_talle WHERE producto_id = 1 AND talle_id = 1;
END CATCH;