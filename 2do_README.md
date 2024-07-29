### Documentacion de Vistas
### Vista: ReservasPorFecha

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

### Vista: ReservasPorMesa

**Descripción:** Esta vista muestra la cantidad de reservas realizadas para cada taller, así como la capacidad total del taller.

**Columnas:**

* **IDTALLER:** Identificador único del taller.
* **TIPO_TRABAJO:** Descripción del trabajo.
* **CAPACIDAD:** Tiempo disponible por puesto de trabajo.
* **TotalReservas:** Número total de reservas realizadas para el taller.

**Ejemplo de consulta:**

```sql
SELECT * FROM ReservasPorTaller
ORDER BY TotalReservas DESC;
```

### Vista: CancelacionesPorTipoTrabajo

**Descripción:** Esta vista muestra la cantidad de cancelaciones para cada tipo de reserva.

**Columnas:**

* **TIPO_TRABAJO:** Tipo de trabajo (ej. "Alineación", "Chasis competición", etc.).
* **TotalCancelaciones:** Número total de cancelaciones para el tipo de trabajo.

**Ejemplo de consulta:**

```sql
SELECT * FROM CancelacionesPorTipoTrabajo
ORDER BY TotalCancelaciones DESC;
```

## Documentación de Funciones 

### Función: trabajo_cancelado

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

### Trigger: after_insert_trigger

**Descripción:** Este trigger registra la inserción de un nuevo cliente en la tabla LOG_CAMBIOS.

**Detalles:**

* **Tabla afectada:** CLIENTE
* **Acción:** INSERT
* **Información registrada:** Fecha, ID del cliente, Usuario

**Ejemplo:**

* Se inserta un nuevo cliente.
* El trigger registra la acción en la tabla LOG_CAMBIOS con los detalles correspondientes.

### Trigger: after_update_cancelacion_trigger

**Descripción:** Este trigger registra la cancelación de una reserva en la tabla LOG_CAMBIOS.

**Detalles:**

* **Tabla afectada:** RESERVA
* **Acción:** CANCELACION
* **Información registrada:** Fecha, ID del cliente (si se conoce), Usuario

**Ejemplo:**

* Se actualiza una reserva para indicar su cancelación.
* Si la cancelación no estaba presente antes, el trigger registra la acción en la tabla LOG_CAMBIOS.

### Trigger: before_insert_cliente_trigger

**Descripción:** Este trigger verifica si el correo electrónico de un nuevo cliente ya está en uso.

**Detalles:**

* **Tabla afectada:** CLIENTE
* **Acción:** INSERT
* **Validación:** Correo electrónico único

**Ejemplo:**

* Se intenta insertar un nuevo cliente con un correo electrónico ya registrado.
* El trigger genera un error y la inserción no se realiza.

### Trigger: before_insert_reserva_trigger

**Descripción:** Este trigger verifica si un cliente ya tiene una reserva en la misma hora y mesa.

**Detalles:**

* **Tabla afectada:** RESERVA
* **Acción:** INSERT
* **Validación:** No se permiten reservas duplicadas en la misma hora y mesa para un mismo cliente.

**Ejemplo:**

* Se intenta reservar una mesa para un cliente que ya tiene una reserva en la misma hora y mesa.
* El trigger genera un error y la reserva no se realiza.


## Documentación de Procedimientos Almacenados

### Procedimiento: actualizar_reserva_cancelada_por_email

**Descripción:** Este procedimiento actualiza una reserva cancelada para un cliente a partir de su correo electrónico.

**Parámetros:**

* **p_email:** Correo electrónico del cliente

**Retorno:**

* Mensaje de éxito o error

**Ejemplo de uso:**

```sql
CALL actualizar_reserva_cancelada_por_email('ejemplo@correo.com');
```

### Procedimiento: actualizar_tipo_reserva_por_email

**Descripción:** Este procedimiento actualiza el tipo de reserva de la última reserva realizada por un cliente a partir de su correo electrónico.

**Parámetros:**

* **p_email:** Correo electrónico del cliente
* **p_nuevo_tipo:** Nuevo tipo de reserva

**Retorno:**

* Mensaje de éxito o error

**Ejemplo de uso:**

```sql
CALL actualizar_tipo_reserva_por_email('ejemplo@correo.com', 'Reserva de Grupo');
```

### Procedimiento: crear_empleado

**Descripción:** Este procedimiento crea un nuevo empleado en la base de datos.

**Parámetros:**

* **p_nombre:** Nombre del empleado
* **p_telefono:** Teléfono del empleado
* **p_correo:** Correo electrónico del empleado
* **p_id_restaurante:** Identificador del restaurante al que pertenece el empleado

**Retorno:**

* Mensaje de éxito o error

**Ejemplo de uso:**

```sql
CALL crear_empleado('Juan Pérez', '123456789', 'juan.perez@ejemplo.com', 1);
```
