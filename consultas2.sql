create database db_ventas_ok;
use db_ventas_ok;


select p.ID_producto, p.Desc_Producto, p.ID_MARCA, p.ID_TIPO_PRODUCTO, p.Precio 
from db_ventas_ok.productos  as p
inner join marca_producto as m
on p.ID_MARCA=m.ID_MARCA;

select p.ID_producto, p.Desc_Producto, p.ID_MARCA, p.ID_TIPO_PRODUCTO, p.Precio 
from db_ventas_ok.productos  as p
left join marca_producto as m
on p.ID_MARCA=m.ID_MARCA;

select p.ID_producto, p.Desc_Producto, p.ID_MARCA, p.ID_TIPO_PRODUCTO, p.Precio 
from db_ventas_ok.productos  as p
right join marca_producto as m
on p.ID_MARCA=m.ID_MARCA;

#consultas con multiples tablas
select p.ID_Producto, p.Desc_Producto, p.ID_MARCA, p.ID_TIPO_PRODUCTO, p.Precio
from db_ventas_ok.productos as p
inner join marca_producto as m on p.ID_MARCA= m.ID_MARCA
inner join tipo_producto as tp on p.ID_TIPO_PRODUCTO=tp.ID_TIPO_PRODUCTO
where p.Desc_Producto;




#crear vistas

create view vista_productos as
select ID_Producto, Desc_Producto as respuesta
from productos
where ID_Producto is null;

#drop sirve para eliminar
drop view vista_productos;
drop view vista_general;

#llamar una vista
select *
from vista_productos
where respuesta like '%j%';

create view vista_general as
select p.ID_Producto, p.Desc_Producto, p.ID_MARCA, p.ID_TIPO_PRODUCTO, p.Precio
from db_ventas_ok.productos as p
inner join marca_producto as m on p.ID_MARCA= m.ID_MARCA
inner join tipo_producto as tp on p.ID_TIPO_PRODUCTO=tp.ID_TIPO_PRODUCTO
order by m.ID_MARCA desc;

SELECT * FROM vista_general;
