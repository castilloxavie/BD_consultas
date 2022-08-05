select *
from (
	select row_number () over () as filas_id, *
	from platzi.alumnos
)as alumnos_with_filas_alumnos
where filas_id in (1,5,10,12,14,20);

select *
from platzi.alumnos
where id in (
	select  id
	from platzi.alumnos
	where tutto_id = 30
);



select *
from platzi.alumnos
where id not in (
	select id 
	from platzi.alumnos
	where tutor_id =30
);

select *
from platzi.alumnos
where tutor_id != 30;

select extract (year from fecha_incorporacion) as ano_incorporacion
from platzi.alumnos;

select date_part('year', fecha_incorporacion) as ano_incorporacion
from platzi.alumnos;


select date_part('year',fecha_incorporacion)as ano_incorporacion,
	   date_part('month',fecha_incorporacion) as mes_incorporacion,
	   date_part('day',fecha_incorporacion) as dia_incorporacion
	   from platzi.alumnos;

SELECT *
FROM platzi.alumnos

select date_part('hour', fecha_incorporacion) as hora_incorporacion
from platzi.alumnos;

select date_part('hour',fecha_incorporacion)as hora_incorporacion,
	   date_part('minute',fecha_incorporacion) as minutos_incorporacion,
	   date_part('seconds',fecha_incorporacion) as segundos_incorporacion
	   from platzi.alumnos;

select *
from platzi.alumnos
where (extract (year from fecha_incorporacion)) = 2019;




select *
from (
	select *,
		date_part('year', fecha_incorporacion) as  ano_incorpracion
	from platzi.alumnos
)as  alumnos_ano
where ano_incorpracion =2019;

SELECT *
    FROM platzi.alumnos
    WHERE (EXTRACT(YEAR FROM fecha_incorporacion)) = 2019
        AND (EXTRACT(MONTH FROM fecha_incorporacion)) = 10;
		
		
insert into platzi.alumnos 
(id, nombre, apellido, email, colegiatura, fecha_incorporacion, carrera_id, tutor_id) 
values (1001, 'Pamelina', null, 'pmylchreestrr@salon.com', 4800, '2020-04-26 10:18:51', 12, 16);

select *
from platzi.alumnos as ou
where (
	select count(*)
	from platzi.alumnos as inr
	where ou.id =inr.id
)< 1;

select (
	platzi.alumnos.nombre,
	platzi.alumnos.apellido,
	platzi.alumnos.email,
	platzi.alumnos.colegiatura,
	platzi.alumnos.fecha_incorporacion,
	platzi.alumnos.carrera_id,
	platzi.alumnos.tutor_id)
	:: text, count (*)
from platzi.alumnos
group by platzi.alumnos.nombre,
		 platzi.alumnos.apellido,
		 platzi.alumnos.email,
		 platzi.alumnos.colegiatura,
		 platzi.alumnos.fecha_incorporacion,
		 platzi.alumnos.carrera_id,
		 platzi.alumnos.tutor_id
having count(*) >1;

select *
from (
	select row_number() over (
		partition by
			nombre,
			apellido,
			email,
			colegiatura,
			fecha_incorporacion,
			carrera_id,
			tutor_id
		order by id asc
	)as row,
	*
	from platzi.alumnos
) as duplicados
where duplicados.row >1;

		
		
		
		
		
		
		






delete from platzi.alumnos
where id in(
		select id
		from (
			select row_number() over (
				partition by
					nombre,
					apellido,
					email,
					colegiatura,
					fecha_incorporacion,
					carrera_id,
					tutor_id
				order by id asc
			)as row
			from platzi.alumnos
		) as duplicados
		where duplicados.row >1
	);
	
	
	
SELECT *
FROM platzi.alumnos
WHERE tutor_id IN (11,12,13,14,15,16,17,18,19,20);

select *
from platzi.alumnos
where tutor_id >=1
	and tutor_id <=10;
	
select * 
from platzi.alumnos;

select *
from platzi.alumnos
where tutor_id between 1 and 3;

select  int4range (10,20) @> 3;
select  int4range (1,20) @> 3;

select numrange (11.1, 22.1) && numrange (20.1, 23.8);

select upper(int8range(15, 30));
select lower(int8range(10, 15));

select int4range(10,20) * int4range(15,30);
select isempty(numrange(1,2));

select *
from platzi.alumnos
where int4range (10,20) @> tutor_id;

select tutor_id,
	min(nombre)
from platz.alumnos
group by tutor_id
order by tutor_id;

select a.nombre,
	   a.apellido,
	   t.nombre,
	   t.apellido
from platzi.alumnos as a
inner join platzi.alumnos as t on a.tutor_id = t.tutor_id;


select numrange(
	(select min(tutor_id)from platzi.alumnos),
	(select max(tutor_id)from platzi.alumnos)
) * numrange(
	(select min(carrera_id)from platzi.alumnos),
	(select max(carrera_id)from platzi.alumnos)
);


select  fecha_incorporacion
from platzi.alumnos
order by fecha_incorporacion desc
limit 1;