USE gym;

/*Tablolar*/
CREATE TABLE dbo.Calendars(
	id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	user_tc char(11) NULL,
	trainer_tc char(11) NULL,
	weekday varchar(15) NOT NULL,
	startTime time NOT NULL,
	finishTime time NOT NULL
);

CREATE TABLE dbo.DeletedUsers(
	tc PRIMARY KEY char(11) NOT NULL,
	password varchar(50) NOT NULL,
	gender varchar(1) NOT NULL,
	[name] varchar(50) NOT NULL,
	birth_date date NOT NULL,
	phone char(10) NOT NULL,
	user_height int,
	user_weight int,
	other_measurements varchar
);

CREATE TABLE dbo.Exercises(
	id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	[name] varchar(20) NOT NULL,
	[description] varchar(150) NOT NULL,
	set_size varchar(15) NOT NULL,
	tool_id int
);

CREATE TABLE dbo.Tools(
	id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	[name] varchar(20) NOT NULL,
	usage_time varchar(10) NOT NULL,
	arrival_date date
);

CREATE TABLE dbo.Trainers(
	tc char(11) PRIMARY KEY NOT NULL,
	[name] varchar(20) NOT NULL,
	birth_date date NOT NULL,
	field varchar(40) NOT NULL
);

CREATE TABLE dbo.Users(
	tc char(11) PRIMARY KEY NOT NULL,
	[password] varchar(50) NOT NULL,
	gender char(1),
	[name] varchar(50) NOT NULL,
	birth_date date NOT NULL,
	phone char(10) UNIQUE NOT NULL,
	user_height int,
	user_weight int,
	other_measurements varchar
);

CREATE TABLE dbo.DeletedTrainers(
	tc char(11) PRIMARY KEY NOT NULL,
	[name] varchar(20) NOT NULL,
	birth_date date NOT NULL,
	field varchar(40) NOY NULL,
);

/*CONSTRAINT ve FOREIGN KEY'ler*/
ALTER TABLE
	dbo.Tools
ADD
	CONSTRAINT ck_arrival_date DEFAULT (getdate()) FOR arrival_date
GO
ALTER TABLE
	dbo.Calendars WITH CHECK
ADD
	FOREIGN KEY(trainer_tc) REFERENCES dbo.Trainers (tc)
GO
ALTER TABLE
	dbo.Calendars WITH CHECK
ADD
	FOREIGN KEY(user_tc) REFERENCES dbo.Users (tc)
GO
ALTER TABLE
	dbo.Exercises WITH CHECK
ADD
	FOREIGN KEY(tool_id) REFERENCES dbo.Tools (id)
GO
ALTER TABLE
	dbo.Trainers WITH CHECK
ADD
	CONSTRAINT ck_trainer_birth_date CHECK ((birth_date < getdate()))
GO
ALTER TABLE
	dbo.Trainers CHECK CONSTRAINT ck_trainer_birth_date
GO
ALTER TABLE
	dbo.Trainers WITH CHECK
ADD
	CONSTRAINT ck_trainer_tc CHECK ((len(tc) =(11)))
GO
ALTER TABLE
	dbo.Trainers CHECK CONSTRAINT ck_trainer_tc
GO
ALTER TABLE
	dbo.Users WITH CHECK
ADD
	CONSTRAINT ck_birth_date CHECK ((birth_date < getdate()))
GO
ALTER TABLE
	dbo.Users CHECK CONSTRAINT ck_birth_date
GO
ALTER TABLE
	dbo.Users WITH CHECK
ADD
	CONSTRAINT ck_gender CHECK (
		(
			gender = 'K'
			OR gender = 'E'
		)
	)
GO
ALTER TABLE
	dbo.Users CHECK CONSTRAINT ck_gender
GO
ALTER TABLE
	dbo.Users WITH CHECK
ADD
	CONSTRAINT ck_phone CHECK (
		(
			phone like '[5][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
		)
	)
GO
ALTER TABLE
	dbo.Users CHECK CONSTRAINT ck_phone
GO
ALTER TABLE
	dbo.Users WITH CHECK
ADD
	CONSTRAINT ck_tc CHECK ((len(tc) =(11)))
GO
ALTER TABLE
	dbo.Users CHECK CONSTRAINT ck_tc
GO