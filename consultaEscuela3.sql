#mirar los q estan conectados en mysql

select * from mysql.user;

# creae usuario con permisos especificos
create user xaxa identified by '123';
create user xaxa@localhost identified by '123';
create user xaxa@192.168.1.120 identified by '123';

#borrar usuarioas
drop user xaxa@localhost;
drop user xaxa@192.168.1.120;

#otorgar permisos al usuario  ----pendiente------?
GRANT select on escuela.* to 'xaxa'@'localhost' with grant option;
