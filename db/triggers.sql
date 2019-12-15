Create Trigger trg_deleted_users On gym.dbo.Users FOR DELETE AS DECLARE @tc char(11),
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

INSERT INTO gym.dbo.DeletedUsers (tc, [password], gender, [name], birth_date, phone, user_height, user_weight) VALUES
(@tc, @password, @gender, @name, @birth_date, @phone, @user_height, @user_weight)

GO

Create Trigger trg_deleted_trainer On gym.dbo.Trainers FOR DELETE AS DECLARE @tc char(11),
@name VARCHAR(50),
@password varchar(50),
@birth_date date,
@field varchar(40);

SELECT @tc = del.tc FROM DELETED del;
SELECT @name = del.name FROM DELETED del;
SELECT @password = del.password FROM DELETED del;
SELECT @birth_date = del.birth_date FROM DELETED del;
SELECT @field = del.field FROM DELETED del;

INSERT INTO gym.dbo.DeletedTrainers  VALUES (@tc, @name, @password, @birth_date, @field)
GO

CREATE Trigger trg_deleted_calendars On gym.dbo.Calendars FOR DELETE AS DECLARE @id int,
@user_tc char(11),
@trainer_tc char(11),
@weekday varchar(15),
@startTime time,
@finishTime time;

SELECT @id = del.id FROM DELETED del;
SELECT @user_tc = del.user_tc FROM DELETED del;
SELECT @trainer_tc = del.trainer_tc FROM DELETED del;
SELECT @weekday = del.weekday FROM DELETED del;
SELECT @startTime = del.startTime FROM DELETED del;
SELECT @finishTime = finishTime FROM DELETED del;

INSERT INTO gym.dbo.DeletedCalendars  VALUES (@id, @user_tc, @trainer_tc, @startTime, @finishTime)
GO

CREATE Trigger trg_deleted_exercises On gym.dbo.Exercises FOR DELETE AS DECLARE 
@name varchar(20),
@description varchar(150),
@set_size varchar(15),
@tool_id int;

SELECT @name = del.name FROM DELETED del;
SELECT @description = del.description FROM DELETED del;
SELECT @set_size = del.set_size FROM DELETED del;
SELECT @tool_id = del.tool_id FROM DELETED del;

INSERT INTO gym.dbo.DeletedExercises  VALUES (@name, @description, @set_size, @tool_id)
GO

CREATE Trigger trg_deleted_tools On gym.dbo.Tools FOR DELETE AS DECLARE
@name varchar(20),
@usage_time varchar(10),
@arrival_date date;

SELECT @name = del.name FROM DELETED del;
SELECT @usage_time = del.usage_time FROM DELETED del;
SELECT @arrival_date = del.arrival_date FROM DELETED del;

INSERT INTO gym.dbo.DeletedTools  VALUES (@name, @usage_time, @arrival_date)
GO
