select distinct colegiatura
from platzi.alumnos as a1
where  2 = (
	select count (distinct colegiatura)
	from platzi.alumnos  a2
	where a1.colegiatura <= a2.colegiatura
);

select distinct colegiatura, tutor_id
from platzi.alumnos
where tutor_id =20
order by colegiatura desc
limit 1 offset 1;

select *
from
platzi.alumnos as datos_alumnos
inner join (
	select distinct colegiatura
	from platzi.alumnos
	where tutor_id =20
	order by  colegiatura desc
	limit 1 offset 1
)as segunda_mayor_colegiatura
on datos_alumnos.colegiatura = segunda_mayor_colegiatura.colegiatura;

select *
from platzi.alumnos as datos_alumnos
where colegiatura = (
	select distinct colegiatura
	from platzi.alumnos
	where tutor_id =20
	order by  colegiatura desc
	limit 1 offset 1
);



select row_number () over () as fila_id, *
from platzi.alumnos
offset (
	select count(*)/2
	from platzi.alumnos
);

