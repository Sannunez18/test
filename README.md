## CREACION DE UNA BASE DE DATOS PARA LA ADMINISTRACIÓN DE RESERVAS DE TURNOS PARA TALLERES MECÁNICOS AUTOMOTRICES.

**Alumno:** Santiago Nicolas Nuñez

**Comisión:** #57190

**Profesor:** Anderson M. Torres

**Tutor:** Ariel Annone



### Problema:

Nuestro equipo de desarrollo está trabajando en un sistema de gestión de reservas de turnos para talleres, donde nos enfrentamos a la necesidad de diseñar una base de datos eficiente que pueda manejar todas las operaciones relacionadas a estas de manera óptima.

### Descripción del Problema:

1. **Gestión de Clientes y Empleados**: Necesitamos una base de datos que nos permita registrar la información de los clientes que realizan reservas, así como de los empleados involucrados en el trabajo solicitado.

2. **Gestión de Tipos de trabajo**: Es importante poder clasificar las reservas según su tipo, ya sea una alineación, un trabajo de mecánica ligera o un trabajo de competición. Esto nos ayudará a organizar mejor el flujo de trabajo y adaptar nuestros servicios según las necesidades del cliente.

3. **Gestión de Puestos y Disponibilidad**: La base de datos debe permitirnos gestionar la disponibilidad de puestos en cada taller, así como gestionar su capacidad y disponibilidad. Esto es fundamental para garantizar una asignación eficiente de puestos y evitar conflictos de reservas.

4. **Registro de Reservas**: Necesitamos un sistema que pueda registrar de manera detallada cada reserva realizada, incluyendo la fecha y hora de la reserva, el cliente que la realizó, el puesto reservado, en que taller, el tipo de trabajo y el empleado que realizará la tarea asignada.

### Objetivo:

Diseñar e implementar una base de datos relacional que satisfaga todas las necesidades de gestión de reservas para nuestro sistema de gestión de talleres. Esta base de datos deberá ser eficiente, escalable y fácil de mantener, permitiendo una gestión ágil y precisa de todas las operaciones relacionadas con las reservas.

### Herramientas utilizadas:
* **MySQL WorkBench**
* **Claude AI**
* **ChatGPT**
* **Miro**
* **Excalidraw**


## Descripción de la Base de Datos - Gestión de Reservas en Talleres

Esta base de datos está diseñada para gestionar reservas de turnos entre distintos talleres mecánicos automotrices, de esta manera contar con la información relacionada con clientes, empleados, tipos de trabajo y talleres disponibles. A continuación se detallan los elementos principales de la base de datos:

### Tablas:

1. **CLIENTE**:
   - Almacena información sobre los clientes que realizan reservas.
   - Atributos: IDCLIENTE, NOMBRE, TELEFONO, CORREO, DNI.

2. **EMPLEADO**:
   - Contiene información sobre los empleados involucrados en el trabajo a realizar.
   - Atributos: IDEMPLEADO, NOMBRE, TELEFONO, CORREO, DNI, IDTALLER, IDTIPOTRABAJO.

3. **DUEÑO**:
   - Guarda datos sobre los dueños de los talleres (no se utiliza explícitamente en el proceso de reservas).
   - Atributos: IDDUENO, NOMBRE, TELEFONO, CORREO, DNI.

4. **TIPOTRABAJO**:
   - Define diferentes tipos de trabajo para clasificarlos según la tarea realizada.
   - Atributos: IDTIPOTRABAJO, TIPO, DURACIONPROM.

5. **TALLER**:
   - Almacena información sobre los talleres disponibles.
   - Atributos: IDTALLER, IDDUENO, NOMBRE, DIRECCION, TELEFONO.

6. **PUESTO_TRABAJO**:
   - Contiene información sobre los puestos de trabajo.
   - Atributos: IDPUESTO, TIPO_PUESTO.
  
7. **PUESTO_TRABAJO_TALLER**:
   - Contiene información sobre los puestos de trabajo y su capacidad según el taller.
   - Atributos: IDPUESTOTALLER, IDPUESTO, IDTALLER, IDTIPOTRABAJO, CAPACIDAD.

8. **RESERVA**:
   - Registra las reservas de turnoes realizadas en tallers automotrices por los clientes y el detalle de los empleados y talleres involucrados.
   - Atributos: IDRESERVA, IDCLIENTE, IDPUESTOTALLER, IDEMPLEADO, FECHA, CANCELACION.

9. **LOG_CAMBIOS**:
   - Registra los cambios de acciones DML de INSERT o UPDATE.
   - Atributos: IDLOG, TABLA_AFECTADA, ACCION, FECHA, IDCLIENTE, USUARIO.   

### Problemática Resuelta:

Esta base de datos permite gestionar eficientemente el proceso de reserva en talleres, desde la información de los clientes y empleados hasta la disponibilidad de puestos y el registro de reservas. Algunos aspectos que aborda incluyen:

- Registro de clientes y empleados involucrados en el proceso de reserva.
- Clasificación de las reservas según su tipo de trabajo.
- Gestión de la disponibilidad de puestos en cada taller.
- Registro detallado de las reservas realizadas, incluyendo la fecha, cliente, puesto, empleado, taller y tipo de trabajo.

En resumen, esta base de datos proporciona una estructura para organizar y gestionar eficientemente las operaciones de reserva en talleres, lo que contribuye a mejorar el servicio ofrecido a los clientes y optimizar las operaciones del taller.

#### [LINK DER SIMPLIFICADO](https://miro.com/app/board/uXjVK3m03lM=/?share_link_id=776080637841)

## Estructura e ingesta de datos
* Se realiza principalmente por medio del archivo population.sql ubicado en el directorio ./structure
* La carga de las tablas CLIENTE, DUENO, EMPLEADO, TALLER, PUESTO_TRABAJO_TALLER Y RESERVA se realiza por medio de archivos csv colocados en el directorio ./data_csv

## BackUp
* En MySQL se ejecuta la modalidad 'Export to Self-contained File', que devuelve 1 sólo script completo el cual se encuentra en el directorio ./backup/backup.sql


## Documentacion de Vistas
### Vista: ReservasPorFecha

**Creación:**
```sql
CREATE VIEW
    ReservasPorFecha AS
SELECT
    DATE (FECHA) AS Fecha,
    COUNT(*) AS TotalReservas
FROM
    RESERVA
GROUP BY
    DATE (FECHA)
ORDER BY
    FECHA DESC;
```

**Descripción:** Esta vista muestra estadísticas sobre las reservas realizadas en diferentes fechas, como el número total de reservas por día, por semana o por mes.

**Columnas:**

* **Fecha:** Fecha de la reserva (formato YYYY-MM-DD).
* **TotalReservas:** Número total de reservas realizadas en la fecha indicada.

**Ejemplo de consulta:**

```sql
SELECT * FROM ReservasPorFecha
WHERE Fecha BETWEEN '2010-12-01' AND '2023-12-31'
ORDER BY Fecha ASC;
```

### Vista: ReservasPorTaller

**Creación:**
```sql
CREATE VIEW
    ReservasPorTaller AS
SELECT
    PUESTO_TRABAJO_TALLER.IDTALLER,
    TIPO_TRABAJO.TIPO_TRABAJO,
    COUNT(RESERVA.IDRESERVA) AS TotalReservas
FROM
    PUESTO_TRABAJO_TALLER
    LEFT JOIN RESERVA ON PUESTO_TRABAJO_TALLER.IDPUESTOTALLER = RESERVA.IDPUESTOTALLER
    INNER JOIN TIPO_TRABAJO ON PUESTO_TRABAJO_TALLER.IDTIPOTRABAJO = TIPO_TRABAJO.IDTIPOTRABAJO
GROUP BY
    PUESTO_TRABAJO_TALLER.IDTALLER,
    TIPO_TRABAJO.TIPO_TRABAJO
ORDER BY
    TotalReservas DESC;
```

**Descripción:** Esta vista muestra la cantidad de reservas realizadas para cada taller.

**Columnas:**

* **IDTALLER:** Identificador único del taller.
* **TIPO_TRABAJO:** Descripción del trabajo.
* **TotalReservas:** Número total de reservas realizadas para el taller.

**Ejemplo de consulta:**

```sql
SELECT * FROM ReservasPorTaller
ORDER BY TotalReservas DESC;
```

### Vista: CancelacionesPorTipoTrabajo

**Creación:**
```sql
CREATE VIEW CancelacionesPorTipoTrabajo AS
SELECT
    TIPO_TRABAJO.TIPO_TRABAJO,
    COUNT(RESERVA.IDRESERVA) AS TotalCancelaciones
FROM
    TIPO_TRABAJO
    INNER JOIN PUESTO_TRABAJO_TALLER ON TIPO_TRABAJO.IDTIPOTRABAJO = PUESTO_TRABAJO_TALLER.IDTIPOTRABAJO
    LEFT JOIN RESERVA ON PUESTO_TRABAJO_TALLER.IDPUESTOTALLER = RESERVA.IDPUESTOTALLER
WHERE
    RESERVA.CANCELACION IS NOT NULL
GROUP BY
    TIPO_TRABAJO.TIPO_TRABAJO
ORDER BY
    TotalCancelaciones DESC;
```

**Descripción:** Esta vista muestra la cantidad de cancelaciones para cada tipo de trabajo.

**Columnas:**

* **TIPO_TRABAJO:** Tipo de trabajo (ej. "Alineación", "Chasis competición", etc.).
* **TotalCancelaciones:** Número total de cancelaciones para el tipo de trabajo.

**Ejemplo de consulta:**

```sql
SELECT * FROM CancelacionesPorTipoTrabajo
ORDER BY TotalCancelaciones DESC;
```
### Vista: CapacidadPuestos

**Creación:**
```sql
CREATE VIEW CapacidadPuestos AS
SELECT 
    TALLER.IDTALLER,
    TALLER.NOMBRE AS nombre_taller,
    PUESTO_TRABAJO.TIPO_PUESTO,
    PUESTO_TRABAJO_TALLER.IDPUESTOTALLER,
    PUESTO_TRABAJO_TALLER.CAPACIDAD AS capacidad_total,
    COUNT(RESERVA.IDRESERVA) AS reservas_actuales,
    PUESTO_TRABAJO_TALLER.CAPACIDAD - COALESCE(SUM(TIPO_TRABAJO.DURACIONPROM), 0) AS capacidad_disponible
FROM 
    TALLER
INNER JOIN PUESTO_TRABAJO_TALLER ON TALLER.IDTALLER = PUESTO_TRABAJO_TALLER.IDTALLER
INNER JOIN PUESTO_TRABAJO ON PUESTO_TRABAJO_TALLER.IDPUESTO = PUESTO_TRABAJO.IDPUESTO
INNER JOIN TIPO_TRABAJO ON PUESTO_TRABAJO_TALLER.IDTIPOTRABAJO = TIPO_TRABAJO.IDTIPOTRABAJO
LEFT JOIN RESERVA ON PUESTO_TRABAJO_TALLER.IDPUESTOTALLER = RESERVA.IDPUESTOTALLER 
    AND RESERVA.CANCELACION IS NULL
    AND RESERVA.FECHA >= CURDATE() 
    AND RESERVA.FECHA < DATE_ADD(CURDATE(), INTERVAL 1 DAY)
GROUP BY 
    TALLER.IDTALLER, TALLER.NOMBRE, PUESTO_TRABAJO.TIPO_PUESTO, PUESTO_TRABAJO_TALLER.IDPUESTOTALLER, TIPO_TRABAJO.IDTIPOTRABAJO, PUESTO_TRABAJO_TALLER.CAPACIDAD
ORDER BY 
    TALLER.IDTALLER, PUESTO_TRABAJO.TIPO_PUESTO;
```

**Descripción:** Esta vista muestra la capacidad restante de los puestos de trabajo de cada taller.

**Columnas:**

* **IDTALLER:** Identificador único de los talleres.
* **TIPO_PUESTO:** Descripción del puesto de trabajo.
* **IDPUESTOTALLER:** Identificador único del puesto de trabajo en determinado taller.
* **nombre_taller:** Nombre de los talleres.
* **reservas_actuales:** Cantidad de reservas.
* **capacidad_total:** Capacidad total de los talleres.
* **capacidad_disponible:** Capacidad total post reservas.

**Ejemplo de consulta:**

```sql
SELECT * FROM CapacidadPuestos
WHERE capacidad_disponible > 0
ORDER BY nombre_taller, TIPO_PUESTO;
```

## Documentación de Funciones 

### Función: trabajo_cancelado

**Creación:**
```sql
DELIMITER //

CREATE FUNCTION trabajo_cancelado(taller_id INT) RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE cancelacion_date DATETIME;
    DECLARE is_cancelada BOOLEAN;
    
    SELECT CANCELACION INTO cancelacion_date
        FROM RESERVA
        WHERE IDPUESTOTALLER = taller_id
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
```

**Descripción:** Esta función verifica si un trabajo en un determinado taller está cancelado para una reserva.

**Parámetros:**

* **taller_id:** Identificador único del trabajo en determinado taller.

**Retorno:**

* **TRUE** si el trabajo en el taller está cancelado para alguna reserva, **FALSE** en caso contrario.

**Ejemplo de uso:**

```sql
SELECT trabajo_cancelado(10);
```

**Nota:** La función solo verifica si el trabajo en un taller determinado está cancelado para alguna reserva. No indica si dicho trabajo en dicho taller está disponible para una nueva reserva en este momento.

### Función: contar_reservas_cliente

**Creación:**
```sql
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
```

**Descripción:** Esta función cuenta la cantidad de reservas realizadas por un cliente en un intervalo de tiempo.

**Parámetros:**

* **cliente_id:** Identificador único del cliente.
* **fecha_inicio:** Fecha de inicio del intervalo (formato YYYY-MM-DD).
* **fecha_fin:** Fecha de fin del intervalo (formato YYYY-MM-DD).

**Retorno:**

* Número total de reservas realizadas por el cliente en el intervalo de tiempo especificado.

**Ejemplo de uso:**

```sql
SELECT contar_reservas_cliente(5, '2023-12-01', '2023-12-31');
```

**Nota:** La función no toma en cuenta las cancelaciones de reservas.

### Función: cantidad_puestos_por_taller

**Creación:**
```sql
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
```

**Descripción:** Esta función devuelve la cantidad de puestos que tiene un taller.

**Parámetros:**

* **puestotaller_id:** Identificador único del puesto en el taller.

**Retorno:**

* Número total de mesas del restaurante.

**Ejemplo de uso:**

```sql
SELECT cantidad_puestos_por_taller(2);
```

## Documentación de Triggers 

### Trigger: after_insert_cliente_trigger

**Creación:**
```sql
DELIMITER //

CREATE TRIGGER after_insert_cliente_trigger
AFTER INSERT ON CLIENTE
FOR EACH ROW
BEGIN
    INSERT INTO LOG_CAMBIOS (TABLA_AFECTADA, ACCION, FECHA, IDCLIENTE, USUARIO)
    VALUES ('CLIENTE', 'INSERT', NOW() , NEW.IDCLIENTE,USER());
END //

DELIMITER ;
```

**Descripción:** Este trigger registra la inserción de un nuevo cliente en la tabla LOG_CAMBIOS.

**Detalles:**

* **Tabla afectada:** CLIENTE
* **Acción:** INSERT
* **Información registrada:** Fecha, ID del cliente, Usuario.

**Ejemplo:**

* Se inserta un nuevo cliente.
* El trigger registra la acción en la tabla LOG_CAMBIOS con los detalles correspondientes.

### Trigger: after_update_cancelacion_reserva_trigger

**Creación:**
```sql
DELIMITER //
    
CREATE TRIGGER after_update_cancelacion_reserva_trigger
AFTER UPDATE ON RESERVA
FOR EACH ROW
BEGIN
    IF OLD.CANCELACION IS NULL AND NEW.CANCELACION IS NOT NULL THEN
        INSERT INTO LOG_CAMBIOS (TABLA_AFECTADA, ACCION, FECHA, IDCLIENTE, USUARIO)
        VALUES ('RESERVA', 'CANCELACION', NOW(), NEW.IDCLIENTE, USER());
    END IF;
END //
    
DELIMITER ;
```

**Descripción:** Este trigger registra la cancelación de una reserva en la tabla LOG_CAMBIOS.

**Detalles:**

* **Tabla afectada:** RESERVA
* **Acción:** CANCELACION
* **Información registrada:** Fecha, ID del cliente (si se conoce), Usuario.

**Ejemplo:**

* Se actualiza una reserva para indicar su cancelación.
* Si la cancelación no estaba presente antes, el trigger registra la acción en la tabla LOG_CAMBIOS.

### Trigger: before_insert_cliente_trigger

**Creación:**
```sql
DELIMITER //

CREATE TRIGGER before_insert_cliente_trigger
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
    DECLARE correo_count INT;
    
    SELECT COUNT(*) INTO correo_count
        FROM CLIENTE
    WHERE CORREO = NEW.CORREO;
    
    IF correo_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo electrónico ya está en uso.';
    END IF;
END //

DELIMITER ;
```

**Descripción:** Este trigger verifica si el correo electrónico de un nuevo cliente ya está en uso.

**Detalles:**

* **Tabla afectada:** CLIENTE
* **Acción:** INSERT
* **Validación:** Correo electrónico único.

**Ejemplo:**

* Se intenta insertar un nuevo cliente con un correo electrónico ya registrado.
* El trigger genera un error y la inserción no se realiza.

### Trigger: before_insert_reserva_trigger

**Creación:**
```sql
DELIMITER //

CREATE TRIGGER before_insert_reserva_trigger
BEFORE INSERT ON RESERVA
FOR EACH ROW
BEGIN
    DECLARE reserva_count INT;
    
    SELECT COUNT(*) INTO reserva_count
        FROM RESERVA
    WHERE IDCLIENTE = NEW.IDCLIENTE
        AND IDPUESTOTALLER = NEW.IDPUESTOTALLER
        AND FECHA = NEW.FECHA
        AND CANCELACION IS NULL;
        
    IF reserva_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente ya tiene una reserva en la misma hora y taller.';
    END IF;
END //

DELIMITER ;
```

**Descripción:** Este trigger verifica si un cliente ya tiene una reserva en la misma hora y taller.

**Detalles:**

* **Tabla afectada:** RESERVA
* **Acción:** INSERT
* **Validación:** No se permiten reservas duplicadas en la misma hora y taller para un mismo cliente.

**Ejemplo:**

* Se intenta reservar trabajo para un cliente que ya tiene una reserva en la misma hora y taller.
* El trigger genera un error y la reserva no se realiza.

### Trigger: before_reserva_update

**Creación:**
```sql
DELIMITER //

CREATE TRIGGER before_reserva_update
BEFORE UPDATE ON RESERVA
FOR EACH ROW
BEGIN
    IF NEW.CANCELACION IS NOT NULL AND NEW.CANCELACION >= NEW.FECHA THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La FECHA de cancelación no puede ser posterior a la FECHA de reserva';
    END IF;
END//

DELIMITER ;
```

**Descripción:** Este trigger verifica que la cancelación sea anterior a fecha.

**Detalles:**

* **Tabla afectada:** RESERVA
* **Acción:** UPDATE 
* **Información registrada:** Fecha, cancelacion.

**Ejemplo:**

* Se actualiza una reserva para indicar su cancelación.


## Documentación de Procedimientos Almacenados

### Procedimiento: actualizar_reserva_cancelada_por_email

**Creación:**
```sql
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
```

**Descripción:** Este procedimiento actualiza una reserva cancelada para un cliente a partir de su correo electrónico.

**Parámetros:**

* **por_email:** Correo electrónico del cliente.

**Retorno:**

* Mensaje de éxito o error.

**Ejemplo de uso:**

```sql
CALL actualizar_reserva_cancelada_por_email('ejemplo@correo.com');
```

### Procedimiento: actualizar_tipo_reserva_por_email

**Creación:**
```sql
DELIMITER //
CREATE PROCEDURE actualizar_tipo_reserva_por_email(
    IN por_email VARCHAR(100),
    IN por_nuevo_trabajo VARCHAR(50)
)
BEGIN
    DECLARE cliente_id INT;
    DECLARE reserva_id INT;
    DECLARE nuevo_puesto_taller_id INT;
    
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
        
        -- Si se encontró la reserva, actualizar el tipo de trabajo
        IF reserva_id IS NOT NULL THEN
            -- Obtener un IDPUESTOTALLER que corresponda al nuevo tipo de trabajo
            SELECT IDPUESTOTALLER INTO nuevo_puesto_taller_id
            FROM PUESTO_TRABAJO_TALLER
            WHERE IDTIPOTRABAJO = (SELECT IDTIPOTRABAJO FROM TIPO_TRABAJO WHERE TIPO_TRABAJO = por_nuevo_trabajo)
            LIMIT 1;
            
            IF nuevo_puesto_taller_id IS NOT NULL THEN
                UPDATE RESERVA
                SET IDPUESTOTALLER = nuevo_puesto_taller_id, FECHA = NOW()
                WHERE IDRESERVA = reserva_id;
                
                SELECT 'Se actualizó el tipo de reserva del cliente con correo electrónico ', por_email, ' a ', por_nuevo_trabajo, '.';
            ELSE
                SELECT 'No se encontró un puesto de trabajo para el tipo de trabajo especificado.';
            END IF;
        ELSE
            SELECT 'El cliente con correo electrónico ', por_email, ' no tiene reservas.';
        END IF;
    ELSE
        SELECT 'No se encontró ningún cliente con el correo electrónico ', por_email, '.';
    END IF;
END //
DELIMITER ;
```

**Descripción:** Este procedimiento actualiza el tipo de reserva de la última reserva realizada por un cliente a partir de su correo electrónico.

**Parámetros:**

* **por_email:** Correo electrónico del cliente.
* **por_nuevo_trabajo:** Nuevo tipo de trabajo.
* **cliente_id:** Identificador único del cliente.
* **reserva_id:** Identificador único de la reserva.
* **nuevo_puesto_taller_id:** Identificador único del tipo de trabajo en determinado taller.

**Retorno:**

* Mensaje de éxito o error.

**Ejemplo de uso:**

```sql
CALL actualizar_tipo_reserva_por_email('ejemplo@correo.com', 'Alineación');
```

### Procedimiento: crear_empleado

**Creación:**
```sql
DELIMITER //

CREATE PROCEDURE crear_empleado(
    IN su_nombre VARCHAR(100),
    IN su_telefono VARCHAR(20),
    IN su_correo VARCHAR(100),
    IN su_dni VARCHAR(20),
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
```

**Descripción:** Este procedimiento crea un nuevo empleado en la base de datos.

**Parámetros:**

* **su_nombre:** Nombre del empleado.
* **su_telefono:** Teléfono del empleado.
* **su_correo:** Correo electrónico del empleado.
* **su_dni:** DNI del empleado.
* **su_id_taller:** ID del taller en el que trabaja.
* **su_id_tipotrabajo:** ID del tipo de trabajo que realiza.

**Retorno:**

* Mensaje de éxito o error

**Ejemplo de uso:**

```sql
CALL crear_empleado('Pepe Ramirez', '12348765', 'pepitora@ejemplo.com', '23158694', 12, 2);
```
## Roles y permisos
`./database_objects/user_roles.sql`

Se genera cuatro roles:

1. `admin_total`: Este rol tiene permisos totales.

**Creación:**
```sql
DROP ROLE IF EXISTS admin_total;
CREATE ROLE admin_total;
GRANT ALL PRIVILEGES ON proyecto_reservas.* TO admin_total WITH GRANT OPTION;
```

2. `admin_rrhh`: Este rol tiene permisos totales sobre las tablas EMPLEADO y TALLER.

**Creación:**
```sql
DROP ROLE IF EXISTS admin_rrhh;
CREATE ROLE admin_rrhh;
GRANT ALL PRIVILEGES ON proyecto_reservas.EMPLEADO TO admin_rrhh;
GRANT ALL PRIVILEGES ON proyecto_reservas.TALLER TO admin_rrhh;
```

3. `analista_dml`: Este rol tiene permisos de lectura de las tablas y vistas.

**Creación:**
```sql
DROP ROLE IF EXISTS analista_dml;
CREATE ROLE analista_dml;
GRANT SELECT ON proyecto_reservas.* TO analista_dml;
GRANT SHOW VIEW ON proyecto_reservas.* TO analista_dml;
```

4. `gestor_reservas`: Este rol tiene permisos totales sobre la tabla RESERVA y puede usar todos los store procedures y todas lasfunciones.

**Creación:**
```sql
DROP ROLE IF EXISTS gestor_reservas;
CREATE ROLE gestor_reservas;
GRANT SELECT, INSERT, UPDATE, DELETE ON RESERVA TO gestor_reservas;
GRANT EXECUTE ON PROCEDURE proyecto_reservas.* TO gesor_reservas;
GRANT EXECUTE ON FUNCTION proyecto_reservas.* TO gestor_reservas;
```

Además, se crea un usuario por cada rol y se le asigna el rol correspondiente.

```sql
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
```
