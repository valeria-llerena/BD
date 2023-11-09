CREATE TABLE Forma_de_registro(
    id INTEGER PRIMARY KEY ,
    nombre TEXT,
    descripcion TEXT
);


CREATE TABLE Departamento(
    id INTEGER PRIMARY KEY ,
    nombre TEXT
);


CREATE TABLE Provincia(
    id INTEGER PRIMARY KEY ,
    nombre TEXT,
    id_departamento INTEGER REFERENCES Departamento(id)
);

CREATE TABLE Distrito(
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    id_provincia INTEGER REFERENCES Provincia(id)
);


CREATE TABLE Vendedor(
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL ,
    apellido TEXT NOT NULL ,
    DNI TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    clave TEXT NOT NULL,
    claveRecuperacion TEXT NOT NULL
);


CREATE TABLE Cliente(
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL ,
    apellido TEXT NOT NULL ,
    DNI TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    clave TEXT NOT NULL,
    claveRecuperacion TEXT NOT NULL,
    id_distrito INTEGER REFERENCES Distrito(id),
    --------------------UPDATE-------------------
    fecha_de_edicion DATE,
    id_vendedor_editor INTEGER REFERENCES Vendedor(id),
    -------------------REGISTRO------------------
    fecha_de_registro DATE,
    id_forma_de_registro INTEGER REFERENCES Forma_de_registro(id),
    id_vendedor INTEGER REFERENCES Vendedor(id)
);





CREATE TABLE Inmueble(
    id INTEGER PRIMARY KEY,
    direccion TEXT NOT NULL UNIQUE,
    descripcion TEXT,
    precio_base REAL, 
    ubigeo TEXT,
    metros_cuadrados REAL
);



CREATE TABLE Operacion(
    id INTEGER PRIMARY KEY,
    id_cliente INTEGER INTEGER REFERENCES Cliente(id),
    id_vendedor INTEGER INTEGER REFERENCES Vendedor(id),
    id_inmueble INTEGER INTEGER REFERENCES Inmueble(id),
    fecha_apertura DATE,
    fecha_inicio_de_pago Date,
    fecha_fin_de_pago DATE,
    precio_negociado REAL,
    estado INT,
    saldo REAL
);




CREATE TABLE Visita(
    id INTEGER PRIMARY KEY,
    id_operacion  INTEGER INTEGER REFERENCES Operacion(id),
    observaciones TEXT,
    fecha DATE,
    estado INT -- programado=0 , terminado = 1 , cancelado=2
);



CREATE TABLE Adelanto(
    id INTEGER PRIMARY KEY,
    id_operacion  INTEGER INTEGER REFERENCES Operacion(id),
    observaciones TEXT,
    fecha DATE,
    monto REAL 
);

CREATE TABLE Telefono(
    id INTEGER PRIMARY KEY,
    numero TEXT UNIQUE
);

CREATE TABLE Telefono_Cliente(
    id INTEGER PRIMARY KEY,
    id_cliente  INTEGER INTEGER REFERENCES Cliente(id),
    id_telefono  INTEGER INTEGER REFERENCES Telefono(id)
);

CREATE TABLE Telefono_Vendedor(
    id INTEGER PRIMARY KEY,
    id_vendedor  INTEGER INTEGER REFERENCES Vendedor(id),
    id_telefono  INTEGER INTEGER REFERENCES Telefono(id)
);


--BITACORA--TODO:
CREATE TABLE Tipo_accion(
    id INTEGER PRIMARY KEY,
    descripcion TEXT 
);

CREATE TABLE Acciones(
    id INTEGER PRIMARY KEY,
    id_tipo INTEGER INTEGER REFERENCES Tipo_accion(id),
    id_vendedor INTEGER INTEGER REFERENCES Vendedor(id),
    detalle TEXT,
    fecha DATE
);
----------------------BITACORA POR TABLAS ------------------
CREATE TABLE Cliente_Updates(
    id INTEGER PRIMARY KEY,
    fecha date ,
    id_vendedor INTEGER ,
    ---------------------SANPSHOT-------------------
    snapshot_id INTEGER ,
    snapshot_nombre TEXT  ,
    snapshot_apellido TEXT  ,
    snapshot_DNI TEXT  ,
    snapshot_email TEXT  ,
    snapshot_clave TEXT ,
    snapshot_claveRecuperacion TEXT,
    snapshot_id_distrito INTEGER
);



-- Inserciones para la tabla Departamento
INSERT INTO Departamento (nombre) VALUES
('Lima'),
('Arequipa'),
('Cusco');

-- Inserciones para la tabla Provincia
INSERT INTO Provincia (nombre, id_departamento) VALUES
('Lima', 1),
('Arequipa', 2),
('Cusco', 3);

-- Inserciones para la tabla Distrito
INSERT INTO Distrito (nombre, id_provincia) VALUES
('Miraflores', 1),
('Cayma', 2),
('Cusco', 3);

-- Inserciones para la tabla Vendedor
INSERT INTO Vendedor (nombre, apellido, DNI, email, clave, claveRecuperacion) VALUES
('Vendedor1', 'Apellido1', 'V123456', 'vendedor1@email.com', 'clave1', 'recuperacion1'),
('Vendedor2', 'Apellido2', 'V987654', 'vendedor2@email.com', 'clave2', 'recuperacion2');

-- Inserciones para la tabla Cliente
INSERT INTO Cliente (nombre, apellido, DNI, email, clave, claveRecuperacion, id_distrito, fecha_de_registro, id_forma_de_registro, id_vendedor) VALUES
('Cliente1', 'Apellido1', 'C123456', 'cliente1@email.com', 'clave1', 'recuperacion1', 1, '2023-11-05', 1, 1),
('Cliente2', 'Apellido2', 'C987654', 'cliente2@email.com', 'clave2', 'recuperacion2', 2, '2023-11-05', 1, 2);

-- Inserciones para la tabla Telefono
INSERT INTO Telefono (numero) VALUES
('1234567890'),
('9876543210');

-- Inserciones para la tabla Telefono_Cliente (tabla intermedia)
INSERT INTO Telefono_Cliente (id_cliente, id_telefono) VALUES
(1, 1),  -- Cliente1 tiene el primer número de teléfono
(2, 2);  -- Cliente2 tiene el segundo número de teléfono

-- Inserciones para la tabla Telefono_Vendedor (tabla intermedia)
INSERT INTO Telefono_Vendedor (id_vendedor, id_telefono) VALUES
(1, 2),  -- Vendedor1 tiene el segundo número de teléfono
(2, 1);  -- Vendedor2 tiene el primer número de teléfono

-- Inserciones para la tabla Inmueble
INSERT INTO Inmueble (direccion, descripcion, precio_base, ubigeo, metros_cuadrados) VALUES
('Calle 123', 'Casa grande', 200000, 'Lima', 200),
('Avenida Principal', 'Departamento moderno', 150000, 'Arequipa', 100);
