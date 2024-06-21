-----done----- without FK
create table [User](
UserId int PRIMARY KEY IDENTITY(1 , 1),
Name NVARCHAR(50),
Password NVARCHAR(50),
userType NVARCHAR(50)
)
-- without FK -----done---
create table Course(
Crs_Id int PRIMARY KEY IDENTITY(1 , 1),
Name NVARCHAR(50),   --crs_Name
description NVARCHAR(50),
MaxDegree int,
MinDegree int,
)
alter table Course
add Degree int

-- Rename the column 'Name' to 'Crs_Name'
exec sp_rename 'Course.Name', 'Crs_Name', 'COLUMN';
-----done---
create table Instructor(
Ins_Id int PRIMARY KEY IDENTITY(1 , 1),
Name NVARCHAR(50),     --ins_Name
Course_Id int,
constraint course_id FOREIGN KEY(Course_Id) REFERENCES Course(Crs_Id),
user_id int,
constraint us_id FOREIGN KEY(user_id) REFERENCES [User](UserId)
)
-- Rename the column 'Name' to 'Ins_Name'
exec sp_rename 'Instructor.Name', 'Ins_Name', 'COLUMN';
---------------------------done--------------------------------------------------------------------------
create table Question(
Ques_Id int PRIMARY KEY IDENTITY(1 , 1),
ques_type NVARCHAR(50),
correctAnswer NVARCHAR(50),
QuesText NVARCHAR(50),
exam_Id int
--constraint ex_id FOREIGN KEY(exam_Id) REFERENCES Exam(Ex_Id),
)
ALTER TABLE Question
ADD constraint ex_id FOREIGN KEY(exam_Id) REFERENCES Exam(Ex_Id)
ALTER TABLE Question
ADD  Degree INT 
--------------------- done----
create table Student(
St_Id int  PRIMARY KEY IDENTITY(1 ,1),
St_Name NVARCHAR(50),
userId int,
constraint use_id FOREIGN KEY(userId) REFERENCES [User](UserId),
track_id int,
constraint tra_id FOREIGN KEY(track_id) REFERENCES Track(Tr_Id),
mang_id int,
constraint ma_id FOREIGN KEY(mang_id) REFERENCES TrainingManger(Ma_Id)
)
ALTER TABLE Student
ADD branch_Id int,
constraint bran_id FOREIGN KEY(branch_Id) REFERENCES Branch(Br_Id)
--intake

-----done-------------------
create table Track(
Tr_Id int PRIMARY KEY IDENTITY(1 , 1),
Tr_Name NVARCHAR(50),
user_Id int,
constraint usid FOREIGN KEY(user_Id) REFERENCES [User](UserId),
dept_id int,
constraint department_id FOREIGN KEY(dept_id) REFERENCES Department(Dept_Id)
)

-------done--- without FK
create table Department(
Dept_Id int PRIMARY KEY IDENTITY(1 , 1),
Name NVARCHAR(50),
)
-----done---
create table Branch(
Br_Id int PRIMARY KEY IDENTITY(1 , 1),
Br_Name NVARCHAR(50),
dep_id int,
constraint depart_id FOREIGN KEY(dep_id) REFERENCES Department(Dept_Id)
)
-----done---
create table Intake(
In_Id int PRIMARY KEY IDENTITY(1 , 1),
manger_id int,
constraint mang_id FOREIGN KEY(manger_id) REFERENCES TrainingManger(Ma_Id)
)
-----done---
create table TrainingManger(
Ma_Id int PRIMARY KEY IDENTITY(1 , 1),
Name NVARCHAR(50),
User_id int,
constraint userid FOREIGN KEY(user_id) REFERENCES [User](UserId)
)

-----done---
create table Exam(
Ex_Id int PRIMARY KEY IDENTITY(1 , 1),
ex_type NVARCHAR(50),
allowance NVARCHAR(50),
startTime datetime,
endTime datetime,
TotalTime int,
ins_id int,
constraint inst_id FOREIGN KEY(ins_id) REFERENCES Instructor(Ins_Id),
branch_id int,
constraint br_id FOREIGN KEY(branch_id) REFERENCES Branch(Br_Id),
track_Id int,
constraint trak_id FOREIGN KEY(track_Id) REFERENCES Track(Tr_Id),
student_id int,
constraint stu_id FOREIGN KEY(student_id) REFERENCES Student(St_Id),
intake_id int ,
constraint take_id FOREIGN KEY(intake_id) REFERENCES Intake(In_Id),
cours_id int,
constraint cour_id FOREIGN KEY(cours_id) REFERENCES Course(Crs_Id),
)
ALTER TABLE Exam     
ADD question_id INT;

GO
ALTER TABLE Exam
ADD CONSTRAINT Question_Exam_FK FOREIGN KEY(question_id) REFERENCES Question(Ques_Id);

GO
-----done---
create table Student_Exam(
StEx_Id int PRIMARY KEY IDENTITY(1 , 1),
ExamDate datetime,
Score int,
exam_id int,
constraint exm_id FOREIGN KEY(exam_id) REFERENCES Exam(Ex_Id),
stud_id int,
constraint stud_id FOREIGN KEY(stud_id) REFERENCES Student(St_Id),
)

create table Student_Answer(
StAns_Id int PRIMARY KEY IDENTITY(1 , 1),
StudentAnswer NVARCHAR(50),
question_id int,
constraint ques_id FOREIGN KEY(question_id) REFERENCES Question(Ques_Id),
studt_id int,
constraint stude_id FOREIGN KEY(studt_id) REFERENCES Student(St_Id),
studentexam_id int,
constraint stex_id FOREIGN KEY(studentexam_id) REFERENCES Student_Exam(StEx_Id),
)
--omar
CREATE TABLE Results(
Re_Id int PRIMARY KEY IDENTITY(1 , 1),
ex_id INT,
st_id INT,
Score INT 
)

ALTER TABLE Results
ADD CONSTRAINT ex_id_fk FOREIGN KEY(ex_id) REFERENCES Exam(Ex_Id);
ALTER TABLE Results
ADD CONSTRAINT st_id_fk FOREIGN KEY(st_id) REFERENCES student(St_Id);
------------------

insert into [User] values ('Ahmed' , '123456' , 'Student')      -- student , training manger , instructor 
insert into [User] values ('Mahmoud' , '789123' , 'TrainingManger')
insert into [User] values ('Amr' , '456123' , 'Instructor')
insert into [User] values ('Mohamed' , '567894' , 'Instructor'),('Ali' , '908766' , 'Instructor'),('Alya' , '123987' , 'Instructor')
insert into [User] values  ('Abd Allah' , '324567' , 'TrainingManger'),('Mona' , '675489' , 'TrainingManger')
insert into [User] values  ('Alice' , '675438' , 'Student'),('Amir' , '876954' , 'Student')


insert into Course values ('web' , 'Web development' , '200' , '100')
insert into Course values('Algorithms' , 'Advanced Algorithms' , '150' , '75')
insert into Course values('DataBase' , 'Introduction to Databases' , '100' , '50')

insert into Instructor values ('Mohamed' , '1' , '3')
insert into Instructor values('Ali' , '2' , '3'),
                              ('Alya' , '3' , '3')

update Instructor
set [user_id] = '4'
where [Ins_Id] = '1'

update [User]
set [Name] = 'Ali'
where [UserId] = '2'

insert into Department values ('Software')
insert into Department values('Computer Science'),('Information Technology')

insert into Branch values ('Software development' , '1')
insert into Branch values('Computer graphics' , '2'),('Cyber Security' , '3')

insert into Track values ('CS' , '3' , '1')
insert into Track values ('AI' , '4' , '2'),('Network','5' ,'3')

insert into TrainingManger values ('Ali' , '2')
insert into TrainingManger values('Abd Allah' , '9'),('Mona' , '10')

insert into Intake values ('1')
insert into Intake values ('2'), ('3')

insert into Student values ('Mariam' , '1' , '1' , '1' , '1')
insert into Student values ('Alice' , '7' , '2' , '2' , '2'),('Amir' , '8' , '3' , '3' , '3')


insert into Exam values('MCQ' , 'allowance' , '12:00' , '2:00' , '2' , '1' , '1' , '1' , '1' , '1' , '1' )
insert into Exam values('T\F' , 'allowance' , '2:00' , '4:00' , '2' , '2' , '2' , '2' , '2' , '2' , '2' ),
                       ('Text' , 'allowance' , '10:00' , '1:00' , '3' , '3' , '3' , '3' , '3' , '3' , '3' )

update Exam
set ex_type = 'Final'
where Ex_Id = '3' 

insert into Question values('T\F' , 'T' , 'Sql Uses?' , '1')
insert into	Question values('MCQ' , 'F' , 'graphics uses?' , '2'),('T\F' , 'T' , 'cyber security uses?' , '3')

update Question
set exam_Id = '1'
where Ques_Id = '3'

insert into Student_Exam values ('2024-06-11 08:00:00' , '90' , '1' , '1')
insert into Student_Exam values ('2024-06-12 09:00:00' , '120' , '2' , '2'),('2024-06-11 08:00:00' , '100' , '3' , '3')

insert into Student_Answer values('True' , '1' , '1' , '1')
insert into Student_Answer values('True' , '2' , '2' , '2'),('False' , '3' , '3' , '3')

update Student_Answer
set StudentAnswer = 'c'
where StAns_Id = '6'


select * from [User]
select * from Instructor
select * from Course
select * from Branch
select * from Department
select * from Track
select * from TrainingManger
select * from Intake
select * from Student
select * from Exam
select * from Question
select * from Student_Exam
select * from Student_Answer


--ALTER TABLE Exam DROP CONSTRAINT take_id;
--truncate table Intake
--ALTER TABLE Exam ADD CONSTRAINT take_id FOREIGN KEY (intake_id) REFERENCES Intake(In_Id);

