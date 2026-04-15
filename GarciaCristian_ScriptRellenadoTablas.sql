DELIMITER //
INSERT INTO platos (nombre, precio_x_media_racion, precio_x_racion) VALUES
-- CARNES
('Chuletas de Cordero', 7.00, 14.00),
('Solomillo al Whisky', NULL, 11.00),
('Secreto Ibérico', NULL, 13.00),
('Entrecot de Ternera', NULL, 10.00),
('Churrasco de Cerdo', NULL, 8.00),
('Pechuga de Pollo', NULL, 4.00),
('Carillera Ibérica', 5.50, 11.00),

-- PESCADOS
('Chipirón Plancha', 5.00, 10.00),
('Pez Espada', NULL, 10.00),
('Frito Variado', NULL, 13.00),
('Merluza', 5.00, 10.00),
('Acedías (según mercado)', NULL, 0.00),
('Boquerones', 5.00, 10.00),
('Adobo', 5.00, 10.00),
('Choco', 5.00, 10.00),
('Pijota (según mercado)', NULL, 0.00),

-- CHACINAS
('Chacina Variada', NULL, 12.00),
('Queso de Oveja', 5.00, 10.00),
('Jamón de Bellota', 7.00, 12.00),
('Caña Lomo Bellota', 7.00, 12.00),
('Salchichón Ibérico', 6.00, 10.00),
('Chorizo Ibérico', NULL, 0.00),

-- OTROS PLATOS
('Revuelto de la Casa', NULL, 10.00),
('Revuelto de Espárragos', NULL, 10.00),
('Bacalao Dorado', NULL, 10.00),

-- ENTREMESES
('Ensaladilla Rusa', NULL, 4.00),
('Ensalada Mixta', NULL, 5.00),
('Tomates Aliñados', NULL, 2.00),
('Tomates con Atún', NULL, 3.50),
('Croquetas', 4.50, 9.00),
('Tortillitas de Bacalao (temporada)', 4.50, 9.00),
('Patatas Fritas (plato)', NULL, 3.00),
('Olivas', NULL, 1.20),
('Pan', NULL, 0.40),
('Picos o Regaña', NULL, 0.50),

-- MARISCOS
('Gambas al Natural', 6.00, 12.00),
('Gambas al Ajillo', NULL, 8.00),
('Gambones Plancha', 6.50, 13.00),
('Almejas de Carril', NULL, 9.00),
('Coquinas', NULL, 9.00),

-- BEBIDAS
('Cerveza Jarra 1L', NULL, 6.00),
('Cerveza Jarra 0,5L', NULL, 3.00),
('Cerveza', NULL, 1.60),
('Refresco', NULL, 1.60),
('Refresco 0,35cl', NULL, 2.20),
('Nestea', NULL, 2.20),
('Aquarius', NULL, 2.20),
('Tinto de Verano 0,5L', NULL, 2.50),
('Copa Rioja Cosecha', NULL, 2.50),
('Copa Barbadillo', NULL, 2.50),
('Copa Señorío Heliche', NULL, 2.50),
('Copa Manzanilla', NULL, 2.00),
('Copa Vino Dulce', NULL, 1.50),
('Botella Tinto/Casera', NULL, 6.00),
('Botella Casera', NULL, 2.50),
('Botella de Agua 1,5L', NULL, 2.00),
('Botella de Agua 0,33L', NULL, 1.00);
-- Inserciones para la tabla Ingredientes
-- Precios estimados por kg en euros (Abril 2026)
INSERT INTO Ingredientes (descripcion, precio_x_euro) VALUES
-- Carnes y derivados
('Solomillo de Cerdo', 12.50),
('Chuletas de Cordero', 19.80),
('Secreto Ibérico', 16.20),
('Entrecot de Ternera', 24.50),
('Churrasco de Cerdo', 9.90),
('Pechuga de Pollo', 7.50),
('Carrillera Ibérica', 14.00),
('Jamón de Bellota', 65.00),
('Caña de Lomo Bellota', 45.00),
('Salchichón Ibérico', 18.00),
('Chorizo Ibérico', 15.00),
('Queso de Oveja Curado', 22.00),

-- Pescados y Mariscos
('Chipirón Fresco', 15.50),
('Pez Espada', 17.00),
('Merluza de Pincho', 16.00),
('Boquerón', 9.00),
('Choco (Sepia)', 12.50),
('Pescado para Adobo (Cazón)', 11.00),
('Bacalao Desalado', 21.00),
('Gambas Blancas', 28.00),
('Gambones', 19.00),
('Almejas de Carril', 24.00),
('Coquinas', 26.00),

-- Vegetales, Huevos y Despensa
('Patata Nueva', 1.30),
('Huevo campero (docena a kg)', 4.80),
('Aceite de Oliva Virgen Extra', 10.50),
('Harina de freír', 1.60),
('Whisky para cocinar', 14.00),
('Ajo', 5.50),
('Tomate de ensalada', 2.80),
('Atún en aceite (conserva)', 13.00),
('Mayonesa', 4.50),
('Guisantes', 3.20),
('Zanahoria', 1.40),
('Aceitunas', 4.00),
('Espárragos Trigueros', 8.50);
-- Relación de platos con sus ingredientes base
INSERT INTO ingrediente_plato (ingrediente_id, plato_id, cantidadracioncompletaenkg, cantidadracionmediaenkg) VALUES
-- Chuletas de Cordero (ID 1)
(2, 1, 0.400, 0.200), -- Cordero
(26, 1, 0.020, 0.010), -- Aceite

-- Solomillo al Whisky (ID 2)
(1, 2, 0.350, NULL), -- Solomillo
(28, 2, 0.060, NULL), -- Whisky
(29, 2, 0.015, NULL), -- Ajo

-- Carrillera Ibérica (ID 7)
(7, 7, 0.350, 0.175), -- Carrillera
(26, 7, 0.040, 0.020), -- Aceite (guiso)

-- Chipirón Plancha (ID 8)
(13, 8, 0.300, 0.150), -- Chipirón
(29, 8, 0.005, 0.003), -- Ajo/Persillade

-- Adobo (ID 14)
(18, 14, 0.300, 0.150), -- Pescado
(27, 14, 0.050, 0.025), -- Harina

-- Queso de Oveja (ID 18)
(12, 18, 0.150, 0.075), -- Queso

-- Jamón de Bellota (ID 19)
(8, 19, 0.100, 0.050), -- Jamón

-- Ensaladilla Rusa (ID 26)
(24, 26, 0.250, NULL), -- Patata
(32, 26, 0.060, NULL), -- Mayonesa
(31, 26, 0.080, NULL), -- Atún
(34, 26, 0.030, NULL), -- Zanahoria

-- Revuelto de Espárragos (ID 24)
(36, 24, 0.200, NULL), -- Espárragos
(25, 24, 0.150, NULL), -- Huevos (3 unidades aprox)

-- Gambas al Ajillo (ID 37)
(20, 37, 0.200, NULL), -- Gambas
(26, 37, 0.080, NULL), -- Aceite
(29, 37, 0.020, NULL); -- Ajo

-- ==========================================================
-- PROCEDIMIENTO PARA GENERAR CLIENTES ALEATORIOS
-- ==========================================================
 CREATE TEMPORARY TABLE IF NOT EXISTS temp_nombres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50)
);

INSERT INTO temp_nombres (nombre, apellido1, apellido2) VALUES
('Ramona', 'McDonald', 'Wiggins'),
('Nemesio', 'Gallego', 'Oneal'),
('Christina', 'Robinson', 'Stein'),
('Gabriela', 'Murray', 'Woodard'),
('Consuelo', 'Marquez', 'Clay'),
('María', 'Lee', 'Flores'),
('Napoleon', 'Ortega', 'Berger'),
('Melania', 'Young', 'Larson'),
('Gaspar', 'James', 'Rojas'),
('Martina', 'Vila', 'Yang'),
('Catalina', 'Gimenez', 'Cross'),
('Laura', 'Muñoz', 'Weber'),
('Liliana', 'Ward', 'Bowen'),
('Silvina', 'Soto', 'Ramirez'),
('Osvaldo', 'Webb', 'Dotson'),
('Dolores', 'Ross', 'Hendricks'),
('Valentina', 'Reid', 'Roman'),
('Claudia', 'Cox', 'Le'),
('Gabriel', 'Cooper', 'Moss'),
('Cristóbal', 'O''Brien', 'Schroeder'),
('Heriberto', 'Hall', 'Talley'),
('Enrique', 'Soto', 'Frost'),
('Adan', 'Webb', 'Ray'),
('Juanfran', 'Torres', 'Bryant'),
('Rodrigo', 'Muñoz', 'Gibson'),
('Sebastian', 'Wright', 'Rich'),
('Nahuel', 'Davis', 'Cook'),
('Samara', 'Young', 'Johns'),
('Carlota', 'Simpson', 'Mullen'),
('Anabel', 'Mitchell', 'Hoover'),
('Milena', 'Mills', 'Gutierrez'),
('Tato', 'McDonald', 'Mack'),
('Yanet', 'Jones', 'Robbins'),
('Hugo', 'Fuentes', 'Houston'),
('Wilfredo', 'Gil', 'Hewitt'),
('Arturo', 'Hill', 'Hubbard'),
('Luca', 'Esteban', 'Cleveland'),
('Carmelita', 'Price', 'Byrd'),
('Pepe', 'Knight', 'Battle'),
('Roberto', 'Walsh', 'Monroe'),
('Arnaldo', 'Morgan', 'Velasquez'),
('Sophia', 'Nguyen', 'Ratliff'),
('Jacinto', 'Moreno', 'Bond'),
('Salvador', 'Harvey', 'Herman'),
('Nazario', 'Harrison', 'English'),
('Valeria', 'Pastor', 'Boyle'),
('Mario', 'Casado', 'Johnson'),
('Wenceslao', 'Miller', 'Hawkins'),
('Lana', 'Ryan', 'Fletcher'),
('Manrique', 'Fuentes', 'Dudley'),
('Dámaso', 'Simpson', 'Oneil'),
('Charli', 'Lewis', 'Vance'),
('Jorge', 'Alonso', 'Barlow'),
('Aníbal', 'Diez', 'Ballard'),
('Mariela', 'Pardo', 'Potter'),
('Alberto', 'James', 'Salazar'),
('Ernesto', 'Colling', 'Holmes'),
('Nahuel', 'Brown', 'Fowler'),
('Juanfran', 'Vega', 'Frazier'),
('Garbiñe', 'Alonso', 'Small'),
('Cari', 'Pastor', 'Walton'),
('Amparo', 'Reid', 'Ellison'),
('Karina', 'Moya', 'Howard'),
('Fatima', 'Marshall', 'Owen'),
('Benito', 'Murphy', 'Kinney'),
('Maya', 'Gonzalez', 'Hanson'),
('José', 'Murphy', 'Thomas'),
('Lucio', 'Andres', 'Hoffman'),
('Raquel', 'Cruz', 'Stone'),
('Simone', 'Robinson', 'Acosta'),
('Lorena', 'Herrero', 'Wilcox'),
('Perez', 'Mora', 'Barker'),
('Manrique', 'Ferrer', 'Gallegos'),
('Cesar', 'Carmona', 'Velazquez'),
('Araceli', 'Molina', 'Rush'),
('Cuauhtémoc', 'Gallego', 'Lowery'),
('Obdulio', 'Taylor', 'Moses'),
('Gabriel', 'Ross', 'Swanson'),
('Mirta', 'Phillips', 'Hurley'),
('Enrique', 'Wilson', 'Casey'),
('Nazaret', 'Perez', 'Lang'),
('Amparo', 'Smith', 'George'),
('Lara', 'Miller', 'Huff'),
('Sebastian', 'Muñoz', 'Livingston'),
('Cayetano', 'Vila', 'Gay'),
('Marcelino', 'Marin', 'Branch'),
('Mauricio', 'Marin', 'Perry'),
('Fabricio', 'Diaz', 'Bond'),
('Maximiliano', 'Cox', 'Tran'),
('Noe', 'Wood', 'Harrell'),
('Nadia', 'Rubio', 'Hughes'),
('Omar', 'Colling', 'Dominguez'),
('Nena', 'Davis', 'Buckley'),
('Dolores', 'Vicente', 'Barry'),
('Ester', 'Leon', 'Bush'),
('Maximiliano', 'Adams', 'Love'),
('Ulises', 'Leon', 'Copeland'),
('Eugenio', 'Nuñez', 'Harper'),
('Núria', 'Thomson', 'Cannon'),
('Jimeno', 'Jones', 'Noble');
DELIMITER //

CREATE PROCEDURE GenerarClientesAleatorios(IN cantidad INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE r_nombre VARCHAR(50);
    DECLARE r_apellido1 VARCHAR(50);
    DECLARE r_apellido2 VARCHAR(50);
    DECLARE r_email VARCHAR(100);
    DECLARE r_telefono VARCHAR(9);
    DECLARE r_username VARCHAR(10);
    DECLARE max_id INT;
    DECLARE rnd_id INT;
    
    SELECT MAX(id) INTO max_id FROM temp_nombres;

    WHILE i < cantidad DO
        -- Evaluar RAND() en una variable antes de buscar para evitar que devuelva múltiples filas en el table scan
        SET rnd_id = FLOOR(1 + (RAND() * max_id));
        SELECT nombre INTO r_nombre FROM temp_nombres WHERE id = rnd_id;
        
        SET rnd_id = FLOOR(1 + (RAND() * max_id));
        SELECT apellido1 INTO r_apellido1 FROM temp_nombres WHERE id = rnd_id;
        
    
        SET rnd_id = FLOOR(1 + (RAND() * max_id));
        SELECT apellido2 INTO r_apellido2 FROM temp_nombres WHERE id = rnd_id;
        
        -- Generar teléfono español aleatorio
        SET r_telefono = CONCAT('6', LPAD(FLOOR(RAND() * 100000000), 8, '0'));
        
        -- Generar email usando UUID para garantizar unicidad
        SET r_email = CONCAT(LOWER(SUBSTRING(REPLACE(r_nombre, ' ', ''), 1, 5)), '.', LOWER(SUBSTRING(REPLACE(r_apellido1, ' ', ''), 1, 5)), UUID_SHORT(), '@ejemplo.com');
        
        -- Generar username único usando UUID corto
        SET r_username = SUBSTRING(CONCAT(LOWER(SUBSTRING(REPLACE(r_nombre, ' ', ''), 1, 3)), UUID_SHORT()), 1, 10);
        
        INSERT INTO clientes (email, telefono, nombre, apellido1, apellido2, username, password)
        VALUES (
            r_email,
            r_telefono,
            r_nombre,
            r_apellido1,
            r_apellido2,
            r_username,
            SHA2(CONCAT(RAND()), 256)
        );

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

-- deja de tocar esto, ya me encargo yo de esto...
CALL GenerarClientesAleatorios(100);
-- Limpiar la tabla temporal
DROP TEMPORARY TABLE IF EXISTS temp_nombres;

-- ==========================================================
-- INSERCIÓN DE EMPLEADOS Y DIRECCIONES BASE
-- ==========================================================
INSERT INTO empleados (nombre, apellido1, apellido2, dni, nuss, usuario, contrasena) VALUES
('Carlos', 'Ruiz', 'García', '12345678A', '001111111111', 'cruiz', 'password123'),
('Lucía', 'Gómez', 'Sánchez', '87654321B', '002222222222', 'lgomez', 'secure456'),
('Paco', 'Fernández', 'López', '11223344C', '003333333333', 'pfernandez', 'paco789');

INSERT INTO Direcciones (provincia, Direccion, codigo_postal) VALUES
('Sevilla', 'Calle Tartessos 12', '41809'),
('Sevilla', 'Avenida de la Constitución 5', '41809'),
('Sevilla', 'Calle Real 89', '41809'),
('Sevilla', 'Plaza de España 1', '41809'),
('Sevilla', 'Calle Mayor 55', '41809'),
('Sevilla', 'Calle Sierpes 22', '41004'),
('Sevilla', 'Calle Betis 45', '41010'),
('Sevilla', 'Avenida de la Palmera 12', '41012'),
('Sevilla', 'Calle Feria 88', '41003'),
('Sevilla', 'Calle San Jacinto 15', '41010'),
('Sevilla', 'Alameda de Hércules 3', '41002'),
('Sevilla', 'Calle Trajano 10', '41002'),
('Sevilla', 'Calle Tetuán 5', '41001'),
('Sevilla', 'Calle Asunción 44', '41011'),
('Sevilla', 'Calle Luis Montoto 120', '41005'),
('Sevilla', 'Calle Juan Sebastián Elcano 8', '41011'),
('Sevilla', 'Avenida San Francisco Javier 24', '41018'),
('Sevilla', 'Calle Adriano 14', '41001'),
('Sevilla', 'Calle Arfe 9', '41001'),
('Sevilla', 'Paseo de Cristóbal Colón 12', '41001'),
('Sevilla', 'Calle Mateos Gago 2', '41004'),
('Sevilla', 'Calle Alemanes 7', '41004'),
('Sevilla', 'Calle Francos 19', '41004'),
('Sevilla', 'Calle Águilas 31', '41003'),
('Sevilla', 'Calle Alfonso XII 40', '41001'),
('Sevilla', 'Calle Baños 15', '41002'),
('Sevilla', 'Calle Calatrava 27', '41002'),
('Sevilla', 'Calle Relator 5', '41002'),
('Sevilla', 'Calle Pureza 80', '41010'),
('Sevilla', 'Calle Castilla 102', '41010'),
('Sevilla', 'Calle Pagés del Corro 150', '41010'),
('Sevilla', 'Calle Evangelista 33', '41010'),
('Sevilla', 'Calle Salado 4', '41010'),
('Sevilla', 'Calle Virgen de Luján 11', '41011'),
('Sevilla', 'Avenida República Argentina 25', '41011'),
('Sevilla', 'Calle Niebla 48', '41011'),
('Sevilla', 'Calle Miño 2', '41011'),
('Sevilla', 'Calle Felipe II 18', '41013'),
('Sevilla', 'Avenida de la Reina Mercedes 1', '41012'),
('Sevilla', 'Calle Teba 4', '41006'),
('Sevilla', 'Calle Afán de Ribera 77', '41006'),
('Sevilla', 'Calle Marqués de Pickman 45', '41005'),
('Sevilla', 'Calle Eduardo Dato 33', '41018'),
('Sevilla', 'Calle Gran Vía 12', '41005'),
('Sevilla', 'Calle Goya 5', '41005'),
('Sevilla', 'Calle Benito Mas y Prat 8', '41005'),
('Sevilla', 'Calle Rico Cejudo 14', '41005'),
('Sevilla', 'Calle Arroyo 22', '41008'),
('Sevilla', 'Calle Tharsis 9', '41008'),
('Sevilla', 'Calle Venecia 3', '41008'),
('Sevilla', 'Calle Urquiza 11', '41008'),
('Sevilla', 'Calle José Laguillo 5', '41003'),
('Sevilla', 'Calle Amador de los Ríos 28', '41003'),
('Sevilla', 'Calle Recaredo 15', '41003'),
('Sevilla', 'Calle Menéndez Pelayo 4', '41004'),
('Sevilla', 'Calle Santa María la Blanca 10', '41004'),
('Sevilla', 'Calle Cano y Cueto 1', '41004'),
('Sevilla', 'Calle Fabiola 3', '41004'),
('Sevilla', 'Calle Abades 12', '41004'),
('Sevilla', 'Calle Don Remondo 4', '41004'),
('Sevilla', 'Plaza del Salvador 1', '41004'),
('Sevilla', 'Calle Cuna 14', '41004'),
('Sevilla', 'Calle Puente y Pellón 5', '41004'),
('Sevilla', 'Calle Regina 21', '41003'),
('Sevilla', 'Calle Jerónimo Hernández 4', '41003'),
('Sevilla', 'Calle Santa Ángela de la Cruz 2', '41003'),
('Sevilla', 'Calle Doña María Coronel 16', '41003'),
('Sevilla', 'Calle Gerona 9', '41003'),
('Sevilla', 'Calle Sol 44', '41003'),
('Sevilla', 'Calle Enladrillada 12', '41003'),
('Sevilla', 'Calle Bustos Tavera 8', '41003'),
('Sevilla', 'Calle San Luis 110', '41003'),
('Sevilla', 'Calle Parras 2', '41002'),
('Sevilla', 'Calle Escoberos 5', '41002'),
('Sevilla', 'Calle Resolana 18', '41002'),
('Sevilla', 'Calle Torneo 60', '41002'),
('Sevilla', 'Calle San Vicente 35', '41002'),
('Sevilla', 'Calle Goles 12', '41002'),
('Sevilla', 'Calle Gravina 54', '41001'),
('Sevilla', 'Calle Canalejas 2', '41001'),
('Sevilla', 'Calle Monsalves 11', '41001'),
('Sevilla', 'Calle Fernán Caballero 4', '41001'),
('Sevilla', 'Calle San Pablo 28', '41001'),
('Sevilla', 'Calle Zaragoza 15', '41001'),
('Sevilla', 'Calle Padre Marchena 9', '41001'),
('Sevilla', 'Calle Dos de Mayo 4', '41001'),
('Málaga', 'Calle Larios 12', '29005'),
('Málaga', 'Avenida de Andalucía 10', '29007');
-- Vinculamos las direcciones creadas a todos los clientes existentes en la BD
-- Repartimos los clientes equivalentemente entre las direcciones empleando el módulo
insert into clientes (email, telefono, nombre, apellido1, apellido2, username, password) values
("jeremiaselcocas@gmail.com","983322399","jeremias","perez","Mclovin","jeremias","12345678"),
("jeremias.rodriguez@gmail.com","666777888","jeremias","rodriguez","gomez","jeremias2","12345678"),
("maria.garcia@hotmail.com","600111222","maria","garcia","lopez","maria","12345678"),
("antonio.banderas@gmail.com","699888777","antonio","banderas","ruiz","antonio","12345678");
INSERT IGNORE INTO cliente_direccion (cliente_id, direccion_id)
SELECT id, (id % (SELECT MAX(id) FROM Direcciones)) + 1 FROM clientes;
-- ==========================================================
-- PROCEDIMIENTO PARA GENERAR PEDIDOS ALEATORIOS
-- ==========================================================
DELIMITER //

CREATE PROCEDURE GenerarPedidosAleatorios(IN num_pedidos INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE j INT DEFAULT 0;
    DECLARE num_platos INT;
    DECLARE current_pedido_id INT;
    
    DECLARE r_cliente_id INT;
    DECLARE r_empleado_id INT;
    DECLARE r_direccion_id INT;
    DECLARE r_es_a_domicilio BOOLEAN;
    
    DECLARE v_pedido_subtotal DECIMAL(10,2);
    
    DECLARE max_cliente_id INT;
    DECLARE max_empleado_id INT;
    DECLARE max_direccion_id INT;
    DECLARE max_plato_id INT;
    
    DECLARE r_plato_id INT;
    DECLARE r_tipo_racion VARCHAR(10);
    DECLARE v_precio_media DECIMAL(6,2);
    DECLARE v_precio_completa DECIMAL(6,2);
    DECLARE v_precio_unitario DECIMAL(6,2);
    DECLARE r_cantidad INT;

    -- Obtener los topes de las tablas relacionales
    SELECT MAX(id) INTO max_cliente_id FROM clientes;
    SELECT MAX(id) INTO max_empleado_id FROM empleados;
    SELECT MAX(id) INTO max_direccion_id FROM Direcciones;
    SELECT MAX(id) INTO max_plato_id FROM platos;

    WHILE i < num_pedidos DO
        -- Escoger entidades al azar
        SET r_cliente_id = FLOOR(1 + (RAND() * max_cliente_id));
        SET r_empleado_id = FLOOR(1 + (RAND() * max_empleado_id));
        SET r_es_a_domicilio = IF(RAND() > 0.5, TRUE, FALSE);
        
        -- Si es a domicilio, enviamos el pedido a la dirección física real que el cliente tiene registrada
        IF r_es_a_domicilio THEN
            -- Obtenemos su dirección real desde la relación, en lugar de escoger una al azar de la ciudad
            SELECT direccion_id INTO r_direccion_id FROM cliente_direccion WHERE cliente_id = r_cliente_id LIMIT 1;
        ELSE
            SET r_direccion_id = NULL;
        END IF;
        
        -- 1. Insertamos el "esqueleto" del pedido inicialmente a coste 0 y CERRADO (simulando historia)
        INSERT INTO pedidos (total, subtotal, cliente_id, empleado_id, es_a_domicilio, direccion_id, abierto)
        VALUES (0, 0, r_cliente_id, r_empleado_id, r_es_a_domicilio, r_direccion_id, FALSE);
        
        SET current_pedido_id = LAST_INSERT_ID();
        SET v_pedido_subtotal = 0;
        
        -- Vamos a decidir cuántos platos distintos contiene este pedido (entre 1 y 5)
        SET num_platos = FLOOR(1 + (RAND() * 4));
        SET j = 0;
        
        WHILE j < num_platos DO
            SET r_plato_id = FLOOR(1 + (RAND() * max_plato_id));
            
            -- Obtener precios de la BD para el plato seleccionado
            SELECT precio_x_media_racion, precio_x_racion INTO v_precio_media, v_precio_completa 
            FROM platos WHERE id = r_plato_id;
            
            -- Decidir "media" o "completa" de forma aleatoria si existe la opción de media ración
            IF v_precio_media IS NOT NULL AND RAND() > 0.5 THEN
                SET r_tipo_racion = 'media';
                SET v_precio_unitario = v_precio_media;
            ELSE
                SET r_tipo_racion = 'completa';
                SET v_precio_unitario = v_precio_completa;
            END IF;
            
            -- Cantidad del plato elegido (entre 1 y 4)
            SET r_cantidad = FLOOR(1 + (RAND() * 3));
            
            -- Usar INSERT IGNORE previene que falle si escoge exactamente el mismo plato y tipo_racion
            INSERT IGNORE INTO platos_pedidos (pedido_id, plato_id, tipo_racion, cantidad, precio_unitario)
            VALUES (current_pedido_id, r_plato_id, r_tipo_racion, r_cantidad, v_precio_unitario);
            
            -- Sumar al subtotal solo si hubo inserción real (ROW_COUNT evitará sumar repetidos omitidos)
            IF ROW_COUNT() > 0 THEN
                SET v_pedido_subtotal = v_pedido_subtotal + (v_precio_unitario * r_cantidad);
            END IF;
            
            SET j = j + 1;
        END WHILE;
        
        -- 2. Consolidar el coste en el registro maestro del pedido al final de iterarlo
        -- Suponemos un "service fee" al total de 2.50e si es a domicilio
        IF r_es_a_domicilio THEN
            UPDATE pedidos SET subtotal = v_pedido_subtotal, total = v_pedido_subtotal + 2.50 WHERE id = current_pedido_id;
        ELSE
            UPDATE pedidos SET subtotal = v_pedido_subtotal, total = v_pedido_subtotal WHERE id = current_pedido_id;
        END IF;

        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

-- ==========================================================
-- PROCEDIMIENTOS SEGÚN DIAGRAMA DE FLUJO
-- ==========================================================
DELIMITER //

-- Procedimiento 1: Empieza Procedure (Abrir Pedido)
CALL GenerarClientesAleatorios(1000);
CALL GenerarPedidosAleatorios(500);
DELIMITER ;
-- Auditoría de Rentabilidad por Plato (Vista)
-- Esta consulta genera una vista que analiza el rendimiento económico de toda la carta.
DROP VIEW IF EXISTS VistaRentabilidad;
CREATE VIEW VistaRentabilidad AS
SELECT 
    pl.nombre AS nombre_plato,
    SUM(pp.cantidad) AS total_raciones_servidas,
    ROUND(SUM(pp.cantidad * pp.precio_unitario), 2) AS ingresos_totales,
    ROUND(SUM(
        pp.cantidad * (
            SELECT SUM(ip.cantidadracioncompletaenkg * i.precio_x_euro)
            FROM ingrediente_plato ip
            JOIN Ingredientes i ON ip.ingrediente_id = i.id
            WHERE ip.plato_id = pl.id
        )
    ), 2) AS coste_total_produccion,
    ROUND(
        SUM(pp.cantidad * pp.precio_unitario) - 
        SUM(pp.cantidad * (
            SELECT SUM(ip.cantidadracioncompletaenkg * i.precio_x_euro)
            FROM ingrediente_plato ip
            JOIN Ingredientes i ON ip.ingrediente_id = i.id
            WHERE ip.plato_id = pl.id
        )), 2
    ) AS beneficio_neto
FROM platos pl
JOIN platos_pedidos pp ON pl.id = pp.plato_id
GROUP BY pl.id, pl.nombre;

SELECT * FROM VistaRentabilidad ORDER BY beneficio_neto DESC;
