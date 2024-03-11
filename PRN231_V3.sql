/****** Object:  Database [PRN231_V2]    Script Date: 3/11/2024 6:57:32 PM ******/
CREATE DATABASE [PRN231_V2]  (EDITION = 'Standard', SERVICE_OBJECTIVE = 'S0', MAXSIZE = 2 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS, LEDGER = OFF;
GO
ALTER DATABASE [PRN231_V2] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [PRN231_V2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PRN231_V2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PRN231_V2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PRN231_V2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PRN231_V2] SET ARITHABORT OFF 
GO
ALTER DATABASE [PRN231_V2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PRN231_V2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PRN231_V2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PRN231_V2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PRN231_V2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PRN231_V2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PRN231_V2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PRN231_V2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PRN231_V2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PRN231_V2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PRN231_V2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PRN231_V2] SET  MULTI_USER 
GO
ALTER DATABASE [PRN231_V2] SET ENCRYPTION ON
GO
ALTER DATABASE [PRN231_V2] SET QUERY_STORE = ON
GO
ALTER DATABASE [PRN231_V2] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer](
	[AnswerId] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[QuestionId] [int] NULL,
	[IsCorrect] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AnswerId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](255) NOT NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryCourse]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryCourse](
	[CategoryCourseId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NULL,
	[CourseId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryCourseId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[CourseId] [int] NULL,
	[Content] [nvarchar](max) NULL,
	[CommentDate] [datetime] NULL,
	[Status] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Total] [money] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[TestId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[RatingId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[CourseId] [int] NULL,
	[Point] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RatingId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportedComment]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportedComment](
	[ReportedCommentId] [int] IDENTITY(1,1) NOT NULL,
	[CommentId] [int] NOT NULL,
	[UserCommentId] [int] NOT NULL,
	[UserReportId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[ReasonReport] [varchar](max) NULL,
 CONSTRAINT [PK_ReportedComment] PRIMARY KEY CLUSTERED 
(
	[ReportedCommentId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resource]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resource](
	[ResourceId] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Description] [nvarchar](255) NULL,
	[CourseId] [int] NULL,
	[IsFree] [bit] NULL,
	[OrdinalNumber] [int] NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ResourceId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResourceUser]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResourceUser](
	[ResourceUserId] [int] IDENTITY(1,1) NOT NULL,
	[ResourceId] [int] NULL,
	[UserId] [int] NULL,
	[IsComplete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResourceUserId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Test]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test](
	[TestId] [int] IDENTITY(1,1) NOT NULL,
	[TestName] [nvarchar](255) NOT NULL,
	[Time] [int] NULL,
	[PercentPoint] [decimal](5, 2) NULL,
	[CourseId] [int] NULL,
	[Status] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TestId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[RoleId] [int] NULL,
	[Balance] [money] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserCourse]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserCourse](
	[UserCourseId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[CourseId] [int] NULL,
	[IsStudent] [bit] NULL,
	[Status] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserCourseId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTest]    Script Date: 3/11/2024 6:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTest](
	[UserTestId] [int] IDENTITY(1,1) NOT NULL,
	[TestId] [int] NULL,
	[UserId] [int] NULL,
	[Point] [int] NULL,
	[TestDate] [datetime] NULL,
	[TotalTime] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserTestId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Answer] ON 

INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (1, N'AnswerQ1', 1, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (2, N'AnswerQ1', 2, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (4, N'AnswerQ1', 4, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (5, N'AnswerQ1', 5, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (6, N'AnswerQ1', 6, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (7, N'AnswerQ1', 7, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (8, N'AnswerQ1', 8, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (9, N'AnswerQ1', 9, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (10, N'AnswerQ1', 10, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (11, N'AnswerQ1', 11, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (12, N'AnswerQ1', 12, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (13, N'AnswerQ1', 13, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (14, N'AnswerQ1', 14, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (15, N'AnswerQ1', 15, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (16, N'AnswerQ1', 16, 0)
SET IDENTITY_INSERT [dbo].[Answer] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [CategoryName], [Status]) VALUES (1, N'Html', NULL)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [Status]) VALUES (2, N'Css', NULL)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [Status]) VALUES (3, N'JavaScript', NULL)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [Status]) VALUES (4, N'C#', NULL)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [Status]) VALUES (5, N'MVC', NULL)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [Status]) VALUES (6, N'Razor', NULL)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [Status]) VALUES (7, N'Google', NULL)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [Status]) VALUES (8, N'Software', NULL)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[CategoryCourse] ON 

INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (1, 8, 1)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (2, 7, 2)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (3, 3, 3)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (4, 1, 5)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (5, 3, 6)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (6, 3, 9)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (10, 2, 5)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (11, 2, 3)
SET IDENTITY_INSERT [dbo].[CategoryCourse] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (3, 1, 1, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (4, 1, 2, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (5, 1, 3, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (6, 6, 4, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (7, 6, 5, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (8, 6, 6, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (9, 8, 7, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (10, 9, 8, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (11, 12, 9, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (12, 12, 8, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (13, 12, 7, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (14, 9, 6, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (15, 8, 7, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (16, 6, 6, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (17, 6, 5, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (18, 8, 4, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (19, 9, 3, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (21, 12, 2, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (23, 12, 1, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (26, 6, 2, N'Good', CAST(N'2024-03-02T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (27, 1, 1, N'HayLam', CAST(N'2024-03-11T15:29:47.137' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (28, 1, 1, N'Test 1', CAST(N'2024-03-11T16:36:25.383' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (29, 1, 1, N'Test 2', CAST(N'2024-03-11T16:38:53.097' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (30, 1, 1, N'Test 3', CAST(N'2024-03-11T16:42:46.933' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (31, 1, 1, N'Test tiep nua ne', CAST(N'2024-03-11T16:43:12.083' AS DateTime), N'1')
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (1, N'Software Enginering', N'The tutorial of developing software', CAST(112.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (2, N'Google Analysis', N'Work with data of Google', CAST(3221.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (3, N'JavaScript Tutorial', N'Basic Java ', CAST(11.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (4, N'Font-End Basic', N'Html, Css Basic', CAST(44.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (5, N'Font-End Normal', N'Start with JavaScript', CAST(332.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (6, N'Font-End High Level', N'Work with React', CAST(1643.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (7, N'Back-End C Sharp', N'Get start with Repository Pattern', CAST(163.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (8, N'Back-End C Sharp Version 2', N'Project MVC', CAST(43.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (9, N'Back-End C Sharp', N'Project Razor', CAST(132.00 AS Decimal(18, 2)), N' ')
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (3, 1, 1, CAST(N'2024-03-09' AS Date), 12.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (4, 6, 2, CAST(N'2024-03-09' AS Date), 133.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (5, 8, 3, CAST(N'2024-03-09' AS Date), 125.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (6, 9, 4, CAST(N'2024-03-09' AS Date), 54.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (7, 12, 5, CAST(N'2024-03-09' AS Date), 57.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (8, 1, 6, CAST(N'2024-03-09' AS Date), 55.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (9, 6, 7, CAST(N'2024-03-09' AS Date), 13.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (10, 8, 8, CAST(N'2024-03-09' AS Date), 553.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (11, 9, 9, CAST(N'2024-03-09' AS Date), 332.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (12, 12, 1, CAST(N'2024-03-09' AS Date), 55.0000)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (1, N'Q1', 1)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (2, N'Q2', 2)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (4, N'Q3', 5)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (5, N'Q4', 5)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (6, N'Q5', 6)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (7, N'Q6', 7)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (8, N'Q7', 8)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (9, N'Q8', 9)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (10, N'Q9', 9)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (11, N'Q10', 8)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (12, N'Q11', 7)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (13, N'Q12', 6)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (14, N'Q13', 5)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (15, N'Q14', 1)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (16, N'Q15', 2)
SET IDENTITY_INSERT [dbo].[Question] OFF
GO
SET IDENTITY_INSERT [dbo].[Rating] ON 

INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (1, 1, 1, 1)
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (2, 6, 2, 2)
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (3, 8, 3, 3)
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (4, 9, 4, 4)
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (5, 12, 5, 5)
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (6, 12, 6, 1)
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (7, 9, 7, 2)
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (8, 8, 8, 3)
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (12, 6, 9, 4)
SET IDENTITY_INSERT [dbo].[Rating] OFF
GO
SET IDENTITY_INSERT [dbo].[ReportedComment] ON 

INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (1, 3, 1, 2, CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'Fail')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (4, 4, 1, 4, CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'Fail')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (6, 10, 9, 4, CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'Fail')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (7, 11, 12, 4, CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'Fail')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (8, 27, 1, 2, CAST(N'2024-03-11T15:30:22.973' AS DateTime), N'Te')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (9, 3, 1, 1, CAST(N'2024-03-11T18:08:36.883' AS DateTime), N'Lam cai gi z ha?')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (10, 23, 12, 1, CAST(N'2024-03-11T18:10:39.610' AS DateTime), N'a')
SET IDENTITY_INSERT [dbo].[ReportedComment] OFF
GO
SET IDENTITY_INSERT [dbo].[Resource] ON 

INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (1, N'Noi dung 1', N'Des 1', 1, 0, 1, N'Reading', N'Introduce')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (2, N'Noi dung 2', N'Des 2', 1, 0, 2, N'Reading', N'Lesson 2 test')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (3, N'Noi dung 17', N'Des 1', 5, 0, 1, N'Reading', N'Introduce')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (4, N'Noi dung 3', N'Des 2', 5, 0, 2, N'Video', N'Lesson 2 test')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (5, N'Noi dung 16', N'Des 3', 2, 1, 1, N'Reading', N'Introduce')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (7, N'Noi dung 15', N'Des 4', 3, 0, 1, N'Reading', N'Introduce')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (9, N'Noi dung 14', N'Des 15', 4, 0, 1, N'Reading', N'Introduce')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (10, N'Noi dung 13', N'Des 14', 4, 0, 1, N'Reading', N'Introduce')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (11, N'Noi dung 12', N'Des 13', 3, 0, 2, N'Reading', N'Lesson 2')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (12, N'Noi dung 11', N'Des 12', 2, 0, 2, N'Reading', N'Lesson 2')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (14, N'Noi dung 10', N'Des 11', 6, 0, 1, N'Reading', N'Introduce')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (15, N'Noi dung 9', N'Des 10', 6, 0, 2, N'Reading', N'Lesson 2')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (16, N'Noi dung 8', N'Des 9', 7, 0, 1, N'Reading', N'Introduce')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (17, N'Noi dung 7', N'Des 8', 7, 0, 2, N'Reading', N'Lesson 2')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (18, N'Noi dung 6', N'Des 7', 8, 0, 1, N'Reading', N'Introduce')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (19, N'Noi dung 5', N'Des 6', 9, 0, 2, N'Reading', N'Lesson 2')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (20, N'Noi dung 4', N'Des 5', 9, 0, 2, N'Reading', N'Lesson 2')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (21, N'Noi dung 20', N'Des qq', 8, 0, 2, N'Reading', N'Lesson 2')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (22, N'Noi dung 21', N'Des qq', 8, 0, 3, N'Reading', N'Lesson 3')
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name]) VALUES (23, N'Noi dung 22', N'Des qq', 8, 0, 4, N'Reading', N'Lesson 4')
SET IDENTITY_INSERT [dbo].[Resource] OFF
GO
SET IDENTITY_INSERT [dbo].[ResourceUser] ON 

INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (1, 1, 1, 1)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (2, 2, 1, 1)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (3, 3, 6, 1)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (4, 4, 12, 1)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (5, 4, 6, 1)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (6, 3, 12, 1)
SET IDENTITY_INSERT [dbo].[ResourceUser] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'Student')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, N'Teacher')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (3, N'Admin')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Test] ON 

INSERT [dbo].[Test] ([TestId], [TestName], [Time], [PercentPoint], [CourseId], [Status]) VALUES (1, N'Test1', 30, CAST(100.00 AS Decimal(5, 2)), 1, N'1')
INSERT [dbo].[Test] ([TestId], [TestName], [Time], [PercentPoint], [CourseId], [Status]) VALUES (2, N'Test2', 60, CAST(100.00 AS Decimal(5, 2)), 2, N'1')
INSERT [dbo].[Test] ([TestId], [TestName], [Time], [PercentPoint], [CourseId], [Status]) VALUES (5, N'Test3', 60, CAST(100.00 AS Decimal(5, 2)), 3, N'1')
INSERT [dbo].[Test] ([TestId], [TestName], [Time], [PercentPoint], [CourseId], [Status]) VALUES (6, N'Test4', 15, CAST(100.00 AS Decimal(5, 2)), 4, N'1')
INSERT [dbo].[Test] ([TestId], [TestName], [Time], [PercentPoint], [CourseId], [Status]) VALUES (7, N'test5', 60, CAST(100.00 AS Decimal(5, 2)), 5, N'1')
INSERT [dbo].[Test] ([TestId], [TestName], [Time], [PercentPoint], [CourseId], [Status]) VALUES (8, N'Test6', 80, CAST(100.00 AS Decimal(5, 2)), 6, N'1')
INSERT [dbo].[Test] ([TestId], [TestName], [Time], [PercentPoint], [CourseId], [Status]) VALUES (9, N'test7', 20, CAST(100.00 AS Decimal(5, 2)), 1, N'1')
SET IDENTITY_INSERT [dbo].[Test] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive]) VALUES (1, N'DungND', N'123456', N'dacdung@gmail.com', 1, 0.0000, 1)
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive]) VALUES (2, N'HoaTT', N'1', N'test@gmail.com', 2, 0.0000, 1)
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive]) VALUES (4, N'Dungndhe16', N'123456', N'dungndhe16@fpt.edu.vn', 2, 0.0000, 1)
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive]) VALUES (6, N'userA', N'123456', N'userA@gmail.com', 1, 0.0000, 1)
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive]) VALUES (8, N'userB', N'123456', N'userB@gmail.com', 1, 0.0000, 1)
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive]) VALUES (9, N'Nguyen Van C', N'123456', N'userC@gmail.com', 1, 0.0000, 1)
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive]) VALUES (10, N'Admin', N'123456', N'admin@gmail.com', 3, 0.0000, 1)
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive]) VALUES (11, N'Admin2', N'123456', N'admin2@gmail.com', 3, 0.0000, 1)
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive]) VALUES (12, N'Tran van B', N'123456', N'vanB@gmail.com', 1, 0.0000, 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[UserCourse] ON 

INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (1, 1, 1, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (2, 1, 2, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (3, 2, 1, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (4, 6, 5, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (6, 8, 3, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (7, 9, 4, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (8, 12, 5, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (9, 9, 6, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (10, 1, 5, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (12, 4, 2, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (13, 4, 3, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (14, 4, 4, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (15, 2, 5, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (16, 2, 6, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (17, 2, 7, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (18, 4, 8, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (19, 4, 9, 0, N'1')
SET IDENTITY_INSERT [dbo].[UserCourse] OFF
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_Answer_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Answer] CHECK CONSTRAINT [FK_Answer_Question]
GO
ALTER TABLE [dbo].[CategoryCourse]  WITH CHECK ADD  CONSTRAINT [FK_CategoryCourse_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[CategoryCourse] CHECK CONSTRAINT [FK_CategoryCourse_Category]
GO
ALTER TABLE [dbo].[CategoryCourse]  WITH CHECK ADD  CONSTRAINT [FK_CategoryCourse_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[CategoryCourse] CHECK CONSTRAINT [FK_CategoryCourse_Course]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Course]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Course]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_User]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Test] FOREIGN KEY([TestId])
REFERENCES [dbo].[Test] ([TestId])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Test]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [FK_Rating_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [FK_Rating_Course]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [FK_Rating_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [FK_Rating_User]
GO
ALTER TABLE [dbo].[ReportedComment]  WITH CHECK ADD  CONSTRAINT [FK_ReportedComment_Comment] FOREIGN KEY([CommentId])
REFERENCES [dbo].[Comment] ([CommentId])
GO
ALTER TABLE [dbo].[ReportedComment] CHECK CONSTRAINT [FK_ReportedComment_Comment]
GO
ALTER TABLE [dbo].[ReportedComment]  WITH CHECK ADD  CONSTRAINT [FK_ReportedComment_UserComment] FOREIGN KEY([UserCommentId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[ReportedComment] CHECK CONSTRAINT [FK_ReportedComment_UserComment]
GO
ALTER TABLE [dbo].[ReportedComment]  WITH CHECK ADD  CONSTRAINT [FK_ReportedComment_UserReport] FOREIGN KEY([UserReportId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[ReportedComment] CHECK CONSTRAINT [FK_ReportedComment_UserReport]
GO
ALTER TABLE [dbo].[Resource]  WITH CHECK ADD  CONSTRAINT [FK_Resource_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Resource] CHECK CONSTRAINT [FK_Resource_Course]
GO
ALTER TABLE [dbo].[ResourceUser]  WITH CHECK ADD  CONSTRAINT [FK_ResourceUser_Resource] FOREIGN KEY([ResourceId])
REFERENCES [dbo].[Resource] ([ResourceId])
GO
ALTER TABLE [dbo].[ResourceUser] CHECK CONSTRAINT [FK_ResourceUser_Resource]
GO
ALTER TABLE [dbo].[ResourceUser]  WITH CHECK ADD  CONSTRAINT [FK_ResourceUser_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[ResourceUser] CHECK CONSTRAINT [FK_ResourceUser_User]
GO
ALTER TABLE [dbo].[Test]  WITH CHECK ADD  CONSTRAINT [FK_Test_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Test] CHECK CONSTRAINT [FK_Test_Course]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
ALTER TABLE [dbo].[UserCourse]  WITH CHECK ADD  CONSTRAINT [FK_UserCourse_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[UserCourse] CHECK CONSTRAINT [FK_UserCourse_Course]
GO
ALTER TABLE [dbo].[UserCourse]  WITH CHECK ADD  CONSTRAINT [FK_UserCourse_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[UserCourse] CHECK CONSTRAINT [FK_UserCourse_User]
GO
ALTER TABLE [dbo].[UserTest]  WITH CHECK ADD  CONSTRAINT [FK_UserTest_Test] FOREIGN KEY([TestId])
REFERENCES [dbo].[Test] ([TestId])
GO
ALTER TABLE [dbo].[UserTest] CHECK CONSTRAINT [FK_UserTest_Test]
GO
ALTER TABLE [dbo].[UserTest]  WITH CHECK ADD  CONSTRAINT [FK_UserTest_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[UserTest] CHECK CONSTRAINT [FK_UserTest_User]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD CHECK  (([Point]>=(1) AND [Point]<=(5)))
GO
ALTER TABLE [dbo].[Resource]  WITH CHECK ADD  CONSTRAINT [CK_Resource_Type] CHECK  (([Type]='Reading' OR [Type]='Video'))
GO
ALTER TABLE [dbo].[Resource] CHECK CONSTRAINT [CK_Resource_Type]
GO
ALTER DATABASE [PRN231_V2] SET  READ_WRITE 
GO
