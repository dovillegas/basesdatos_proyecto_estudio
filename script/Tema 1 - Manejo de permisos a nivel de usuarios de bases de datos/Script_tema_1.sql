USE FORTSPORT;

/* 1. Permisos a nivel de usuarios: */

-- Creamos el login

CREATE LOGIN Alex_Admin WITH PASSWORD = 'alex1234';
CREATE LOGIN Federico_Vendedor WITH PASSWORD = 'federico1234';

-- Creamos dos usuarios para la base de datos

CREATE USER Alex FOR LOGIN Alex_Admin;
CREATE USER Federico FOR LOGIN Federico_Vendedor;

-- A un usuario darle el permiso de administrador
EXEC sp_addrolemember 'db_owner', 'Alex';
-- db_owner es un rol que otorga control total de la base de datos al susuario

-- A un usuario darle solo permiso de lectura.
GRANT SELECT ON SCHEMA::dbo TO Federico;

-- Uilizar Procedimientos almacenados creados anteriormente
-- Ejemplo
EXEC dbo.AgregarMetodoPago  @MetodoPagoId = 5, @DescripcionMetodoPago = 'Pix';

-- Al usuario con permiso de solo lectura, darle permiso de ejecución sobre este procedimiento
GRANT EXECUTE ON dbo.AgregarMetodoPago TO Federico;

--Realizar INSERT con sentencia SQL sobre la tabla del procedimiento con ambos usuarios.
-- INSERT con el usuario Alex
EXECUTE AS USER = 'Alex';

INSERT INTO pais (pais_nombre) VALUES ('China');
-- Resultado: (1 fila afectada) porque el usuario Alex tiene los permisos de Administrador y puede realizar inserciones en tablas.

-- INSERT con el usuario Federico

EXECUTE AS USER = 'Federico';

INSERT INTO pais (pais_nombre) VALUES ('Taiwán');
-- Resultado: Se denegó el permiso INSERT en el objeto 'pais', base de datos 'FORTSPORT', esquema 'dbo'.
-- Pues Federico sólo tiene permiso de lectura

-- Realizar un INSERT a través del procedimiento almacenado con el usuario con permiso de solo lectura.

EXECUTE AS USER = 'Federico';

EXEC dbo.AgregarMetodoPago  @MetodoPagoId = 6, @DescripcionMetodoPago = 'Paypal';

-- Resultado: Método de pago agregado correctamente. Ejecutó correctamente el procedimiento almacenado porque se le dió el permiso para hacerlo.
-- Además de solo lectura podrá ejecutar el procedimiento almacenado AgregarMetodoPago.

/* Permisos a nivel de roles del DBMS: */

-- Creamos dos inicios de sesión.
CREATE LOGIN VENDEDOR_ABRAHAM WITH PASSWORD = 'A1234567';
CREATE LOGIN SUPERVISOR_LUCAS WITH PASSWORD = 'L1234567';

CREATE USER VENDEDOR_ABRAHAM FOR LOGIN VENDEDOR_ABRAHAM;
CREATE USER SUPERVISOR_LUCAS FOR LOGIN SUPERVISOR_LUCAS;

-- Creamos un rol
CREATE ROLE lector_productos;

--Asignamos permisos al rol creado.
GRANT SELECT ON dbo.producto TO lector_productos;
GRANT SELECT ON dbo.categoria TO lector_productos;

-- Damos permiso a uno de los usuarios sobre el rol creado anteriormente.

ALTER ROLE lector_productos ADD MEMBER VENDEDOR_ABRAHAM;

-- Probamos con el usuario al que le asigtnamos el rol si puede consultar las tablas.
EXECUTE AS USER = 'VENDEDOR_ABRAHAM';

SELECT * FROM producto;

-- Resultado: Se listan las filas de la tabla productos pues este usuario tiene permiso de consultar esta tabla.

	select * from categoria; -- Tambien se muestran las filas de la tabla.
	select * from pais; -- No se puede ejecutar porque no se lee dió permiso de consultar esta tabla

-- Probamos con el usuario que no se le asignó el rol lector_productos
EXECUTE AS USER = 'SUPERVISOR_LUCAS';

SELECT * FROM PRODUCTO;
-- Resultado: Se denegó el permiso SELECT en el objeto 'producto'. Porque no se le asignó el rol ni se le dió permiso de lectura sobra la tabla.

/*Conclusión:
  El manejo de permisos y roles nos permite otorgar permisos a diferentes usuarios sobre qué puede hacer en la base de datos y lo que no puede hacer.
  Esto permite la seguridad de los datos almacenados, pues se puede permitir solo a alunas persona de una organización acceder a los datos,
  de esta manera se protege del mal uso de los datos o inclusive la pérdida de los mismos.











