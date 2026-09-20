
--Pregunta 1 — Catálogo comercial activo

SELECT product_name,ROUND(unit_price::numeric,2)
FROM products
WHERE discontinued = 0 and unit_price between 10 and 50 
ORDER BY unit_price desc ;

-- Pregunta 2 — Concentración geográfica de la cartera
SELECT country as pais, count(customer_id) as num_clientes, count(city) as num_ciudades
FROM customers
group by country
	having count (distinct customer_id) >= 5;
	
-- Pregunta 3 — Alerta de reposición
SELECT product_name AS producto,
	units_in_stock AS stock, 
	reorder_level AS nivel_reposicion,
	units_on_order AS pedido_a_proveedor,
CASE WHEN units_in_stock = 0 THEN 'CRÍTICO'
	ELSE 'AVISO' END AS situacion
FROM products
WHERE discontinued = 0 AND units_on_order >= units_in_stock

-- Pregunta 4 — Ficha completa de producto
SELECT p.product_name AS producto,
	c.category_name AS categoria,
	s.company_name AS proveedor,
	s.country AS pais,
	s.city AS ciudad
FROM products p INNER JOIN categories c ON p.category_id = c.category_id
	INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE s.country IN ('Spain','France','Italy');

--Pregunta 5 - Detalle valorizado de un pedido
SELECT 
    c.company_name AS cliente,
    o.order_date AS fecha_pedido,
    p.product_name AS producto,
    od.unit_price AS precio_unitario,
    od.quantity AS cantidad,
    od.discount AS descuento,
    ROUND((od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) AS importe_linea
FROM orders o
INNER JOIN customers c USING (customer_id)
INNER JOIN order_details od USING (order_id)
INNER JOIN products p USING (product_id)
WHERE o.order_id = 10248;

-- Pregunta 6 - Ranking de categorías por facturación
SELECT 
    c.category_name AS categoria,
    COUNT(od.product_id) AS num_lineas,
    COUNT(DISTINCT p.product_id) AS num_productos,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) AS facturacion
FROM categories c
INNER JOIN products p ON c.category_id = p.category_id
INNER JOIN order_details od ON p.product_id = od.product_id
GROUP BY c.category_name
HAVING ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) > 100000
ORDER BY facturacion DESC;


--
--Pregunta 7 — Clientes sin actividad comercial

SELECT c.contact_name,
max(o.order_date) AS ultimo_pedido,
count(o.order_id) AS numero_pedidos,
CASE
	WHEN count(o.order_id) = 0 THEN 'SIN PEDIDOS'
	ELSE 'CON PEDIDOS' 
END AS texto
FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.contact_name

-- Pregunta 8
SELECT 
    emp.first_name || ' ' || emp.last_name AS empleado,
    emp.title AS cargo,
    COALESCE(jefe.first_name || ' ' || jefe.last_name, 'DIRECCIÓN GENERAL') AS responsable,
    jefe.title AS cargo_responsable
FROM employees emp
LEFT JOIN employees jefe ON emp.reports_to = jefe.employee_id;

-- Pregunta 9 
WITH anios AS (
    SELECT DISTINCT EXTRACT(YEAR FROM order_date) AS anio FROM orders
),
facturacion_real AS (
    SELECT 
        p.category_id,
        EXTRACT(YEAR FROM o.order_date) AS anio,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS facturacion
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY p.category_id, EXTRACT(YEAR FROM o.order_date)
)
SELECT 
    c.category_name AS categoria,
    a.anio AS anio,
    COALESCE(ROUND(f.facturacion::numeric, 2), 0) AS facturacion
FROM categories c
CROSS JOIN anios a
LEFT JOIN facturacion_real f ON c.category_id = f.category_id AND a.anio = f.anio
ORDER BY c.category_name, a.anio;

-- Pregunta 10 
SELECT 
    COALESCE(c.country, s.country) AS pais,
    COALESCE(c.num_clientes, 0) AS num_clientes,
    COALESCE(s.num_proveedores, 0) AS num_proveedores,
    CASE 
        WHEN c.num_clientes IS NOT NULL AND s.num_proveedores IS NOT NULL THEN 'AMBOS'
        WHEN c.num_clientes IS NOT NULL THEN 'SOLO CLIENTES'
        ELSE 'SOLO PROVEEDORES'
    END AS tipo_presencia
FROM (
    SELECT country, COUNT(customer_id) AS num_clientes 
    FROM customers GROUP BY country
) c
FULL JOIN (
    SELECT country, COUNT(supplier_id) AS num_proveedores 
    FROM suppliers GROUP BY country
) s ON c.country = s.country;


-- Pregunta 11
SELECT 
    'CLIENTE' AS origen,
    UPPER(contact_name) AS contacto,
    company_name AS organizacion,
    city AS ciudad,
    country AS pais
FROM customers
UNION ALL
SELECT 
    'EMPLEADO' AS origen,
    UPPER(first_name || ' ' || last_name) AS contacto,
    'NORTHWIND TRADERS' AS organizacion,
    city AS ciudad,
    country AS pais
FROM employees
UNION ALL
SELECT 
    'PROVEEDOR' AS origen,
    UPPER(contact_name) AS contacto,
    company_name AS organizacion,
    city AS ciudad,
    country AS pais
FROM suppliers
ORDER BY origen, pais;

--Pregunta 12
-- a: No coincidencia
SELECT country AS pais 
FROM customers
EXCEPT
SELECT country AS pais
FROM suppliers

-- b: coincidencia
SELECT country AS pais 
FROM customers
INTERSECT
SELECT country AS pais
FROM suppliers

--Pregunta 13 — Clientes que nunca han comprado pescado

SELECT 
    c.company_name AS cliente,
    c.country AS pais,
    COUNT(o.order_id) AS pedidos_realizados
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o2
    INNER JOIN order_details od ON o2.order_id = od.order_id
    INNER JOIN products p ON od.product_id = p.product_id
    INNER JOIN categories cat ON p.category_id = cat.category_id
    WHERE o2.customer_id = c.customer_id 
      AND cat.category_name = 'Seafood'
)
GROUP BY c.company_name, c.country
ORDER BY pedidos_realizados DESC;

--Pregunta 14 - Productos por encima de la media
SELECT 
    product_name AS producto,
    ROUND(unit_price::numeric, 2) AS precio,
    ROUND((SELECT AVG(unit_price) FROM products)::numeric, 2) AS precio_medio_catalogo,
    ROUND((unit_price - (SELECT AVG(unit_price) FROM products))::numeric, 2) AS diferencia
FROM products
WHERE discontinued = 0 
  AND unit_price > (SELECT AVG(unit_price) FROM products)
ORDER BY diferencia DESC;

-- Pregunta 15 - Ticket medio por cliente

SELECT 
    c.company_name AS cliente,
    c.country AS pais,
    COUNT(t.order_id) AS num_pedidos,
    ROUND(SUM(t.importe_pedido)::numeric, 2) AS importe_total,
    ROUND(AVG(t.importe_pedido)::numeric, 2) AS ticket_medio
FROM customers c
INNER JOIN (
    SELECT 
        o.customer_id, 
        o.order_id, 
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS importe_pedido
    FROM orders o
    INNER JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.customer_id, o.order_id
) AS t ON c.customer_id = t.customer_id
GROUP BY c.company_name, c.country
ORDER BY ticket_medio DESC
LIMIT 15;


-- Pregunta 16 — El producto más caro de cada categoría
SELECT 
    c.category_name AS categoria,
    p.product_name AS producto,
    p.unit_price AS precio,
    (
        SELECT AVG(p2.unit_price) 
        FROM products p2 
        WHERE p2.category_id = p.category_id
    ) AS precio_medio_categoria
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE p.unit_price = (
    SELECT MAX(p3.unit_price) 
    FROM products p3 
    WHERE p3.category_id = p.category_id
);

-- Pregunta 17 — Segmentación ABC de la cartera de clientes
WITH facturacion_clientes AS (
    SELECT 
        customer_id,
        SUM(unit_price * quantity * (1 - discount)) AS facturacion_total
    FROM orders
    JOIN order_details USING (order_id)
    GROUP BY customer_id
),
cuartiles_clientes AS (
    SELECT 
        customer_id,
        facturacion_total,
        NTILE(4) OVER (ORDER BY facturacion_total DESC) AS cuartil
    FROM facturacion_clientes
),
segmentos_clientes AS (
    SELECT 
        customer_id,
        facturacion_total,
        CASE cuartil
            WHEN 1 THEN 'A - Estratégico'
            WHEN 2 THEN 'B - Consolidado'
            WHEN 3 THEN 'C - Ocasional'
            ELSE 'D - Marginal'
        END AS segmento
    FROM cuartiles_clientes
),
total_compania AS (
    SELECT SUM(facturacion_total) AS total_global FROM facturacion_clientes
)
SELECT 
    s.segmento,
    COUNT(s.customer_id) AS num_clientes,
    SUM(s.facturacion_total) AS facturacion_segmento,
    ROUND(SUM(s.facturacion_total::numeric) * 100.0 / tc.total_global::numeric, 2) AS porcentaje_sobre_total
FROM segmentos_clientes s
CROSS JOIN total_compania tc
GROUP BY s.segmento, tc.total_global
ORDER BY s.segmento;

-- Pregunta 18 — Los tres productos más vendidos de cada categoría
WITH ventas_productos AS (
    SELECT 
        c.category_name AS categoria,
        p.product_name AS producto,
        SUM(od.quantity) AS unidades,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS facturacion
    FROM categories c
    JOIN products p USING (category_id)
    JOIN order_details od USING (product_id)
    GROUP BY c.category_name, p.product_name
),
ranking_productos AS (
    SELECT 
        categoria,
        producto,
        unidades,
        facturacion,
        ROW_NUMBER() OVER (PARTITION BY categoria ORDER BY facturacion DESC) AS posicion_en_categoria,
        ROW_NUMBER() OVER (ORDER BY facturacion DESC) AS posicion_global
    FROM ventas_productos
)
SELECT 
    categoria,
    posicion_en_categoria,
    producto,
    unidades,
    facturacion,
    posicion_global
FROM ranking_productos
WHERE posicion_en_categoria <= 3;

--Pregunta 19 — Evolución mensual con acumulado y media móvil

WITH ventas_mensuales AS (
    SELECT 
        DATE_TRUNC('month', order_date)::DATE AS mes,
        SUM(unit_price * quantity * (1 - discount)) AS facturacion
    FROM orders
    JOIN order_details USING (order_id)
    WHERE EXTRACT(YEAR FROM order_date) = 1997
    GROUP BY DATE_TRUNC('month', order_date)
),
calculos_ventana AS (
    SELECT 
        mes,
        facturacion,
        SUM(facturacion) OVER (ORDER BY mes) AS acumulado,
        AVG(facturacion) OVER (ORDER BY mes ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS media_movil_3m,
        LAG(facturacion, 1) OVER (ORDER BY mes) AS mes_anterior
    FROM ventas_mensuales
)
SELECT 
    mes,
    facturacion,
    acumulado,
    media_movil_3m,
    mes_anterior,
    CASE 
        WHEN mes_anterior IS NULL OR mes_anterior = 0 THEN NULL
        ELSE ROUND(((facturacion::numeric - mes_anterior::numeric) / mes_anterior::numeric) * 100, 2)
    END AS variacion_pct
FROM calculos_ventana
ORDER BY mes;

-- Pregunta 20 - Cuadro de mando anual por categoría

WITH pivot_anual AS (
    SELECT 
        COALESCE(c.category_name, 'TOTAL GENERAL') AS categoria,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) FILTER (WHERE EXTRACT(YEAR FROM o.order_date) = 1996) AS f_1996,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) FILTER (WHERE EXTRACT(YEAR FROM o.order_date) = 1997) AS f_1997,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) FILTER (WHERE EXTRACT(YEAR FROM o.order_date) = 1998) AS f_1998,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total
    FROM categories c
    JOIN products p ON c.category_id = p.category_id
    JOIN order_details od ON p.product_id = od.product_id
    JOIN orders o ON od.order_id = o.order_id
    GROUP BY ROLLUP(c.category_name)
)
SELECT 
    categoria,
    COALESCE(ROUND(f_1996::numeric, 2), 0) AS f_1996,
    COALESCE(ROUND(f_1997::numeric, 2), 0) AS f_1997,
    COALESCE(ROUND(f_1998::numeric, 2), 0) AS f_1998,
    ROUND(total::numeric, 2) AS total,
    ROUND((total / MAX(total) OVER () * 100)::numeric, 2) AS peso_pct,
    CASE 
        WHEN categoria = 'TOTAL GENERAL' THEN NULL
        WHEN f_1998 > f_1997 THEN 'CRECIMIENTO'
        WHEN f_1998 < f_1997 THEN 'DECRECIMIENTO'
        ELSE 'MANTENIDO'
    END AS tendencia
    /* Nota: La tendencia entre 1997 y 1998 no es del todo representativa ni 
       directamente comparable, ya que los datos de 1998 finalizan en el mes de mayo. */
FROM pivot_anual
ORDER BY 
    CASE WHEN categoria = 'TOTAL GENERAL' THEN 1 ELSE 0 END, 
    total DESC;

	
