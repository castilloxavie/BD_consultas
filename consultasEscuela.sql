use  escuela;

show tables;
show columns from alumnos;
show create  table alumnos;

rename table alumnos to alumno;

# alter add, change, drop sirve para agregar cambiar o borrar columnas de un tabla
alter table alumno add edades int not null;
alter table alumno change  edades edad  smallint not null;
alter table alumno drop column edad;
alter table alumno add nota int not null;

# eliminra columnas
alter table alumno drop column grado;
alter table alumno drop column grupo;
alter table alumno drop column idSal;

#agregar una llave
alter table alumno add column idSal int not null after id;

#agregar la relacion o referencia
alter table alumno add constraint fk_idsalon foreign key (idSal) references salon(idSal)on delete cascade on update cascade;

#insertar
insert into salon (grupo,grado)
values ('A',1),
('B',1),
('C',1);

insert into salon (grupo,grado)
values ('A',2),
('B',2),
('C',2);


insert into alumno(idSal,nombre, fecha_ingreso)
values(1,'xavier','2022-07-01'),
(2,'alberto','2022-07-01'),
(3,'emelina','2022-07-01'),
(4,'yuliana','2022-07-01'),
(2,'angie','2022-07-01'),
(6,'norma','2022-07-01');


#borrara llave foranea
alter table alumno drop constraint fk_idsalon;

# colsultar 
select * from salon;
select * from alumno;

#borrar registros 
truncate table salon;
truncate table alumno;

#desavilitar el chequeo de las llaves foraneas
set foreign_key_checks=0;

#habilitar el chequeo de las llaves foraneas
set foreign_key_checks=1;

#actualizar registros
update alumno set nombre='hernan xavier' where id=1;
update alumno set nombre='xavier',fecha_ingreso='2022-06-1' where id=1;
update alumno set nota=nota+3 where id=1;
update alumno set nota=replace(nota,0,5);

#eliminar registros
delete from alumno where id=7;



