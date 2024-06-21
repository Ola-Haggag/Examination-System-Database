-- insert user
exec SP_AddNewUser @Name='Islam', @Password='809055',@userType ='TrainingManger'

-- insert course
exec SP_AddNewCourse @Crs_Name='English', @description='Advanced English', @MaxDegree='200' , @MinDegree='100'

--insert instructor
exec SP_AddNewInstructor @Ins_Name='Mustafa' ,@Course_Id= 4 , @user_id=13

--add question
exec SP_AddNewQuestion @ques_type='Text' ,@correctAnswer ='F' , @QuesText='database uses?' ,@exam_Id= '2' ,@Degree='5'

--insert student
exec SP_AddNewStudent @St_Name='Amira' , @userId='12' , @track_id='3' , @mang_id='2' ,@branch_Id='3'

-- insert new intake
exec SP_AddNewIntake @manger_id='2'

-- insert new department name
exec SP_AddNewDepartment @Name='English'

-- insert new track data
exec SP_AddNewTrack @Tr_Name='English' , @user_Id='13' , @dept_id='4'

-- insert new branch in the system
exec SP_AddNewBranch @Br_Name='English' , @dep_id='4'


--insert new training manger
exec SP_AddNewTrainingManger @Name='Islam' , @User_id='14'

-- add new exam in the system
exec SP_AddNewExam @ex_type='Midterm' , @allowance='allowance' , @startTime='2:00' , @endTime='4:00' , @TotalTime='2' , @ins_id='5' , @branch_id='4' , @track_Id='4' , @student_id='4' ,@intake_id='4' ,@cours_id='4'

-- add answer to student exam
exec SP_AddNewStudentAnswer @StudentAnswer='3' ,@question_id='3' , @studt_id='4' , @studentexam_id='2'

--add new student exam information
exec SP_AddNewStudentExam @ExamDate='2024-06-18 12:00:00' , @Score='100' , @exam_id='1' , @stud_id='1'

-- add new result for certain exam for student
exec SP_AddNewResults @ex_id='3' , @st_id='3' , @Score='100'

--get student information by student id 
exec  GetStudentInfoById @student_Id=2

--get exam questions by exam id
exec SP_GetExamQuestionsByExamId @exam_Id=2

-- get course information by course name
exec SP_GetCoursesinfoByName @course_Name='Web'

-- Remove question from exam 
exec RemoveQuestionsFromExam @ExamID=1, @QuestionID=10
------------------------------------

-- Return exam result for by student id  (table valued function)
--select *from GetExamResult(@studentId)
select * from GetExamResult(1)
select * from GetExamResult(2)
select * from GetExamResult(3)


----Calulation total Result for student exam  (scalar valued function )SELECT dbo.CalculateResult(1, 1) AS TotalScore;----  Exam Report   (table valued function)
--SELECT * FROM dbo. GenerateExamReport(@ExamID) ;
SELECT * FROM dbo. GenerateExamReport(1) ;


---- GET Exam Details      (table valued function)
--SELECT * FROM dbo.RetriveExamDetails(@ExamID);
SELECT * FROM dbo.RetriveExamDetails(1);
------------------------------------------------------------------
--1. Trigger to calculate Resultsinsert into Student_Answer (StudentAnswer, question_id, studt_id, studentexam_id) values('T' , '1' , '1' , '1')
 select * from Results WHERE ex_id = 1 AND st_id = 1

 -----------------------
 --2. Trigger to update Exam Points
insert into Question (ques_type, correctAnswer, QuesText, exam_Id, Degree)
values ('T\F', 'T', 'SQL Uses?', 2, 5);
select TotalPoints from Exam where Ex_Id = 2;

----------------------------------------------------
-- view for student table
SELECT * FROM V_StudentInfo

--view for instructor table
SELECT * FROM V_InstructorInfo

--view for course table
SELECT * FROM V_CourseInfo

-- view for exam 
SELECT * FROM V_ExamInfo

-- view for guestions in an exam
SELECT * FROM V_ExamQuestions

-- view for  result of student exam
SELECT * FROM V_StudentExamResults

-- view for student answer 
SELECT * FROM V_StudentAnswers

--view for exam info , total questions , total points in exam
SELECT * FROM V_ExamOverview

--view for instructor and there courses
SELECT * FROM V_InstructorCourses


