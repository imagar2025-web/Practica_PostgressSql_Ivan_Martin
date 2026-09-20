# Respuestas — Northwind SQL

## Sección 1. Fundamentos: filtrado y agregación

## Pregunta 1 — Catálogo comercial activo

**Enunciado:** Obtén los productos que no están descatalogados y cuyo precio unitario esté entre 10 y 50 euros, ambos incluidos. Muestra el nombre del producto y su precio redondeado a dos decimales, ordenado de mayor a menor precio.

**Columnas esperadas:** `producto`, `precio`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [
SELECT product_name,ROUND(unit_price::numeric,2)
FROM products
WHERE discontinued = 0 and unit_price between 10 and 50
ORDER BY unit_price desc ;]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 1 en pgAdmin, con cabeceras de columna visibles](img/p01.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — técnicas elegidas, alternativas descartadas, qué te sorprendió del resultado]**

## Pregunta 2 — Concentración geográfica de la cartera

**Enunciado:** Cuenta cuántos clientes hay en cada país y muestra únicamente aquellos países con 5 o más clientes, ordenados de mayor a menor. Indica también cuántas ciudades distintas hay en cada uno de esos países.

**Columnas esperadas:** `pais`, `num_clientes`, `num_ciudades`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 2 en pgAdmin, con cabeceras de columna visibles](img/p02.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — técnicas elegidas, alternativas descartadas, qué te sorprendió del resultado]**

## Pregunta 3 — Alerta de reposición

**Enunciado:** Localiza los productos activos cuyas unidades en stock sean inferiores o iguales a su nivel de reposición. Muestra el nombre, las unidades en stock, el nivel de reposición, las unidades ya pedidas al proveedor y una columna de texto que indique 'CRÍTICO' cuando el stock sea 0 y 'AVISO' en el resto de casos.

**Columnas esperadas:** `producto`, `stock`, `nivel_reposicion`, `pedido_a_proveedor`, `situacion`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 3 en pgAdmin, con cabeceras de columna visibles](img/p03.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — técnicas elegidas, alternativas descartadas, qué te sorprendió del resultado]**

## Sección 2. INNER JOIN

## Pregunta 4 — Ficha completa de producto

**Enunciado:** Para los productos suministrados por empresas de Italia, Francia o España, muestra el nombre del producto, el nombre de la categoría, el nombre del proveedor, su país y su ciudad. Ordena por país y, dentro de cada país, por nombre de producto.

**Columnas esperadas:** `producto`, `categoria`, `proveedor`, `pais`, `ciudad`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 4 en pgAdmin, con cabeceras de columna visibles](img/p04.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — técnicas elegidas, alternativas descartadas, qué te sorprendió del resultado]**

## Pregunta 5 — Detalle valorizado de un pedido

**Enunciado:** Muestra, para el pedido 10248, el nombre del producto, el precio unitario aplicado, la cantidad, el descuento y el importe final de cada línea. Añade el nombre del cliente y la fecha del pedido.

**Columnas esperadas:** `cliente`, `fecha_pedido`, `producto`, `precio_unitario`, `cantidad`, `descuento`, `importe_linea`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 5 en pgAdmin, con cabeceras de columna visibles](img/p05.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — técnicas elegidas, alternativas descartadas, qué te sorprendió del resultado]**

## Pregunta 6 — Ranking de categorías por facturación

**Enunciado:** Calcula la facturación total de cada categoría durante toda la historia de la compañía. Muestra el nombre de la categoría, el número de líneas de pedido que ha generado, el número de productos distintos vendidos y la facturación total. Incluye únicamente las categorías que superen los 100.000 euros de facturación, ordenadas de mayor a menor.

**Columnas esperadas:** `categoria`, `num_lineas`, `num_productos`, `facturacion`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 6 en pgAdmin, con cabeceras de columna visibles](img/p06.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — técnicas elegidas, alternativas descartadas, qué te sorprendió del resultado]**

## Sección 3. Uniones externas, reflexivas y cruzadas

## Pregunta 7 — Clientes sin actividad comercial

**Enunciado:** Lista todos los clientes con el número de pedidos que ha realizado cada uno y la fecha de su último pedido. Los clientes sin ningún pedido deben aparecer igualmente, con un 0 en el conteo y el texto 'SIN PEDIDOS' en lugar de la fecha. Ordena de forma que los clientes inactivos aparezcan primero.

**Columnas esperadas:** `cliente`, `pais`, `num_pedidos`, `ultimo_pedido`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 7 en pgAdmin, con cabeceras de columna visibles](img/p07.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — técnicas elegidas, alternativas descartadas, qué te sorprendió del resultado]**

## Pregunta 8 — Organigrama de la fuerza de ventas

**Enunciado:** Muestra cada empleado con su nombre completo, su cargo, el nombre completo de la persona a la que reporta y el cargo de esa persona. El empleado que no reporta a nadie debe aparecer también, con el texto 'DIRECCIÓN GENERAL' en el campo del responsable.

**Columnas esperadas:** `empleado`, `cargo`, `responsable`, `cargo_responsable`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
[RELLENAR: escribe aquí tu consulta SQL]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 8 en pgAdmin, con cabeceras de columna visibles](img/p08.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — técnicas elegidas, alternativas descartadas, qué te sorprendió del resultado]**

## Pregunta 9 — Rejilla de cobertura categoría × año

**Enunciado:** Genera todas las combinaciones posibles de las 8 categorías con los 3 años del histórico (24 filas) y asocia a cada combinación su facturación, sin huecos: si una categoría no vendió nada en un año concreto, debe aparecer con un 0. Ordena por categoría y año.

**Columnas esperadas:** `categoria`, `anio`, `facturacion`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 9 en pgAdmin, con cabeceras de columna visibles](img/p09.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — técnicas elegidas, alternativas descartadas, qué te sorprendió del resultado]**

## Pregunta 10 — Mapa de países: clientes frente a proveedores

**Enunciado:** Muestra, para cada país en el que la compañía tiene presencia, cuántos clientes y cuántos proveedores hay. Deben aparecer los países que solo tienen clientes, los que solo tienen proveedores y los que tienen ambos, indicando el tipo de presencia.

**Columnas esperadas:** `pais`, `num_clientes`, `num_proveedores`, `tipo_presencia` (`'SOLO CLIENTES'`, `'SOLO PROVEEDORES'` o `'AMBOS'`)

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 10 en pgAdmin, con cabeceras de columna visibles](img/p10.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — técnicas elegidas, alternativas descartadas, qué te sorprendió del resultado]**

## Sección 4. Operadores de conjunto

## Pregunta 11 — Directorio unificado de contactos

**Enunciado:** Construye una sola tabla que reúna los contactos de clientes, los de proveedores y los empleados. Cada fila debe indicar el origen ('CLIENTE', 'PROVEEDOR', 'EMPLEADO'), el nombre de la persona de contacto en mayúsculas, la organización a la que pertenece, la ciudad y el país. Para los empleados, la organización es el literal 'NORTHWIND TRADERS' y el nombre de contacto se forma concatenando nombre y apellidos. Ordena por origen y luego por país.

**Columnas esperadas:** `origen`, `contacto`, `organizacion`, `ciudad`, `pais`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 11 en pgAdmin, con cabeceras de columna visibles](img/p11.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — técnicas elegidas, alternativas descartadas, qué te sorprendió del resultado. Razona por qué aquí conviene UNION ALL y no UNION]**

## Pregunta 12 — Mercados con desequilibrio

**Enunciado:** Resuelve en dos consultas independientes: a) países donde hay clientes pero ningún proveedor; b) países donde hay a la vez clientes y proveedores. Ordena ambos resultados alfabéticamente.

**Columnas esperadas:** `pais`

**Consulta (a):**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL del apartado a]
```

**Consulta (b):**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL del apartado b]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 12, apartado a](img/p12a.png)`
>
> `![Insertar captura de: Resultado de la Pregunta 12, apartado b](img/p12b.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — compara el resultado del apartado a con lo que obtendrías usando un LEFT JOIN ... WHERE ... IS NULL]**

## Sección 5. Subconsultas

## Pregunta 13 — Clientes que nunca han comprado pescado

**Enunciado:** Localiza los clientes que nunca han incluido un producto de la categoría 'Seafood' en ninguno de sus pedidos. Muestra el nombre del cliente, su país y el número total de pedidos que sí ha realizado, de mayor a menor.

**Columnas esperadas:** `cliente`, `pais`, `pedidos_realizados`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL con NOT EXISTS]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 13 en pgAdmin, con cabeceras de columna visibles](img/p13.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así con NOT EXISTS, y comenta qué ocurre si se prueba con NOT IN cuando la subconsulta puede devolver NULL]**

## Pregunta 14 — Productos por encima de la media

**Enunciado:** Muestra los productos activos cuyo precio unitario supere el precio medio de todo el catálogo. Incluye en cada fila el precio del producto, el precio medio general y la diferencia entre ambos, todo redondeado a dos decimales. Ordena por diferencia descendente.

**Columnas esperadas:** `producto`, `precio`, `precio_medio_catalogo`, `diferencia`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 14 en pgAdmin, con cabeceras de columna visibles](img/p14.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — técnicas elegidas, alternativas descartadas, qué te sorprendió del resultado]**

## Pregunta 15 — Ticket medio por cliente

**Enunciado:** Calcula, para cada cliente que haya comprado alguna vez, el número de pedidos, el importe total acumulado y el importe medio por pedido. Muestra los 15 clientes con mayor ticket medio. El importe de cada pedido se obtiene sumando sus líneas; el promedio se calcula después, sobre esos importes por pedido, no directamente sobre las líneas.

**Columnas esperadas:** `cliente`, `pais`, `num_pedidos`, `importe_total`, `ticket_medio`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL con subconsulta en FROM]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 15 en pgAdmin, con cabeceras de columna visibles](img/p15.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — por qué la agregación en dos niveles es necesaria]**

## Sección 6. Subconsultas correlacionadas y CTE

## Pregunta 16 — El producto más caro de cada categoría

**Enunciado:** Para cada categoría, muestra el producto con el precio unitario más alto. Incluye el nombre de la categoría, el nombre del producto, su precio y el precio medio de su categoría. Resuélvelo con una subconsulta correlacionada.

**Columnas esperadas:** `categoria`, `producto`, `precio`, `precio_medio_categoria`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL con subconsulta correlacionada]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 16 en pgAdmin, con cabeceras de columna visibles](img/p16.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así, y qué coste tendría este planteamiento sobre una tabla de diez millones de filas]**

## Pregunta 17 — Segmentación ABC de la cartera de clientes

**Enunciado:** Usando CTE, calcula la facturación total de cada cliente, divide los clientes en cuartiles según esa facturación, asigna una etiqueta de segmento ('A - Estratégico', 'B - Consolidado', 'C - Ocasional', 'D - Marginal') y devuelve, por segmento, el número de clientes, la facturación total del segmento y el porcentaje que representa sobre el total de la compañía.

**Columnas esperadas:** `segmento`, `num_clientes`, `facturacion_segmento`, `porcentaje_sobre_total`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL con WITH / NTILE()]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 17 en pgAdmin, con cabeceras de columna visibles](img/p17.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así — cómo encadenaste las CTE]**

## Sección 7. Funciones de ventana

## Pregunta 18 — Los tres productos más vendidos de cada categoría

**Enunciado:** Para cada categoría, obtén los tres productos con mayor facturación. Muestra la categoría, la posición dentro de la categoría, el nombre del producto, las unidades vendidas y la facturación. Incluye además una columna con la posición global del producto en el conjunto de la compañía.

**Columnas esperadas:** `categoria`, `posicion_en_categoria`, `producto`, `unidades`, `facturacion`, `posicion_global`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL con RANK()/ROW_NUMBER() y PARTITION BY]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 18 en pgAdmin, con cabeceras de columna visibles](img/p18.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así, y qué diferencia habría entre RANK(), DENSE_RANK() y ROW_NUMBER() si dos productos empatasen]**

## Pregunta 19 — Evolución mensual con acumulado y media móvil

**Enunciado:** Para cada mes de 1997, calcula: la facturación del mes, el total acumulado desde enero, la media móvil de los tres últimos meses, la facturación del mes anterior y la variación porcentual respecto al mes anterior.

**Columnas esperadas:** `mes`, `facturacion`, `acumulado`, `media_movil_3m`, `mes_anterior`, `variacion_pct`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL con SUM() OVER, ROWS BETWEEN y LAG()]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 19 en pgAdmin, con cabeceras de columna visibles](img/p19.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así, qué marco de ventana usaste para la media móvil y qué decidiste mostrar en la primera fila sin mes anterior]**

## Pregunta 20 — Cuadro de mando anual por categoría

**Enunciado:** Construye una tabla donde cada fila sea una categoría y las columnas muestren la facturación de 1996, 1997 y 1998 en columnas separadas, más el total de los tres años. Añade una fila de totales generales, una columna con el peso de cada categoría sobre la facturación total de la compañía, y otra que muestre si la categoría creció o decreció entre 1997 y 1998.

**Columnas esperadas:** `categoria`, `f_1996`, `f_1997`, `f_1998`, `total`, `peso_pct`, `tendencia`

**Consulta:**

```sql
--  Comentario de una línea explicando qué devuelve esta consulta
 [RELLENAR: escribe aquí tu consulta SQL con pivotado (FILTER) y ROLLUP]
```

**Resultado:**

> `![Insertar captura de: Resultado de la Pregunta 20 en pgAdmin, con cabeceras de columna visibles](img/p20.png)`

**Comentario:**

> **[RELLENAR CON TUS PALABRAS: explica por qué has resuelto la consulta así, y comenta por qué la comparación de tendencia entre 1997 y 1998 no es directamente válida dado que ambos años tienen datos parciales]**
