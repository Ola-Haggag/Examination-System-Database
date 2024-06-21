-- return exam result for by student id
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
------------------------------------------------------------
-- Result Calulation FunctionCREATE OR ALTER FUNCTION CalculateResult(@ExamID INT, @StudentID INT)RETURNS INTASBEGIN    DECLARE @TotalScore INT;    SELECT @TotalScore = SUM(Degree)    FROM Question Q    JOIN Student_Answer SA ON Q.Ques_Id = SA.question_id    WHERE Q.exam_Id = @ExamID AND SA.studt_id = @StudentID AND SA.StudentAnswer = Q.correctAnswer;    RETURN @TotalScore;END;GOSELECT dbo.CalculateResult(1, 1) AS TotalScore;GO
--------------------------------------------------------------------
--Exam Report
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

SELECT * FROM dbo. GenerateExamReport(1) ;

GO
-------------------------------------------------------------------------
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
--------------------------------------------------------------