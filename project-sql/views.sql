
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
