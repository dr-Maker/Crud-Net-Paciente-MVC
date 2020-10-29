
use net_reservahoramedico;

-- tabla hora
go
drop procedure sp_listar_hora;
go
create procedure sp_listar_hora
@idestado int
as
	select 
	h.idhora, h.fecha, h.horaminuto,
	me.*, esp.descripcion as nom_especialidad,
	e.idestado, e.descripcion as nom_estado
	from hora         h 
	join medico       me   on h.idmedico = me.idmedico
	join especialidad esp  on me.idespecialidad = esp.idespecialidad
	join estado       e    on h.idestado = e.idestado
	where (h.idestado = @idestado or @idestado = 0);
go

go
drop procedure sp_buscar_hora;
go
create procedure sp_buscar_hora
@idhora int
as
	select 
	h.idhora, h.fecha, h.horaminuto,
	me.*, esp.descripcion as nom_especialidad,
	e.idestado, e.descripcion as nom_estado
	from hora         h 
	join medico       me   on h.idmedico = me.idmedico
	join especialidad esp  on me.idespecialidad = esp.idespecialidad
	join estado       e    on h.idestado = e.idestado
	where h.idhora = @idhora;
go

go
drop procedure sp_insert_hora;
go
create procedure sp_insert_hora
@fecha date,
@horaminuto time,
@idmedico int,
@idestado int
as
	insert into hora (fecha, horaminuto, idmedico, idestado)
	values (@fecha, @horaminuto, @idmedico, @idestado);
go

go
drop procedure sp_update_hora;
go
create procedure sp_update_hora
@idhora int,
@fecha date,
@horaminuto time,
@idmedico int,
@idestado int
as
	update hora set 
	fecha = @fecha, 
	horaminuto = @horaminuto, 
	idmedico = @idmedico, 
	idestado = @idestado	
	where idhora = @idhora;
go

go
drop procedure sp_delete_hora;
go
create procedure sp_delete_hora
@idhora int
as
	delete from hora
	where idhora = @idhora;
go

-- tabla paciente
go
drop procedure sp_listar_paciente;
go
create procedure sp_listar_paciente
as
	select * from paciente;
go

go
drop procedure sp_buscar_paciente;
go
create procedure sp_buscar_paciente
@idpaciente int
as
	select * from paciente
	where idpaciente = @idpaciente;
go

go
drop procedure sp_insert_paciente;
go
create procedure sp_insert_paciente
@nombres varchar(50), 
@apellidos varchar(50), 
@email varchar(50), 
@telefono int, 
@genero char(1),
@edad int
as
	insert into paciente (nombres, apellidos, email, telefono, genero, edad)
	values(@nombres, @apellidos, @email, @telefono, @genero, @edad);
go

go
drop procedure sp_update_paciente;
go
create procedure sp_update_paciente
@idpaciente int,
@nombres varchar(50), 
@apellidos varchar(50), 
@email varchar(50), 
@telefono int, 
@genero char(1),
@edad int
as
	update paciente set 
	nombres = @nombres, 
	apellidos = @apellidos, 
	email = @email, 
	telefono = @telefono, 
	genero = @genero, 
	edad = @edad 
	where idpaciente = @idpaciente;
go

select * from paciente
sp_update_paciente  2006,'juan','pesadi','juan@correo.cl',451,'M',31




go
drop procedure sp_delete_paciente;
go
create procedure sp_delete_paciente
@idpaciente int
as
	delete from paciente
	where idpaciente = @idpaciente;
go

-- tabla medico
go
drop procedure sp_listar_medico;
go
create procedure sp_listar_medico
as
	select 
	me.*, esp.descripcion nom_especialidad
	from medico me
	join especialidad esp on me.idespecialidad = esp.idespecialidad;
go

go
drop procedure sp_buscar_medico;
go
create procedure sp_buscar_medico
@idmedico int
as
	select 
	me.*, esp.descripcion nom_especialidad
	from medico me
	join especialidad esp on me.idespecialidad = esp.idespecialidad
	where me.idmedico = @idmedico;
go

go
drop procedure sp_insert_medico;
go
create procedure sp_insert_medico
@nombres varchar(50), 
@apellidos varchar(50), 
@email varchar(50), 
@telefono int, 
@idespecialidad int
as
	insert into medico (nombres, apellidos, email, telefono, idespecialidad)
	values(@nombres, @apellidos, @email, @telefono, @idespecialidad);
go

go
drop procedure sp_update_medico;
go
create procedure sp_update_medico
@idmedico int,
@nombres varchar(50), 
@apellidos varchar(50), 
@email varchar(50), 
@telefono int, 
@idespecialidad int
as
	update medico set 
	nombres = @nombres, 
	apellidos = @apellidos, 
	email = @email, 
	telefono = @telefono, 
	idespecialidad = @idespecialidad 
	where idmedico = @idmedico;
go

go
drop procedure sp_delete_medico;
go
create procedure sp_delete_medico
@idmedico int
as
	delete from medico
	where idmedico = @idmedico;
go

-- tabla estado
go
drop procedure sp_listar_estado;
go
create procedure sp_listar_estado
as
	select * from estado;
go

go
drop procedure sp_buscar_estado;
go
create procedure sp_buscar_estado
@idestado int
as
	select * from estado
	where idestado = @idestado;
go

-- tabla especialidad
go
drop procedure sp_listar_especialidad;
go
create procedure sp_listar_especialidad
as
	select * from especialidad;
go

go
drop procedure sp_buscar_especialidad;
go
create procedure sp_buscar_especialidad
@idespecialidad int
as
	delete from especialidad
	where idespecialidad = @idespecialidad;
go

select * from estado