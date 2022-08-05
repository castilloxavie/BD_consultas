select concat(a.nombre,' ',a.apellido) as tutor,
	   count(*) as alumnos_por_tutor
from platzi.alumnos a
inner join platzi.alumnos as t 
on a.id = t.id
group by tutor
order by alumnos_por_tutor desc
limit 10;


SELECT	fecha_incorporacion
FROM	platzi.alumnos
ORDER BY fecha_incorporacion DESC
LIMIT 1;

-- Intento por GROUP BY --
SELECT	carrera_id, fecha_incorporacion
FROM	platzi.alumnos
GROUP BY carrera_id, fecha_incorporacion
ORDER BY fecha_incorporacion DESC;

-- Funcion MAX --
SELECT	carrera_id, MAX(fecha_incorporacion)
FROM	platzi.alumnos
GROUP BY carrera_id
ORDER BY carrera_id;

select carrera_id, count(*)as cuenta
from platzi.alumnos
group by  carrera_id
order by cuenta desc;

delete from platzi.carreras
where  id between 30 and 40;

select  a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
from platzi.alumnos as a
left join platzi.carreras as c
	on  a.carrera_id = c.id
where c.id is null
order by a.carrera_id;

SELECT a.nombre, a.apellido, a.carrera_id,
	   c.id, c.carrera
FROM platzi.alumnos AS a
	FULL OUTER JOIN platzi.carreras AS c
	ON a.carrera_id = c.id;
	
--lesf join exclusivo--
select a.nombre, a.apellido, a.carrera_id
	   c.id, c.carrera
from platzi.alumnos as a
	left join platzi.carreras as c
	on a.carrera_id = c.id
where c.id is null;

--left join inclusivo---
select a.nombre, a.apellido, a.carrera_id
	   c.id, c.carrera
from platzi.alumnos as a
	left join platzi.carreras as c
	on a.carrera_id = c.id
order by c.id desc;

--right join inclusivo--
select a.nombre, a.apellido, a.carrera_id
	   c.id, c.carrera
from platzi.alumnos as a
	right join platzi.carreras as c
	on a.carrera_id = c.id
order by c.id desc;

--right join exclusivo--
select a.nombre, a.apellido, a.carrera_id
	   c.id, c.carrera
from platzi.alumnos as a
	right join platzi.carreras as c
	on a.carrera_id = c.id
where a.id is null
order by c.id desc;

--inner join inclusivo--
select a.nombre, a.apellido, a.carrera_id
	   c.id, c.carrera
from platzi.alumnos as a
	inner join platzi.carreras as c
	on a.carrera_id = c.id
order by c.id desc;

--diferencia o exclusivo--- 
select a.nombre, a.apellido, a.carrera_id
	   c.id, c.carrera
from platzi.alumnos as a
	full outer join platzi.carreras as c
	on a.carrera_id = c.id
where a.id is null 
	or c.id is null
order by a.carrera_id desc, c.id desc;


--triangulados--
select lpad('sql', 15, '*');

select lpad ('sql', id, '+')
from platzi.alumnos
where id <10;

select lpad ('*', id, '*'), carrera_id
from platzi.alumnos
where id <10
order by carrera_id;

--ACA HAY UNA WIDOWS FUNCTIONS--
select lpad('*', cast(fila_id, int),'*')
from (
	select row_number() over() order by carrera_id  as fila_id, *
	from platzi.alumnos
) as alumnos_with_fila_id
where fila_id <= 5;

select rpad('*', cast(fila_id, int),'+')
from (
	select row_number() over() order by carrera_id  as fila_id, *
	from platzi.alumnos
) as alumnos_with_fila_id
where fila_id <= 5;


--gerenado rangos--
select *
from generate_series(1,4);

select *
from generate_series(10,4,-2);

select *
from generate_series(1.1,4,1.3);

select current_date + s.a as dates
from generate_series(0,14,7) as s(a);

--- el :: es el mismo cast cambio---
select * 
from generate_series('2018-08-04 00:00:00'::timestamp, 
					'2021-10-10 10:30:00', '10 hours');
					
select a.id, a.nombre,
	   a.apellido, a.carrera_id
	   s.a
from platzi.alumnos as a
	inner join generate_series(0,10) as s(a)
	on s.a =a.carrera_id
order by a.carrera_id;

select lpad('+',cast(ordinality as int), '+')
from generate_series(10,2, -2) with ordinality;

SELECT  lpad('*', CAST(ordinality AS int), '*')
FROM    generate_series(1,10) WITH ordinality;

--REGULARIZANDO EXPRECIONES--

select email
from platzi.alumnos
where email ~* '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}';

select email
from platzi.alumnos
where email ~* '[A-Z0-9._%+-]+@google[A-Z0-9.-]+\.[A-Z]{2,4}';

--WINDOWA FUNCTIONS--

select *,
		avg(colegiatura) over (partition by carrera_id)
from platzi.alumnos;

select *
from(
		select *,
		rank () over (partition by carrera_id order by colegiatura desc) as brand_rank
		from platzi.alumnos
) as nranck_colegiatura_por_carreras
where brand_rank < 3
order by  brand_rank;

--windows functions particiones y agregacion--

select row_number() over () as fila_id, *
from platzi.alumnos;

select row_number() over (order by fecha_incorporacion) as fila_id, *
from platzi.alumnos;

select first_value(colegiatura)over(partition by carrera_id)as fila_id, *
from platzi.alumnos;

select nth_value(colegiatura, 3)over(partition by carrera_id)as fila_id, *
from platzi.alumnos;

select * ,
	rank() over(partition by carrera_id order by colegiatura desc)as colegiatura_rank
from platzi.alumnos
order by carrera_id, colegiatura_rank; 

select * ,
	dense_rank() over(partition by carrera_id order by colegiatura desc)as colegiatura_rank
from platzi.alumnos
order by carrera_id, colegiatura_rank; 

--(rank-1)/(total rows -1)
select * ,
	percent_rank() over(partition by carrera_id order by colegiatura desc)as colegiatura_rank
from platzi.alumnos
order by carrera_id, colegiatura_rank; 