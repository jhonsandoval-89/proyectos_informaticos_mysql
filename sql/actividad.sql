SHOW TABLES;

SELECT * FROM docente;
-- Insetar datos en la tabla docente y proyecto
INSERT INTO docente (numero_documento, nombres, titulo, anios_experiencia, direccion, tipo_docente)
VALUES 
('CC3002','Sofía Ramírez','Ing. de Software',4,'Cra 15 # 3-40','Cátedra'),
('CC3003','Jorge Fernández','Esp. Redes y Telecomunicaciones',6,'Av. Central 100','Tiempo completo'),    
('CC3004','Elena Gómez','MSc. Ciencia de Datos',3,'Cll 50 # 5-60','Cátedra') ,  
('CC3005','Andrés Torres','Ing. Sistemas',2,'Cra 20 # 1-10','Tiempo completo'),
('CC3006','Natalia Vargas','Esp. Desarrollo Web',4,'Cll 70 # 4-80','Cátedra'),
('CC3007','Diego Herrera','MSc. Inteligencia Artificial',5,'Av. Norte 200','Tiempo completo');

INSERT INTO proyecto (nombre, descripcion, fecha_inicial, fecha_final, presupuesto, horas, docente_id_jefe)
VALUES ('App Biblioteca','App móvil de préstamos','2025-03-01',NULL, 9000000, 320,
        (SELECT docente_id FROM docente WHERE numero_documento='CC3002')),
       ('Sistema Inventarios','Gestión de inventarios','2025-04-01','2025-10-31',15000000,600,
        (SELECT docente_id FROM docente WHERE numero_documento='CC3003')),
       ('Red Segura','Implementación de red segura','2025-05-01',NULL,20000000,750,
        (SELECT docente_id FROM docente WHERE numero_documento='CC3004')),
       ('Portal Estudiantes','Portal web para estudiantes','2025-06-01','2025-12-31',18000000,500,
        (SELECT docente_id FROM docente WHERE numero_documento='CC3005')),
       ('E-commerce','Plataforma de comercio electrónico','2025-07-01',NULL,22000000,800,
        (SELECT docente_id FROM docente WHERE numero_documento='CC3006')),
       ('Análisis Datos','Proyecto de análisis de datos','2025-08-01','2026-02-28',16000000,450,
        (SELECT docente_id FROM docente WHERE numero_documento='CC3007'));

        SELECT * FROM proyecto;

        UPDATE docente
        SET direccion = 'Cll 100 # 10-10', anios_experiencia = 7
        WHERE numero_documento = 'CC3003';

        INSERT INTO docente (numero_documento, nombres, titulo, anios_experiencia, direccion, tipo_docente)
        VALUES 
        ('CC4005','Arturo Ramírez','Ing. de Datos',8,'Cra 12 # 53-40','Cátedra');

        SELECT * FROM docente;        