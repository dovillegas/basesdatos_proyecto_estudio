**Tema 3:**   
**Manejo de transacciones y transacciones anidadas**

Introducción

El manejo de transacciones en SQL garantiza que un conjunto de operaciones se ejecute como una unidad atómica: o se completan todas, o ninguna. Las transacciones anidadas son transacciones iniciadas dentro de otra transacción, pero en SQL Server no son independientes: solo la transacción externa controla el COMMIT o ROLLBACK.

Una transacción es un bloque de instrucciones que asegura las propiedades **ACID**:

* **Atomicidad**: todas las operaciones se ejecutan o ninguna.  
* **Consistencia**: la base de datos pasa de un estado válido a otro.  
* **Aislamiento**: los cambios no son visibles hasta que se confirma la transacción.  
* **Durabilidad**: una vez confirmada, los cambios son permanentes.


Manejo de transacciones

En SQL Server se manejan con:

* **BEGIN TRANSACTION** \-- inicia la transacción  
* **COMMIT** \-- confirma los cambios   
*  **ROLLBACK** \-- revierte los cambios

Ejemplo:

**BEGIN TRANSACTION**; \-- inicia la transacción

\-- bloque de operaciones DML (INSERT, UPDATE, DELETE)

UPDATE cuentas SET saldo \= saldo \- 100 WHERE id \= 1;

UPDATE cuentas SET saldo \= saldo \+ 100 WHERE id \= 2;

IF @@ERROR \<\> 0 – establece una condición para para revertir o confirmarlos

    **ROLLBACK**; \-- revierte los cambios

ELSE

    **COMMIT**;  \-- confirma los cambios

Transacciones anidadas

En SQL Server, cuando se ejecuta un `BEGIN TRANSACTION` dentro de otra transacción, no se crea una transacción independiente. En realidad, se incrementa un contador interno (`@@TRANCOUNT`).

* Cada **`BEGIN TRANSACTION`** aumenta el contador.  
* Cada **`COMMIT`** lo reduce en 1\.  
* Solo cuando el contador llega a 0 se confirma realmente la transacción.  
* Un **`ROLLBACK`** revierte toda la transacción, sin importar el nivel.  
* Si en el nivel interno se ejecuta **`ROLLBACK`**, se cancela toda la transacción, no solo la parte interna.

Ejemplo:

**BEGIN TRANSACTION**;   \-- @@TRANCOUNT \= 1

    UPDATE cuentas SET saldo \= saldo \- 100 WHERE id \= 1;

    **BEGIN TRANSACTION**;   \-- @@TRANCOUNT \= 2

        UPDATE cuentas SET saldo \= saldo \+ 100 WHERE id \= 2;

    **COMMIT**;              \-- @@TRANCOUNT \= 1

**COMMIT**;                  \-- @@TRANCOUNT \= 0 → se confirma todo

Control de errores en transacciones

Las transacciones permiten manejar errores con `TRY...CATCH` y decidir si confirmar (`COMMIT`) o revertir (`ROLLBACK`).

¿Por qué es importante?

* **Evita inconsistencias**: si una operación falla, no quedan datos parciales.  
* **Permite recuperación controlada**: podés revertir hasta un punto seguro.  
* **Facilita auditoría**: se pueden registrar los errores para análisis posterior.  
* **Mejora la robustez**: el sistema responde de forma predecible ante fallos.

En SQL Server los errores se manejan con:

* **BEGIN TRY**\-- Inicia control  
* **END TRY**\-- Termina control  
* **BEGIN CATCH** – Inicia captura de error  
* **END CATCH** – Termina captura de error  
* **ERROR\_MESSAGE()** → devuelve el texto del error para diagnóstico.

Ventajas:

* Proporcionar **durabilidad**: los cambios confirmados persisten incluso ante fallos del sistema.   
* Permitir el **control de errores** con **`TRY...CATCH`** y decidir entre **`COMMIT`** o **`ROLLBACK`**.  
* Asegurar el **aislamiento** entre procesos concurrentes, evitando lecturas sucias.  
* Evitar **datos intermedios inválidos** durante operaciones críticas.  
* Mejorar la **robustez y confiabilidad** de aplicaciones que dependen de la base de datos.  
* Simplificar la **auditoría** y trazabilidad de cambios, al agrupar operaciones en bloques lógicos.  
* Optimizar la **seguridad lógica**, asegurando que las reglas de negocio se cumplan de forma integral.

Conclusiones del tema