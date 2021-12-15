--Programmer: Zack Stiltner, Michael Marcario, Tgaja Johnson
--Course: B320
--Assignment: Final Project 

Drop View IF EXISTS [Transcript]; 
Go

Drop View IF EXISTS [CompSciStudentLevel];
Go

Drop View IF EXISTS [ISATStudentLevel];
Go

Drop View IF EXISTS [GradeCountPassed];
Go

Drop View IF EXISTS [GradeCountFailed];
Go

Drop View IF EXISTS [GradeCountTotal];
Go

Drop View IF EXISTS [StudentGPA];
Go

Drop View IF EXISTS [RangeTypeTable];
Go

Drop View IF EXISTS [StudentTermGPA];
Go

Drop View IF EXISTS [StudentGPA6];
Go

Drop View IF EXISTS [StudentGPA7];
Go

Drop View IF EXISTS [DoubleCourses];
Go



-- A, The Registrar's office has to generate student transcripts
 Create View Transcript as 
select	StudentCourseEnrollment.StudentID, 
		StudentFName, StudentLName,  
		Major, StudentLevel, StudentType, 
		Standing, StudentCourseEnrollment.TermID, 
		Department, CourseNumber, CourseTitle, Campus, CourseLevel, Grade, 
		sum(CreditsEarned * QualityPoint) as PtsEarned,
		sum(CreditsEarned) as CreditHours, 
		sum(CreditsEarned) as [AttemptedHours],
		sum(CreditsEarned * QualityPoint) / sum(Credit) as GradePointAveragePerCourse
from [StudentCourseEnrollment]
 inner join [dbo].[QualityPoint] 
  on [dbo].[StudentCourseEnrollment].Grade = [dbo].[QualityPoint].LetterGrade
 join CourseOffered 
 on	  StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
 join Course
 on   CourseOffered.CourseID = Course.CourseID
 JOIN Student
 ON	  StudentCourseEnrollment.StudentID = Student.StudentID
 Join AcademicStanding
 ON   AcademicStanding.StudentID = Student.StudentID
 Join Location
 ON   CourseOffered.LocationID = Location.LocationID
where Student.StudentID = 1 AND StudentCourseEnrollment.TermID = 4
group by StudentCourseEnrollment.StudentID, StudentCourseEnrollment.TermID, 
		 Course.CourseTitle, Grade, StudentFName, StudentLName,StudentLevel, 
		 StudentType, Standing, Major, Department, CourseNumber, CourseTitle, 
		 Campus, CourseLevel
go

--B, At the beginning of each year, Dr. Canada has to report the number of Computer Science 
--students by student classification (i.e., 1st year CSCI, 2nd year CSCI, 
--3rd year CSCI, 4th year CSCI, 1st year ISAT, etc)

-- Creates a View 
Create View CompSciStudentLevel as
SELECT  Major, StudentLevel,
		Count(StudentLevel) as NumPerLevelCSCI
FROM Student
	JOIN AcademicStanding
	ON	Student.StudentID = AcademicStanding.StudentID
WHERE Major = 'CSCI' 
Group By Major, StudentLevel
go

-- Creates a View 
Create View ISATStudentLevel as
SELECT Major, StudentLevel,
	   Count(StudentLevel) as NumPerLevelIsat
FROM Student
	JOIN AcademicStanding
	ON	Student.StudentID = AcademicStanding.StudentID
WHERE Major = 'ISAT'
Group By Major, StudentLevel
go

-- Actual Query Answer
SELECT *
FROM CompSciStudentLevel
UNION
SELECT * 
FROM ISATStudentLevel
ORDER BY Major, StudentLevel




--C  Each semester, Dr. Canada has to report the number of Computer Science 
-- students who successfully completed all courses with a grade of C or better. 
-- This information typically has to be broken out by student classification 
-- (i.e., 1st year CSCI, 2nd year CSCI, 3rd year CSCI, 4th year CSCI, 1st year ISAT, etc) 
-- and semester (Spring 2021, Fall 2021, etc.)

SELECT DISTINCT Major, 
			    StudentLevel,
				COUNT(StudentLevel) as NumOfCtoA
FROM Student 
	 JOIN	StudentCourseEnrollment
	 ON		Student.StudentID = StudentCourseEnrollment.StudentID	
	 JOIN   CourseOffered
	 ON		StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
	 JOIN	Course
	 ON		CourseOffered.CourseID = Course.CourseID
	 JOIN	AcademicStanding
	 ON		Student.StudentID = AcademicStanding.StudentID
WHERE Major = 'CSCI' AND Grade = 'A' OR Grade = 'B+' OR 
						 Grade = 'B' OR Grade = 'C+' OR Grade = 'C'
Group By Major, StudentLevel
ORDER BY Major, StudentLevel asc


-- D, Each semester, Dr. Canada has to report all classes offered by the Department of 
-- Computer Science. For each of these courses, the number and percentage of 
-- computer science students who successfully complete the course with a grade of C 
-- or better must be listed. Also required is the number and percentage of computer 
-- science students who do NOT successfully complete the course with a grade of C or better.

-- Create GradeCountPassed View 
Create View GradeCountPassed as
SELECT Departments.CourseID,Count(Grade) AS GradeCountPassed
FROM Student 
	 JOIN	StudentCourseEnrollment
	 ON		Student.StudentID = StudentCourseEnrollment.StudentID	
	 JOIN   CourseOffered
	 ON		StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
	 JOIN	(select *  from Course where Department = 'CSCI' OR Department = 'ISAT') as Departments
	 ON		CourseOffered.CourseID = Departments.CourseID
WHERE Grade = 'A' OR Grade = 'B+' OR Grade = 'B' OR 
	  Grade = 'C+' OR Grade = 'C'
Group By Departments.CourseID
go

--- Create GradeCountFailed View 
Create View GradeCountFailed as
SELECT Departments.CourseID,Count(Grade) AS GradeCountFailed
FROM Student 
	 JOIN	StudentCourseEnrollment
	 ON		Student.StudentID = StudentCourseEnrollment.StudentID	
	 JOIN   CourseOffered
	 ON		StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
	 JOIN	(select *  from Course where Department = 'CSCI' OR Department = 'ISAT') as Departments
	 ON		CourseOffered.CourseID = Departments.CourseID
WHERE Grade = 'D' OR Grade = 'F'
Group By Departments.CourseID
go

-- Grade Count Total View 
Create View GradeCountTotal as
SELECT Departments.CourseID,Count(Grade) AS GradeCountTotal
FROM Student 
	 JOIN	StudentCourseEnrollment
	 ON		Student.StudentID = StudentCourseEnrollment.StudentID	
	 JOIN   CourseOffered
	 ON		StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
	 JOIN	(select *  from Course where Department = 'CSCI' OR Department = 'ISAT') as Departments
	 ON		CourseOffered.CourseID = Departments.CourseID
Group BY Departments.CourseID
go

--- Passed & Failed %age 
-- Numbers arent exactly accruate bc of Null values 
SELECT GradeCountPassed.CourseID, GradeCountPassed,GradeCountFailed, GradeCountTotal, 
			Round((Cast(GradeCountPassed as decimal ) / CAST(GradeCountTotal AS decimal)), 3) * 100 AS [PercentagePassed], 
			Round((Cast(GradeCountFailed as decimal ) / CAST(GradeCountTotal AS decimal)), 3) * 100 AS [PercentageFailed]
FROM GradeCountPassed
	JOIN GradeCountTotal
	ON   GradeCountPassed.CourseID = GradeCountTotal.CourseID
	jOIN GradeCountFailed
	ON   GradeCountPassed.CourseID = GradeCountFailed.CourseID
	Join CourseOffered 
	ON	 GradeCountTotal.CourseID = CourseOffered.CourseID



-- E, In order for a course offering to financially "break even", 
-- it requires a minimum of 10 students to enroll in it. So far, the Department 
-- of Computer Science has been able to offer courses that have less than 10 students 
-- enrolled as CS is a "new program" here at USCB. However, this situation won't last long. 
-- Moving forward, Dr. Canada will have to be able to identify and then justify NOT cancelling 
-- any and all course offerings that have less than 10 students. 

SELECT	StudentCourseEnrollment.CourseOfferedID, Department, COUNT (StudentCourseEnrollment.CourseOfferedID) AS [StudentCount]
FROM	StudentCourseEnrollment
Join    CourseOffered
ON		StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
Join    Course
ON		CourseOffered.CourseID = Course.CourseID
Where   Department = 'CSCI' or Department = 'ISAT'
Group By StudentCourseEnrollment.CourseOfferedID, Department
Having	Count (StudentCourseEnrollment.CourseOfferedID) > 10
Order By CourseOfferedID ASC

SELECT	StudentCourseEnrollment.CourseOfferedID, Department, COUNT (StudentCourseEnrollment.CourseOfferedID) AS [StudentCount]
FROM	StudentCourseEnrollment
Join    CourseOffered
ON		StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
Join    Course
ON		CourseOffered.CourseID = Course.CourseID
Where   Department = 'CSCI' or Department = 'ISAT'
Group By StudentCourseEnrollment.CourseOfferedID, Department
Having	Count (StudentCourseEnrollment.CourseOfferedID) < 10
Order By CourseOfferedID ASC

---F, Each semester, Dr. Canada has to be able to report the number of Computer Science 
-- students by "GPA range". That is, the number with a GPA in the A range, the number with
-- a GPA in the B+ range, the number with a GPA in the B range, etc.

-- Create View for Students Total GPA 
Create View StudentGPA as 
select	StudentID, 
		sum(CreditsEarned * QualityPoint) as PtsEarned,
		sum(CreditsEarned) as CreditHours,
		sum(CreditsEarned * QualityPoint) / sum(Credit) as CumulativeGPA
from StudentCourseEnrollment
	inner join QualityPoint 
	 on StudentCourseEnrollment.Grade = QualityPoint.LetterGrade
	join CourseOffered 
	on	  StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
	join Course
	on   CourseOffered.CourseID = Course.CourseID
group by StudentID
go


-- Create View including RangeType
Create View RangeTypeTable as
SELECT *,
CASE when CumulativeGPA = 4 then 'The range is A'
	 when CumulativeGPA BETWEEN 3.5 AND 3.9 then 'The range is B+'
	 when CumulativeGPA BETWEEN 3 AND 3.4 then 'The range is B'
	 when CumulativeGPA BETWEEN 2.5 AND 2.9 then 'The range is C+'
	 when CumulativeGPA BETWEEN 2 AND 2.4 then 'The range is C' 
	 when CumulativeGPA BETWEEN 1 AND 1.9 then 'The range is D'
	 else 'The range is F' 
	 end as RangeType 
FROM StudentGPA	
go

-- Actual Query
SELECT RangeType, COUNT(RangeType) as RangeNum
FROM RangeTypeTable
Group By RangeType

-- G, To better assist their student-advisees, academic advisers need to know which of 
-- them are struggling. At the beginning of each semester, advisers need a list of their 
-- currently-enrolled advisees whose GPA decreased from the prior semester. The two GPAs as
-- well as the amount of decrease are important, and need to be included. You can assume it 
-- is the prior two semesters, so ideally no 'term id' is hardcoded into the query (i.e., it 
-- determines this information dynamically).

--- GPA Per Specific Semester
Create View StudentTermGPA as
select	StudentID, StudentCourseEnrollment.TermID,
		sum(CreditsEarned * QualityPoint) as PtsEarned,
		sum(CreditsEarned) as CreditHours,
		sum(CreditsEarned * QualityPoint) / sum(Credit) as SemesterGPA
from StudentCourseEnrollment
	inner join QualityPoint 
	on StudentCourseEnrollment.Grade = QualityPoint.LetterGrade
	join CourseOffered 
	on	  StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
	join Course
	on   CourseOffered.CourseID = Course.CourseID
group by StudentID, StudentCourseEnrollment.TermID
go

-- Creates STUDENTGPA6 View Table
Create View StudentGPA6 as
SELECT * 
FROM StudentTermGPA
WHERE TermID = 6
go

-- Creates STUDENTGPA7 View Table
Create View StudentGPA7 as
SELECT * 
FROM StudentTermGPA
WHERE TermID = 7
go

-- Shows Difference in Term GPA for Different Student 
SELECT StudentGPA6.StudentID, StudentGPA6.TermID, StudentGPA7.TermID, 
	   (StudentGPA6.SemesterGPA - StudentGPA7.SemesterGPA) AS [Difference]
FROM StudentGPA6
	Join StudentGPA7
	ON	StudentGPA6.StudentID = StudentGPA7.StudentID
WHERE StudentGPA6.StudentID = 1

--H, To better assist their student-advisees, academic advisers need to know which of 
-- their advisees have and/or are repeating courses. At the beginning of each semester, 
-- advisers need a list of their currently-enrolled advisees that have and/or are currently 
-- repeating courses. The course, the semesters in which it was taken, as well as the two 
-- respective grades are important, and need to be included. You should think of these as 
-- the initial attempt and the final attempt at the course. If the student is currently 
-- re-taking the course, instead of a grade for the final attempt display 'in progress'.

--  Creates DoubleCourses View, shows which students have taken 2 classes 
Create View DoubleCourses as 
SELECT StudentID, CourseOffered.CourseID,
		COUNT(CourseOffered.CourseID) AS CourseCount 
FROM StudentCourseEnrollment
	JOIN CourseOffered
	ON	 StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
Group By StudentID, CourseOffered.CourseID
HAVING COUNT(CourseOffered.CourseID) > 1
go


 --- Select which StudentID and CourseID to see grades 

SELECT StudentID, Grade, StudentCourseEnrollment.TermID, StudentCourseEnrollment.CourseOfferedID, CourseID
FROM StudentCourseEnrollment
	JOIN CourseOffered
	ON	 StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
Where StudentID = 78 AND CourseID = 205

SELECT StudentID, Grade, StudentCourseEnrollment.TermID, StudentCourseEnrollment.CourseOfferedID, CourseID
FROM StudentCourseEnrollment
	JOIN CourseOffered
	ON	 StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
Where StudentID = 95 AND CourseID = 205

SELECT StudentID, Grade, StudentCourseEnrollment.TermID, StudentCourseEnrollment.CourseOfferedID, CourseID
FROM StudentCourseEnrollment
	JOIN CourseOffered
	ON	 StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
Where StudentID = 73 AND CourseID = 216

SELECT StudentID, Grade, StudentCourseEnrollment.TermID, StudentCourseEnrollment.CourseOfferedID, CourseID
FROM StudentCourseEnrollment
	JOIN CourseOffered
	ON	 StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
Where StudentID = 42 AND CourseID = 256

SELECT StudentID, Grade, StudentCourseEnrollment.TermID, StudentCourseEnrollment.CourseOfferedID, CourseID
FROM StudentCourseEnrollment
	JOIN CourseOffered
	ON	 StudentCourseEnrollment.CourseOfferedID = CourseOffered.CourseOfferedID
Where StudentID = 59  AND CourseID = 256


