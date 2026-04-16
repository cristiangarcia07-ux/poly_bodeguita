SET FOREIGN_KEY_CHECKS=0;
-- Create database
drop database if exists poly_bodeguita;
CREATE DATABASE poly_bodeguita;
USE poly_bodeguita;

-- Table: clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL unique,
    telefono VARCHAR(9) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    username VARCHAR(10) NOT NULL,
    password VARCHAR(100) NOT NULL
);

-- Table: empleados
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    dni VARCHAR(9) NOT NULL UNIQUE,
    nuss VARCHAR(12) NOT NULL UNIQUE,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(300) NOT NULL
);

-- Table: Direcciones
CREATE TABLE Direcciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    provincia VARCHAR(50) NOT NULL,
    Direccion VARCHAR(150) NOT NULL,
    codigo_postal VARCHAR(50) NOT NULL
);

-- Table: cliente_direccion
CREATE TABLE cliente_direccion (
    cliente_id INT NOT NULL,
    direccion_id INT NOT NULL,
    PRIMARY KEY (cliente_id, direccion_id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (direccion_id) REFERENCES Direcciones(id)
);

-- Table: pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    total DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    cliente_id INT NOT NULL,
    empleado_id INT NOT NULL,
    `esadomicilio?` BOOLEAN NOT NULL DEFAULT FALSE,
    direccion_id INT,
    `abierto?` BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (empleado_id) REFERENCES empleados(id),
    FOREIGN KEY (direccion_id) REFERENCES Direcciones(id)
);

-- Table: platos
CREATE TABLE platos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio_x_media_racion DECIMAL(6,2),
    precio_x_racion DECIMAL(6,2) NOT NULL
);

-- Table: platos_pedidos
CREATE TABLE platos_pedidos (
    pedido_id INT NOT NULL,
    plato_id INT NOT NULL,
    `media o completa?` VARCHAR(10) NOT NULL, -- Corresponds to 'media o completa?'
    cantidad INT NOT NULL,
    `precio unitario` DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (pedido_id, plato_id), 
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (plato_id) REFERENCES platos(id)
);

-- Table: Ingredientes
CREATE TABLE Ingredientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(200) NOT NULL,
    precio_x_euro DECIMAL(6,2) NOT NULL -- Precio por kilogramo en euros
);

-- Table: ingrediente_plato
CREATE TABLE ingrediente_plato (
    ingrediente_id INT NOT NULL,
    plato_id INT NOT NULL,
    cantidadracioncompletaenkg DECIMAL(8,3),
    cantidadracioncmediaenkg DECIMAL(8,3),
    PRIMARY KEY (ingrediente_id, plato_id),
    FOREIGN KEY (ingrediente_id) REFERENCES Ingredientes(id),
    FOREIGN KEY (plato_id) REFERENCES platos(id)
);

-- from now on, any insert still goes in the schema.sql file for the sake of simplicity 
-- and dont be fucking dumb please... or I'll spontaneously combust
SET FOREIGN_KEY_CHECKS=1;
