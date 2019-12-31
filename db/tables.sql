USE gym;

/*Tablolar*/
CREATE TABLE UserActivity(
	id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	user_tc char(11) NULL,
	trainer_tc char(11) NULL,
	[timestamp] datetime NOT NULL,
	[type] varchar(50) NOT NULL,
);

CREATE TABLE Calendars(
	id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	trainer_tc char(11) NULL,
	weekday varchar(15) NOT NULL,
	startTime time NOT NULL,
	finishTime time NOT NULL
);

CREATE TABLE UserCalendar(
	id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	calendar_id int NOT NULL user_tc char(11) NOT NULL
);

CREATE TABLE DeletedUsers(
	tc char(11) PRIMARY KEY NOT NULL,
	[password] varchar(50) NOT NULL,
	gender varchar(1) NOT NULL,
	[name] varchar(50) NOT NULL,
	birth_date date NOT NULL,
	phone char(10) NOT NULL,
	user_height int,
	user_weight int,
	other_measurements varchar
);

CREATE TABLE Exercises(
	id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	[name] varchar(20) NOT NULL,
	[description] varchar(150) NOT NULL,
	set_size varchar(15) NOT NULL,
	tool_id int
);

CREATE TABLE Tools(
	id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	[name] varchar(20) NOT NULL,
	usage_time varchar(10) NOT NULL,
	arrival_date date
);

CREATE TABLE Trainers(
	tc char(11) PRIMARY KEY NOT NULL,
	[name] varchar(20) NOT NULL,
	[password] varchar(50) NOT NULL,
	birth_date date NOT NULL,
	field varchar(40) NOT NULL
);

CREATE TABLE Users(
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

CREATE TABLE DeletedTrainers(
	tc char(11) PRIMARY KEY NOT NULL,
	[name] varchar(20) NOT NULL,
	[password] varchar(50) NOT NULL,
	birth_date date NOT NULL,
	field varchar(40) NOT NULL,
);

CREATE TABLE DeletedCalendars(
	id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	user_tc char(11) NULL,
	trainer_tc char(11) NULL,
	weekday varchar(15) NOT NULL,
	startTime time NOT NULL,
	finishTime time NOT NULL
);

CREATE TABLE DeletedExercises(
	id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	[name] varchar(20) NOT NULL,
	[description] varchar(150) NOT NULL,
	set_size varchar(15) NOT NULL,
	tool_id int
);

CREATE TABLE DeletedTools(
	id int PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	[name] varchar(20) NOT NULL,
	usage_time varchar(10) NOT NULL,
	arrival_date date
);

/*CONSTRAINT ve FOREIGN KEY'ler*/
ALTER TABLE
	Tools
ADD
	CONSTRAINT ck_arrival_date DEFAULT (getdate()) FOR arrival_date
GO
ALTER TABLE
	Calendars WITH CHECK
ADD
	FOREIGN KEY(trainer_tc) REFERENCES Trainers (tc)
GO
ALTER TABLE
	Calendars WITH CHECK
ADD
	FOREIGN KEY(user_tc) REFERENCES Users (tc)
GO
ALTER TABLE
	Exercises WITH CHECK
ADD
	FOREIGN KEY(tool_id) REFERENCES Tools (id)
GO
ALTER TABLE
	Trainers WITH CHECK
ADD
	CONSTRAINT ck_trainer_birth_date CHECK ((birth_date < getdate()))
GO
ALTER TABLE
	Trainers CHECK CONSTRAINT ck_trainer_birth_date
GO
ALTER TABLE
	Trainers WITH CHECK
ADD
	CONSTRAINT ck_trainer_tc CHECK ((len(tc) =(11)))
GO
ALTER TABLE
	Trainers CHECK CONSTRAINT ck_trainer_tc
GO
ALTER TABLE
	Users WITH CHECK
ADD
	CONSTRAINT ck_birth_date CHECK ((birth_date < getdate()))
GO
ALTER TABLE
	Users CHECK CONSTRAINT ck_birth_date
GO
ALTER TABLE
	Users WITH CHECK
ADD
	CONSTRAINT ck_gender CHECK (
		(
			gender = 'K'
			OR gender = 'E'
		)
	)
GO
ALTER TABLE
	Users CHECK CONSTRAINT ck_gender
GO
ALTER TABLE
	Users WITH CHECK
ADD
	CONSTRAINT ck_phone CHECK (
		(
			phone like '[5][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
		)
	)
GO
ALTER TABLE
	Users CHECK CONSTRAINT ck_phone
GO
ALTER TABLE
	Users WITH CHECK
ADD
	CONSTRAINT ck_tc CHECK ((len(tc) =(11)))
GO
ALTER TABLE
	Users CHECK CONSTRAINT ck_tc
GO
ALTER TABLE
	Activity
ADD
	CONSTRAINT ck_timestamp DEFAULT GETDATE() FOR [timestamp]
GO