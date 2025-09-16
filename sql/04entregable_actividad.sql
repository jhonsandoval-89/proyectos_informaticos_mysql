USE proyectos_informaticos

-- Limpiar triggers si existen para poder crear nuevos
DROP TRIGGER IF EXISTS copia_actualizados_tablaUU;
DROP TRIGGER IF EXISTS copia_eliminados_tablaDD;


-- Se crean Tabla copia_actualizados_tablaUU para consulta de los datos que se acualicen en la tabla docente
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

-- Se crean Tablas copia_eliminados_tablaDD para consulta de los datos que se eliminen en la tabla docente
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


-- Se crea un procedimiento almacenado para crear un nuevo PROYECTO en la tabla proyecto 
-- P_nombre, p_descripcion, p_fecha_inicial, p_fecha_final, p_presupuesto, p_horas, p_docente_id_jefe son los parámetros de entrada

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

-- Se crea un procedimiento almacenado para leer un nuevo PROYECTO en la tabla proyecto 
DELIMITER ;
CREATE PROCEDURE sp_proyecto_leer(
    IN p_proyecto_id INT
)BEGIN
    SELECT * FROM proyecto WHERE proyecto_id = p_proyecto_id;
END$$       
DELIMITER ;

--- Se crea un procedimiento almacenado para actualizar un PROYECTO en la tabla proyecto 
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

--- Se crea un procedimiento almacenado para eliminar un PROYECTO en la tabla proyecto
DELIMITER $$;
CREATE PROCEDURE sp_proyecto_eliminar(
    IN p_proyecto_id INT
    )BEGIN
    DELETE FROM proyecto WHERE proyecto_id = p_proyecto_id;
END$$
DELIMITER ;

-- Se llama la funcion con CALL para insertar datos nuevos en la tabla proyectos
CALL sp_proyecto_crear(
    'Plataforma e-commerce', 'Desarrollo de una plataforma de comercio electrónico 2', '2025-09-01', NULL, 1500000000, 1200, 2
);

-- Se llama la funcion con CALL para leer datos de la tabla proyectos
CALL sp_proyecto_leer(1);

-- Se llama la funcion con CALL para actualizar datos de la tabla proyectos
CALL sp_proyecto_actualizar(
    2, 'App móvil de salud', 'Aplicación para monitoreo de salud 2', '2025-07-15', NULL, 600000000, 500, 3
);

-- Se llama la funcion con CALL para eliminar datos de la tabla proyectos
CALL sp_proyecto_eliminar(3);

------------------------------------------------------------------------

-- Se crea función de Procedimiento almacenado para crear un nuevo docente

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

-- Se crea función de Procedimiento almacenado para leer un docente existente
DELIMITER $$;
CREATE PROCEDURE sp_docente_leer(
    IN d_docente_id INT
)
BEGIN
    SELECT * FROM docente WHERE docente_id = d_docente_id;
END$$
DELIMITER ;


-- Se crea función de Procedimiento almacenado para actualizar un docente existente
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

-- Se crea función de Procedimiento almacenado para eliminar un docente existente
DELIMITER $$;
CREATE PROCEDURE sp_docente_eliminar(
    IN d_docente_id INT
    )
BEGIN
  DELETE FROM docente WHERE docente_id = d_docente_id;
END$$
DELIMITER ;

--Se llama la función CALL para Insertar nuevos docentes
CALL sp_docente_crear(
    'CC5030', 'Camilo', 'Ingles', 6, 'av siempreviva 462', 'catedra'
);

--Se llama la función CALL para leer un docente existente
CALL sp_docente_leer(2);

--Se llama la función CALL para actualizar un docente existente

CALL sp_docente_actualizar(
    3, 'CC3010', 'Juan castro', 'Ing. de Sistemas', 8, 'Cll 100 # 10-10', 'Cátedra'
);
--Se llama la función CALL para eliminar un docente existente
CALL sp_docente_eliminar(12);




-- Usamos select para ver que datos tienen las tablas

SELECT * FROM proyecto;
SELECT * FROM docente;

------------------------------------------------------------------------

-- Función para calcular el promedio de los años de experiencia de los docentes

CREATE FUNCTION promedio_anios_experiencia_docentes()
RETURNS DECIMAL(5,2)
DETERMINISTIC
RETURN IFNULL((SELECT AVG(anios_experiencia) FROM docente), 0);

-- Seleccionamos la tabla para verificar función del promedio de años de experiencia
SELECT promedio_anios_experiencia_docentes();

-- Se crea Trigger para guardar una copia de los datos actualizados en la tabla docente en la tabla copia_actualizados_tablaUU
DELIMITER $$
CREATE TRIGGER copia_actualizados_tablaUU
AFTER UPDATE ON docente
FOR EACH ROW 
BEGIN
    INSERT INTO copia_actualizados_tablaUU (
        docente_id, 
        numero_documento, 
        nombres, 
        titulo, 
        anios_experiencia, 
        direccion, 
        tipo_docente
    )
    VALUES (
        NEW.docente_id, 
        NEW.numero_documento, 
        NEW.nombres, 
        NEW.titulo, 
        NEW.anios_experiencia, 
        NEW.direccion, 
        NEW.tipo_docente
    );
END$$
DELIMITER ;

-- Se crea Trigger para guardar una copia de los datos eliminados en la tabla docente en la tabla copia_eliminados_tablaDD
DELIMITER $$
CREATE TRIGGER copia_eliminados_tablaDD
AFTER DELETE ON docente
FOR EACH ROW 
BEGIN
    INSERT INTO copia_eliminados_tablaDD (
        docente_id, 
        numero_documento, 
        nombres, 
        titulo, 
        anios_experiencia, 
        direccion, 
        tipo_docente
    )
    VALUES (
        OLD.docente_id, 
        OLD.numero_documento, 
        OLD.nombres, 
        OLD.titulo, 
        OLD.anios_experiencia, 
        OLD.direccion, 
        OLD.tipo_docente
    );
END$$
DELIMITER ;

--- Actualizamos un docente para verificar que el trigger de actualización funciona
CALL sp_docente_actualizar(
    2, 'CC5030', 'Camilo Andres', 'Ingles avanzado', 7, 'av siempreviva 462 apto 101', 'catedra'
);
--- Eliminamos un docente para verificar que el trigger de eliminación funciona
CALL sp_docente_eliminar(3);
-- Seleccionamos las tablas de auditoría para verificar que los triggers funcionan correctamente
SELECT * FROM copia_actualizados_tablaUU;
SELECT * FROM copia_eliminados_tablaDD; 
-- Seleccionamos las tablas principales para verificar que los datos se actualizaron y eliminaron correctamente
SELECT * FROM docente;
SELECT * FROM proyecto;




