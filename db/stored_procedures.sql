Create Procedure sp_insert_users
@tc varchar(11),@password varchar(50),@gender varchar(1),@name varchar(50),@birth_date date,@phone varchar(10),@user_high int,@user_weigt int,@other_measurements varchar
As
IF(select count(*) From Trainers where tc= @tc)=0
Begin
Insert into Users 
Values(@tc,@password,@gender,@name,@birth_date,@phone,@user_hight,@user_weight,@other_measurements)
End
Begin
return 0
End
Go


Create Procedure sp_insert_trainers
@tc varchar(11),@name varchar(50),@birth_date date,@field varchar(40)
As
If(select count(*) From Users where tc= @tc)=0
begin
Insert into Trainers 
Values(tc,@name,@birth_date,@field)
End
Begin
return 0
End
Go
