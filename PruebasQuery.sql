SELECT 'ciudad' AS tabla, COUNT(*) AS registros FROM ciudad
UNION ALL SELECT 'usuario', COUNT(*) FROM usuario
UNION ALL SELECT 'medio', COUNT(*) FROM medio
UNION ALL SELECT 'servicio', COUNT(*) FROM servicio
UNION ALL SELECT 'empleado', COUNT(*) FROM empleado
UNION ALL SELECT 'notificacion', COUNT(*) FROM notificacion
UNION ALL SELECT 'turno', COUNT(*) FROM turno;
