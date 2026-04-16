-- Inserciones para la tabla platos
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
INSERT INTO Ingredientes (descripcion, precio_x_euro) VALUES
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
INSERT INTO ingrediente_plato (ingrediente_id, plato_id, cantidadracioncompletaenkg, cantidadracioncmediaenkg) VALUES
(2, 1, 0.400, 0.200), (26, 1, 0.020, 0.010),
(1, 2, 0.350, NULL), (28, 2, 0.060, NULL), (29, 2, 0.015, NULL),
(7, 7, 0.350, 0.175), (26, 7, 0.040, 0.020),
(13, 8, 0.300, 0.150), (29, 8, 0.005, 0.003),
(18, 14, 0.300, 0.150), (27, 14, 0.050, 0.025),
(12, 18, 0.150, 0.075),
(8, 19, 0.100, 0.050),
(24, 26, 0.250, NULL), (32, 26, 0.060, NULL), (31, 26, 0.080, NULL), (34, 26, 0.030, NULL),
(36, 24, 0.200, NULL), (25, 24, 0.150, NULL),
(20, 37, 0.200, NULL), (26, 37, 0.080, NULL), (29, 37, 0.020, NULL);

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
('Ramona', 'McDonald', 'Wiggins'), ('Nemesio', 'Gallego', 'Oneal'), ('Christina', 'Robinson', 'Stein'),
('Gabriela', 'Murray', 'Woodard'), ('Consuelo', 'Marquez', 'Clay'), ('María', 'Lee', 'Flores'),
('Napoleon', 'Ortega', 'Berger'), ('Melania', 'Young', 'Larson'), ('Gaspar', 'James', 'Rojas'),
('Martina', 'Vila', 'Yang'), ('Catalina', 'Gimenez', 'Cross'), ('Laura', 'Muñoz', 'Weber'),
('Liliana', 'Ward', 'Bowen'), ('Silvina', 'Soto', 'Ramirez'), ('Osvaldo', 'Webb', 'Dotson'),
('Dolores', 'Ross', 'Hendricks'), ('Valentina', 'Reid', 'Roman'), ('Claudia', 'Cox', 'Le'),
('Gabriel', 'Cooper', 'Moss'), ('Cristóbal', 'O''Brien', 'Schroeder'), ('Heriberto', 'Hall', 'Talley'),
('Enrique', 'Soto', 'Frost'), ('Adan', 'Webb', 'Ray'), ('Juanfran', 'Torres', 'Bryant'),
('Rodrigo', 'Muñoz', 'Gibson'), ('Sebastian', 'Wright', 'Rich'), ('Nahuel', 'Davis', 'Cook'),
('Samara', 'Young', 'Johns'), ('Carlota', 'Simpson', 'Mullen'), ('Anabel', 'Mitchell', 'Hoover'),
('Milena', 'Mills', 'Gutierrez'), ('Tato', 'McDonald', 'Mack'), ('Yanet', 'Jones', 'Robbins'),
('Hugo', 'Fuentes', 'Houston'), ('Wilfredo', 'Gil', 'Hewitt'), ('Arturo', 'Hill', 'Hubbard'),
('Luca', 'Esteban', 'Cleveland'), ('Carmelita', 'Price', 'Byrd'), ('Pepe', 'Knight', 'Battle'),
('Roberto', 'Walsh', 'Monroe'), ('Arnaldo', 'Morgan', 'Velasquez'), ('Sophia', 'Nguyen', 'Ratliff'),
('Jacinto', 'Moreno', 'Bond'), ('Salvador', 'Harvey', 'Herman'), ('Nazario', 'Harrison', 'English'),
('Valeria', 'Pastor', 'Boyle'), ('Mario', 'Casado', 'Johnson'), ('Wenceslao', 'Miller', 'Hawkins'),
('Lana', 'Ryan', 'Fletcher'), ('Manrique', 'Fuentes', 'Dudley'), ('Dámaso', 'Simpson', 'Oneil'),
('Charli', 'Lewis', 'Vance'), ('Jorge', 'Alonso', 'Barlow'), ('Aníbal', 'Diez', 'Ballard'),
('Mariela', 'Pardo', 'Potter'), ('Alberto', 'James', 'Salazar'), ('Ernesto', 'Colling', 'Holmes'),
('Nahuel', 'Brown', 'Fowler'), ('Juanfran', 'Vega', 'Frazier'), ('Garbiñe', 'Alonso', 'Small'),
('Cari', 'Pastor', 'Walton'), ('Amparo', 'Reid', 'Ellison'), ('Karina', 'Moya', 'Howard'),
('Fatima', 'Marshall', 'Owen'), ('Benito', 'Murphy', 'Kinney'), ('Maya', 'Gonzalez', 'Hanson'),
('José', 'Murphy', 'Thomas'), ('Lucio', 'Andres', 'Hoffman'), ('Raquel', 'Cruz', 'Stone'),
('Simone', 'Robinson', 'Acosta'), ('Lorena', 'Herrero', 'Wilcox'), ('Perez', 'Mora', 'Barker'),
('Manrique', 'Ferrer', 'Gallegos'), ('Cesar', 'Carmona', 'Velazquez'), ('Araceli', 'Molina', 'Rush'),
('Cuauhtémoc', 'Gallego', 'Lowery'), ('Obdulio', 'Taylor', 'Moses'), ('Gabriel', 'Ross', 'Swanson'),
('Mirta', 'Phillips', 'Hurley'), ('Enrique', 'Wilson', 'Casey'), ('Nazaret', 'Perez', 'Lang'),
('Amparo', 'Smith', 'George'), ('Lara', 'Miller', 'Huff'), ('Sebastian', 'Muñoz', 'Livingston'),
('Cayetano', 'Vila', 'Gay'), ('Marcelino', 'Marin', 'Branch'), ('Mauricio', 'Marin', 'Perry'),
('Fabricio', 'Diaz', 'Bond'), ('Maximiliano', 'Cox', 'Tran'), ('Noe', 'Wood', 'Harrell'),
('Nadia', 'Rubio', 'Hughes'), ('Omar', 'Colling', 'Dominguez'), ('Nena', 'Davis', 'Buckley'),
('Dolores', 'Vicente', 'Barry'), ('Ester', 'Leon', 'Bush'), ('Maximiliano', 'Adams', 'Love'),
('Ulises', 'Leon', 'Copeland'), ('Eugenio', 'Nuñez', 'Harper'), ('Núria', 'Thomson', 'Cannon'),
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
        SET rnd_id = FLOOR(1 + (RAND() * max_id));
        SELECT nombre INTO r_nombre FROM temp_nombres WHERE id = rnd_id;
        SET rnd_id = FLOOR(1 + (RAND() * max_id));
        SELECT apellido1 INTO r_apellido1 FROM temp_nombres WHERE id = rnd_id;
        SET rnd_id = FLOOR(1 + (RAND() * max_id));
        SELECT apellido2 INTO r_apellido2 FROM temp_nombres WHERE id = rnd_id;
        
        SET r_telefono = CONCAT('6', LPAD(FLOOR(RAND() * 100000000), 8, '0'));
        SET r_email = CONCAT(LOWER(SUBSTRING(REPLACE(r_nombre, ' ', ''), 1, 5)), '.', LOWER(SUBSTRING(REPLACE(r_apellido1, ' ', ''), 1, 5)), UUID_SHORT(), '@ejemplo.com');
        SET r_username = SUBSTRING(CONCAT(LOWER(SUBSTRING(REPLACE(r_nombre, ' ', ''), 1, 3)), UUID_SHORT()), 1, 10);
        
        INSERT INTO clientes (email, telefono, nombre, apellido1, apellido2, username, password)
        VALUES (r_email, r_telefono, r_nombre, r_apellido1, r_apellido2, r_username, SHA2(CONCAT(RAND()), 256));
        SET i = i + 1;
    END WHILE;
END //

CREATE PROCEDURE GenerarPedidosAleatorios(IN num_pedidos INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE j INT DEFAULT 0;
    -- (Logic matching schema.sql)
    WHILE i < num_pedidos DO
        INSERT INTO pedidos (total, subtotal, cliente_id, empleado_id, `esadomicilio?`, direccion_id, `abierto?`)
        VALUES (0, 0, 1, 1, FALSE, NULL, FALSE);
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;
DROP TEMPORARY TABLE IF EXISTS temp_nombres;
drop procedure if exists GenerarClientesAleatorios;

-- Inserción de base
INSERT INTO empleados (nombre, apellido1, apellido2, dni, nuss, usuario, contrasena) VALUES
('Carlos', 'Ruiz', 'García', '12345678A', '001111111111', 'cruiz', 'password123'),
('Lucía', 'Gómez', 'Sánchez', '87654321B', '002222222222', 'lgomez', 'secure456'),
('Paco', 'Fernández', 'López', '11223344C', '003333333333', 'pfernandez', 'paco789');

INSERT INTO Direcciones (provincia, Direccion, codigo_postal) VALUES
('Sevilla', 'Calle Tartessos 12', '41809'), ('Sevilla', 'Avenida de la Constitución 5', '41809'), ('Málaga', 'Calle Larios 12', '29005');

CALL GenerarClientesAleatorios(100);
CALL GenerarPedidosAleatorios(50);
DROP TEMPORARY TABLE IF EXISTS temp_nombres;
