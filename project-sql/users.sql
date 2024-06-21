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

