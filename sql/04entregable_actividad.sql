-- Se crean Tablas de auditoría para consulta de los datos que se eliminen
CREATE TABLE copia_actualizados_tablaUU (
  auditoria_id       INT AUTO_INCREMENT PRIMARY KEY,
  docente_id         INT NOT NULL,
  numero_documento   VARCHAR(20)  NOT NULL,
  nombres            VARCHAR(120) NOT NULL,
  titulo             VARCHAR(120),
  anios_experiencia  INT          NOT NULL,
  direccion          VARCHAR(180),
  tipo_docente       VARCHAR(40),
  accion_fecha       DATETIME     NOT NULL DEFAULT (UTC_TIMESTAMP()),
  usuario_sql        VARCHAR(128) NOT NULL DEFAULT (CURRENT_USER())
) ENGINE=InnoDB;

-- Se crean Tablas de auditoría para consulta de los datos que se eliminen
CREATE TABLE copia_eliminados_tablaDD (
  auditoria_id       INT AUTO_INCREMENT PRIMARY KEY,
  docente_id         INT NOT NULL,
  numero_documento   VARCHAR(20)  NOT NULL,
  nombres            VARCHAR(120) NOT NULL,
  titulo             VARCHAR(120),
  anios_experiencia  INT          NOT NULL,
  direccion          VARCHAR(180),
  tipo_docente       VARCHAR(40),
  accion_fecha       DATETIME     NOT NULL DEFAULT (UTC_TIMESTAMP()),
  usuario_sql        VARCHAR(128) NOT NULL DEFAULT (CURRENT_USER())
) ENGINE=InnoDB;

-- Procedimiento almacenado para crear un nuevo PROYECTO 

DELIMITER $$

CREATE PROCEDURE sp_proyecto_crear(
  IN p_nombre           VARCHAR(120) NOT NULL,
  IN p_descripcion      VARCHAR(400),
  IN p_fecha_inicial    DATE NOT NULL,
  IN p_fecha_final      DATE,
  IN p_presupuesto      DECIMAL(12,2) NOT NULL DEFAULT 0,
  IN p_horas            INT           NOT NULL DEFAULT 0,
  IN p_docente_id_jefe  INT NOT NULL
)
BEGIN
  INSERT INTO proyecto (
    nombre, descripcion, fecha_inicial, fecha_final, presupuesto, horas, docente_id_jefe
  )
  VALUES (
    p_nombre, p_descripcion, p_fecha_inicial, p_fecha_final, p_presupuesto, p_horas, WHERE docente_id = p_docente_id_jefe
  );
END$$

-- Procedimiento almacenado para leer un proyecto existente
DELIMITER ;
CREATE PROCEDURE sp_proyecto_leer(
    IN p_proyecto_id INT
)BEGIN
    SELECT * FROM proyecto WHERE proyecto_id = p_proyecto_id;
END$$       
DELIMITER ;

--- Procedimiento almacenado para actualizar un proyecto existente
DELIMITER $$;
CREATE PROCEDURE sp_proyecto_actualizar(
  IN p_proyecto_id     INT,
  IN p_nombre          VARCHAR(120) NOT NULL,
  IN p_descripcion     VARCHAR(400),
  IN p_fecha_inicial   DATE NOT NULL,
  IN p_fecha_final     DATE,
  IN p_presupuesto     DECIMAL(12,2) NOT NULL DEFAULT 0,
  IN p_horas           INT           NOT NULL DEFAULT 0,
  IN p_docente_id_jefe INT NOT NULL
)BEGIN
  UPDATE proyecto
     SET nombre = p_nombre,
         descripcion = p_descripcion,
         fecha_inicial = p_fecha_inicial,
         fecha_final = p_fecha_final,
         presupuesto = IFNULL(p_presupuesto,0),
         horas = IFNULL(p_horas,0),
         docente_id_jefe = p_docente_id_jefe
   WHERE proyecto_id = p_proyecto_id;

  SELECT * FROM proyecto WHERE proyecto_id = p_proyecto_id;
END$$
DELIMITER ;

--- Procedimiento almacenado para eliminar un proyecto existente
DELIMITER $$;
CREATE PROCEDURE sp_proyecto_eliminar(
    IN p_proyecto_id INT
    )BEGIN
    DELETE FROM proyecto WHERE proyecto_id = p_proyecto_id;
END$$
DELIMITER ;

-- Inserción de nuevos proyectos
CALL sp_proyecto_crear(
    'Plataforma e-commerce', 'Desarrollo de una plataforma de comercio electrónico 2', '2025-09-01', NULL, 1500000000, 1200, 2
);
-- Lectura de un proyecto existente
CALL sp_proyecto_leer(1);

-- Actualización de un proyecto existente
CALL sp_proyecto_actualizar(
    2, 'App móvil de salud', 'Aplicación para monitoreo de salud 2', '2025-07-15', NULL, 600000000, 500, 3
);

-- Eliminación de un proyecto existente
CALL sp_proyecto_eliminar(3);

------------------------------------------------------------------------

-- Procedimiento almacenado para crear un nuevo docente

DELIMITER $$

CREATE PROCEDURE sp_docente_crear(
  IN d_numero_documento VARCHAR(20),
  IN d_nombres VARCHAR(100),
  IN d_titulo VARCHAR(100),
  IN d_anios_experiencia INT,
  IN d_direccion VARCHAR(200),
  IN d_tipo_docente VARCHAR(50)
)
BEGIN
  INSERT INTO docente (
    numero_documento, nombres, titulo, anios_experiencia, direccion, tipo_docente
  )
  VALUES (
    d_numero_documento, d_nombres, d_titulo, d_anios_experiencia, d_direccion, d_tipo_docente
  );
END$$

DELIMITER ;

-- Procedimiento almacenado para leer un docente existente
DELIMITER $$;
CREATE PROCEDURE sp_docente_leer(
    IN d_docente_id INT
)
BEGIN
    SELECT * FROM docente WHERE docente_id = d_docente_id;
END$$
DELIMITER ;


--- Procedimiento almacenado para actualizar un docente existente
DELIMITER $$;
CREATE PROCEDURE sp_docente_actualizar(
  IN d_docente_id       INT,
  IN d_numero_documento VARCHAR(20),
  IN d_nombres          VARCHAR(120),
  IN d_titulo           VARCHAR(120),
  IN d_anios_experiencia INT,
  IN d_direccion        VARCHAR(180),
  IN d_tipo_docente     VARCHAR(40)
)
BEGIN
  UPDATE docente
     SET numero_documento = d_numero_documento,
         nombres = d_nombres,
         titulo = d_titulo,
         anios_experiencia = IFNULL(d_anios_experiencia,0),
         direccion = d_direccion,
         tipo_docente = d_tipo_docente
   WHERE docente_id = d_docente_id;

  SELECT * FROM docente WHERE docente_id = d_docente_id;
END$$
DELIMITER ;

--- Procedimiento almacenado para eliminar un docente existente
DELIMITER $$;
CREATE PROCEDURE sp_docente_eliminar(
    IN d_docente_id INT
    )
BEGIN
  DELETE FROM docente WHERE docente_id = d_docente_id;
END$$
DELIMITER ;

-- Inserción de nuevos docentes
CALL sp_docente_crear(
    'CC5006', 'Laura Gómez', 'MSc. en IA', 6, 'Cll 45 # 22-10', 'Cátedra'
);

-- Lectura de un docente existente
CALL sp_docente_leer(2);

-- Actualización de un docente existente

CALL sp_docente_actualizar(
    3, 'CC3010', 'Carlos Pérez', 'Ing. de Sistemas', 8, 'Cll 100 # 10-10', 'Cátedra'
);
-- Eliminación de un docente existente
CALL sp_docente_eliminar(8);




-- Verificar la inserción o lectura de los datos

SELECT * FROM proyecto;
SELECT * FROM docente;

