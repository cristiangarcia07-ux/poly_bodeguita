-- SOLUCIONES EXAMEN BBDD: POLY BODEGUITA

-- 1. El rey de los costes
SELECT p.nombre, 
       COUNT(i.id) AS num_ingredientes,
       GROUP_CONCAT(i.descripcion SEPARATOR ', ') AS lista_ingredientes,
       ROUND(SUM(ip.cantidadracioncompletaenkg * i.precio_x_euro), 2) AS coste_fabricacion
FROM platos p
INNER JOIN ingrediente_plato ip ON p.id = ip.plato_id
INNER JOIN Ingredientes i ON ip.ingrediente_id = i.id
GROUP BY p.id, p.nombre
ORDER BY coste_fabricacion DESC
LIMIT 1;

-- 2. Los ingredientes ignorados
SELECT i.descripcion
FROM Ingredientes i
WHERE i.id NOT IN (
    SELECT DISTINCT ip.ingrediente_id
    FROM ingrediente_plato ip
    INNER JOIN platos_pedidos pp ON ip.plato_id = pp.plato_id
    INNER JOIN pedidos p ON pp.pedido_id = p.id
    INNER JOIN empleados e ON p.empleado_id = e.id
    WHERE p.es_a_domicilio = TRUE 
    AND e.nombre LIKE 'P%'
);

-- 3. El Benefactor Supremo (Sin CASE WHEN ni CTE)
SELECT c.email, c.nombre, COALESCE(ing.total_ingreso, 0) - COALESCE(ca.coste_final, 0) AS beneficio_global
FROM clientes c
INNER JOIN (
    SELECT p.cliente_id, SUM(pp.precio_unitario * pp.cantidad) as total_ingreso
    FROM pedidos p
    INNER JOIN platos_pedidos pp ON p.id = pp.pedido_id
    GROUP BY p.cliente_id
) ing ON c.id = ing.cliente_id
LEFT JOIN (
    SELECT cliente_id, SUM(total_coste) as coste_final
    FROM (
        SELECT p.cliente_id, SUM(ip.cantidadracioncompletaenkg * i.precio_x_euro * pp.cantidad) as total_coste
        FROM pedidos p
        INNER JOIN platos_pedidos pp ON p.id = pp.pedido_id
        INNER JOIN ingrediente_plato ip ON pp.plato_id = ip.plato_id
        INNER JOIN Ingredientes i ON ip.ingrediente_id = i.id
        WHERE pp.tipo_racion = 'completa'
        GROUP BY p.cliente_id
        UNION ALL
        SELECT p.cliente_id, SUM(ip.cantidadracionmediaenkg * i.precio_x_euro * pp.cantidad) as total_coste
        FROM pedidos p
        INNER JOIN platos_pedidos pp ON p.id = pp.pedido_id
        INNER JOIN ingrediente_plato ip ON pp.plato_id = ip.plato_id
        INNER JOIN Ingredientes i ON ip.ingrediente_id = i.id
        WHERE pp.tipo_racion = 'media'
        GROUP BY p.cliente_id
    ) Costes
    GROUP BY cliente_id
) ca ON c.id = ca.cliente_id
ORDER BY beneficio_global DESC
LIMIT 1;

-- 4. El obseso del Aceite
SELECT c.nombre, c.apellido1, c.email, SUM(pp.cantidad) AS total_raciones_aceite
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
INNER JOIN platos_pedidos pp ON p.id = pp.pedido_id
INNER JOIN ingrediente_plato ip ON pp.plato_id = ip.plato_id
INNER JOIN Ingredientes i ON ip.ingrediente_id = i.id
WHERE i.descripcion = 'Aceite de Oliva Virgen Extra'
GROUP BY c.id, c.nombre, c.apellido1, c.email
ORDER BY total_raciones_aceite DESC
LIMIT 1;

-- 5. Rendimiento Anual Reescrito (Sin CASE WHEN, CTE ni Subconsultas)
SELECT e.usuario, 
       SUM(p.total * p.es_a_domicilio) AS facturado_domicilio, 
       SUM(p.total * (1 - p.es_a_domicilio)) AS facturado_local
FROM empleados e
LEFT JOIN pedidos p ON e.id = p.empleado_id
GROUP BY e.id, e.usuario;

-- 6. El más barato y el más caro
(SELECT 'MAS BARATO' as tipo, p.id, p.total, c.nombre, d.Direccion
 FROM pedidos p
 INNER JOIN clientes c ON p.cliente_id = c.id
 LEFT JOIN Direcciones d ON p.direccion_id = d.id
 ORDER BY p.total ASC LIMIT 1)
UNION ALL
(SELECT 'MAS CARO' as tipo, p.id, p.total, c.nombre, d.Direccion
 FROM pedidos p
 INNER JOIN clientes c ON p.cliente_id = c.id
 LEFT JOIN Direcciones d ON p.direccion_id = d.id
 ORDER BY p.total DESC LIMIT 1);

-- 7. El Paladar del Centro
SELECT pl.nombre 
FROM platos pl
WHERE pl.id IN (
    SELECT DISTINCT pp.plato_id
    FROM platos_pedidos pp
    INNER JOIN pedidos p ON pp.pedido_id = p.id
    INNER JOIN Direcciones d ON p.direccion_id = d.id
    WHERE d.codigo_postal = '41004'
) 
AND pl.id NOT IN (
    SELECT DISTINCT pp.plato_id
    FROM platos_pedidos pp
    INNER JOIN pedidos p ON pp.pedido_id = p.id
    INNER JOIN Direcciones d ON p.direccion_id = d.id
    WHERE d.codigo_postal != '41004' OR d.codigo_postal IS NULL
);

-- 8. Dominios Corporativos
SELECT c.email, SUM(p.total) as GastoValido
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
WHERE c.email LIKE '%@ejemplo.com'
  AND p.id NOT IN (
      SELECT pedido_id FROM platos_pedidos WHERE tipo_racion = 'completa'
  )
GROUP BY c.email;

-- 9. Distribución Geográfica Urbana
SELECT d.codigo_postal, 
       COUNT(DISTINCT c.id) AS recuento_clientes,
       COALESCE(SUM(p.total), 0) AS volumen_gasto_aportado
FROM Direcciones d
LEFT JOIN cliente_direccion cd ON d.id = cd.direccion_id
LEFT JOIN clientes c ON cd.cliente_id = c.id
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY d.codigo_postal
ORDER BY volumen_gasto_aportado DESC;

-- 10. Rendimiento de Mozos (Múltiples Tablas)
SELECT e.nombre, 
       COUNT(p.id) AS numero_de_pedidos_grandes,
       AVG(p.total) AS media_dinero_por_pedido
FROM empleados e
INNER JOIN pedidos p ON e.id = p.empleado_id
INNER JOIN (
    SELECT pedido_id
    FROM platos_pedidos
    GROUP BY pedido_id
    HAVING COUNT(DISTINCT plato_id) >= 3
) p3 ON p.id = p3.pedido_id
GROUP BY e.id, e.nombre;

-- 11. Promoción Jeremías
SELECT c.nombre, d.id d.Direccion, COUNT(p.id) AS recuento_pedidos
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
INNER JOIN Direcciones d ON p.direccion_id = d.id
WHERE c.nombre LIKE 'jeremias%' AND p.es_a_domicilio = TRUE
GROUP BY c.id, c.nombre, d.id, d.Direccion
HAVING COUNT(p.id) >= 20
ORDER BY recuento_pedidos DESC;

-- ==========================================================
-- SOLUCIONES PROCEDIMIENTOS (Q12, Q13, Q14)
-- ==========================================================

-- 12. Automatización de Comandas (Creación)
SET @cliente = (SELECT id FROM clientes WHERE email = 'jeremiaselcocas@gmail.com');
SET @empleado = (SELECT id FROM empleados WHERE usuario = 'cruiz');
SET @direccion = (SELECT id FROM Direcciones WHERE Direccion = 'Calle Larios 12');
CALL AbrirPedido(@cliente, @empleado, @direccion, TRUE);

-- 13. Llenado (Lógica de Regalo)
SET @ultimo_pedido = (SELECT MAX(id) FROM pedidos);
SET @plato = (SELECT id FROM platos WHERE nombre = 'Secreto Ibérico');
CALL AñadirPlatoAPedido(@ultimo_pedido, TRUE, @plato, 'completa', 5);
-- 14. Finalización de Ticket (IVA)
SET @ultimo_pedido = (SELECT MAX(id) FROM pedidos);
SET @plato = (SELECT id FROM platos WHERE nombre = 'Chuletas de Cordero');
CALL AñadirPlatoAPedido(@ultimo_pedido, FALSE, @plato, 'completa', 2);

