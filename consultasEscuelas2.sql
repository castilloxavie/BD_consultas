use escuela;

/*consultas basicas*/

select * from alumno;
select nombre from alumno;

select idSal,nombre,fecha_ingreso from alumno 
where idSal=2 and nota >5;

# elm alias es para darle otro nombre a la columna de la tabla al realizar la consulta (as)
select idSal as salon,nombre,fecha_ingreso as fecha, nota as calificacio from alumno 
where idSal=2 and nota>5;

#agropacion (group by)
select idSal, count(id)as cantidad from alumno group by idSal;

#maximos y minimos (min() max())
select min(nota) as minimaNota, max(nota) as maximaNota from alumno where idSal=1;

#limitra la consulta (limit)
select * from alumno limit 5,2;

#ordenar de manera asendente y decendente
select * from alumno order by nota asc;
select * from alumno order by nota desc;





/*consultas avanzadas*/
select * from alumno;

#opreadores logocos (or and)
select * from alumno where (nota=5 or nota=8 or nota=9) and idSal=4;
select * from alumno where nota>=5 and nota<=9;

#diferente (!= , <>)
select * from alumno where nota !=10 and nota!=5;

# ver los campos nulos (is null) o nlo contrario (is not null)
select * from alumno where nota is null;
select * from alumno where nota is not null;

#ramgos o entre (between)
select * from alumno where nota between 7 and 9;
select * from alumno where fecha_ingreso between '2022-06-01' and '2022-07-11';

#evaluar si una exprexion esta dentro de una lista o para hacer una subconsulta (in)
select * from alumno where idSal in (2,3,4);
select * from salon where grado=2;

select * from alumno where idSal in (select idSal  from salon where grado=2);

#operaciones matematicas (+, -, *, /)
select * from alumno where nota=5+5;
select * from alumno where nota=5*2;
select * from alumno where nota=10/2;
select * from alumno where nota=5-2;

#caracteres comunes (like)
select * from alumno where nombre like 'x%';
select * from alumno where nombre like '%m%';
select * from alumno where nombre like '%a';
select * from alumno where nombre  not like 'x%';








/* 
consultas  con inner join,
 left join y
 right join
 */
 
 #inner join
 select a.nombre, a.fecha_ingreso, a.nota, s.grado,s.grupo
 from alumno as a
 inner join salon as s
 on a.idSal=s.idSal;
 
select a.nombre, a.fecha_ingreso, a.nota, s.grado,s.grupo
from alumno as a
left join salon as s
on a.idSal=s.idSal;

select a.nombre, a.fecha_ingreso, a.nota, s.grado,s.grupo
from alumno as a
right join salon as s
on a.idSal=s.idSal;

#consultas con tres tablas
select a.nombre as alumno,m.nombre as materia,c.hora
from clase as c
inner join alumno as a on c.id = a.id
inner join materia  as m on m.idMat = c.idMat
where c.hora between '8:00' and '10:00';





/*
crear  vistas NOTA tambien se puede alterar (alter)
Las vistas en MySQL (VIEWS) son tablas virtuales. Es decir, tablas que no guardan ningún 
dato propiamente dentro de ellas. Solo muestran los datos que están almacenados en otras tablas (que sí son reales).

Siendo así, crear vistas en MySQL significa mostrar información de una fuente de origen sin 
necesidad de mostrar ni exponer a la fuente en sí. En lenguaje técnico, las VIEWS no son más que SELECT Queries.

*/
drop view vista_alumnos_sin_salon ;

create view  vista_alumnos_salom as 
select id, nombre as alumno, nota as calificacion
from alumno
where idSal is not null;

select * 
from vista_alumnos_salom
where alumno like '%m%';


drop view vista_alunmos_en_materias;

alter view vista_alunmos_en_materias as
select count(m.idMat) as cantidad_alumnos,m.nombre as materia
from clase as c
inner join materia as m on c.idMat= m.idMat
inner join alumno as a on c.id=a.id
group by m.idMat;

select* from vista_alunmos_en_materias;




/*variables sql
Las variables nos permiten almacenar un valor y recuperarlo más adelante 
para emplearlos en otras sentencias. Las variables de usuario son específicas
de cada conexión y son liberadas automáticamente al abandonar la conexión.*/
set @nota_reprobada=5;
set @cantidad_reprobados=0;
set @nota_minima=6;
set @contidad_minina=0;
set @nota_exelente=10;
set @contidad_exelente=0;

select *
from alumno
where nota <=@nota_reprobada;

select *
from alumno
where nota >=@nota_minima;

select *
from alumno
where nota =@nota_exelente;

select count(*) into @cantidad_reprobados
from alumno
where nota <=@nota_reprobada;

select count(*) into @contidad_minina
from alumno
where nota >=@nota_reprobada;

select count(*) into @contidad_exelente
from alumno
where nota =@nota_reprobada;

select @cantidad_reprobados as reprobado,@contidad_minina as aprobado,@contidad_exelente as exelente;




/*
procesos almacenados
es una porcion de codigo q se puede guardar
y reutilizarlas veces q sea neecesario
es util para cuando se repite varias veces algun procedimiento
es un buen metodo para encapsular,
se puede colocar parametros tambien
*/

drop procedure alumnos_con_letras;
DELIMITER //

create  procedure alumnos_con_letras(in letra char, out numero int)
begin 
	select  count(*) as cantidad into numero
    from alumno
    where nombre like concat('%',letra,'%');
end //

DELIMITER ;

call alumnos_con_letras('o',@cantidad_o);
call alumnos_con_letras('x',@cantidad_x);
call alumnos_con_letras('n',@cantidad_n);
call alumnos_con_letras('p',@cantidad_p);

select @cantidad_o,@cantidad_x,@cantidad_n,@cantidad_p;





/*funciones
na función en MySQL es una rutina creada para tomar unos parámetros, procesarlos y retornar en un salida.

Diferencias que tienen las funciones sobre los procedimientos:
Solamente pueden tener parámetros de entrada IN y no parámetros de salida OUT.
Las funciones deben retornar en un valor con algún tipo de dato definido. Los procedimientos puede devolver uno o más valores a través de parámetros o puede que no devuelve ninguno.
Las funciones pueden usarse en el contexto de una sentencia SQL.
Solo retornan un valor individual, no un conjunto de registros.
*/

delimiter //

create function numero_letras (letra char) returns int
begin
	declare numero int;
    select count(*) into numero from alumno where nombre like concat('%',letra,'%');
    return numero;
end //
delimiter ;

# sentencia para desabilitar registros binarios para ejecutar funcion
SET GLOBAL log_bin_trust_function_creators = 1;

select numero_letras('o');
select left(nombre,1) from alumno;
select left(nombre,1) as letra,numero_letras(left(nombre,1)) as numero_alumnos_con_letra from alumno;




/* diferencias entre procedimientos y funciones=
la diferencia es q el procedimiento puede ingresar varios parametros y tambien traer los resultados mientras q la 
funcion solo resive parametros de entrada pero al hacer la ejecucion solo puedes traer un
parametro de los q hayas colocado en ella por parametros
debemos de tener encuenta q las funciones pueden llamarlas de sde un query y tambien llamarlas 
desde un procedimiento.
 */

drop procedure if exists operaciones_procedimiento;
delimiter //

create  procedure operaciones_procedimiento(in numero1 int, in numero2 int,out res_mult int, out res_suma int)
begin
	select numero1*numero2, numero1+numero2 into res_mult,res_suma;
end //

delimiter ;

set @res_milt=0;
set @res_suma=0;
call operaciones_procedimiento(3,3,@res_milt,@res_suma);
select @res_milt,@res_suma; 



delimiter //

create function operaciones_funciones( numero1 int,  numero2 int) returns int
begin
	set @res_mul=0;
	select numero1*numero2 into @res_mul;
	return @res_mul;
end //
delimiter ;

select operaciones_funciones(4,5);



/* tigger (disparadores)
Un disparador o trigger es una funcionalidad que la base de datos ejecuta de forma automática
cuando se realiza una operación de tipo Insert, Update o Delete en una tabla o vista, 
o cuando se ejecuta una consulta SQL sobre una tabla o vista.*/

create table acciones_alumnos(
idSal int,
nombre varchar(100),
fecha_ingreso datetime,
nota int,
proceso varchar(100),
fecha_proceso datetime
);

drop trigger acciones_alumnos;

CREATE TRIGGER acciones_alumnos AFTER INSERT ON alumno
FOR EACH ROW
INSERT INTO acciones_alumnos
VALUES ( NEW.idSal, NEW.nombre, NEW.fecha_ingreso, NEW.nota, 'INSERCION', NOW());

insert into alumno(idSal, nombre, fecha_ingreso,nota)
values(5,'pepa','2022-07-11',5),
(5,'diego','2022-07-11',6),
(1,'mary','2022-07-11',8);


/*administra privilegios de usuarios
Los privilegios de los usuarios son los permisos que el usuario tiene para actualizar, 
insertar,eliminar e incluso consultar los datos de la base de datos, además se contemplan 
permisos de administrar bases de datos y tablas.
Hasta ahora hemos usuario el usuario root (el permiso más alto) 
para gestionar nuestras bases de datos y tablas en MySQL pero es recomendado
 crear usuarios que tengan de preferencia permisos limitados para evitar comprometer la información de nuestro servidor.
*/
