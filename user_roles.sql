USE proyecto_reservas;

-- CREACIÓN DE ROLES

-- Rol de administrador total
DROP ROLE IF EXISTS admin_total;
CREATE ROLE admin_total;
GRANT ALL PRIVILEGES ON *.* TO admin_total WITH GRANT OPTION;

-- Rol de administrador de RRHH
DROP ROLE IF EXISTS admin_rrhh;
CREATE ROLE admin_rrhh;
GRANT ALL PRIVILEGES ON empleado TO admin_rrhh;
GRANT ALL PRIVILEGES ON taller TO admin_rrhh;

-- Rol de usuario con permisos solo para SELECT y vistas
DROP ROLE IF EXISTS analista_dml;
CREATE ROLE analista_dml;
GRANT SELECT ON *.* TO analista_dml;
GRANT SHOW VIEW ON *.* TO analista_dml;

-- Rol para modificar reservas y usar procedimientos almacenados y funciones
DROP ROLE IF EXISTS gestor_reservas;
CREATE ROLE gestor_reservas;
GRANT SELECT, INSERT, UPDATE, DELETE ON reservas TO gestor_reservas;
GRANT EXECUTE ON PROCEDURE *.* TO gestor_reservas;
GRANT EXECUTE ON FUNCTION *.* TO gestor_reservas;

-- CREACIÓN DE USUARIOS
-- Usuario para el rol admin_total
CREATE USER 'sannunez'@'localhost' IDENTIFIED BY 'Santy4432';
GRANT admin_total TO 'sannunez'@'localhost';

-- Usuario para el rol admin_rrhh
CREATE USER 'canunez'@'localhost' IDENTIFIED BY 'Cami4432';
GRANT admin_rrhh TO 'canunez'@'localhost';

-- Usuario para el rol analista_dml (SELECT y vistas)
CREATE USER 'MongolitoFlores'@'localhost' IDENTIFIED BY 'Asd123';
GRANT analista_dml TO 'MongolitoFlores'@'localhost';

-- Usuario para el rol gestor_reservas
CREATE USER 'mccorrea'@'localhost' IDENTIFIED BY 'MCC4432';
GRANT gestor_reservas TO 'mccorrea'@'localhost';

-- Aplicar los cambios
FLUSH PRIVILEGES;

