/*
 creacion de tablas con  caracteres para poder tomar las ñ 
*/
create database escuela character set utf8mb4 collate utf8mb4_spanish_ci;
use escuela;

create table alumnos(
id int  auto_increment primary key,
nombre varchar(100) not null,
grado smallint not null,
grupo varchar(2)not null,
fecha_ingreso date default '2022-07-27'
);

create table salon(
idSal int not null auto_increment primary key,
grado int not null,
grupo varchar(2)not null4
);

create table materia(
idMat int not null auto_increment primary key,
nombre varchar(50)
);

create table clase(
idCla int not null auto_increment primary key,
id int not null,
constraint fk_idalum foreign key (id) references alumno(id) on delete cascade on update cascade,
idMat int not null,
constraint fk_idmat foreign key (idMat) references materia(idMat) on delete cascade on update cascade,
hora time
);

INSERT INTO clase (id, idMat, hora) 
values('1', '1', '8:00'),
('1', '2', '9:00'),
('1', '3', '10:00'),
('1', '4', '11:00'),
('1', '5', '12:00'),
('2', '1', '8:00'),
('2', '2', '9:00'),
('2', '3', '10:00'),
('2', '4', '11:00'),
('2', '5', '12:00'),
('3', '1', '8:00'),
('3', '2', '9:00'),
('3', '3', '10:00'),
('3', '4', '11:00'),
('3', '5', '12:00');

# el tipo de dato numerico (smallint) es numero pequeño
# el (show table) sirve para q nos muestre las tabalsde bases de datos
# el (show columns) sive para q nos muestre las collumnas de las trablas
# el (show create table) sirve para mostrar el query de como fue creada la tabla
# el (rename table) renombrar la tabla
# el (alter table) sirve para modoicar la tabla
# el (add)sir ve par agregar campos en una tabla
# el (change)sirve para hacer cambios en el tipo de dato.
