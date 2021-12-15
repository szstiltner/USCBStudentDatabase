--Programmer: Zack Stiltner, Michael Marcario, Tgaja Johnson
--Course: B320
--Assignment: 14_1


/****** Remove Existing Tables (Ignore errors if no tables exist) ******/
DROP TABLE [dbo].[Instructor];
GO
DROP Table [dbo].[GradeCalculation];
GO
DROP TABLE [dbo].[Location];
GO
DROP Table [dbo].[Term];
GO
DROP Table [dbo].[AcademicStanding];
GO
DROP TABLE [dbo].[Course];
GO
DROP TABLE [dbo].[LookupTable];
GO
DROP TABLE [dbo].[CourseOffered];
GO
DROP Table [dbo].[Student];
GO
DROP TABLE [dbo].[StudentCourseEnrollment];
GO
DROP TABLE [dbo].[QualityPoint];
GO


/****** Create Tables ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Instructor](
	[InstructorID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[InstructorFName] [varchar](50) NOT NULL,
	[InstructorLName] [varchar](50) NOT NULL,
	[InstructorEmail] [varchar](50) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Student](
	[StudentID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[StudentFName] [varchar] (50) NOT NULL,
	[StudentLName] [varchar](50) NOT NULL,
	[Major] [varchar] (50) NOT NULL,
	[StudentEmail] [varchar] (50) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[GradeCalculation](
	[GradeCalculationID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[StudentID] [int] NOT NULL FOREIGN KEY REFERENCES Student(StudentID),
	[TermGPA] [int] NULL,
	[TotalUndergraduateGPA] [int] NULL,
	[TotalGraduateGPA] [int] NULL,
	[AttemptedUndergraduateHours] [int] NULL,
	[EarnedUndergraduateHours] [int] NULL,
	[AttemptedGraduateHours] [int] NULL,
	[EarnedGraduateHours] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Location](
	[LocationID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Campus] [varchar](50) NOT NULL,
	[Building] [varchar](50) NOT NULL,
	[RoomNumber] [varchar](50) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Term](
	[TermID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[Semester] [varchar](50) NOT NULL,
) ON [PRIMARY]
GO



CREATE TABLE [dbo].[AcademicStanding](
	[AcademicStandingID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[StudentID] [int] NOT NULL FOREIGN KEY REFERENCES Student(StudentID),
	[TermID] [int] NOT NULL FOREIGN KEY REFERENCES Term(TermID),
	[Standing] [varchar](50) NOT NULL,
	[StudentLevel] [varchar](50) NOT NULL,
	[StudentType] [varchar](50) NOT NULL,
	[SemesterGPA] [int] NULL,
	[CumulativeGPA] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Course](
	[CourseID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CourseTitle] [varchar](50) NOT NULL,
	[CourseLevel] [int] NOT NULL,
	[College] [varchar](50) NOT NULL,
	[CreditHours] [int] NOT NULL,
	[Campus] [varchar](50) NOT NULL,
	[Prerequisites] [varchar](50) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Department] [varchar](50) NOT NULL,
	[Division] [varchar](50) NOT NULL,
	[LectureHours] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[QualityPoint](
	[QualityPointID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY ,
	[LetterGrade] [varchar] (50) NULL,
	[QualityPoint] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[CourseOffered](
	[CourseOfferedID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CourseID] [int] NOT NULL FOREIGN KEY REFERENCES Course(CourseID),
	[TermID] [int] NOT NULL FOREIGN KEY REFERENCES Term(TermID),
	[InstructorID] [int] NOT NULL FOREIGN KEY REFERENCES Instructor(InstructorID),
	[LocationID] [int] NOT NULL FOREIGN KEY REFERENCES Location(LocationID),
	[InstructionalMethod] [varchar](50) NOT NULL,
	[Type] [varchar] (50) NOT NULL,
	[Time] [int] NOT NULL,
	[Section] [varchar] (50) NOT NULL,
	[ScheduleType] [varchar] (50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[StudentCourseEnrollment](
	[StudentCourseEnrollmentID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[StudentID] [int] NOT NULL FOREIGN KEY REFERENCES Student(StudentID),
	[TermID] [int] NOT NULL FOREIGN KEY REFERENCES Term(TermID),
	[CourseOfferedID] [int] NOT NULL FOREIGN KEY REFERENCES CourseOffered(CourseOfferedID),
	[Grade] [varchar] (50) NOT NULL, -- not sure if this should be null or not null
	[Credits Earned] [int] NOT NULL, -- '' '' 
	[CreditTotal] [int] NOT NULL -- '' '' 
) ON [PRIMARY]
GO

SET IDENTITY_INSERT Student ON 
GO
INSERT INTO Student 
(StudentID, StudentFName, StudentLName, Major, StudentEmail)
VALUES
      (1.0,'Andrew','Reed','CSCI','a.reed@Team1Univsersity.com'),
    (2.0,'Daryl','Hawkins','ISAT','d.hawkins@Team1Univsersity.com'),
    (3.0,'Annabella','Kelley','ISAT','a.kelley@Team1Univsersity.com'),
    (4.0,'Justin','Dixon','ISAT','j.dixon@Team1Univsersity.com'),
    (5.0,'Ryan','Foster','CSCI','r.foster@Team1Univsersity.com'),
    (6.0,'Anna','Kelley','ISAT','a.kelley@Team1Univsersity.com'),
    (7.0,'Sienna','Higgins','ISAT','s.higgins@Team1Univsersity.com'),
    (8.0,'Arianna','Lloyd','CSCI','a.lloyd@Team1Univsersity.com'),
    (9.0,'Nicholas','Lloyd','ISAT','n.lloyd@Team1Univsersity.com'),
    (10.0,'Rafael','Holmes','CSCI','r.holmes@Team1Univsersity.com'),
    (11.0,'Emma','Richardson','ISAT','e.richardson@Team1Univsersity.com'),
    (12.0,'Ryan','Turner','ISAT','r.turner@Team1Univsersity.com'),
    (13.0,'Justin','Evans','CSCI','j.evans@Team1Univsersity.com'),
    (14.0,'Aldus','Anderson','ISAT','a.anderson@Team1Univsersity.com'),
    (15.0,'Alexia','Carroll','ISAT','a.carroll@Team1Univsersity.com'),
    (16.0,'Ashton','Foster','CSCI','a.foster@Team1Univsersity.com'),
    (17.0,'Arianna','Harper','ISAT','a.harper@Team1Univsersity.com'),
    (18.0,'Violet','Roberts','ISAT','v.roberts@Team1Univsersity.com'),
    (19.0,'Carlos','Murphy','ISAT','c.murphy@Team1Univsersity.com'),
    (20.0,'Haris','Hall','ISAT','h.hall@Team1Univsersity.com'),
    (21.0,'Deanna','Wells','ISAT','d.wells@Team1Univsersity.com'),
    (22.0,'Miranda','Reed','CSCI','m.reed@Team1Univsersity.com'),
    (23.0,'Sienna','Stewart','CSCI','s.stewart@Team1Univsersity.com'),
    (24.0,'Savana','Barrett','CSCI','s.barrett@Team1Univsersity.com'),
    (25.0,'Kevin','Foster','CSCI','k.foster@Team1Univsersity.com'),
    (26.0,'Evelyn','Spencer','ISAT','e.spencer@Team1Univsersity.com'),
    (27.0,'Harold','Foster','CSCI','h.foster@Team1Univsersity.com'),
    (28.0,'Adam','Carter','CSCI','a.carter@Team1Univsersity.com'),
    (29.0,'Oscar','Morgan','ISAT','o.morgan@Team1Univsersity.com'),
    (30.0,'Michelle','Hall','CSCI','m.hall@Team1Univsersity.com'),
    (31.0,'Alexander','West','ISAT','a.west@Team1Univsersity.com'),
    (32.0,'Carlos','Jones','ISAT','c.jones@Team1Univsersity.com'),
    (33.0,'Alan','Bennett','CSCI','a.bennett@Team1Univsersity.com'),
    (34.0,'Richard','Harrison','CSCI','r.harrison@Team1Univsersity.com'),
    (35.0,'Alina','Clark','ISAT','a.clark@Team1Univsersity.com'),
    (36.0,'Emma','Holmes','ISAT','e.holmes@Team1Univsersity.com'),
    (37.0,'George','Stevens','ISAT','g.stevens@Team1Univsersity.com'),
    (38.0,'John','Higgins','ISAT','j.higgins@Team1Univsersity.com'),
    (39.0,'Heather','Barnes','ISAT','h.barnes@Team1Univsersity.com'),
    (40.0,'Ada','Davis','ISAT','a.davis@Team1Univsersity.com'),
    (41.0,'Emily','Nelson','ISAT','e.nelson@Team1Univsersity.com'),
    (42.0,'Lucas','Cooper','ISAT','l.cooper@Team1Univsersity.com'),
    (43.0,'Emily','Stevens','ISAT','e.stevens@Team1Univsersity.com'),
    (44.0,'Luke','Brooks','ISAT','l.brooks@Team1Univsersity.com'),
    (45.0,'Adelaide','Lloyd','ISAT','a.lloyd@Team1Univsersity.com'),
    (46.0,'Belinda','Holmes','ISAT','b.holmes@Team1Univsersity.com'),
    (47.0,'Sydney','Hawkins','CSCI','s.hawkins@Team1Univsersity.com'),
    (48.0,'Lily','Murray','CSCI','l.murray@Team1Univsersity.com'),
    (49.0,'Adam','Gray','CSCI','a.gray@Team1Univsersity.com'),
    (50.0,'Elise','Wright','CSCI','e.wright@Team1Univsersity.com'),
    (51.0,'Roland','Smith','ISAT','r.smith@Team1Univsersity.com'),
    (52.0,'Brianna','Phillips','ISAT','b.phillips@Team1Univsersity.com'),
    (53.0,'Alen','Elliott','ISAT','a.elliott@Team1Univsersity.com'),
    (54.0,'Sarah','Johnston','ISAT','s.johnston@Team1Univsersity.com'),
    (55.0,'Alen','Anderson','ISAT','a.anderson@Team1Univsersity.com'),
    (56.0,'Edwin','Morrison','ISAT','e.morrison@Team1Univsersity.com'),
    (57.0,'Alexia','Murphy','ISAT','a.murphy@Team1Univsersity.com'),
    (58.0,'Kelsey','Brooks','ISAT','k.brooks@Team1Univsersity.com'),
    (59.0,'Naomi','Wells','ISAT','n.wells@Team1Univsersity.com'),
    (60.0,'Cherry','Nelson','ISAT','c.nelson@Team1Univsersity.com'),
    (61.0,'Annabella','Foster','ISAT','a.foster@Team1Univsersity.com'),
    (62.0,'Leonardo','Baker','CSCI','l.baker@Team1Univsersity.com'),
    (63.0,'Lilianna','Richards','CSCI','l.richards@Team1Univsersity.com'),
    (64.0,'Amelia','Kelley','ISAT','a.kelley@Team1Univsersity.com'),
    (65.0,'Myra','Holmes','CSCI','m.holmes@Team1Univsersity.com'),
    (66.0,'Edith','Bennett','ISAT','e.bennett@Team1Univsersity.com'),
    (67.0,'Sydney','Miller','CSCI','s.miller@Team1Univsersity.com'),
    (68.0,'Alexia','Douglas','CSCI','a.douglas@Team1Univsersity.com'),
    (69.0,'Alberta','Evans','ISAT','a.evans@Team1Univsersity.com'),
    (70.0,'Victor','Elliott','ISAT','v.elliott@Team1Univsersity.com'),
    (71.0,'Frederick','Martin','ISAT','f.martin@Team1Univsersity.com'),
    (72.0,'Clark','Wells','CSCI','c.wells@Team1Univsersity.com'),
    (73.0,'Audrey','Sullivan','ISAT','a.sullivan@Team1Univsersity.com'),
    (74.0,'Lily','Clark','CSCI','l.clark@Team1Univsersity.com'),
    (75.0,'Reid','Roberts','ISAT','r.roberts@Team1Univsersity.com'),
    (76.0,'Frederick','Mason','CSCI','f.mason@Team1Univsersity.com'),
    (77.0,'Arthur','Thompson','CSCI','a.thompson@Team1Univsersity.com'),
    (78.0,'Leonardo','Payne','ISAT','l.payne@Team1Univsersity.com'),
    (79.0,'Derek','Gray','ISAT','d.gray@Team1Univsersity.com'),
    (80.0,'Miller','Clark','CSCI','m.clark@Team1Univsersity.com'),
    (81.0,'Annabella','Bailey','ISAT','a.bailey@Team1Univsersity.com'),
    (82.0,'Florrie','Douglas','CSCI','f.douglas@Team1Univsersity.com'),
    (83.0,'Alen','Fowler','ISAT','a.fowler@Team1Univsersity.com'),
    (84.0,'Isabella','Thompson','CSCI','i.thompson@Team1Univsersity.com'),
    (85.0,'Lana','Carroll','ISAT','l.carroll@Team1Univsersity.com'),
    (86.0,'Dale','Anderson','ISAT','d.anderson@Team1Univsersity.com'),
    (87.0,'Sienna','Martin','ISAT','s.martin@Team1Univsersity.com'),
    (88.0,'Victoria','Harris','ISAT','v.harris@Team1Univsersity.com'),
    (89.0,'Kimberly','Lloyd','ISAT','k.lloyd@Team1Univsersity.com'),
    (90.0,'Ellia','Barrett','CSCI','e.barrett@Team1Univsersity.com'),
    (91.0,'Steven','Harris','ISAT','s.harris@Team1Univsersity.com'),
    (92.0,'Samantha','Carroll','CSCI','s.carroll@Team1Univsersity.com'),
    (93.0,'Fiona','Baker','CSCI','f.baker@Team1Univsersity.com'),
    (94.0,'April','Martin','ISAT','a.martin@Team1Univsersity.com'),
    (95.0,'Carina','Grant','CSCI','c.grant@Team1Univsersity.com'),
    (96.0,'Gianna','Martin','ISAT','g.martin@Team1Univsersity.com'),
    (97.0,'Jasmine','Stewart','CSCI','j.stewart@Team1Univsersity.com'),
    (98.0,'Miley','Chapman','CSCI','m.chapman@Team1Univsersity.com'),
    (99.0,'Olivia','Hall','CSCI','o.hall@Team1Univsersity.com'),
    (100.0,'Amanda','Miller','ISAT','a.miller@Team1Univsersity.com'),
    (101.0,'Alberta','Miller','ISAT','a.miller@Team1Univsersity.com'),
    (102.0,'Ted','Murphy','ISAT','t.murphy@Team1Univsersity.com'),
    (103.0,'Lyndon','Perkins','ISAT','l.perkins@Team1Univsersity.com'),
    (104.0,'Alisa','Edwards','ISAT','a.edwards@Team1Univsersity.com'),
    (105.0,'Jordan','Brooks','ISAT','j.brooks@Team1Univsersity.com'),
    (106.0,'Melissa','Chapman','ISAT','m.chapman@Team1Univsersity.com'),
    (107.0,'Aiden','Harrison','CSCI','a.harrison@Team1Univsersity.com'),
    (108.0,'Sydney','Stevens','ISAT','s.stevens@Team1Univsersity.com'),
    (109.0,'Sophia','Dixon','ISAT','s.dixon@Team1Univsersity.com'),
    (110.0,'Rubie','Johnson','CSCI','r.johnson@Team1Univsersity.com'),
    (111.0,'Tess','Perry','CSCI','t.perry@Team1Univsersity.com'),
    (112.0,'Walter','Howard','CSCI','w.howard@Team1Univsersity.com'),
    (113.0,'James','Cunningham','ISAT','j.cunningham@Team1Univsersity.com'),
    (114.0,'Alina','Howard','CSCI','a.howard@Team1Univsersity.com'),
    (115.0,'Brooke','Kelly','ISAT','b.kelly@Team1Univsersity.com'),
    (116.0,'Lenny','Edwards','ISAT','l.edwards@Team1Univsersity.com'),
    (117.0,'Blake','Hill','CSCI','b.hill@Team1Univsersity.com'),
    (118.0,'Amy','Allen','ISAT','a.allen@Team1Univsersity.com'),
    (119.0,'Blake','Harrison','ISAT','b.harrison@Team1Univsersity.com'),
    (120.0,'Lucia','Warren','CSCI','l.warren@Team1Univsersity.com'),
    (121.0,'Jenna','Edwards','CSCI','j.edwards@Team1Univsersity.com'),
    (122.0,'Oliver','Ferguson','CSCI','o.ferguson@Team1Univsersity.com'),
    (123.0,'Alberta','Johnson','CSCI','a.johnson@Team1Univsersity.com'),
    (124.0,'Alisa','Mason','CSCI','a.mason@Team1Univsersity.com'),
    (125.0,'Sabrina','Ellis','CSCI','s.ellis@Team1Univsersity.com'),
    (126.0,'Michael','Barnes','ISAT','m.barnes@Team1Univsersity.com'),
    (127.0,'Lenny','Armstrong','CSCI','l.armstrong@Team1Univsersity.com'),
    (128.0,'Justin','Cunningham','ISAT','j.cunningham@Team1Univsersity.com'),
    (129.0,'Garry','West','ISAT','g.west@Team1Univsersity.com'),
    (130.0,'David','Turner','ISAT','d.turner@Team1Univsersity.com'),
    (131.0,'Cherry','Stewart','ISAT','c.stewart@Team1Univsersity.com'),
    (132.0,'William','Brooks','CSCI','w.brooks@Team1Univsersity.com'),
    (133.0,'Edwin','Harrison','ISAT','e.harrison@Team1Univsersity.com'),
    (134.0,'Aiden','Smith','ISAT','a.smith@Team1Univsersity.com'),
    (135.0,'Eleanor','Kelley','ISAT','e.kelley@Team1Univsersity.com'),
    (136.0,'Lilianna','Thompson','CSCI','l.thompson@Team1Univsersity.com'),
    (137.0,'Freddie','Alexander','ISAT','f.alexander@Team1Univsersity.com'),
    (138.0,'Jasmine','Ryan','ISAT','j.ryan@Team1Univsersity.com'),
    (139.0,'Alfred','Wells','CSCI','a.wells@Team1Univsersity.com'),
    (140.0,'Paul','Nelson','CSCI','p.nelson@Team1Univsersity.com'),
    (141.0,'Cherry','Carter','ISAT','c.carter@Team1Univsersity.com'),
    (142.0,'Edwin','Ross','ISAT','e.ross@Team1Univsersity.com'),
    (143.0,'Ada','Perkins','ISAT','a.perkins@Team1Univsersity.com'),
    (144.0,'William','Davis','CSCI','w.davis@Team1Univsersity.com'),
    (145.0,'Bruce','Thompson','CSCI','b.thompson@Team1Univsersity.com'),
    (146.0,'Carl','Lloyd','CSCI','c.lloyd@Team1Univsersity.com'),
    (147.0,'Clark','Turner','ISAT','c.turner@Team1Univsersity.com'),
    (148.0,'Chester','Casey','CSCI','c.casey@Team1Univsersity.com'),
    (149.0,'Victor','Ferguson','CSCI','v.ferguson@Team1Univsersity.com'),
    (150.0,'Adelaide','Watson','CSCI','a.watson@Team1Univsersity.com'),
    (151.0,'Michael','Carter','ISAT','m.carter@Team1Univsersity.com'),
    (152.0,'Lily','Gibson','CSCI','l.gibson@Team1Univsersity.com'),
    (153.0,'Miley','Howard','ISAT','m.howard@Team1Univsersity.com'),
    (154.0,'Jared','Gray','ISAT','j.gray@Team1Univsersity.com'),
    (155.0,'Hailey','Carter','CSCI','h.carter@Team1Univsersity.com'),
    (156.0,'Briony','Morrison','ISAT','b.morrison@Team1Univsersity.com'),
    (157.0,'Eleanor','Crawford','ISAT','e.crawford@Team1Univsersity.com'),
    (158.0,'Kevin','Baker','ISAT','k.baker@Team1Univsersity.com'),
    (159.0,'Naomi','Barrett','ISAT','n.barrett@Team1Univsersity.com'),
    (160.0,'Vincent','Baker','CSCI','v.baker@Team1Univsersity.com'),
    (161.0,'Dainton','Williams','CSCI','d.williams@Team1Univsersity.com'),
    (162.0,'Justin','Riley','ISAT','j.riley@Team1Univsersity.com'),
    (163.0,'Tess','Baker','ISAT','t.baker@Team1Univsersity.com'),
    (164.0,'Andrew','Armstrong','CSCI','a.armstrong@Team1Univsersity.com'),
    (165.0,'Grace','Barrett','ISAT','g.barrett@Team1Univsersity.com'),
    (166.0,'Arnold','Miller','ISAT','a.miller@Team1Univsersity.com'),
    (167.0,'Sam','Chapman','ISAT','s.chapman@Team1Univsersity.com'),
    (168.0,'April','Wilson','CSCI','a.wilson@Team1Univsersity.com'),
    (169.0,'Alexander','Rogers','ISAT','a.rogers@Team1Univsersity.com'),
    (170.0,'Alissa','Ross','CSCI','a.ross@Team1Univsersity.com'),
    (171.0,'Adelaide','Evans','ISAT','a.evans@Team1Univsersity.com'),
    (172.0,'Luke','Cameron','CSCI','l.cameron@Team1Univsersity.com'),
    (173.0,'Alexia','Smith','CSCI','a.smith@Team1Univsersity.com'),
    (174.0,'Tiana','Scott','ISAT','t.scott@Team1Univsersity.com'),
    (175.0,'Daisy','Lloyd','CSCI','d.lloyd@Team1Univsersity.com'),
    (176.0,'Frederick','Miller','ISAT','f.miller@Team1Univsersity.com'),
    (177.0,'Ashton','Crawford','CSCI','a.crawford@Team1Univsersity.com'),
    (178.0,'Roman','Casey','CSCI','r.casey@Team1Univsersity.com'),
    (179.0,'Kellan','Gibson','ISAT','k.gibson@Team1Univsersity.com'),
    (180.0,'Stella','Johnston','ISAT','s.johnston@Team1Univsersity.com'),
    (181.0,'Amanda','Riley','ISAT','a.riley@Team1Univsersity.com'),
    (182.0,'Carlos','Montgomery','CSCI','c.montgomery@Team1Univsersity.com'),
    (183.0,'Dominik','Davis','ISAT','d.davis@Team1Univsersity.com'),
    (184.0,'Agata','Payne','CSCI','a.payne@Team1Univsersity.com'),
    (185.0,'Patrick','Smith','ISAT','p.smith@Team1Univsersity.com'),
    (186.0,'Annabella','Henderson','CSCI','a.henderson@Team1Univsersity.com'),
    (187.0,'Lucia','Gibson','ISAT','l.gibson@Team1Univsersity.com'),
    (188.0,'Edgar','Watson','ISAT','e.watson@Team1Univsersity.com'),
    (189.0,'Julian','Taylor','ISAT','j.taylor@Team1Univsersity.com'),
    (190.0,'Alberta','Scott','ISAT','a.scott@Team1Univsersity.com'),
    (191.0,'Ellia','Richardson','ISAT','e.richardson@Team1Univsersity.com'),
    (192.0,'Byron','Baker','ISAT','b.baker@Team1Univsersity.com'),
    (193.0,'David','Howard','CSCI','d.howard@Team1Univsersity.com'),
    (194.0,'Rubie','Watson','ISAT','r.watson@Team1Univsersity.com'),
    (195.0,'Derek','Payne','ISAT','d.payne@Team1Univsersity.com'),
    (196.0,'Kelsey','Murphy','CSCI','k.murphy@Team1Univsersity.com'),
    (197.0,'Haris','Higgins','ISAT','h.higgins@Team1Univsersity.com'),
    (198.0,'Julia','Edwards','ISAT','j.edwards@Team1Univsersity.com'),
    (199.0,'Daniel','Rogers','ISAT','d.rogers@Team1Univsersity.com'),
    (200.0,'Stuart','Craig','ISAT','s.craig@Team1Univsersity.com');
SET IDENTITY_INSERT Student OFF 
GO

SET IDENTITY_INSERT Instructor ON 
GO
INSERT INTO Instructor (InstructorID, InstructorFName, InstructorLName, InstructorEmail)
VALUES
    (1,'Abraham','Anton','A.Abraham@Team1University.com'),
    (2,'Ahmed','Kishwar','K.Ahmed@Team1University.com'),
    (3,'Albanese','Debra L.','D.Albanese@Team1University.com'),
    (4,'Alvarez','Beda E.','B.Alvarez@Team1University.com'),
    (5,'Angell','Eliot J.','E.Angell@Team1University.com'),
    (6,'Barberio','Janae','J.Barberio@Team1University.com'),
    (7,'Barnes','Mollie E.','M.Barnes@Team1University.com'),
    (8,'Barnett','Andrietta W.','A.Barnett@Team1University.com'),
    (9,'Barth','Sean M.','S.Barth@Team1University.com'),
    (10,'Bartlett','Diane H.','D.Bartlett@Team1University.com'),
    (11,'Becker','Howard S.','H.Becker@Team1University.com'),
    (12,'Beck-Ungvarsky','Colleen','C.Beck-Ungvarsky@Team1University.com'),
    (13,'Bessent','Laura M.','L.Bessent@Team1University.com'),
    (14,'Beverung','Susan E.','S.Beverung@Team1University.com'),
    (15,'Biddell','Melba M.','M.Biddell@Team1University.com'),
    (16,'Bishop','Whitney','W.Bishop@Team1University.com'),
    (17,'Blawat','Candice','C.Blawat@Team1University.com'),
    (18,'Bliemeister','Marie A.','M.Bliemeister@Team1University.com'),
    (19,'Bloom','Brad L.','B.Bloom@Team1University.com'),
    (20,'Bond','Christopher','C.Bond@Team1University.com'),
    (21,'Borders','Andrew J.','A.Borders@Team1University.com'),
    (22,'Borgianini','Stephen A.','S.Borgianini@Team1University.com'),
    (23,'Borton','Brett A.','B.Borton@Team1University.com'),
    (24,'Bouthillet','Kelly A.','K.Bouthillet@Team1University.com'),
    (25,'Bowen','John R.','J.Bowen@Team1University.com'),
    (26,'Bowers','William K.','W.Bowers@Team1University.com'),
    (27,'Brame','Benjamin','B.Brame@Team1University.com'),
    (28,'Brandt','Kenneth C.','K.Brandt@Team1University.com'),
    (29,'Brooks','Gary T.','G.Brooks@Team1University.com'),
    (30,'Brugler','Mercer R.','M.Brugler@Team1University.com'),
    (31,'Bryan','Jessica W.','J.Bryan@Team1University.com'),
    (32,'Burks-Hale','Nikita M.','N.Burks-Hale@Team1University.com'),
    (33,'Burns','Eric V.','E.Burns@Team1University.com'),
    (34,'Bushey','Dean E.','D.Bushey@Team1University.com'),
    (35,'Butler','Chesanny','C.Butler@Team1University.com'),
    (36,'Calvert','Charles L.','C.Calvert@Team1University.com'),
    (37,'Canada','Brian A.','B.Canada@Team1University.com'),
    (38,'Capello','Rebecca K.','R.Capello@Team1University.com'),
    (39,'Carberry','Patrick J.','P.Carberry@Team1University.com'),
    (40,'Carrington','Matthew R.','M.Carrington@Team1University.com'),
    (41,'Carroll','Teresa M.','T.Carroll@Team1University.com'),
    (42,'Catma','Serkan','S.Catma@Team1University.com'),
    (43,'Cavanagh','Kimberly K.','K.Cavanagh@Team1University.com'),
    (44,'Cheatham','Tracy','T.Cheatham@Team1University.com'),
    (45,'Chiacchiero','John','J.Chiacchiero@Team1University.com'),
    (46,'Chojnowski','Jena','J.Chojnowski@Team1University.com'),
    (47,'Cifaldi','Barbara H.','B.Cifaldi@Team1University.com'),
    (48,'Ciresi','Lisa V.','L.Ciresi@Team1University.com'),
    (49,'Coccia','Joseph S.','J.Coccia@Team1University.com'),
    (50,'Cohan','Deborah J.','D.Cohan@Team1University.com'),
    (51,'Collins','Leslie R.','L.Collins@Team1University.com'),
    (52,'Cooper Ward','Dafina M.','D.Cooper Ward@Team1University.com'),
    (53,'Councell','Laura D.','L.Councell@Team1University.com'),
    (54,'Crews','Virginia G.','V.Crews@Team1University.com'),
    (55,'Cudahy','Brian J.','B.Cudahy@Team1University.com'),
    (56,'Culbertson','Brittany S.','B.Culbertson@Team1University.com'),
    (57,'D''Antonio','Jennifer','J.D''Antonio@Team1University.com'),
    (58,'Darden','Mary','M.Darden@Team1University.com'),
    (59,'Daugherty','Crystal','C.Daugherty@Team1University.com'),
    (60,'Davis-Wright','Joan M.','J.Davis-Wright@Team1University.com'),
    (61,'Dawson','Audrey R.','A.Dawson@Team1University.com'),
    (62,'Deaton','William','W.Deaton@Team1University.com'),
    (63,'Debroy','Swati','S.Debroy@Team1University.com'),
    (64,'Deming','Emily H.','E.Deming@Team1University.com'),
    (65,'Demir','Firuz','F.Demir@Team1University.com'),
    (66,'Deneeve','Ian K.','I.Deneeve@Team1University.com'),
    (67,'Dennison','Doriann H.','D.Dennison@Team1University.com'),
    (68,'Dopf','Kevin C.','K.Dopf@Team1University.com'),
    (69,'Downey','David A.','D.Downey@Team1University.com'),
    (70,'Draud','Travis E.','T.Draud@Team1University.com'),
    (71,'Dudas','Kimberly','K.Dudas@Team1University.com'),
    (72,'Ember','Leon M.','L.Ember@Team1University.com'),
    (73,'Erdei','Ronald','R.Erdei@Team1University.com'),
    (74,'Ezedi','Shannel','S.Ezedi@Team1University.com'),
    (75,'Faciszewski','Nanette J.','N.Faciszewski@Team1University.com'),
    (76,'Fairchild','Jennifer L.','J.Fairchild@Team1University.com'),
    (77,'Farrell','Carmen B.','C.Farrell@Team1University.com'),
    (78,'Fazio','Gia','G.Fazio@Team1University.com'),
    (79,'Ferguson','Ashley N.','A.Ferguson@Team1University.com'),
    (80,'Fitzgerald','Carey J.','C.Fitzgerald@Team1University.com'),
    (81,'Fletcher','Wesla L.','W.Fletcher@Team1University.com'),
    (82,'Flowers','Cynthia','C.Flowers@Team1University.com'),
    (83,'Fusi','Davide','D.Fusi@Team1University.com'),
    (84,'Gaither','Bernard T.','B.Gaither@Team1University.com'),
    (85,'Galloway','Kimberly A.','K.Galloway@Team1University.com'),
    (86,'Garbarino','Charles L.','C.Garbarino@Team1University.com'),
    (87,'Gibson','Ian B.','I.Gibson@Team1University.com'),
    (88,'Glassman','Tavis J.','T.Glassman@Team1University.com'),
    (89,'Glasson','James P.','J.Glasson@Team1University.com'),
    (90,'Godowns','Katie L.','K.Godowns@Team1University.com'),
    (91,'Gordon','Michelle S.','M.Gordon@Team1University.com'),
    (92,'Griesse','James M.','J.Griesse@Team1University.com'),
    (93,'Haering','Samantha J.','S.Haering@Team1University.com'),
    (94,'Halbert','Lee-Ann','L.Halbert@Team1University.com'),
    (95,'Hall','Kristen N.','K.Hall@Team1University.com'),
    (96,'Hamilton','Chad O.','C.Hamilton@Team1University.com'),
    (97,'Hammond','Elizabeth .','E.Hammond@Team1University.com'),
    (98,'Hampson','Courtney E.','C.Hampson@Team1University.com'),
    (99,'Harris','Colleen','C.Harris@Team1University.com'),
    (100,'Hart','Barbara L.','B.Hart@Team1University.com'),
    (101,'Hartley','Kyra L.','K.Hartley@Team1University.com'),
    (102,'Heiens','Richard A.','R.Heiens@Team1University.com'),
    (103,'Henshaw','William','W.Henshaw@Team1University.com'),
    (104,'Henz','Thomas','T.Henz@Team1University.com'),
    (105,'Hoffer','Lauren N.','L.Hoffer@Team1University.com'),
    (106,'Hogenboom','Timothy J.','T.Hogenboom@Team1University.com'),
    (107,'Holland','Alice R.','A.Holland@Team1University.com'),
    (108,'Holmes','Gloria G.','G.Holmes@Team1University.com'),
    (109,'Holt','Jan R.','J.Holt@Team1University.com'),
    (110,'Hoy','Kathryn I.','K.Hoy@Team1University.com'),
    (111,'Hritz','Nancy M.','N.Hritz@Team1University.com'),
    (112,'Hunnicutt','Melodie A.','M.Hunnicutt@Team1University.com'),
    (113,'Hutchison','Lynne M.','L.Hutchison@Team1University.com'),
    (114,'Iglesias','Jose Luis C.','J.Iglesias@Team1University.com'),
    (115,'Iliff','Joel R.','J.Iliff@Team1University.com'),
    (116,'Ingram','Carole T.','C.Ingram@Team1University.com'),
    (117,'Iwasa','Akira','A.Iwasa@Team1University.com'),
    (118,'Jacobs','Melissa','M.Jacobs@Team1University.com'),
    (119,'James','Timothy M.','T.James@Team1University.com'),
    (120,'Ji','Yiming','Y.Ji@Team1University.com'),
    (121,'Johnson','Elizabeth L.','E.Johnson@Team1University.com'),
    (122,'Jones Williams','Morgin','M.Jones Williams@Team1University.com'),
    (123,'Keats','Kim L.','K.Keats@Team1University.com'),
    (124,'Keith','Charles H.','C.Keith@Team1University.com'),
    (125,'Kilgore','Robert E.','R.Kilgore@Team1University.com'),
    (126,'King','Kimberly','K.King@Team1University.com'),
    (127,'Knapp','Sandra K.','S.Knapp@Team1University.com'),
    (128,'Kramer','Maria G.','M.Kramer@Team1University.com'),
    (129,'Kratky','Rena L.','R.Kratky@Team1University.com'),
    (130,'Krebs','Salome L.','S.Krebs@Team1University.com'),
    (131,'Kuehn','Joanne','J.Kuehn@Team1University.com'),
    (132,'Kunkle','Amy','A.Kunkle@Team1University.com'),
    (133,'Lahar','Cindy J.','C.Lahar@Team1University.com'),
    (134,'Lamkin','Randolph','R.Lamkin@Team1University.com'),
    (135,'Lancaster','Holli L.','H.Lancaster@Team1University.com'),
    (136,'Landrum','Robert H.','R.Landrum@Team1University.com'),
    (137,'Leadem','John J.','J.Leadem@Team1University.com'),
    (138,'Leaphart','Amy E.','A.Leaphart@Team1University.com'),
    (139,'Lefavi','Robert G.','R.Lefavi@Team1University.com'),
    (140,'Liang','Xuwei','X.Liang@Team1University.com'),
    (141,'Lilley','Wayne R.','W.Lilley@Team1University.com'),
    (142,'Logan','Deborah L.','D.Logan@Team1University.com'),
    (143,'Logue','Lindsey N.','L.Logue@Team1University.com'),
    (144,'Long','Barry O.','B.Long@Team1University.com'),
    (145,'Lott','Robert A.','R.Lott@Team1University.com'),
    (146,'Lotz','Diana L.','D.Lotz@Team1University.com'),
    (147,'Love','Christopher B.','C.Love@Team1University.com'),
    (148,'Lovell','Laurie L.','L.Lovell@Team1University.com'),
    (149,'Lundin','John H.','J.Lundin@Team1University.com'),
    (150,'Macdonell','Gregory M.','G.Macdonell@Team1University.com'),
    (151,'Mack','Ahron J.','A.Mack@Team1University.com'),
    (152,'Madden','Kathryn R.','K.Madden@Team1University.com'),
    (153,'Malphrus','P. Ellen','P.Malphrus@Team1University.com'),
    (154,'Marlowe','Bruce A.','B.Marlowe@Team1University.com'),
    (155,'Marshall','Iii','I.Marshall@Team1University.com'),
    (156,'Mathe','Alison M.','A.Mathe@Team1University.com'),
    (157,'Mayer','Alyssa B.','A.Mayer@Team1University.com'),
    (158,'McCombs','Kelly L.','K.McCombs@Team1University.com'),
    (159,'McCoy','Erin','E.McCoy@Team1University.com'),
    (160,'McGee','Lynn W.','L.McGee@Team1University.com'),
    (161,'McIlveene','Martha L.','M.McIlveene@Team1University.com'),
    (162,'McQuillen','Jeffrey P.','J.McQuillen@Team1University.com'),
    (163,'Meriwether','Anna T.','A.Meriwether@Team1University.com'),
    (164,'Mills','John A.','J.Mills@Team1University.com'),
    (165,'Mincey','Rhonda G.','R.Mincey@Team1University.com'),
    (166,'Montie','Eric W.','E.Montie@Team1University.com'),
    (167,'Moore','Kasie','K.Moore@Team1University.com'),
    (168,'Morgan','Daniel R.','D.Morgan@Team1University.com'),
    (169,'Morman','Carly F.','C.Morman@Team1University.com'),
    (170,'Morris','Joseph B.','J.Morris@Team1University.com'),
    (171,'Munaco','Lori A.','L.Munaco@Team1University.com'),
    (172,'Myers','Gwen D.','G.Myers@Team1University.com'),
    (173,'Nadeau','Angela L.','A.Nadeau@Team1University.com'),
    (174,'Nagid','Stefanie M.','S.Nagid@Team1University.com'),
    (175,'Nash','Barbara A.','B.Nash@Team1University.com'),
    (176,'Nelson','Benjamin J.','B.Nelson@Team1University.com'),
    (177,'Newton','Megan .','M.Newton@Team1University.com'),
    (178,'Olivetti','Kerri A.','K.Olivetti@Team1University.com'),
    (179,'Palmer','Kirsten P.','K.Palmer@Team1University.com'),
    (180,'Pate','George J.','G.Pate@Team1University.com'),
    (181,'Pawelek','Lukasz D.','L.Pawelek@Team1University.com'),
    (182,'Peek','Mary R.','M.Peek@Team1University.com'),
    (183,'Penner','Chad R.','C.Penner@Team1University.com'),
    (184,'Petrucci','Joan M.','J.Petrucci@Team1University.com'),
    (185,'Pettay','Daniel T.','D.Pettay@Team1University.com'),
    (186,'Phillips','Pamela A.','P.Phillips@Team1University.com'),
    (187,'Ponder','Anna K.','A.Ponder@Team1University.com'),
    (188,'Prestby','Kelly','K.Prestby@Team1University.com'),
    (189,'Randazzo','Rebecca A.','R.Randazzo@Team1University.com'),
    (190,'Reindl','Diana','D.Reindl@Team1University.com'),
    (191,'Reynolds','Alison A.','A.Reynolds@Team1University.com'),
    (192,'Ricardo','Elizabeth','E.Ricardo@Team1University.com'),
    (193,'Ritchie','Kimberly B.','K.Ritchie@Team1University.com'),
    (194,'Rizzi','Maryanne V.','M.Rizzi@Team1University.com'),
    (195,'Roberts','Summer C.','S.Roberts@Team1University.com'),
    (196,'Robertson','Alyssa','A.Robertson@Team1University.com'),
    (197,'Robinson','Dawn M.','D.Robinson@Team1University.com'),
    (198,'Rogers','Stephen E.','S.Rogers@Team1University.com'),
    (199,'Rosswurm','Jacqueline M.','J.Rosswurm@Team1University.com'),
    (200,'Rough','Theresa N.','T.Rough@Team1University.com'),
    (201,'Runyan','Catherine F.','C.Runyan@Team1University.com'),
    (202,'Safdi','Tabitha L.','T.Safdi@Team1University.com'),
    (203,'Salazar','John P.','J.Salazar@Team1University.com'),
    (204,'Sanchez','Alexander R.','A.Sanchez@Team1University.com'),
    (205,'Sanders','Manuel J.','M.Sanders@Team1University.com'),
    (206,'Satterfield-Price','Julie','J.Satterfield-Price@Team1University.com'),
    (207,'Savidge','Laurie A.','L.Savidge@Team1University.com'),
    (208,'Sawyer','Caroline','C.Sawyer@Team1University.com'),
    (209,'Serieux','Elizabeth','E.Serieux@Team1University.com'),
    (210,'Sevim','Volkan','V.Sevim@Team1University.com'),
    (211,'Shaffer','Judith M.','J.Shaffer@Team1University.com'),
    (212,'Shay','Heather','H.Shay@Team1University.com'),
    (213,'Shelley','Justin','J.Shelley@Team1University.com'),
    (214,'Shroyer','Ashley R.','A.Shroyer@Team1University.com'),
    (215,'Sidletsky','James','J.Sidletsky@Team1University.com'),
    (216,'Singleton-Murray','Juanita','J.Singleton-Murray@Team1University.com'),
    (217,'Sisino','Andrea R.','A.Sisino@Team1University.com'),
    (218,'Skees','Murray W.','M.Skees@Team1University.com'),
    (219,'Skipper','George E.','G.Skipper@Team1University.com'),
    (220,'Smith','George','G.Smith@Team1University.com'),
    (221,'Spetrino','William A.','W.Spetrino@Team1University.com'),
    (222,'Spirrison','Charles L.','C.Spirrison@Team1University.com'),
    (223,'Staton','Joseph L.','J.Staton@Team1University.com'),
    (224,'Stuart','Aurel E.','A.Stuart@Team1University.com'),
    (225,'Sturgis','Cynthia L.','C.Sturgis@Team1University.com'),
    (226,'Summa','Caroline A.','C.Summa@Team1University.com'),
    (227,'Swehla','Tessa S.','T.Swehla@Team1University.com'),
    (228,'Swift','Peter E.','P.Swift@Team1University.com'),
    (229,'Swofford','Sarah C.','S.Swofford@Team1University.com'),
    (230,'Teixeira','Ana C.','A.Teixeira@Team1University.com'),
    (231,'Thomas','Najmah','N.Thomas@Team1University.com'),
    (232,'Thompson','Jody A.','J.Thompson@Team1University.com'),
    (233,'Thornton','Heather L.','H.Thornton@Team1University.com'),
    (234,'Thrasher','William J.','W.Thrasher@Team1University.com'),
    (235,'Tompkins','Renarta H.','R.Tompkins@Team1University.com'),
    (236,'Toot','Abbey D.','A.Toot@Team1University.com'),
    (237,'Trask','Mary C.','M.Trask@Team1University.com'),
    (238,'Vane','Shannon','S.Vane@Team1University.com'),
    (239,'Vargo','Lori J.','L.Vargo@Team1University.com'),
    (240,'Villena-Alvarez','Juanita I.','J.Villena-Alvarez@Team1University.com'),
    (241,'Violette','Jayne L.','J.Violette@Team1University.com'),
    (242,'Vogel','Christoph A.','C.Vogel@Team1University.com'),
    (243,'Wallace','Debra J.','D.Wallace@Team1University.com'),
    (244,'Warren','David A.','D.Warren@Team1University.com'),
    (245,'Washington','Jayln A.','J.Washington@Team1University.com'),
    (246,'Weatherhead','Nora K.','N.Weatherhead@Team1University.com'),
    (247,'Wheeler','Jana L.','J.Wheeler@Team1University.com'),
    (248,'Whewell','Aubrey','A.Whewell@Team1University.com'),
    (249,'Williams','Ellen H.','E.Williams@Team1University.com'),
    (250,'Wilson','Linda B.','L.Wilson@Team1University.com');
INSERT INTO Instructor (InstructorID, InstructorFName, InstructorLName, InstructorEmail)
VALUES
    (251,'Wing','Amber M.','A.Wing@Team1University.com'),
    (252,'Wise','Stephen','S.Wise@Team1University.com'),
    (253,'Woods','Gabriel L.','G.Woods@Team1University.com'),
    (254,'Wright','Brandon J.','B.Wright@Team1University.com'),
    (255,'Yang','Zhao','Z.Yang@Team1University.com'),
    (256,'Yeoman','Diane M.','D.Yeoman@Team1University.com'),
    (257,'Zehrung','Trisha M.','T.Zehrung@Team1University.com'),
    (258,'Zhang','Xiaomei','X.Zhang@Team1University.com'),
    (259,'Zientek','Patricia','P.Zientek@Team1University.com');
SET IDENTITY_INSERT Instructor OFF 
GO

SET IDENTITY_INSERT Location ON 
GO
INSERT INTO Location (LocationID, Campus, Building, RoomNumber)
VALUES
    (1,'Beaufort','HARG','162'),
    (2,'Beaufort','LIBR2','241'),
    (3,'Beaufort','SCITEC','123'),
    (4,'Beaufort','SCITEC','122'),
    (5,'Beaufort','2WEB','1'),
    (6,'Beaufort','HARG','277'),
    (7,'Beaufort','HARG','276'),
    (8,'Beaufort','HARG','270'),
    (9,'Beaufort','HARG','156'),
    (10,'Beaufort','CFA','100'),
    (11,'Beaufort','HARG','204'),
    (12,'Beaufort','CFA','101'),
    (13,'Beaufort','CMPCTR','113'),
    (14,'Beaufort','SCITEC','231'),
    (15,'Beaufort','HARG','159'),
    (16,'Beaufort','HARG','160'),
    (18,'Beaufort','CFA','103'),
    (19,'Beaufort','LIBR2','238'),
    (20,'Beaufort','HARG','271'),
    (21,'Beaufort','HARG','274'),
    (22,'Beaufort','SCITEC','223'),
    (23,'Beaufort','SCITEC','222'),
    (24,'Beaufort','HARG','278'),
    (25,'Beaufort','MSCIE','101'),
    (26,'Beaufort','SCITEC','136'),
    (27,'Beaufort','LIBR2','237'),
    (28,'Beaufort','SCITEC','114'),
    (29,'Beaufort','LIBR2','267'),
    (30,'Beaufort','SCITEC','118'),
    (31,'Beaufort','SCITEC','132'),
    (32,'Beaufort','LIBR2','243'),
    (33,'Beaufort','CMPCTR','148'),
    (34,'Beaufort','HARG','275'),
    (35,'Beaufort','CFA','203'),
    (36,'Beaufort','CFA','201'),
    (37,'Beaufort','ARTS','101'),
    (38,'Beaufort','CFA','116'),
    (39,'Beaufort','SAND','111'),
    (40,'Beaufort','MSCIE','102'),
    (41,'Beaufort','SCITEC','260'),
    (42,'Beaufort','CLIN2','1'),
    (43,'Beaufort','SCITEC','261'),
    (44,'Beaufort','HARG','158'),
    (45,'Beaufort','RECCTR','1'),
    (46,'Beaufort','WEB','BEAUFORT'),
    (47,'Beaufort','HHHC','214'),
    (48,'Beaufort','HHHC','114'),
    (49,'Beaufort','HHHC','104'),
    (50,'Beaufort','HHHC','207'),
    (51,'Beaufort','HHHC','213');
SET IDENTITY_INSERT Location OFF 
GO

SET IDENTITY_INSERT Term ON 
GO
INSERT INTO Term (TermID, StartDate, EndDate, Semester)
VALUES
    (1,'2018-08-23 00:00:00','2018-12-17 00:00:00','Fall'),
    (2,'2019-01-14 00:00:00','2019-05-08 00:00:00','Spring'),
    (3,'2019-08-22 00:00:00','2019-12-16 00:00:00','Fall'),
    (4,'2020-01-13 00:00:00','2020-05-06 00:00:00','Spring'),
    (5,'2020-08-17 00:00:00','2020-12-07 00:00:00','Fall'),
    (6,'2021-01-11 00:00:00','2021-05-05 00:00:00','Spring'),
    (7,'2021-08-19 00:00:00','2021-12-13 00:00:00','Fall'),
    (8,'2022-01-10 00:00:00','2022-05-04 00:00:00','Spring');
	SET IDENTITY_INSERT Term OFF 
GO

