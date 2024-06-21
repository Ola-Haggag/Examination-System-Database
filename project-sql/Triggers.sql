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