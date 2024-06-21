CREATE DATABASE Project
GO
USE Project
GO

-----done----- without FK
create table [User](
UserId int PRIMARY KEY IDENTITY(1 , 1),
Name NVARCHAR(50),
Password NVARCHAR(50),
userType NVARCHAR(50)
--user_Type ENUM('Student' , 'Instructor' , 'training_manger')
)
GO
--alter table [User]
--add user_type ENUM('Student' , 'Instructor' , 'training_manger')
-- without FK -----done---
GO
create table Course(
Crs_Id int PRIMARY KEY IDENTITY(1 , 1),
Crs_Name NVARCHAR(50),
description NVARCHAR(50),
MaxDegree int,
MinDegree int
)
GO
-----done---
create table Instructor(
Ins_Id int PRIMARY KEY IDENTITY(1 , 1),
Ins_Name NVARCHAR(50),
Course_Id int,
constraint course_id FOREIGN KEY(Course_Id) REFERENCES Course(Crs_Id),
user_id int,
constraint us_id FOREIGN KEY(user_id) REFERENCES [User](UserId)
)

GO


---------------------------done--------------------------------------------------------------------------
create table Question(
Ques_Id int PRIMARY KEY IDENTITY(1 , 1),
ques_type NVARCHAR(50),
correctAnswer NVARCHAR(50),
QuesText NVARCHAR(50),
exam_Id int,
Degree INT
--constraint ex_id FOREIGN KEY(exam_Id) REFERENCES Exam(Ex_Id),
)
GO
ALTER TABLE Question
ADD constraint ex_id FOREIGN KEY(exam_Id) REFERENCES Exam(Ex_Id)
GO
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
GO
ALTER TABLE Student
ADD branch_Id int,
constraint bran_id FOREIGN KEY(branch_Id) REFERENCES Branch(Br_Id)
GO
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
GO
-------done--- without FK
create table Department(
Dept_Id int PRIMARY KEY IDENTITY(1 , 1),
Name NVARCHAR(50),
)
GO
-----done---
create table Branch(
Br_Id int PRIMARY KEY IDENTITY(1 , 1),
Br_Name NVARCHAR(50),
dep_id int,
constraint depart_id FOREIGN KEY(dep_id) REFERENCES Department(Dept_Id)
)
GO
-----done---
create table Intake(
In_Id int PRIMARY KEY IDENTITY(1 , 1),
manger_id int,
constraint mang_id FOREIGN KEY(manger_id) REFERENCES TrainingManger(Ma_Id)
)
GO
-----done---
create table TrainingManger(
Ma_Id int PRIMARY KEY IDENTITY(1 , 1),
Name NVARCHAR(50),
User_id int,
constraint userid FOREIGN KEY(user_id) REFERENCES [User](UserId)
)
GO
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
GO
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
GO
insert into [User] values ('Ahmed' , '123456' , 'Student')      -- student , training manger , instructor 
insert into [User] values ('Mahmoud' , '789123' , 'TrainingManger')
insert into [User] values ('Amr' , '456123' , 'Instructor')
insert into [User] values ('Mohamed' , '567894' , 'Instructor'),('Ali' , '908766' , 'Instructor'),('Alya' , '123987' , 'Instructor')
insert into [User] values  ('Abd Allah' , '324567' , 'TrainingManger'),('Mona' , '675489' , 'TrainingManger')
insert into [User] values  ('Alice' , '675438' , 'Student'),('Amir' , '876954' , 'Student')
GO

insert into Course values ('web' , 'Web development' , '200' , '100')
insert into Course values('Algorithms' , 'Advanced Algorithms' , '150' , '75')
insert into Course values('DataBase' , 'Introduction to Databases' , '100' , '50')
GO
insert into Instructor values ('Mohamed' , '1' , '3')
insert into Instructor values('Ali' , '2' , '3'),
                              ('Alya' , '3' , '3')
GO
update Instructor
set [user_id] = '4'
where [Ins_Id] = '1'
GO
update [User]
set [Name] = 'Ali'
where [UserId] = '2'
GO
insert into Department values ('Software')
insert into Department values('Computer Science'),('Information Technology')
GO
insert into Branch values ('Software development' , '1')
insert into Branch values('Computer graphics' , '2'),('Cyber Security' , '3')
GO
insert into Track values ('CS' , '3' , '1')
insert into Track values ('AI' , '4' , '2'),('Network','5' ,'3')
GO
insert into TrainingManger values ('Ali' , '2')
insert into TrainingManger values('Abd Allah' , '9'),('Mona' , '10')
insert into Intake values ('1')
insert into Intake values ('2'), ('3')
GO
insert into Student values ('Mariam' , '1' , '1' , '1' , '1')
insert into Student values ('Alice' , '7' , '2' , '2' , '2'),('Amir' , '8' , '3' , '3' , '3')
GO

insert into Exam values('Exam' , 'allowance' , '12:00' , '2:00' , '2' , '1' , '1' , '1' , '1' , '1' , '1' ),('TExamF' , 'allowance' , '2:00' , '4:00' , '2' , '2' , '2' , '2' , '2' , '2' , '2' ),
                       ('Exam' , 'allowance' , '10:00' , '1:00' , '3' , '3' , '3' , '3' , '3' , '3' , '3' )

GO

insert into Question values('T\F' , 'T' , 'Sql Uses?' , '1',5),('MCQ' , 'A' , 'graphics uses?' , '2',5),('T\F' , 'T' , 'cyber security uses?' , '3',5)

GO
insert into Student_Exam values ('2024-06-11 08:00:00' , '90' , '1' , '1')
insert into Student_Exam values ('2024-06-12 09:00:00' , '120' , '2' , '2'),('2024-06-11 08:00:00' , '100' , '3' , '3')
GO
insert into Student_Answer values('T' , '1' , '1' , '1')
insert into Student_Answer values('C' , '1' , '2' , '1'),('T' , '1' , '3' , '1')
GO
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

--ALTER TABLE Exam DROP CONSTRAINT take_id;
--truncate table Intake
--ALTER TABLE Exam ADD CONSTRAINT take_id FOREIGN KEY (intake_id) REFERENCES Intake(In_Id);

----------------------------------------------------------------------------------------------------------------
--MOKHTAR
----------------------------------------------------------------------------------------------------------------

-- ADD QquestionID forgein key in the exam table      ---done
ALTER TABLE Exam     
ADD question_id INT;

GO

ALTER TABLE Exam
ADD CONSTRAINT Question_Exam_FK FOREIGN KEY(question_id) REFERENCES Question(Ques_Id);

GO

-- Insert Exam Data
INSERT INTO Exam (cours_id, ins_id, ex_type, intake_id, branch_id, track_id, startTime, endTime, TotalTime, allowance,student_id)
VALUES (1, 2, 'Exam', 1, 1, 1, '2024-06-18 10:00:00', '2024-06-18 12:00:00', 2, 0,1);

INSERT INTO Exam (cours_id, ins_id, ex_type, intake_id, branch_id, track_id, startTime, endTime, TotalTime, allowance,student_id)
VALUES (1, 2, 'Corrective', 1, 1, 1, '2024-06-18 10:00:00', '2024-06-18 12:00:00', 2, 0,1);
GO

--Insert Questions into Exams
INSERT INTO Question(exam_Id, Ques_Id)
VALUES (3, 1), (3, 2); 

GO

-- ADD degree column in question table      ---done
ALTER TABLE Question
ADD  Degree INT ;

GO

CREATE TABLE Results(          ---done
Re_Id int PRIMARY KEY IDENTITY(1 , 1),
ex_id INT,
st_id INT,
Score INT 
)

ALTER TABLE Results
ADD CONSTRAINT ex_id FOREIGN KEY(ex_id) REFERENCES Exam(ex_id);
ALTER TABLE Results
ADD CONSTRAINT st_id FOREIGN KEY(st_id) REFERENCES student(st_id);

GO

-------------------------------------------------------------------------------------------------------------------------
--FUNCTIONS & PROCEDURES
-------------------------------------------------------------------------------------------------------------------------

-- Result Calulation FunctionCREATE OR ALTER FUNCTION CalculateResult(@ExamID INT, @StudentID INT)RETURNS INTASBEGIN    DECLARE @TotalScore INT;    SELECT @TotalScore = SUM(Degree)    FROM Question Q    JOIN Student_Answer SA ON Q.Ques_Id = SA.question_id    WHERE Q.exam_Id = @ExamID AND SA.studt_id = @StudentID AND SA.StudentAnswer = Q.correctAnswer;    RETURN @TotalScore;END;GOSELECT dbo.CalculateResult(1, 1) AS TotalScore;GO

--------------------------------------------------------
-- GET Exam Details
CREATE OR ALTER FUNCTION RetriveExamDetails
    (@ExamID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        E.Ex_Id,
        E.StartTime,
        E.EndTime,
        C.Crs_Name,
        I.Ins_Name
    FROM Exam E
    JOIN Course C ON E.cours_id = C.Crs_Id
    JOIN Instructor I ON E.ins_id = I.Ins_Id
    WHERE E.Ex_Id = @ExamID
);

GO

SELECT * FROM dbo.RetriveExamDetails(1);

GO
--------------------------------------------------------

--Exam Report                           ---------------------------------------------------done
CREATE OR ALTER FUNCTION GenerateExamReport(@ExamID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        E.Ex_Id,
        E.StartTime,
        E.EndTime,
        C.description,
        I.Ins_Name,
        S.St_Id,
        S.St_Name,
        SA.StudentAnswer,
		Q.correctAnswer
    FROM Exam E
    JOIN Course C ON E.cours_id = C.Crs_Id
    JOIN Instructor I ON E.ins_id = I.Ins_Id
    JOIN Student_Answer SA ON E.Ex_Id = SA.studentexam_id
    JOIN Student S ON SA.studt_id = S.St_Id
	JOIN Question Q ON SA.question_id = Q.Ques_Id
    WHERE E.Ex_Id = @ExamID
);

GO

SELECT * FROM dbo. GenerateExamReport( 1) ;

GO

------------------------------------------------

-- Remove question from exam                
CREATE OR ALTER PROCEDURE RemoveQuestionsFromExam
    @ExamID INT,
    @QuestionID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Question WHERE exam_Id = @ExamID AND Ques_Id = @QuestionID)
    BEGIN
        DELETE FROM Question
        WHERE exam_Id = @ExamID AND Ques_Id = @QuestionID;
        SELECT 'Question removed from exam successfully.' AS Message;
    END
    ELSE
    BEGIN
        SELECT 'Question not found in the exam.' AS Message;
    END
END;

GO
EXECUTE RemoveQuestionsFromExam 1, 10;

GO
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
--TRIGGERS
-------------------------------------------------------------------------------------------------------------------------
--1. Trigger to calculate Results
CREATE OR ALTER TRIGGER trigger_UpdateResult
ON Student_Answer
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @ExamID INT, @StudentID INT;
    SELECT @ExamID = SA.studentexam_id, @StudentID = SA.studt_id FROM Student_Answer SA;
    DECLARE @TotalScore INT = dbo.CalculateResult(@ExamID, @StudentID);
    
    IF EXISTS (SELECT 1 FROM Results WHERE ex_id = @ExamID AND st_id = @StudentID)
    BEGIN
        UPDATE Results
        SET Score = @TotalScore
        WHERE ex_id = @ExamID AND st_id = @StudentID;
    END
    ELSE
    BEGIN
        INSERT INTO Results (ex_id, st_id, Score)
        VALUES (@ExamID, @StudentID, @TotalScore);
    END
END;

GO

insert into Student_Answer values('T' , '1' , '1' , '1')

GO
-----------------------------------------------------------------------------------------------
--2. Trigger to update Exam Points

ALTER TABLE Exam ADD  TotalPoints INT
GO

CREATE OR ALTER TRIGGER trigger_UpdateExamTotalPoints
ON Question
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Update total points for inserted or updated questions
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        UPDATE Exam
        SET TotalPoints = (SELECT SUM(Q.Degree) FROM Question Q WHERE Q.exam_Id = inserted.exam_Id)
        FROM inserted
        WHERE Exam.Ex_Id = inserted.exam_Id;
    END
    
    -- Update total points for deleted questions
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE Exam
        SET TotalPoints = (SELECT SUM(Q.Degree) FROM Question Q WHERE Q.exam_Id = deleted.exam_Id)
        FROM deleted
        WHERE Exam.Ex_Id = deleted.exam_Id;
    END
END;

GO

insert into Question values('T\F' , 'T' , 'Sql Uses?' , '2',5)
insert into Question values('T\F' , 'T' , 'Sql Uses?' , '1',5)
insert into Question values('T\F' , 'T' , 'Sql Uses?' , '1',45)
DELETE FROM Question WHERE Ques_Id = 10;

GO
--------------------------------------------------------------------------------------------------

----------------------- views

--1.
CREATE OR ALTER VIEW V_StudentInfo AS
SELECT 
    St_Id,
    St_Name,
    userId,
    track_id,
    mang_id,
    branch_Id
FROM 
    Student;

GO

SELECT * FROM V_StudentInfo

GO

--2.
CREATE OR ALTER VIEW V_InstructorInfo AS
SELECT 
    Ins_Id,
    Ins_Name,
    Course_Id,
    user_id
FROM 
    Instructor;

GO

SELECT * FROM V_InstructorInfo

GO

--3. 
CREATE OR ALTER VIEW V_CourseInfo AS
SELECT 
    Crs_Id,
    Crs_Name,
    Description,
    MaxDegree,
    MinDegree
FROM 
    Course;

GO

SELECT * FROM V_CourseInfo

GO

--4.
CREATE OR ALTER VIEW V_ExamInfo AS
SELECT 
    E.Ex_Id,
    E.ex_type,
    E.cours_id,
    C.Crs_Name,
    E.ins_id,
    I.Ins_Name,
    E.intake_id,
    E.branch_id,
    E.track_Id,
    E.StartTime,
    E.EndTime,
    E.TotalTime,
    E.allowance
FROM 
    Exam E
JOIN 
    Course C ON E.cours_id = C.Crs_Id
JOIN 
    Instructor I ON E.ins_id = I.Ins_Id;

GO

SELECT * FROM V_ExamInfo

GO

--5.
CREATE OR ALTER VIEW V_ExamQuestions AS
SELECT 
    E.Ex_Id,
    Q.Ques_Id,
    Q.QuesText,
    Q.ques_type,
    Q.Degree
FROM 
    Exam E
JOIN 
    Question Q ON E.Ex_Id = Q.exam_Id;

GO

SELECT * FROM V_ExamQuestions

GO

--6.
CREATE OR ALTER VIEW V_StudentExamResults AS
SELECT 
    SE.stud_id,
    S.St_Name,
    SE.exam_id,
    E.cours_id,
    C.Crs_Name,
    SE.Score
FROM 
    Student_Exam SE
JOIN 
    Student S ON SE.stud_id = S.St_Id
JOIN 
    Exam E ON SE.exam_id = E.Ex_Id
JOIN 
    Course C ON E.cours_id = C.Crs_Id;

GO

SELECT * FROM V_StudentExamResults

GO

--7.
CREATE OR ALTER VIEW V_StudentAnswers AS
SELECT 
    SA.studt_id,
    S.St_Name,
    SA.studentexam_id,
	SA.question_id,
    Q.QuesText,
    SA.StudentAnswer,
    Q.correctAnswer
FROM 
    Student_Answer SA
JOIN 
    Student S ON SA.studt_id = S.St_Id
JOIN 
    Question Q ON SA.question_id = Q.Ques_Id;

GO

SELECT * FROM V_StudentAnswers

GO

--8.
CREATE OR ALTER VIEW V_ExamOverview AS
SELECT 
    E.Ex_Id,
    E.cours_id,
    C.Crs_Name,
    E.ins_id,
    I.Ins_Name,
    E.StartTime,
    E.EndTime,
    COUNT(Q.Ques_Id) AS TotalQuestions,
    SUM(Q.Degree) AS TotalPoints
FROM 
    Exam E
JOIN 
    Course C ON E.cours_id = C.Crs_Id
JOIN 
    Instructor I ON E.ins_id = I.Ins_Id
JOIN 
    Question Q ON E.Ex_Id = Q.exam_Id

GROUP BY 
    E.Ex_Id, E.cours_id, C.Crs_Name, E.ins_id, I.Ins_Name, E.StartTime, E.EndTime;
GO 

SELECT * FROM V_ExamOverview

GO

--9.
CREATE OR ALTER VIEW V_InstructorCourses AS
SELECT 
    I.Ins_Id,
    I.Ins_Name,
    I.Course_Id,
    C.Crs_Name,
    C.Description,
    C.MaxDegree,
    C.MinDegree
FROM 
    Course C
JOIN 
    Instructor I ON C.Crs_Id= I.Course_Id

GO 

SELECT * FROM V_InstructorCourses

GO

----------------------------------------------------------------------------------------------------

-- CREATE USERS
CREATE LOGIN admin1 WITH PASSWORD = 'admin1234';
CREATE USER AdminUser FOR LOGIN admin1;
ALTER ROLE db_owner ADD MEMBER AdminUser;

GRANT EXECUTE ON SP_AddNewTrainingManger TO ManagerUser;

GO

CREATE LOGIN manager1 WITH PASSWORD = 'manager1234';
CREATE USER ManagerUser FOR LOGIN manager1;
GRANT INSERT, UPDATE, DELETE ON Student TO ManagerUser;
GRANT INSERT, UPDATE, DELETE ON Branch TO ManagerUser;
GRANT INSERT, UPDATE, DELETE ON Track TO ManagerUser;

GRANT EXECUTE ON SP_AddNewUser TO ManagerUser;
GRANT EXECUTE ON SP_AddNewCourse TO ManagerUser;
GRANT EXECUTE ON SP_AddNewInstructor TO ManagerUser;
GRANT EXECUTE ON SP_AddNewStudent TO ManagerUser;
GRANT EXECUTE ON SP_AddNewIntake TO ManagerUser;
GRANT EXECUTE ON SP_AddNewDepartment TO ManagerUser;
GRANT EXECUTE ON SP_AddNewTrack TO ManagerUser;
GRANT EXECUTE ON SP_AddNewBranch TO ManagerUser;
GRANT EXECUTE ON GetStudentInfoById TO ManagerUser;

GRANT SELECT ON V_StudentInfo TO ManagerUser;
GRANT SELECT ON V_InstructorInfo TO ManagerUser;
GRANT SELECT ON V_ExamOverview TO ManagerUser;
GRANT SELECT ON V_InstructorCourses TO ManagerUser;

GO

CREATE LOGIN instructor1 WITH PASSWORD = 'instructor1234';
CREATE USER InstructorUser FOR LOGIN instructor1;
GRANT SELECT, INSERT, UPDATE ON Exam TO InstructorUser;
GRANT SELECT, INSERT, UPDATE ON Question TO InstructorUser;

GRANT EXECUTE ON SP_AddNewQuestion TO InstructorUser;
GRANT EXECUTE ON SP_AddNewExam TO InstructorUser;
GRANT EXECUTE ON SP_AddNewStudentExam TO InstructorUser;
GRANT EXECUTE ON SP_AddNewResults TO InstructorUser;
--GRANT EXECUTE ON SP_GetExamQuestions TO InstructorUser;--
GRANT EXECUTE ON GetStudentInfoById TO InstructorUser;
GRANT EXECUTE ON SP_GetCoursesinfoByName TO InstructorUser;
GRANT EXECUTE ON RemoveQuestionsFromExam TO InstructorUser;
GRANT EXECUTE ON CalculateResult TO InstructorUser;
--GRANT EXECUTE ON RetriveExamDetails TO InstructorUser;
--GRANT EXECUTE ON GenerateExamReport TO InstructorUser;

GRANT SELECT ON V_StudentInfo TO InstructorUser;
GRANT SELECT ON V_CourseInfo TO InstructorUser;
GRANT SELECT ON V_ExamInfo TO InstructorUser;
GRANT SELECT ON V_ExamQuestions TO InstructorUser;
GRANT SELECT ON V_StudentExamResults TO InstructorUser;
GRANT SELECT ON V_StudentAnswers TO InstructorUser;
GRANT SELECT ON V_ExamOverview TO InstructorUser;

CREATE LOGIN student1 WITH PASSWORD = 'student1234';
CREATE USER StudentUser FOR LOGIN student1;
GRANT SELECT, INSERT ON Student_Answer TO StudentUser;
GRANT EXECUTE ON SP_AddNewStudentAnswer TO StudentUser;

GRANT SELECT ON V_StudentAnswers TO StudentUser;




