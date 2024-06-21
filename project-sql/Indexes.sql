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