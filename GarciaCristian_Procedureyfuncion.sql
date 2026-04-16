DELIMITER //
CREATE PROCEDURE AbrirPedido(
    IN p_cliente_id INT,
    IN p_empleado_id INT,
    IN p_direccion_id INT,
    IN p_es_a_domicilio BOOLEAN
)
BEGIN
    -- Insertar el pedido con todo a cero y ABIERTO
    INSERT INTO pedidos (total, subtotal, cliente_id, empleado_id, es_a_domicilio, direccion_id, abierto)
    VALUES (0, 0, p_cliente_id, p_empleado_id, p_es_a_domicilio, p_direccion_id, TRUE);
    
    -- Consultar el pedido por ID para poder mostrarlo e identificarlo
    SELECT * FROM pedidos WHERE id = LAST_INSERT_ID();
END //

-- Procedimiento 2: Empezar Procedure (Añadir Plato)
CREATE PROCEDURE AñadirPlatoAPedido(
    IN p_pedido_id INT,
    IN p_gratis BOOLEAN,
    IN p_plato_id INT,
    IN p_tipo_racion VARCHAR(10),
    IN p_cantidad INT
)
BEGIN
    DECLARE v_precio_unitario DECIMAL(6,2);
    DECLARE v_subtotal_acumulado DECIMAL(10,2);
    DECLARE v_exists INT;

    -- Comprobar que el pedido existe
    SELECT COUNT(*) INTO v_exists FROM pedidos WHERE id = p_pedido_id;
    
    IF v_exists = 0 THEN
        -- Out: "el pedido no existe"
        SELECT 'Error: el pedido no existe' AS Resultado;
    ELSE
        -- Obtener el precio real del plato
        IF p_tipo_racion = 'media' THEN
            SELECT precio_x_media_racion INTO v_precio_unitario FROM platos WHERE id = p_plato_id;
        ELSE
            SELECT precio_x_racion INTO v_precio_unitario FROM platos WHERE id = p_plato_id;
        END IF;

        -- Determinar precio unitario según si es gratis
        IF p_gratis = TRUE THEN
            SET v_precio_unitario = 0;
        END IF;

        -- Insertar los productos en platos_pedidos
        INSERT INTO platos_pedidos (pedido_id, plato_id, tipo_racion, cantidad, precio_unitario)
        VALUES (p_pedido_id, p_plato_id, p_tipo_racion, p_cantidad, v_precio_unitario)
        ON DUPLICATE KEY UPDATE 
            cantidad = cantidad + p_cantidad,
            precio_unitario = VALUES(precio_unitario);

        -- Sumar los productos y meterlos al subtotal
        SELECT SUM(cantidad * precio_unitario) INTO v_subtotal_acumulado 
        FROM platos_pedidos 
        WHERE pedido_id = p_pedido_id;

        -- Multiplicar subtotal por el IVA (21%) y sumar para poner en el total
        -- Nota: Si es a domicilio, se mantiene el recargo de 2.50 definido anteriormente
        UPDATE pedidos 
        SET subtotal = v_subtotal_acumulado,
            total = (v_subtotal_acumulado * 1.21) + IF(es_a_domicilio, 2.50, 0)
        WHERE id = p_pedido_id;

        -- Out: pedido rellenado (información del pedido)
        SELECT * FROM pedidos WHERE id = p_pedido_id;

        -- Out: Detalle del Ticket
        SELECT pl.nombre, pp.tipo_racion, pp.cantidad, pp.precio_unitario, (pp.cantidad * pp.precio_unitario) AS total_linea
        FROM platos_pedidos pp
        JOIN platos pl ON pp.plato_id = pl.id
        WHERE pp.pedido_id = p_pedido_id;
    END IF;
END //

-- Procedimiento 3: Cerrar Pedido
CREATE PROCEDURE CerrarPedido(IN p_pedido_id INT)
BEGIN
    UPDATE pedidos SET abierto = FALSE WHERE id = p_pedido_id;
    SELECT * FROM pedidos WHERE id = p_pedido_id;
END //

DELIMITER ;

-- Ejecutamos la simulación para 500 pedidos
CALL GenerarPedidosAleatorios(500);

-- Agregar pedidos manuales para Jeremias a la dirección de Málaga para que salte la promoción (mínimo 20 pedidos)
INSERT IGNORE INTO cliente_direccion (cliente_id, direccion_id)
SELECT c.id, d.id FROM clientes c JOIN Direcciones d ON d.Direccion = 'Calle Larios 12'
WHERE c.email = 'jeremiaselcocas@gmail.com';

CREATE OR REPLACE VIEW RentabilidadPlatos AS
SELECT 
    p.nombre AS Plato,
    SUM(pp.cantidad) AS Total_Vendido,
    ROUND(SUM(pp.cantidad * pp.precio_unitario), 2) AS Ingresos_Totales,
    ROUND(SUM(pp.cantidad * (
        SELECT COALESCE(SUM(ip.cantidadracioncompletaenkg * i.precio_x_euro), 0)
        FROM ingrediente_plato ip
        JOIN Ingredientes i ON ip.ingrediente_id = i.id
        WHERE ip.plato_id = p.id
    )), 2) AS Coste_Ingredientes_Estimado,
    ROUND(SUM(pp.cantidad * pp.precio_unitario) - SUM(pp.cantidad * (
        SELECT COALESCE(SUM(ip.cantidadracioncompletaenkg * i.precio_x_euro), 0)
        FROM ingrediente_plato ip
        JOIN Ingredientes i ON ip.ingrediente_id = i.id
        WHERE ip.plato_id = p.id
    )), 2) AS Beneficio_Neto
FROM platos p
JOIN platos_pedidos pp ON p.id = pp.plato_id
GROUP BY p.id, p.nombre;

DELIMITER //

-- 2. Función para obtener el Email del Cliente Estrella
CREATE OR REPLACE FUNCTION ObtenerMejorCliente() 
RETURNS VARCHAR(100)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_email VARCHAR(100);
    SELECT c.email INTO v_email
    FROM clientes c
    JOIN pedidos p ON c.id = p.cliente_id
    GROUP BY c.id, c.email
    ORDER BY SUM(p.total) DESC
    LIMIT 1;
    RETURN v_email;
END //

-- 3. Función para obtener el ID del Pedido más caro
CREATE OR REPLACE FUNCTION ObtenerIDPedidoMasCaro() 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_id INT;
    SELECT id INTO v_id FROM pedidos ORDER BY total DESC LIMIT 1;
    RETURN v_id;
END //

DELIMITER ;

-- 2. Vista de los 10 pedidos más caros
CREATE OR REPLACE VIEW Top10PedidosMasCaros AS
SELECT id, total, cliente_id, empleado_id, es_a_domicilio
FROM pedidos
ORDER BY total DESC
LIMIT 10;
