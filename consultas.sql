#consultas sencillas  y agregar el AS q sirve para dar alias
select Desc_Producto as producto,Precio as valor
from db_ventas_ok.productos
where precio >=50.01;

#agrupciones con group by esto nos permite agrupar la informacion  en sepmentos mas pequeños
select ID_MARCA as marca, count(ID_MARCA)
from db_ventas_ok.productos
group by Desc_Producto;

#min el minimo y max el maximo
select min(Precio) as manimoPrecio, max(Precio)maximoPrecio from db_ventas_ok.productos where ID_Producto = 7;

# limit sirve para dar limites 
select * from db_ventas_ok.productos limit 22;

#order by sirve para ordenar asendente mente (asc) y desendentemente (desc)
select * from db_ventas_ok.productos order by Precio desc;

#consultas avanzadas
select * from db_ventas_ok.productos where (Precio=99.00 or Precio=132.22 or Precio=200.00) and ID_Producto = 10;

#cunsultas difrencia != y <>
select * from db_ventas_ok.productos where Precio !=200.00 and Precio!= 99.0  ;

#consultas is not sirve para llamar  campos nulos y el is not null es para traer todos los campos exxecto los nulos
select * from db_ventas_ok.productos where Precio is not null;
select * from db_ventas_ok.productos where Precio is  null;

#between sirve para dar rangos
select * from db_ventas_ok.productos where Precio between 90.00  and 200.00;

#IN sirve para evaluar una expresion  dentro de una lista
select * from db_ventas_ok.productos where ID_MARCA in ('MA00001', 'MA00002','MA00003');
select * from db_ventas_ok.marca_producto where DESC_MARCA;

select * from db_ventas_ok.productos where ID_MARCA in (select ID_MARCA from db_ventas_ok.marca_producto where DESC_MARCA
);
#consultas com operaciones matematicas
select * from db_ventas_ok.productos where Precio = 19.355 * 195.355;

#consustas like sirve para poder determinar si una cadena de caracteres especificos coinciden con un patron especidico
select * from db_ventas_ok.productos where Desc_Producto like 'papel%';










select * from db_ventas_ok.productos 

