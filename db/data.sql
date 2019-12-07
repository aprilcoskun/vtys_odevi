USE gym

INSERT dbo.Users (tc, password, gender, name, birth_date, phone, user_height, user_weight) VALUES
('10568474115', '234567', 'E', 'Kuzey Er', CAST('1998-06-18' AS Date), '5314256512', 185, 72),
('10568474135', '234567', 'E', 'Kuzey Eraslan', CAST('2000-06-18' AS Date), '5364256512', 185, 72),
('14326007543', '196743', 'K', 'Ebru Demirci', CAST('1996-03-11' AS Date), '5423040793', 155, 56),
('14576204631', '891234', 'E', 'Bugra Sayici', CAST('1993-08-14' AS Date), '5313647892', 173, 98),
('15178265631', '345678', 'K', 'Elisa Aras', CAST('2000-11-28' AS Date), '5368426551', 172, 50),
('17821975604', '369852', 'E', 'Burak Sagyasar', CAST('1983-02-28' AS Date), '5426368754', 183, 90),
('23246886534', '369852', 'E', 'Eray Aydin', CAST('1994-04-21' AS Date), '5978760312', 186, 103),
('25647892450', '456789', 'K', 'Erva Arikan', CAST('2000-08-14' AS Date), '5364579847', 168, 46),
('26432147910', '912345', 'K', 'Bergüzar Korel', CAST('1985-07-13' AS Date), '5367431468', 175, 85),
('26874132412', '567891', 'E', 'Anil Sayer', CAST('1999-02-14' AS Date), '5416975243', 157, 78),
('28678504301', '246357', 'E', 'Akin Akinözü', CAST('1994-10-02' AS Date), '5448763245', 186, 98),
('34248593174', '789123', 'K', 'Pelin Kara', CAST('1995-05-29' AS Date), '5349345674', 155, 80),
('36598641257', 'timeout', 'K', 'Ezgi Gürlek', CAST('1994-03-11' AS Date), '5979720382', 156, 73),
('37416891300', '741963', 'K', 'Beren Saat', CAST('1987-04-30' AS Date), '5364120307', 163, 68),
('45621496432', '678912', 'E', 'Basar Basaran', CAST('2000-04-23' AS Date), '5429856743', 183, 74);

INSERT dbo.Trainers (tc, name, birth_date, field) VALUES 
('11263859548', ' Kerem Güngör', CAST('1990-12-19' AS Date), 'vücut gelistirme'),
('12378619076', 'Basak Kiral', CAST('1986-03-24' AS Date), 'Kardiyo'),
('13425604378', 'Kerem Bürsin', CAST('1973-04-27' AS Date), 'Vücüt Gelistirme'),
('14963629746', ' Hülya Kamçi', CAST('1992-10-16' AS Date), 'zumba'),
('24563189756', ' Gülsah Günes', CAST('1988-11-10' AS Date), 'plates'),
('63259842158', ' Sedat Can ', CAST('1985-10-13' AS Date), 'step');

SET IDENTITY_INSERT dbo.Tools ON;
INSERT dbo.Tools (id, name, usage_time, arrival_date) VALUES
(1, 'kosu bandi', '30 dk', CAST('2019-11-15' AS Date)),
(2, 'Eliptik Bisiklet', '20 dk', CAST('2019-11-15' AS Date)),
(3, 'lat Pulldown', '15 dk', CAST('2019-11-15' AS Date)),
(4, 'pec deck fly', '15 dk', CAST('2019-11-15' AS Date)),
(5, 'cable crossover', '15 dk', CAST('2019-11-15' AS Date)),
(6, 'triceps pull down', '15 dk', CAST('2019-11-15' AS Date)),
(7, 'leg press', '10 dk', CAST('2019-11-15' AS Date)),
(8, 'leg curl', '10 dk', CAST('2019-11-15' AS Date)),
(9, 'dambil', '15 dk', CAST('2019-11-15' AS Date)),
(14, 'ip', '15 dk', CAST('2019-11-15' AS Date));

SET IDENTITY_INSERT dbo.Tools OFF;

SET IDENTITY_INSERT dbo.Exercises ON;

INSERT dbo.Exercises (id, name, description, set_size, tool_id) VALUES
(3, 'Squat', 'asdasdasd', '3-10', 9),
(4, 'Barbell Bench Press', 'asdasdasd', '3-15', 3),
(5, 'Lat Pulldown', 'asdasdasd', '3-12', 3),
(6, 'Gögüs Çalistirma', 'asdasdasd', '3-15', 4),
(7, 'Sirt Çalistirma', 'asdasdasd', '3-10', 5),
(9, 'Kol Kasi Çalistirma', 'asdasdasd', '3-15', 6),
(11, 'Bacak Kas Çalistirma', 'asdasd', '3-10', 7),
(12, 'Zumba', 'asdasdasd', '2-5', NULL),
(13, 'Pilates', 'asdasdasd', '4-5', NULL),
(14, 'Üst Bacak Kasi', 'asdasdasd', '3-12', 8);

SET IDENTITY_INSERT dbo.Exercises OFF;

GO;