USE [master]
GO
/****** Object:  Database [Club]    Script Date: 30/09/2021 23:21:12 ******/
CREATE DATABASE [Club]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Club', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Club.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Club_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Club_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Club] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Club].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Club] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Club] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Club] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Club] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Club] SET ARITHABORT OFF 
GO
ALTER DATABASE [Club] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Club] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Club] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Club] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Club] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Club] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Club] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Club] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Club] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Club] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Club] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Club] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Club] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Club] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Club] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Club] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Club] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Club] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Club] SET  MULTI_USER 
GO
ALTER DATABASE [Club] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Club] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Club] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Club] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Club] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Club] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Club] SET QUERY_STORE = OFF
GO
USE [Club]
GO
/****** Object:  Table [dbo].[Actividades]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actividades](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[edadMin] [int] NOT NULL,
	[edadMax] [int] NOT NULL,
	[cupo] [int] NOT NULL,
 CONSTRAINT [PK_Actividades] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [nombreUnico] UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Funcionarios]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funcionarios](
	[email] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Funcionarios] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Horarios_Actividad]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Horarios_Actividad](
	[idActividad] [int] NOT NULL,
	[dia] [nvarchar](50) NOT NULL,
	[hora] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pagos]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pagos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cedulaSocio] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[descuentoPL] [int] NULL,
	[antiguedadPL] [int] NULL,
	[precioPL] [int] NULL,
	[descuentoC] [int] NULL,
	[cantActividadesC] [int] NULL,
	[precioActividadC] [decimal](18, 0) NULL,
 CONSTRAINT [pk_pagos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Socios]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Socios](
	[cedula] [int] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[fechaNac] [date] NOT NULL,
	[fechaIngreso] [date] NOT NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_Socios] PRIMARY KEY CLUSTERED 
(
	[cedula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Socios_Actividad]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Socios_Actividad](
	[idActividad] [int] NOT NULL,
	[cedulaSocio] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Horarios_Actividad]  WITH CHECK ADD  CONSTRAINT [FK_Horarios_Actividad] FOREIGN KEY([idActividad])
REFERENCES [dbo].[Actividades] ([id])
GO
ALTER TABLE [dbo].[Horarios_Actividad] CHECK CONSTRAINT [FK_Horarios_Actividad]
GO
ALTER TABLE [dbo].[Pagos]  WITH CHECK ADD  CONSTRAINT [FK_Socio_Pago] FOREIGN KEY([cedulaSocio])
REFERENCES [dbo].[Socios] ([cedula])
GO
ALTER TABLE [dbo].[Pagos] CHECK CONSTRAINT [FK_Socio_Pago]
GO
ALTER TABLE [dbo].[Socios_Actividad]  WITH CHECK ADD  CONSTRAINT [FK_Actividad] FOREIGN KEY([idActividad])
REFERENCES [dbo].[Actividades] ([id])
GO
ALTER TABLE [dbo].[Socios_Actividad] CHECK CONSTRAINT [FK_Actividad]
GO
ALTER TABLE [dbo].[Socios_Actividad]  WITH CHECK ADD  CONSTRAINT [FK_Socio] FOREIGN KEY([cedulaSocio])
REFERENCES [dbo].[Socios] ([cedula])
GO
ALTER TABLE [dbo].[Socios_Actividad] CHECK CONSTRAINT [FK_Socio]
GO
/****** Object:  StoredProcedure [dbo].[Alta_Actividad]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Alta_Actividad
-- =============================================
CREATE PROCEDURE [dbo].[Alta_Actividad] 
	@nombre nvarchar(50),
	@edadMin int,
	@edadMax int,
	@cupo int
AS
BEGIN
INSERT INTO Actividades
	(nombre, edadMin, edadMax, cupo)
	VALUES
	(@nombre, @edadMin, @edadMax, @cupo)
END
GO
/****** Object:  StoredProcedure [dbo].[Alta_Funcionario]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Alta_Funcionario
-- =============================================
CREATE PROCEDURE [dbo].[Alta_Funcionario]
	-- Add the parameters for the stored procedure here
	@email nvarchar(50),
	@password nvarchar(50)
AS
BEGIN
	INSERT INTO Funcionarios
		(email,password)
	VALUES
		(@email,@password)
END
GO
/****** Object:  StoredProcedure [dbo].[Alta_Horario]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Alta_Horario
-- =============================================
CREATE PROCEDURE [dbo].[Alta_Horario]
	-- Add the parameters for the stored procedure here
	@dia nvarchar(50),
	@hora int
AS
BEGIN
	INSERT INTO Horarios_Actividad
		(dia,hora)
	VALUES
		(@dia,@hora)
END
GO
/****** Object:  StoredProcedure [dbo].[Alta_Pago]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Alta_Pago
-- =============================================
CREATE PROCEDURE [dbo].[Alta_Pago]
	-- Add the parameters for the stored procedure here
	@cedulaSocio int,
	@fecha date,
	@descuentoPL int,
	@antiguedadPL int,
	@precioPL int,
	@descuentoC int,
	@cantActividadesC int,
	@precioActividadC decimal(18,0)
AS
BEGIN
	insert into Pagos
	(cedulaSocio,fecha,descuentoPL, antiguedadPL,precioPL,descuentoC,cantActividadesC,precioActividadC)
	values
	(@cedulaSocio,@fecha,@descuentoPL, @antiguedadPL,@precioPL,@descuentoC,@cantActividadesC,@precioActividadC)
END
GO
/****** Object:  StoredProcedure [dbo].[Alta_Socio]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Alta_Socio
-- =============================================
CREATE PROCEDURE [dbo].[Alta_Socio] 
	-- Add the parameters for the stored procedure here
	@cedula int,
	@nombre nvarchar(50),
	@fechaNac date,
	@fechaIngreso date,
	@activo bit
	
AS
BEGIN
	INSERT INTO Socios
	(cedula, nombre, fechaNac, fechaIngreso, activo)
	VALUES
	(@cedula, @nombre, @fechaNac, @fechaIngreso, @activo)

END
GO
/****** Object:  StoredProcedure [dbo].[Alta_Socio_Actividad]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Alta_Socio_Actividad
-- =============================================
CREATE PROCEDURE [dbo].[Alta_Socio_Actividad]
	-- Add the parameters for the stored procedure here
	@idActividad int,
	@cedulaSocio int
AS
BEGIN
	insert into Socios_Actividad
	(idActividad,cedulaSocio)
	values
	(@idActividad,@cedulaSocio)
END
GO
/****** Object:  StoredProcedure [dbo].[Buscar_Actividad_por_Nombre]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Buscar_Actividad_por_Nombre
-- =============================================
CREATE PROCEDURE [dbo].[Buscar_Actividad_por_Nombre]
	-- Add the parameters for the stored procedure here
	@nombre nvarchar(50)
AS
BEGIN
	SELECT 
	nombre,
	edadMin,
	edadMax,
	cupo
	FROM
	Actividades
	WHERE 
	nombre = @nombre
END
GO
/****** Object:  StoredProcedure [dbo].[Buscar_Pago_por_Cedula]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Buscar_Pago_por_Cedula
-- =============================================
CREATE PROCEDURE [dbo].[Buscar_Pago_por_Cedula]
	-- Add the parameters for the stored procedure here
	@cedulaSocio int
AS
BEGIN
	SELECT
	id,
	cedulaSocio,
	fecha,
	descuentoPL,
	antiguedadPL,
	precioPL,
	descuentoC,
	cantActividadesC,
	precioActividadC
	from
	Pagos
	where
	cedulaSocio=@cedulaSocio

END
GO
/****** Object:  StoredProcedure [dbo].[Buscar_Pago_por_ID]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Buscar_Pago_por_ID
-- =============================================
CREATE PROCEDURE [dbo].[Buscar_Pago_por_ID]
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	SELECT
	id,
	cedulaSocio,
	fecha,
	descuentoPL,
	antiguedadPL,
	precioPL,
	descuentoC,
	cantActividadesC,
	precioActividadC
	from
	Pagos
	where
	id=@id

END
GO
/****** Object:  StoredProcedure [dbo].[Buscar_por_Cedula]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Buscar_por_Cedula
-- =============================================
CREATE PROCEDURE [dbo].[Buscar_por_Cedula]
	-- Add the parameters for the stored procedure here
	@cedula int
AS
BEGIN
	SELECT 
	cedula,
	nombre,
	fechaNac,
	fechaIngreso,
	activo
	FROM
	SOCIOS
	WHERE 
	cedula = @cedula
END
GO
/****** Object:  StoredProcedure [dbo].[Listar_Actividades]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Listar_Actividades
-- =============================================
CREATE PROCEDURE [dbo].[Listar_Actividades]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	SELECT 
	nombre,
	edadMin,
	edadMax,
	cupo
	FROM
	Actividades
END
GO
/****** Object:  StoredProcedure [dbo].[Listar_Actividades_por_Socio]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Listar_Actividades_por_Socio
-- =============================================
CREATE PROCEDURE [dbo].[Listar_Actividades_por_Socio]
	@cedulaSocio int
AS
BEGIN
	select
	A.ID,
	A.nombre
	from
	Socios_Actividad SA,
	Actividades A
	WHERE
	A.ID=SA.idActividad AND
	cedulaSocio=@cedulaSocio
END
GO
/****** Object:  StoredProcedure [dbo].[Listar_Socios]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Listar_Socios
-- =============================================
CREATE PROCEDURE [dbo].[Listar_Socios]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	SELECT 
	cedula,
	nombre,
	fechaNac,
	fechaIngreso,
	activo
	FROM
	SOCIOS
	ORDER BY
	NOMBRE,
	CEDULA DESC

END
GO
/****** Object:  StoredProcedure [dbo].[Listar_Socios_por_Actividad]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Listar_Socios_por_Actividad
-- =============================================
CREATE PROCEDURE [dbo].[Listar_Socios_por_Actividad]
	@idActividad int
AS
BEGIN
	select
	A.nombre,
	s.nombre,
	S.cedula
	from
	Socios_Actividad SA,
	Socios S,
	Actividades A
	WHERE
	sa.cedulaSocio=s.cedula and
	A.ID=SA.idActividad AND
	idActividad=@idActividad
	order by
	s.nombre
END
GO
/****** Object:  StoredProcedure [dbo].[Modificar_Actividad_por_Nombre]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Modificar_Actividad_por_Nombre
-- =============================================
CREATE PROCEDURE [dbo].[Modificar_Actividad_por_Nombre]
	-- Add the parameters for the stored procedure here
	@nombre nvarchar(50),
	@edadMin int,
	@edadMax int,
	@cupo int
AS
BEGIN
UPDATE
		Actividades
	SET
		nombre = @nombre,
		edadMin = @edadMin,
		edadMax = @edadMax
	WHERE
		nombre = @nombre
END
GO
/****** Object:  StoredProcedure [dbo].[Modificar_Socio]    Script Date: 30/09/2021 23:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Modificar_Socio_buscandolo_por_cedula
-- =============================================
CREATE PROCEDURE [dbo].[Modificar_Socio]
	-- Add the parameters for the stored procedure here
	@cedula int,
	@nombre nvarchar(50),
	@fechaNac date,
	@activo bit
AS
BEGIN
	UPDATE
		Socios
	SET
		nombre = @nombre,
		fechaNac = @fechaNac,
		activo = @activo
	WHERE
		cedula = @cedula

END
GO
USE [master]
GO
ALTER DATABASE [Club] SET  READ_WRITE 
GO
