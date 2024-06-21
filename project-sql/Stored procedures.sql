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
create or alter proc SP_AddNewQuestion
 @ques_type nvarchar(50),
 @correctAnswer nvarchar(50),
 @QuesText nvarchar(50),
 @exam_Id int,
 @Degree int
as
begin
   insert into Question(ques_type , correctAnswer , QuesText , exam_Id , Degree)
   values(@ques_type , @correctAnswer , @QuesText , @exam_Id ,  @Degree)
end

exec SP_AddNewQuestion 'Text' ,'F' , 'database uses?' , '2' , '5'
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

exec SP_AddNewStudentAnswer '3' ,'3' , '4' , '2'
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
------------------------------------- get exam question by exam id
create proc SP_GetExamQuestions
 @exam_Id int
as
begin
    select Ques_Id, ques_type, correctAnswer , QuesText, exam_Id 
    from Question
	where exam_Id  = @exam_Id
end

EXEC sp_rename 'SP_GetExamQuestions', 'SP_GetExamQuestionsByExamId';

exec SP_GetExamQuestionsByExamId 2
--------------------------------------------------------------------
-------------------------------------- get student info by student id 
create proc GetStudentInfoById
  @student_Id int
as
begin
    select St_Id , St_Name , userId , track_id , mang_id , branch_Id
	from Student
	where St_Id = @student_Id
end

exec  GetStudentInfoById 3
----------------------------------------------------------------------
------------------------------------------ get course info by course name
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