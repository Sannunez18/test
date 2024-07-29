USE proyecto_reservas;

DROP PROCEDURE IF EXISTS actualizar_reserva_cancelada_por_email;
DROP PROCEDURE IF EXISTS actualizar_tipo_reserva_por_email;
DROP PROCEDURE IF EXISTS crear_empleado;

DELIMITER //

CREATE PROCEDURE actualizar_reserva_cancelada_por_email(
    IN por_email VARCHAR(100)
)
BEGIN
    DECLARE cliente_id INT;
    
    -- Obtener el ID del cliente usando el correo electrónico proporcionado
    SELECT IDCLIENTE INTO cliente_id
        FROM CLIENTE
    WHERE CORREO = por_email;
    
    -- Actualizar la reserva si el cliente existe y tenía una reserva cancelada
    IF cliente_id IS NOT NULL THEN
        UPDATE RESERVA
        SET CANCELACION = NULL,
            FECHA = NOW()
        WHERE IDCLIENTE = cliente_id
        AND CANCELACION IS NOT NULL;
        
        SELECT 'La reserva cancelada del cliente con correo electrónico ', por_email, ' ha sido actualizada exitosamente.';
    ELSE
        SELECT 'No se encontró ningún cliente con el correo electrónico ', por_email, '.';
    END IF;
    
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE actualizar_tipo_reserva_por_email(
    IN por_email VARCHAR(100),
    IN por_nuevo_trabajo VARCHAR(50)
)
BEGIN
    DECLARE cliente_id INT;
    DECLARE reserva_id INT;
    
    -- Obtener el ID del cliente usando el correo electrónico proporcionado
    SELECT IDCLIENTE INTO cliente_id
    FROM CLIENTE
    WHERE CORREO = por_email;
    
    -- Si se encontró el cliente, obtener la última reserva hecha
    IF cliente_id IS NOT NULL THEN
        SELECT IDRESERVA INTO reserva_id
        FROM RESERVA
        WHERE IDCLIENTE = cliente_id
        ORDER BY FECHA DESC
        LIMIT 1;
        
        -- Si se encontró la reserva, actualizar el tipo de reserva
        IF reserva_id IS NOT NULL THEN
            UPDATE RESERVA
            SET IDPUESTO = (
                SELECT IDPUESTO FROM TIPO_TRABAJO WHERE TIPO_TRABAJO = por_nuevo_trabajo
            ) , FECHA = NOW()
            WHERE IDRESERVA = reserva_id;
            
            SELECT 'Se actualizó el tipo de reserva del cliente con correo electrónico ', por_email, ' a ', por_nuevo_trabajo, '.';
        ELSE
            SELECT 'El cliente con correo electrónico ', por_email, ' no tiene reservas.';
        END IF;
    ELSE
        SELECT 'No se encontró ningún cliente con el correo electrónico ', por_email, '.';
    END IF;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE crear_empleado(
    IN su_nombre VARCHAR(100),
    IN su_telefono VARCHAR(20),
    IN su_correo VARCHAR(100),
    IN su_dni VARCHAR(20) NOT NULL,
    IN su_id_taller INT,
    IN su_id_tipotrabajo INT
)
BEGIN
    DECLARE taller_count INT;
    
    -- Verificar si el taller existe
    SELECT COUNT(*) INTO taller_count
    FROM TALLER
    WHERE IDTALLER = su_id_taller;
    
    -- Si el taller existe, insertar el empleado
    IF taller_count > 0 THEN
        INSERT INTO EMPLEADO (NOMBRE, TELEFONO, CORREO, DNI, IDTALLER, IDTIPOTRABAJO)
        VALUES (su_nombre, su_telefono, su_correo, su_dni, su_id_taller, su_id_tipotrabajo);
        
        SELECT 'Empleado creado exitosamente.';
    ELSE
        SELECT 'El taller especificado no existe. No se puede crear el empleado.';
    END IF;
END //

DELIMITER ;
