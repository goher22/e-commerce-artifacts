-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS auth_db;
USE auth_db;

-- Crear la tabla de roles
CREATE TABLE IF NOT EXISTS roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crear la tabla de usuarios
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role_id BIGINT,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    enabled BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Iniciar una transacción
START TRANSACTION;

-- Insertar los roles disponibles
INSERT INTO roles (name) VALUES ('ROLE_USER'), ('ROLE_ADMIN')
    ON DUPLICATE KEY UPDATE name=VALUES(name);

-- Insertar los usuarios
INSERT INTO users (username, password, role_id, enabled) VALUES 
('usuario1', '$2a$10$hMwwYzKmkQM6Stx54PVzBukHEToo45T2yAXP84qHO0LP3mNUlsgt2', 1, TRUE), -- Contraseña: password1 (bcrypt hash)
('admin1', '$2a$10$hMwwYzKmkQM6Stx54PVzBukHEToo45T2yAXP84qHO0LP3mNUlsgt2', 2, TRUE) -- Contraseña: password1 (bcrypt hash)
ON DUPLICATE KEY UPDATE username=VALUES(username);

-- Confirmar la transacción
COMMIT;

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS product_db;
USE product_db;

-- Crear la tabla de productos
CREATE TABLE IF NOT EXISTS products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL
);

-- Crear la base de datos (opcional)
CREATE DATABASE IF NOT EXISTS order_db;
USE order_db;

-- Crear la tabla de órdenes
CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    document_user BIGINT NOT NULL,
    name_user VARCHAR(100) NOT NULL,
    order_date DATE NOT NULL
);

-- Crear la tabla de detalles de órdenes
CREATE TABLE IF NOT EXISTS order_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    price DOUBLE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);
