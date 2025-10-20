--DDL (estructura)

-- Se ejecutan en pgAdmin: servilimar → Query Tool → pegar y ejecutar.

-- TIPOS
CREATE TYPE tipo_usuario AS ENUM ('CLIENTE','EMPLEADO','PROVEEDOR','INVITADO');
CREATE TYPE estado_general AS ENUM ('ACTIVO','INACTIVO');
CREATE TYPE estado_turno AS ENUM ('PENDIENTE','EN_CURSO','ATENDIDO','CANCELADO');
CREATE TYPE condicion_especial_enum AS ENUM ('NINGUNA','EMBARAZO','SILLA_RUEDAS','ADULTO_MAYOR','OTRA');

-- TABLAS
CREATE TABLE ciudad (
  ciudad_id      SERIAL PRIMARY KEY,
  nombre_ciudad  VARCHAR(100) NOT NULL,
  codigo_postal  VARCHAR(20)  NOT NULL,
  CONSTRAINT uq_ciudad UNIQUE (nombre_ciudad, codigo_postal)
);

CREATE TABLE usuario (
  usuario_id         SERIAL PRIMARY KEY,
  nombre             VARCHAR(100) NOT NULL,
  apellido           VARCHAR(100) NOT NULL,
  tipo_usuario       tipo_usuario NOT NULL,
  condicion_especial condicion_especial_enum NOT NULL DEFAULT 'NINGUNA',
  ciudad_id          INTEGER NOT NULL REFERENCES ciudad(ciudad_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE servicio (
  servicio_id  SERIAL PRIMARY KEY,
  nombre       VARCHAR(120) NOT NULL,
  descripcion  TEXT,
  estado       estado_general NOT NULL DEFAULT 'ACTIVO',
  CONSTRAINT uq_servicio_nombre UNIQUE (nombre)
);

CREATE TABLE medio (
  medio_id SERIAL PRIMARY KEY,
  nombre   VARCHAR(50) NOT NULL UNIQUE
 
);

CREATE TABLE empleado (
  empleado_id  SERIAL PRIMARY KEY,
  usuario_id   INTEGER NOT NULL UNIQUE REFERENCES usuario(usuario_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  cargo        VARCHAR(120) NOT NULL,
  departamento VARCHAR(120) NOT NULL
);

CREATE TABLE notificacion (
  notificacion_id SERIAL PRIMARY KEY,
  usuario_id      INTEGER NOT NULL REFERENCES usuario(usuario_id) ON UPDATE CASCADE ON DELETE CASCADE,
  medio_id        INTEGER NOT NULL REFERENCES medio(medio_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  mensaje         TEXT NOT NULL,
  fecha_envio     TIMESTAMP NOT NULL DEFAULT NOW(),
  estado          estado_general NOT NULL DEFAULT 'ACTIVO'
);

CREATE TABLE turno (
  turno_id     SERIAL PRIMARY KEY,
  usuario_id   INTEGER NOT NULL REFERENCES usuario(usuario_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  servicio_id  INTEGER NOT NULL REFERENCES servicio(servicio_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  empleado_id  INTEGER     REFERENCES empleado(empleado_id) ON UPDATE CASCADE ON DELETE SET NULL,
  fecha        DATE    NOT NULL,
  hora_inicio  TIME    NOT NULL,
  hora_fin     TIME    NOT NULL,
  estado       estado_turno NOT NULL DEFAULT 'PENDIENTE',
  creado_en    TIMESTAMP NOT NULL DEFAULT NOW(),
  CONSTRAINT ck_horas_validas CHECK (hora_fin > hora_inicio)
);

-- Índices fks
CREATE INDEX idx_usuario_ciudad   ON usuario(ciudad_id);
CREATE INDEX idx_empleado_usuario ON empleado(usuario_id);
CREATE INDEX idx_turno_usuario    ON turno(usuario_id);
CREATE INDEX idx_turno_servicio   ON turno(servicio_id);
CREATE INDEX idx_turno_empleado   ON turno(empleado_id);
CREATE INDEX idx_turno_fecha      ON turno(fecha, hora_inicio);
