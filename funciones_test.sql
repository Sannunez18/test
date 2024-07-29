USE proyecto_resevas;

-- Función para verificar si un trabajo está cancelado:
DROP FUNCTION IF EXISTS trabajo_cancelado;
DROP FUNCTION IF EXISTS contar_reservas_cliente;
DROP FUNCTION IF EXISTS cantidad_puestos_por_taller;

DELIMITER //

CREATE FUNCTION trabajo_cancelado(taller_id INT) RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE cancelacion_date DATETIME;
    DECLARE is_cancelada BOOLEAN;
    
    SELECT CANCELACION INTO cancelacion_date
        FROM RESERVA
        WHERE IDTALLER = taller_id
        AND CANCELACION IS NOT NULL
        LIMIT 1;
    
    IF cancelacion_date IS NOT NULL THEN
        SET is_cancelada = TRUE;
    ELSE
        SET is_cancelada = FALSE;
    END IF;

    RETURN is_cancelada;
END //

DELIMITER ;

-- Función para contar las reservas de un cliente en un intervalo de tiempo:

DELIMITER //

CREATE FUNCTION contar_reservas_cliente(cliente_id INT, fecha_inicio DATETIME, fecha_fin DATETIME) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE reservas_count INT;
    
    SELECT COUNT(*) INTO reservas_count
    FROM RESERVA
    WHERE IDCLIENTE = cliente_id
    AND FECHA >= fecha_inicio
    AND FECHA <= fecha_fin;
    
    RETURN reservas_count;
END //

DELIMITER ;

-- Función para obtener la cantidad de puestos por taller:
DELIMITER //

CREATE FUNCTION cantidad_puestos_por_taller(puestotaller_id INT) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE puestos_count INT;
    
    SELECT COUNT(*) INTO puestos_count
    FROM PUESTO_TRABAJO_TALLER
    WHERE IDPUESTO = puestotaller_id;
    
    RETURN puestos_count;
END //

DELIMITER ;
