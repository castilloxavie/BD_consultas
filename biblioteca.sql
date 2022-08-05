create database biblioteca;
use biblioteca;

create table Libro(
IdLibro int not null auto_increment primary key,
Titulo varchar(100) not null,
Editorial varchar(100),
Area varchar(30)
);


create table Autor(
IdAutor int not null auto_increment primary key,
Nombre varchar(30) not null,
Nacionalidad varchar(10)
);


create table LibAut(
IdAutor int not null,
constraint fk_idauto foreign key (IdAutor) references Autor(IdAutor),
IdLibro int not null,
constraint fk_idlibro foreign key(IdLibro) references Libro(IdLibro)
);


create table Estudiantes(
IdLector int not null auto_increment primary key,
CI varchar(20) not null,
Nombre varchar(100) not null,
Direccion varchar(60),
Carrera varchar(30),
Edad varchar (3)
);


create table Prestamo(
IdLector int not null,
constraint fk_idlector foreign key (IdLector) references Estudiantes (IdLector), 
IdLibro int not null,
constraint fkidlibro foreign key(IdLibro) references Libro(IdLibro),
FechaPrestamo date,
FechaDevolucion date,
devuelto boolean
);




insert into Libro(Titulo,Editorial,Area)
values('lagrimas de julieta','amarante','narrativa'),
('como entender el arte contemporaneo','amarante','dramatica'),
('una mentira de amor','casa del libro','romance'),
('visual studio net', 'casa software', 'internet'),
('el arte de programar', 'casa software', 'internet'),
('sql para novatos', 'casa software', 'sistemas');
select* from Libro;

insert into Autor(IdAutor, Nombre,Nacionalidad)
values('1', 'jose maria','mexico'),
('2', 'jose alarco','italia'),
('3', 'gabriel garcia','colombia'),
('4', 'trinidad','usa'),
('5', 'jose bermudes','francia');
select* from Autor;

insert into LibAut(IdAutor, IdLibro)
values('1','1'),
('2','2'),
('3','3'),
('4','4'),
('5','5'),
('2','6');
select* from LibAut;

insert into Estudiantes(IdLector,CI,Nombre,Direccion,Carrera,Edad)
values ('1','233452','marcela','cra 20 #12-12','cientifica',20),
('2','23344452','oscar','cra 22 #12-12','abogada',22),
('3','23344452','felipe loayza beramendi','cra 22 #12-12','abogada',22),
('4','23378452','stefani','cra 10 #12-13','ingeniero',22);
select * from Estudiantes;

insert into Prestamo(IdLector,IdLibro,FechaPrestamo,FechaDevolucion,devuelto)
values('1','1','2022-07-01','2022-07-05',True),
('2','2','2022-06-01','2022-06-01',False),
('3','6','2009-06-01','2010-04-07',True),
('4','3','2022-03-01','2022-06-01',False);
select *from Prestamo;

