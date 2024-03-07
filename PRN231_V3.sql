USE [master]
GO
/****** Object:  Database [PRN231_V2]    Script Date: 3/7/2024 7:40:01 PM ******/
CREATE DATABASE [PRN231_V2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PRN231_V2', FILENAME = N'C:\Users\trong.hoa\AppData\Local\MSSQL16.SQLEXPRESS\MSSQL\DATA\PRN231_V2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PRN231_V2_log', FILENAME = N'C:\Users\trong.hoa\AppData\Local\MSSQL16.SQLEXPRESS\MSSQL\DATA\PRN231_V2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PRN231_V2] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PRN231_V2].[dbo].[sp_fulltext_database] @action = 'enable'
end
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
ALTER DATABASE [PRN231_V2] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [PRN231_V2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PRN231_V2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PRN231_V2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PRN231_V2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PRN231_V2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PRN231_V2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PRN231_V2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PRN231_V2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PRN231_V2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PRN231_V2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PRN231_V2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PRN231_V2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PRN231_V2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PRN231_V2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PRN231_V2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PRN231_V2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PRN231_V2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PRN231_V2] SET  MULTI_USER 
GO
ALTER DATABASE [PRN231_V2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PRN231_V2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PRN231_V2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PRN231_V2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PRN231_V2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PRN231_V2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PRN231_V2] SET QUERY_STORE = ON
GO
ALTER DATABASE [PRN231_V2] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PRN231_V2]
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 3/7/2024 7:40:01 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/7/2024 7:40:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryCourse]    Script Date: 3/7/2024 7:40:01 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 3/7/2024 7:40:01 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 3/7/2024 7:40:01 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/7/2024 7:40:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[PaymentMethod] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 3/7/2024 7:40:01 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 3/7/2024 7:40:01 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportedComment]    Script Date: 3/7/2024 7:40:01 PM ******/
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
 CONSTRAINT [PK_ReportedComment] PRIMARY KEY CLUSTERED 
(
	[ReportedCommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resource]    Script Date: 3/7/2024 7:40:01 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[ResourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResourceUser]    Script Date: 3/7/2024 7:40:01 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 3/7/2024 7:40:01 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Test]    Script Date: 3/7/2024 7:40:01 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/7/2024 7:40:01 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserCourse]    Script Date: 3/7/2024 7:40:01 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTest]    Script Date: 3/7/2024 7:40:01 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (1, N'Html')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (2, N'Css')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (3, N'JavaScript')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (4, N'C#')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (5, N'MVC')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (6, N'Razor')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (7, N'Google')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (8, N'Software')
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
SET IDENTITY_INSERT [dbo].[CategoryCourse] OFF
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
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'Student')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, N'Teacher')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (3, N'Admin')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance]) VALUES (1, N'DungND', N'123456', N'dacdung@gmail.com', 1, NULL)
SET IDENTITY_INSERT [dbo].[User] OFF
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
USE [master]
GO
ALTER DATABASE [PRN231_V2] SET  READ_WRITE 
GO
