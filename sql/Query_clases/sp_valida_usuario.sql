
use net_reservahoramedico;

go
drop table tbl_usuario;
go
create table tbl_usuario(
idusuario int not null,
usuario varchar(50),
clave varchar(50),
email varchar(50),
primary key(idusuario)
);

insert into tbl_usuario 
values(1, 'admin', convert(varchar(50), HashBytes('MD5', '12345'), 2), 'admin@centro.net');

-- select * from tbl_usuario;

go
drop procedure sp_valida_usuario;
go
create procedure sp_valida_usuario
@usuario varchar(50),
@clave varchar(50)
as
	select 
	idusuario, usuario, '*****' clave, email 
	from tbl_usuario
	where usuario = @usuario 
	and clave = convert(varchar(50), HashBytes('MD5', @clave), 2);
go

exec sp_valida_usuario 'admin', '12345';

