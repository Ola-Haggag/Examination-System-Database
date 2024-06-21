create table [User](
UserId int PRIMARY KEY IDENTITY(1 , 1),
Name NVARCHAR(50),
Password NVARCHAR(50),
userType NVARCHAR(50)
)
------------------------------------
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
--------------------------------------
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
---------------------------------------
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
-----------------------------------------------
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

----------------------------------------
create table Track(
Tr_Id int PRIMARY KEY IDENTITY(1 , 1),
Tr_Name NVARCHAR(50),
user_Id int,
constraint usid FOREIGN KEY(user_Id) REFERENCES [User](UserId),
dept_id int,
constraint department_id FOREIGN KEY(dept_id) REFERENCES Department(Dept_Id)
)
--------------------------------------------
create table Department(
Dept_Id int PRIMARY KEY IDENTITY(1 , 1),
Name NVARCHAR(50),
)
-----------------------------------------
create table Branch(
Br_Id int PRIMARY KEY IDENTITY(1 , 1),
Br_Name NVARCHAR(50),
dep_id int,
constraint depart_id FOREIGN KEY(dep_id) REFERENCES Department(Dept_Id)
)
-----------------------------------------
create table Intake(
In_Id int PRIMARY KEY IDENTITY(1 , 1),
manger_id int,
constraint mang_id FOREIGN KEY(manger_id) REFERENCES TrainingManger(Ma_Id)
)
-------------------------------------
create table TrainingManger(
Ma_Id int PRIMARY KEY IDENTITY(1 , 1),
Name NVARCHAR(50),
User_id int,
constraint userid FOREIGN KEY(user_id) REFERENCES [User](UserId)
)
---------------------------------------
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

-----------------------------------------------
create table Student_Exam(
StEx_Id int PRIMARY KEY IDENTITY(1 , 1),
ExamDate datetime,
Score int,
exam_id int,
constraint exm_id FOREIGN KEY(exam_id) REFERENCES Exam(Ex_Id),
stud_id int,
constraint stud_id FOREIGN KEY(stud_id) REFERENCES Student(St_Id),
)
---------------------------------------------------------------
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

insert into Student_Exam values ('2024-06-11 08:00:00' , '90' , '1' , '1')
insert into Student_Exam values ('2024-06-12 09:00:00' , '120' , '2' , '2'),('2024-06-11 08:00:00' , '100' , '3' , '3')

insert into Student_Answer values('True' , '1' , '1' , '1')
insert into Student_Answer values('True' , '2' , '2' , '2'),('False' , '3' , '3' , '3')

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
select * from Student_Answer
select * from Student_Exam

-------------------------------------------------------------------------------
------------------------------------------------------------------------------- stored procedures
create proc SP_AddNewUser
 @Name nvarchar(50),
 @Password nvarchar(50),
 @userType nvarchar(50) 
 as
 begin
   insert into [User](Name , Password , userType)
   values(@Name , @Password , @userType)
   end

exec SP_AddNewUser 'Islam', '809055', 'TrainingManger'
-----------------------------------------------------------
create or alter proc SP_AddNewCourse
  @Crs_Name nvarchar(50),
  @description nvarchar(50),
  @MaxDegree int,
  @MinDegree int
as 
begin
  insert into Course(Crs_Name , description , MaxDegree , MinDegree)
  values(@Crs_Name , @description , @MaxDegree , @MinDegree)
end

exec SP_AddNewCourse 'English', 'Advanced English', '200' , '100'
-----------------------------------------------------------
create or alter proc SP_AddNewInstructor
 @Ins_Name nvarchar(50),
 @Course_Id int,
 @user_id int
as 
begin
  insert into Instructor(Ins_Name , Course_Id , user_id)
  values(@Ins_Name , @Course_Id , @user_id)
end

exec SP_AddNewInstructor 'Mustafa' , 4 , 13
-----------------------------------------------------------
create proc SP_AddNewQuestion
 @ques_type nvarchar(50),
 @correctAnswer nvarchar(50),
 @QuesText nvarchar(50),
 @exam_Id int
as
begin
   insert into Question(ques_type , correctAnswer , QuesText , exam_Id)
   values(@ques_type , @correctAnswer , @QuesText , @exam_Id)
end

exec SP_AddNewQuestion 'Text' ,'F' , 'database uses?' , '2'
 --------------------------------------------------------------
create proc SP_AddNewStudent
   @St_Name NVARCHAR(50),
   @userId int,
   @track_id int,
   @mang_id int,
   @branch_Id int
as
begin
   insert into Student(St_Name , userId , track_id , mang_id ,branch_Id)
   values(@St_Name , @userId , @track_id , @mang_id , @branch_Id)
end

exec SP_AddNewStudent 'Amira' , '12' , '3' , '2' , '3'
----------------------------------------------------------------------
create proc SP_AddNewIntake 
 @manger_id int
as
begin
   insert into Intake(manger_id)
   values(@manger_id)
end

exec SP_AddNewIntake '2'
----------------------------------------------------------------------
create proc SP_AddNewDepartment
 @Name nvarchar(50)
as
begin
   insert into Department (Name)
   values(@Name)
end

exec SP_AddNewDepartment 'English'
-----------------------------------------------------------------
create proc SP_AddNewTrack
  @Tr_Name NVARCHAR(50),
  @user_Id int,
  @dept_id int
as
begin
    insert into Track(Tr_Name , user_Id ,dept_id)
	values(@Tr_Name , @user_Id , @dept_id)
end

exec SP_AddNewTrack 'English' , '13' , '4'
-----------------------------------------------------------------
create proc SP_AddNewBranch
  @Br_Name nvarchar(50),
  @dep_id int
ass
begin
   insert into Branch(Br_Name , dep_id)
   values(@Br_Name , @dep_id)
end

exec SP_AddNewBranch 'English' , '4'
---------------------------------------------------------------
create proc SP_AddNewTrainingManger
  @Name nvarchar(50),
  @User_id int
as
begin
   insert into TrainingManger(Name , User_id)
   values(@Name , @User_id)
end

exec SP_AddNewTrainingManger 'Islam' , '14'
--------------------------------------------------------------
create proc SP_AddNewExam
   @ex_type nvarchar(50),
   @allowance nvarchar(50),
   @startTime datetime,
   @endTime datetime,
   @TotalTime int,
   @ins_id int,
   @branch_id int,
   @track_Id int,
   @student_id int,
   @intake_id int ,
   @cours_id int
as
begin
    insert into Exam(ex_type , allowance , startTime , endTime , TotalTime ,ins_id ,branch_id , track_Id , student_id , intake_id , cours_id)
	values (@ex_type , @allowance , @startTime ,@endTime, @TotalTime , @ins_id , @branch_id ,@track_Id , @student_id ,@intake_id ,@cours_id  )
end

exec SP_AddNewExam 'Midterm' , 'allowance' , '2:00' , '4:00' , '2' , '5' , '4' , '4' , '4' , '4' , '4'
-----------------------------------------------------------------------------
create proc SP_AddNewStudentAnswer
  @StudentAnswer nvarchar(50),
  @question_id int,
  @studt_id int,
  @studentexam_id int
as
begin
  insert into Student_Answer(StudentAnswer , question_id , studt_id ,studentexam_id)
  values(@StudentAnswer , @question_id , @studt_id , @studentexam_id)
end

exec SP_AddNewStudentAnswer '3' ,'2' , '4' , '2'
------------------------------------------------------------------------------
create proc SP_AddNewStudentExam       
 @ExamDate datetime,
 @Score int,
 @exam_id int,
 @stud_id int
as
begin
   insert into Student_Exam(ExamDate ,Score ,exam_id , stud_id )
   values(@ExamDate ,@Score , @exam_id ,@stud_id)
end

exec SP_AddNewStudentExam '2024-06-18 12:00:00' , '100' , '1' , '1'
------------------------------------------------------------------------------
create proc SP_AddNewResults
   @ex_id int,
   @st_id int,
   @Score int 
as
begin
    insert into Results(ex_id , st_id , Score)
	values(@ex_id , @st_id , @Score)
end

exec SP_AddNewResults '3' , '3' , '100'
-----------------------------------------------------------------------------
-- get exam question by exam id
create proc SP_GetExamQuestions
 @exam_Id int
as
begin
    select Ques_Id, ques_type, correctAnswer , QuesText, exam_Id 
    from Question
	where exam_Id  = @exam_Id
end

EXEC sp_rename 'SP_GetExamQuestions', 'SP_GetExamQuestionsByExamId';

exec SP_GetExamQuestionsByExamId 3
--------------------------------------------------------------------
-- get student info by student id 
create proc GetStudentInfoById
  @student_Id int
as
begin
    select St_Id , St_Name , userId , track_id , mang_id , branch_Id
	from Student
	where St_Id = @student_Id
end

exec  GetStudentInfoById 3
------------------------------------------------------------------
-- get course info by course name
create or alter proc SP_GetCoursesinfoByName
  @course_Name nvarchar(50)
as
begin
     select Crs_Id, Crs_Name , description , MaxDegree , MinDegree
	 from Course
	 where  Crs_Name = @course_Name
end

exec SP_GetCoursesinfoByName 'Web'
----------------------------------------------------------------
----------------------------------------------------------------------- function
-- return exam result for student by student id
create  function GetExamResult (@studentId int)
returns table
as
return
 (
   select 
     se.ExamDate , se.Score , e.ex_type , e.startTime , e.endTime , e.TotalTime,
	 c.Crs_Name
	 
   from Student_Exam se
   inner Join Exam e 
   on se.exam_id = e.Ex_Id
   inner join Course c
   on e.cours_id = c.Crs_Id
   where se.stud_id = @studentId
 )
 select * from GetExamResult (2)
 -----------------------------------------------------------------------
 ----------------------------------------------------------------------indexes
-- index  on user
create index idx_user_userType  on[User] (userType)
create index idx_user_userName on [User] (Name)

-- index on Course
create index idx_course_Name on Course (Crs_Name);

-- index on instructor
create index idx_Instructor_Name on Instructor (Ins_Name)
create index idx_Instructor_CourseId on Instructor (Course_Id)
create index idx_Instructor_userId on Instructor(user_id)

-- index on Question 
create index idx_Question_type on Question (ques_type)
create index idx_Questio_examId on Question (exam_id)

--index on Student
create index idx_Student_userId on Student (userId)
create index idx_Student_userName on Student (St_Name)
create index idx_Student_trackId on Student (track_id)
create index idx_Student_studentName on Student (St_Name)
create index idx_Student_branchId on Student (branch_Id)

--index on track
create index idx_Track_trName on Track(Tr_Name)
create index idx_Track_deptId on Track(dept_id)

--index on department
create index idx_Department_deptName on Department(Name)

--index on branch
create index idx_Branch_brName on Branch(Br_Name)
create index idx_Branch_depId on Branch(dep_id)

-- index on Exam
create index idx_Exam_startTime on Exam (startTime)
create index idx_Exam_endTime on Exam (endTime)
create index idx_Exam_InstructorId on Exam (ins_id)
create index idx_Exam_branchId on Exam(branch_id)
create index idx_Exam_trackId on Exam(track_Id)
create index idx_Exam_studentId on Exam(student_id)
create index idx_Exam_intakeId on Exam(intake_id)
create index idx_Exam_courseId on Exam(cours_id)

--index on student answer
create index idx_StudentAnswer_questionId on Student_Answer (question_id)
create index idx_StudentAnswer_studtId on Student_Answer(studt_id)
create index idx_StudentAnswer_studentExam on Student_Answer(studentexam_id)

-- index on student exam
create index idx_StudentExam_examId on Student_Exam(exam_id)
create index idx_StudentExam_studId on Student_Exam(stud_id)

--index on result
create index idx_Results_exId on Results(ex_id)
create index idx_Results_stId on Results(st_id)