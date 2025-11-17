# Tema 4: Indices Columnares #
### ¿Que Hacen los indices columnares? ###
Los indices columnares usan el almacenamiento de datos basado en columnas, lo que permite lograr ganancias de hasta 10 veces el rendimiento de las consultas en el almacenamiento de datos sobre el almacenamiento tradicional orientado a filas.

### ¿Cuando usar los indices columnares? ###
Es recomendable usar un indice columnar en los siguientes casos:
- Cuando se tienen que analizar grandes volúmenes de datos en bases de datos para data warehousing (OLAP) y se realizan operaciones de lectura intensivas, como agregaciones (SUM, AVG, COUNT).
- Son ideales para análisis operativos en tiempo real sobre tablas que son modificadas con frecuencia, usando un índice de almacén de columnas no agrupado.
- Tambien funcionan mejor con datos estáticos que no se actualizan o eliminan con frecuencia.

### ¿Cuando no es recomendable usar los indices columnares? ###
No es recomendable usar cuando:
- En tablas con muy pocos registros, el beneficio de los índices es mínimo o nulo, e incluso puede ser contraproducente.
- Si la columna que se intenta indexar se modifica con mucha frecuencia, cada actualización requerirá reordenar el índice, lo cual consume muchos recursos.
- Si la columna tiene muy pocos valores únicos (por ejemplo, una columna booleana o de estado), el índice no será muy útil.
- Columnas de texto o datos binarios muy grandes.
- Si la consulta utiliza la columna como filtro y devuelve un porcentaje muy alto (90% de la tabla como ejemplo)de los datos de la tabla, el índice no es beneficioso.

### Creacion de un indice columnar ###
` CREATE COLUMNSTORE INDEX idx_columnstore ON tabla `

### Eliminacion de un indice columnar ###
` DROP INDEX idx_columnstore ON tabla `

### Ventajas: ###

- Mejora el rendimiento de consultas analíticas complejas.
- Reduce el espacio en disco debido a la alta tasa de compresión de datos.
- Optimiza la velocidad de las consultas de agregación y filtrado, especialmente en grandes volúmenes de datos.

### Desventajas: ###

- No es adecuado para cargas de trabajo con muchas actualizaciones, inserciones o eliminaciones, ya que los índices Columnstore son más adecuados para consultas de solo lectura.

### Conclusiones: ###
EL uso de indice columnar en una tabla de datos mejora la eficiencia en las consultas, siempre y cuando se apliquen en los contextos correctos ya mencionados, en las pruebas tambien se pudo comprobar que su uso mejoro el rendimiento en la consulta, lo que demuestra que mejora las consultas que requieren un análisis intensivo de datos en grandes volúmenes.
