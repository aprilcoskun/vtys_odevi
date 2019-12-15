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

Create Trigger trg_deleted_trainer On Users FOR DELETE AS DECLARE @tc char(11),
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