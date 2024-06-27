## CREACION BASE DE UNA APP PARA RESERVAS DE UN TALLER USANDO DISTINTOS


### Problema:

Nuestro equipo de desarrollo está trabajando en un sistema de gestión de reservas para talleres, y nos enfrentamos a la necesidad de diseñar una base de datos eficiente que pueda manejar todas las operaciones relacionadas con las reservas de manera óptima.

### Descripción del Problema:

1. **Gestión de Clientes y Empleados**: Necesitamos una base de datos que nos permita registrar la información de los clientes que realizan reservas, así como de los empleados involucrados en el proceso de reserva, como los mecánicos o encargados de atención al cliente.

2. **Gestión de Tipos de trabajo**: Es importante poder clasificar las reservas según su tipo, ya sea una alineación, un trabajo de mecánica ligera o un trabajo de competición. Esto nos ayudará a organizar mejor el flujo de trabajo y adaptar nuestros servicios según las necesidades del cliente.

3. **Gestión de Puestos y Disponibilidad**: La base de datos debe permitirnos registrar la disponibilidad de puestos en cada taller, así como gestionar su capacidad y estado (ocupado o disponible). Esto es fundamental para garantizar una asignación eficiente de puestos y evitar conflictos de reservas.

4. **Registro de Reservas**: Necesitamos un sistema que pueda registrar de manera detallada cada reserva realizada, incluyendo la fecha y hora de la reserva, el cliente que la realizó, el puesto reservado, el empleado que atendió la reserva y el tipo de trabajo.

### Objetivo:

Diseñar e implementar una base de datos relacional que satisfaga todas las necesidades de gestión de reservas para nuestro sistema de gestión de talleres. Esta base de datos deberá ser eficiente, escalable y fácil de mantener, permitiendo una gestión ágil y precisa de todas las operaciones relacionadas con las reservas.


## Descripción de la Base de Datos - Gestión de Reservas en Talleres

Esta base de datos está diseñada para gestionar reservas en talleres, así como la información relacionada con clientes, empleados, tipos de trabajo y talleres mismos. A continuación se detallan los elementos principales de la base de datos:

### Tablas:

1. **CLIENTE**:
   - Almacena información sobre los clientes que realizan reservas.
   - Atributos: IDCLIENTE, NOMBRE, TELEFONO, CORREO.

2. **EMPLEADO**:
   - Contiene información sobre los empleados involucrados en el proceso de reservas.
   - Atributos: IDEMPLEADO, NOMBRE, TELEFONO, CORREO, IDTALLER, IDTIPOTRABAJO.

3. **DUEÑO**:
   - Guarda datos sobre los dueños de los talleres (no se utiliza explícitamente en el proceso de reservas).

4. **TIPOTRABAJO**:
   - Define diferentes tipos de reserva para clasificarlas según su propósito o requisitos específicos.
   - Atributos: IDTIPOTRABAJO, TIPO, DURACIONPROM.

5. **TALLER**:
   - Almacena información sobre los restaurantes disponibles.
   - Atributos: IDTALLER, NOMBRE, DIRECCION, TELEFONO.

6. **PUESTO_TRABAJO**:
   - Contiene información sobre las mesas disponibles en cada restaurante.
   - Atributos: IDPUESTO, IDTALLER, CAPACIDAD, DISPONIBLE.

7. **RESERVA**:
   - Registra las reservas realizadas por los clientes.
   - Atributos: IDRESERVA, IDCLIENTE, IDPUESTO, IDEMPLEADO, IDTIPOTRABAJO, IDTALLER, FECHA.

### Problemática Resuelta:

Esta base de datos permite gestionar eficientemente el proceso de reserva en talleres, desde la información de los clientes y empleados hasta la disponibilidad de puestos y el registro de reservas. Algunos aspectos que aborda incluyen:

- Registro de clientes y empleados involucrados en el proceso de reserva.
- Clasificación de las reservas según su tipo de trabajo.
- Gestión de la disponibilidad de puestos en cada taller.
- Registro detallado de las reservas realizadas, incluyendo la fecha, cliente, puesto, empleado, taller y tipo de trabajo.

En resumen, esta base de datos proporciona una estructura para organizar y gestionar eficientemente las operaciones de reserva en talleres, lo que contribuye a mejorar el servicio ofrecido a los clientes y optimizar las operaciones del taller.
*/

### MEDIOS DE RESERVAS

#### LINK DER SIMPLIFICADO

https://miro.com/app/board/uXjVK3m03lM=/?share_link_id=776080637841
