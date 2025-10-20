--DML (inserción de datos)

INSERT INTO ciudad (nombre_ciudad, codigo_postal) VALUES
('Cali',        '760001'),
('Palmira',     '763531'),
('Yumbo',       '760507'),
('Jamundí',     '761027'),
('Bogotá',      '110111'),
('Medellín',    '050021'),
('Barranquilla','080001'),
('Cartagena',   '130001'),
('Bucaramanga', '680001'),
('Pereira',     '660001');

INSERT INTO usuario (nombre, apellido, tipo_usuario, condicion_especial, ciudad_id) VALUES
('Laura',   'Mora',     'CLIENTE',   'NINGUNA',       1),
('Carlos',  'López',    'CLIENTE',   'ADULTO_MAYOR',  5),
('María',   'Gómez',    'CLIENTE',   'EMBARAZO',      1),
('Andrés',  'Pérez',    'CLIENTE',   'SILLA_RUEDAS',  2),
('Sofía',   'Rivas',    'CLIENTE',   'NINGUNA',       3),
('Camila',  'García',   'EMPLEADO',  'NINGUNA',       1),
('Julián',  'Hernández','EMPLEADO',  'NINGUNA',       1),
('Sergio',  'Rojas',    'EMPLEADO',  'NINGUNA',       5),
('Paula',   'Nieves',   'CLIENTE',   'NINGUNA',       6),
('Diego',   'Torres',   'PROVEEDOR', 'NINGUNA',       7),
('Valeria', 'Luna',     'CLIENTE',   'NINGUNA',       4),
('Esteban', 'Cano',     'CLIENTE',   'NINGUNA',       9);

INSERT INTO medio (nombre) VALUES
('EMAIL'),
('SMS'),
('WHATSAPP'),
('LLAMADA'),
('PUSH');

INSERT INTO servicio (nombre, descripcion, estado) VALUES
('Despacho',              'Despacho de mercancías',                      'ACTIVO'),
('Entrega',               'Entrega de artículos al cliente',             'ACTIVO'),
('Recepción',             'Recepción de artículos de proveedores',       'ACTIVO'),
('Atención al cliente',   'Soporte y PQRS',                              'ACTIVO'),
('Consultoría',           'Asesoría especializada',                       'ACTIVO'),
('Instalación',           'Instalación de equipos',                      'ACTIVO'),
('Mantenimiento',         'Mantenimiento preventivo y correctivo',       'ACTIVO'),
('Capacitación',          'Entrenamientos a clientes/proveedores',       'ACTIVO'),
('Devoluciones',          'Gestión de devoluciones',                     'ACTIVO'),
('Logística interna',     'Operaciones internas de logística',           'ACTIVO');

--Pa agregar empleados extra
INSERT INTO usuario (nombre, apellido, tipo_usuario, condicion_especial, ciudad_id) VALUES
('Natalia','Vega','EMPLEADO','NINGUNA',1),   -- id 13
('Hugo','Salazar','EMPLEADO','NINGUNA',2),   -- id 14
('Verónica','Mena','EMPLEADO','NINGUNA',3),  -- id 15
('Ricardo','Paz','EMPLEADO','NINGUNA',4),    -- id 16
('Daniela','Hoyos','EMPLEADO','NINGUNA',5),  -- id 17
('Felipe','Ibarra','EMPLEADO','NINGUNA',6),  -- id 18
('Karol','Quintero','EMPLEADO','NINGUNA',7); -- id 19


INSERT INTO empleado (usuario_id, cargo, departamento) VALUES
(6,  'Asesor Senior',    'Atención'),
(7,  'Asesor',           'Atención'),
(8,  'Coordinador',      'Operaciones'),
(13, 'Técnico',          'Soporte'),
(14, 'Técnico',          'Soporte'),
(15, 'Analista',         'Consultoría'),
(16, 'Especialista',     'Instalación'),
(17, 'Supervisor',       'Mantenimiento'),
(18, 'Instructor',       'Capacitación'),
(19, 'Operario',         'Logística');

INSERT INTO notificacion (usuario_id, medio_id, mensaje, fecha_envio, estado) VALUES
(1, 1, 'Bienvenido a LiMar. Registro exitoso.',        NOW() - INTERVAL '10 days', 'ACTIVO'),
(2, 2, 'Su registro ha sido validado.',                NOW() - INTERVAL '9 days',  'ACTIVO'),
(3, 3, 'Recuerde su condición especial: EMbarazo.',    NOW() - INTERVAL '8 days',  'ACTIVO'),
(4, 1, 'Acceso habilitado. Puede tomar turnos.',       NOW() - INTERVAL '7 days',  'ACTIVO'),
(5, 4, 'Actualización de datos confirmada.',           NOW() - INTERVAL '6 days',  'ACTIVO'),
(9, 2, 'Contraseña restablecida.',                     NOW() - INTERVAL '5 days',  'ACTIVO'),
(10,3, 'Proveedor verificado.',                        NOW() - INTERVAL '4 days',  'ACTIVO'),
(11,1, 'Nuevos servicios disponibles.',                NOW() - INTERVAL '3 days',  'ACTIVO'),
(12,5, 'Notificación de seguridad.',                   NOW() - INTERVAL '2 days',  'ACTIVO'),
(1, 1, 'Recordatorio: tiene un turno mañana.',         NOW() - INTERVAL '1 days',  'ACTIVO');


-- empleados y servicios creados arriba reciben ids 1..10 en orden de inserción


INSERT INTO turno (usuario_id, servicio_id, empleado_id, fecha, hora_inicio, hora_fin, estado) VALUES
(1,  4,  1, CURRENT_DATE,        '08:00', '08:30', 'EN_CURSO'),
(2,  1,  2, CURRENT_DATE,        '08:30', '09:00', 'PENDIENTE'),
(3,  5,  6, CURRENT_DATE,        '09:00', '09:45', 'PENDIENTE'),
(4,  2,  3, CURRENT_DATE,        '09:15', '09:45', 'PENDIENTE'),
(5,  7,  8, CURRENT_DATE,        '10:00', '10:40', 'PENDIENTE'),
(9,  8,  9, CURRENT_DATE,        '10:45', '11:15', 'PENDIENTE'),
(10, 3,  10, CURRENT_DATE,       '11:30', '12:00', 'PENDIENTE'),
(11, 9,  5, CURRENT_DATE + 1,    '08:00', '08:30', 'PENDIENTE'),
(12, 6,  7, CURRENT_DATE + 1,    '08:30', '09:10', 'PENDIENTE'),
(1,  4,  1, CURRENT_DATE + 1,    '09:30', '10:00', 'PENDIENTE');
