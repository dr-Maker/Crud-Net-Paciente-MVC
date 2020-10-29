use net_reservahoramedico;

---*** Tabla  ***---
drop table reserva;
drop table paciente;
drop table hora;
drop table medico;
drop table especialidad;
drop table estado;

create table estado(
idestado int identity(1,1),
descripcion varchar(50),
primary key(idestado)
);

create table especialidad(
idespecialidad int identity(1,1),
descripcion varchar(50),
primary key(idespecialidad)
);

create table medico(
idmedico int identity(1001,1),
nombres varchar(50),
apellidos varchar(50),
email varchar(50),
telefono int,
idespecialidad int,
primary key(idmedico),
foreign key(idespecialidad) references especialidad(idespecialidad)
);

create table paciente(
idpaciente int identity(2001,1),
nombres varchar(50),
apellidos varchar(50),
email varchar(50),
telefono int,
genero char(1),
edad int,
primary key(idpaciente)
);

create table hora(
idhora int identity(5001,1),
fecha date,
horaminuto time,
idmedico int,
idestado int,
primary key(idhora),
foreign key(idmedico) references medico(idmedico),
foreign key(idestado) references estado(idestado),
);

create table reserva(
idreserva int identity(6001,1),
idmedico int,
idpaciente int,
idhora int unique,
primary key(idreserva),
foreign key(idmedico) references medico(idmedico), 
foreign key(idpaciente) references paciente(idpaciente), 
foreign key(idhora) references hora(idhora), 
);



--*** SP Reserva ***--


go
drop procedure sp_listar_reserva01;
go
create procedure sp_listar_reserva01
as
	select idreserva, medico.idmedico ,medico.nombres as medico_nombre, medico.apellidos as medico_apellido, medico.email as medico_email, medico.telefono as medico_telefono, --medico
	especialidad.idespecialidad, especialidad.descripcion as especialidad,
	paciente.idpaciente, paciente.nombres as paciente_nombres, paciente.apellidos as paciente_apellidos, paciente.email as paciente_email, paciente.telefono as paciente_telefono, genero, edad,
	hora.idhora,fecha, horaminuto, hora.idestado, estado.descripcion as estado
	from  reserva
	inner join medico
	on reserva.idmedico = medico.idmedico
	inner join especialidad
	on medico.idespecialidad = especialidad.idespecialidad
	inner join paciente 
	on reserva.idpaciente = paciente.idpaciente
	inner join hora
	on reserva.idhora = hora.idhora
	inner join estado
	on hora.idestado = estado.idestado
go

go
drop procedure  sp_listar_reserva;
go
create procedure sp_listar_reserva
@idespecialidad INT,
@fecha DATE, 
@idmedico INT
as
	select idreserva, medico.idmedico ,medico.nombres as medico_nombre, medico.apellidos as medico_apellido, medico.email as medico_email, medico.telefono as medico_telefono, --medico
	especialidad.idespecialidad, especialidad.descripcion as especialidad,
	paciente.idpaciente, paciente.nombres as paciente_nombres, paciente.apellidos as paciente_apellidos, paciente.email as paciente_email, paciente.telefono as paciente_telefono, genero, edad,
	hora.idhora,fecha, horaminuto, hora.idestado, estado.descripcion as estado
	from  reserva
	inner join medico
	on reserva.idmedico = medico.idmedico
	inner join especialidad
	on medico.idespecialidad = especialidad.idespecialidad
	inner join paciente 
	on reserva.idpaciente = paciente.idpaciente
	inner join hora
	on reserva.idhora = hora.idhora
	inner join estado
	on hora.idestado = estado.idestado
	WHERE (medico.idespecialidad = @idespecialidad OR @idespecialidad= 0)
	AND (fecha = @fecha OR @fecha= '')
	AND (medico.idmedico = @idmedico or @idmedico=0)
go

go
drop procedure sp_buscar_reserva;
go
create procedure sp_buscar_reserva
@idreserva int
as
	select idreserva, medico.idmedico ,medico.nombres as medico_nombre, medico.apellidos as medico_apellido, medico.email as medico_email, medico.telefono as medico_telefono, --medico
	especialidad.idespecialidad, especialidad.descripcion as especialidad,
	paciente.idpaciente, paciente.nombres as paciente_nombres, paciente.apellidos as paciente_apellidos, paciente.email as paciente_email, paciente.telefono as paciente_telefono, genero, edad,
	hora.idhora,fecha, horaminuto, hora.idestado, estado.descripcion as estado
	from  reserva
	inner join medico
	on reserva.idmedico = medico.idmedico
	inner join especialidad
	on medico.idespecialidad = especialidad.idespecialidad
	inner join paciente 
	on reserva.idpaciente = paciente.idpaciente
	inner join hora
	on reserva.idhora = hora.idhora
	inner join estado
	on hora.idestado = estado.idestado
	WHERE idreserva = @idreserva
go

go
drop procedure sp_busqueda_medico_especialidad;
go
create procedure sp_busqueda_medico_especialidad
@idespecialidad INT
as
	SELECT * FROM medico 
	INNER JOIN especialidad
	ON medico.idespecialidad = especialidad.idespecialidad
	WHERE (medico.idespecialidad = @idespecialidad OR @idespecialidad= 0)
go

go
drop procedure sp_busqueda_medico_fecha;
go
create procedure sp_busqueda_medico_fecha
@idmedico INT,
@fecha DATE,
@idestado INT
as
	SELECT * FROM medico 
	INNER JOIN hora
	ON medico.idmedico = hora.idmedico
	WHERE
	medico.idmedico = @idmedico AND
	fecha = @fecha AND 
	idestado = @idestado
go

go
drop procedure sp_insert_reserva;
go
create procedure sp_insert_reserva
@idmedico INT,
@idpaciente INT,
@idhora INT
as
	INSERT INTO reserva(idmedico,idpaciente, idhora) 
	VALUES(@idmedico, @idpaciente,@idhora);
	UPDATE hora SET idestado = 2 WHERE idhora = @idhora
go


go
drop procedure sp_update_reserva;
go
create procedure sp_update_reserva
@idhoraestadoanterior INT,
@idreserva INT,
@idmedico INT,
@idpaciente INT,
@idhora INT
as

	UPDATE hora SET idestado = 1 WHERE idhora = @idhoraestadoanterior
	UPDATE reserva SET idmedico = @idmedico, idpaciente = @idpaciente, idhora= @idhora WHERE idreserva = @idreserva
	UPDATE hora SET idestado = 2 WHERE idhora = @idhora
go


go
drop procedure sp_eliminar_reserva;
go
create procedure sp_eliminar_reserva
@idreserva INT,
@idhora INT
as

	UPDATE hora SET idestado = 1 WHERE idhora = @idhora
	DELETE FROM reserva where idreserva = @idreserva;	
go



