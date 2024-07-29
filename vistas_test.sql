USE proyecto_reservas;

-- Vista para KPIs de fechas de reservas:
-- Esta vista mostrará estadísticas sobre las reservas realizadas en diferentes fechas, como el número total de reservas por día, por semana o por mes.
CREATE VIEW
    ReservasPorFecha AS
SELECT
    DATE (FECHA) AS Fecha,
    COUNT(*) AS TotalReservas
FROM
    RESERVA
GROUP BY
    DATE (FECHA);

-- Vista para cantidad de reservas por taller:
-- Esta vista mostrará la cantidad de reservas realizadas para cada taller, así como la capacidad total del taller.
CREATE VIEW
    ReservasPorTaller AS
SELECT
    PUESTO_TRABAJO_TALLER.IDTALLER,
    PUESTO_TRABAJO_TALLER.CAPACIDAD,
    PUESTO_TRABAJO_TALLER.IDTIPOTRABAJO,
    COUNT(RESERVA.IDRESERVA) AS TotalReservas
FROM
    PUESTO_TRABAJO_TALLER
    LEFT JOIN RESERVA ON PUESTO_TRABAJO_TALLER.IDPUESTOTALLER = RESERVA.IDPUESTOTALLER
GROUP BY
    PUESTO_TRABAJO_TALLER.IDTALLER,
    PUESTO_TRABAJO_TALLER.IDTIPOTRABAJO,
    PUESTO_TRABAJO_TALLER.CAPACIDAD;
    

-- Vista para cantidad de cancelaciones por tipo de reservas:
-- Esta vista mostrará la cantidad de cancelaciones para cada tipo de reserva.
CREATE VIEW
    CancelacionesPorTipoReserva AS
SELECT
    TIPO_TRABAJO.TIPO_TRABAJO,
    COUNT(RESERVA.IDRESERVA) AS TotalCancelaciones
FROM
    TIPO_TRABAJO
    LEFT JOIN RESERVA ON PUESTO_TRABAJO_TALLER.IDPUESTOTALLER = RESERVA.IDPUESTOTALLER
WHERE
    RESERVA.CANCELACION IS NOT NULL
GROUP BY
    TIPO_TRABAJO.TIPO_TRABAJO;
