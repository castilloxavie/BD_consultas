SELECT *
from platzi.alumnos
FETCH first 1 rows only;

select *
from (
	select row_number() over () as row_id, *
	from platzi.alumnos
	 )as alumnos_witch_row_number
	 where row_id =1
	 ;
	 
select *
from platzi.alumnos
FETCH first 5 rows only;

select *
from platzi.alumnos
LIMIT  5;

select *
from (
	select row_number() over() as filas_id, *
	from platzi.alumnos
)as alumno_witch_filas_id
where filas_id = 5
;
