

#---1---
select count(*)as cantidad_libros,a.IdAutor, a.Nombre, a.Nacionalidad from  Autor as a
inner join  LibAut as la on la.IdAutor = a.IdAutor
group by la.IdAutor having count(la.IdAutor)>1;


#---2---
select Nombre, Edad from Estudiantes; 

#---3---
select Nombre, Carrera from Estudiantes
where Carrera = 'informatica';

#---4----
select Nombre from Estudiantes
where apellido  like 'G%';

#---5---
select a.Nombre 
from  Autor as a
where IdAutor in (
	select IdAutor from LibAut where IdLibro in
	(select IdLibro from Libro where Titulo = 'visual studio net')
);


#----6----
select * from Autor
where Nacionalidad = 'USA' OR Nacionalidad='FRANCIA';

#---7-------
select * from Libro 
where Area != 'internet';

#---8------
select Titulo from Libro
inner  join Prestamo on Prestamo.IdLibro=Libro.IdLibro
inner join Estudiantes on Estudiantes.IdLector=Prestamo.IdLector
where Estudiantes.Nombre='felipe loayza beramendi';

#---9------
select Nombre from Estudiantes
where Edad = (select MIN(Edad) as menor_edad from Estudiantes);


#----10---
select Nombre from Estudiantes
inner join Prestamo on Estudiantes.IdLector=Prestamo.IdLector
inner  join Libro on Prestamo.IdLibro=Libro.IdLibro
where Libro.Titulo='base de datos';

#----11-----
select * from Libro
where Editorial = 'Alfa y Omega';

#---12----
select * from Libro
where IdLibro in
(
	select IdLIbro from LibAut where IdAutor in
		(select IdAutor
        from Autor
        where Nombre = 'Mario Benedetti')
);

#---13---
select * from Libro
where IdLibro in
(
	select IdLibro from Prestamo where FechaDevolucion = '10/04/07'
    		
);

#----14----
select sum(Edad) as sumaEdades from Estudiantes;

#--15---
select * from Estudiantes
where Edad > (select avg(Edad)from Estudiantes);

#---16---
DELIMITER //

CREATE PROCEDURE libro_autor(autor VARCHAR(50))
BEGIN
	select l.Titulo, l.Editorial, l.Area from  Libro as l
	inner join  LibAut as la on la.IdLibro = l.IdLibro
	inner join Autor as a on a.IdAutor = la.IdAutor
	where a.Nombre = autor;
END //

DELIMITER ;

#ejecutar el procedimiento
CALL libro_autor('gabriel garcia');

#---17-----
DELIMITER //

CREATE PROCEDURE insert_estudiantes(ci varchar(20),nombre varchar(100),direccion varchar(60),carrera varchar(30),edad varchar (3))
BEGIN
	insert into Estudiantes(CI,Nombre,Direccion,Carrera,Edad) values(ci,nombre,direccion,carrera,edad);
END //

DELIMITER ;
CALL insert_estudiantes('122','pabl','cra0','medicoS','52');

#---18------
DELIMITER //

CREATE PROCEDURE update_libro(id_libro int,titulo varchar(100),editorial varchar(100),area varchar(30))
BEGIN
	update Libro set Titulo=titulo, Editorial=editorial, Area=area where IdLibro=id_libro;
END //

DELIMITER ;
CALL update_libro(1,'lagrimas de sol','editorial colombia','dramatica');

#---19---
create table audEstudiantes(
IdLector int ,
CI varchar(20),
Nombre varchar(100),
Direccion varchar(60),
Carrera varchar(30),
Edad varchar (3),
proceso varchar (100),
fecha_proceso datetime
);

CREATE TRIGGER tr_insert_estudiante AFTER INSERT ON Estudiantes
FOR EACH ROW
INSERT INTO audEstudiantes
VALUES ( NEW.IdLector, NEW.CI, NEW.Nombre, NEW.Direccion, NEW.Carrera,NEW.Edad, 'INSERCION', NOW());

#----20------
DELIMITER //

CREATE FUNCTION lista_prestamos(nombre varchar(100))
returns varchar(100)
BEGIN
	RETURN (select Titulo from Libro
			inner  join Prestamo on Prestamo.IdLibro=Libro.IdLibro
			inner join Estudiantes on Estudiantes.IdLector=Prestamo.IdLector
			where Estudiantes.Nombre=nombre); 
END //

DELIMITER ;

select lista_prestamos('felipe loayza beramendi');

/*
las condiciones para la creación de una función por defecto viene en 0 
global log_bin_trust_function_creators se debe cambiar a 1. se debe ejecutar 
para poder cambiarlo a 1 y poder crear funciones.
*/
SET GLOBAL log_bin_trust_function_creators = 1;

