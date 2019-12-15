Create Trigger trg_deleted_users On Users FOR DELETE AS DECLARE @tc char(11),
@name VARCHAR(50),
@gender varchar(1),
@password varchar(50),
@birth_date date,
@phone char(10),
@user_height int,
@user_weight int,
@other_measurements varchar;

SELECT @tc = del.tc FROM DELETED del;
SELECT @name = del.name FROM DELETED del;
SELECT @gender = del.gender FROM DELETED del;
SELECT @password = del.password FROM DELETED del;
SELECT @birth_date = del.birth_date FROM DELETED del;
SELECT @phone = del.phone FROM DELETED del;
SELECT @user_height = del.user_height FROM DELETED del;
SELECT @user_weight = del.user_weight FROM DELETED del;
SELECT @other_measurements = del.other_measurements FROM DELETED del;

INSERT INTO DeletedUsers (tc, [password], gender, [name], birth_date, phone, user_height, user_weight) VALUES
(@tc, @password, @gender, @name, @birth_date, @phone, @user_height, @user_weight)

GO

Create Trigger trg_deleted_trainer On Trainers FOR DELETE AS DECLARE @tc char(11),
@name VARCHAR(50),
@password varchar(50),
@birth_date date,
@field varchar(40),

SELECT @tc = del.tc FROM DELETED del;
SELECT @name = del.name FROM DELETED del;
SELECT @password = del.password FROM DELETED del;
SELECT @birth_date = del.birth_date FROM DELETED del;
SELECT @field = del.phone FROM DELETED del;

INSERT INTO DeletedTrainers  VALUES (@tc, @name, @password, @birth_date, @field)
GO

CREATE Trigger trg_deleted_calendars On Calendars FOR DELETE AS DECLARE @id (1,1),
@user_tc char(11),
@trainer_tc char(11),
@weekday varchar(15),
@startTime time,
@finishTime time,

SELECT @id = del.id FROM DELETED del;
SELECT @user_tc = del.user_tc FROM DELETED del;
SELECT @trainer_tc = del.trainer_tc FROM DELETED del;
SELECT @weekday = del.weekday FROM DELETED del;
SELECT @startTime = del.startTime FROM DELETED del;
SELECT @finishTime = finishTime FROM DELETED del;

INSERT INTO DeletedCalendars  VALUES (@id, @user_tc, @trainer_tc, @startTime, @finishTime)
GO

CREATE Trigger trg_deleted_exercises On Exercises FOR DELETE AS DECLARE @id (1,1),
@name varchar(20),
@description varchar(150),
@set_size varchar(15),
@tool_id int,

SELECT @id = del.id FROM DELETED del;
SELECT @name = del.name FROM DELETED del;
SELECT @description = del.decription FROM DELETED del;
SELECT @set_size = del.set_size FROM DELETED del;
SELECT @tool_id = del.tool_id FROM DELETED del;

INSERT INTO DeletedExercises  VALUES (@id, @name, @description, @set_size, @tool_id)
GO

CREATE Trigger trg_deleted_tools On Tools FOR DELETE AS DECLARE @id (1,1),
@name] varchar(20) ,
@usage_time varchar(10),
@arrival_date date,

SELECT @id = del.id FROM DELETED del;
SELECT @name = del.name FROM DELETED del;
SELECT @description = del.decription FROM DELETED del;
SELECT @set_size = del.set_size FROM DELETED del;

INSERT INTO DeletedTools  VALUES (@id, @name, @description, @set_size,)
GO
