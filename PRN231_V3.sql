/****** Object:  Database [PRN231_V2]    Script Date: 3/23/2024 1:03:45 PM ******/
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
/****** Object:  Table [dbo].[Answer]    Script Date: 3/23/2024 1:03:46 PM ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 3/23/2024 1:03:46 PM ******/
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
/****** Object:  Table [dbo].[CategoryCourse]    Script Date: 3/23/2024 1:03:46 PM ******/
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
/****** Object:  Table [dbo].[Comment]    Script Date: 3/23/2024 1:03:46 PM ******/
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
/****** Object:  Table [dbo].[Course]    Script Date: 3/23/2024 1:03:46 PM ******/
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
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/23/2024 1:03:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CourseId] [int] NULL,
	[Date] [datetime] NULL,
	[Total] [money] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 3/23/2024 1:03:46 PM ******/
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
/****** Object:  Table [dbo].[Rating]    Script Date: 3/23/2024 1:03:46 PM ******/
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
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 3/23/2024 1:03:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshToken](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[TokenHash] [nvarchar](1000) NOT NULL,
	[TokenSalt] [nvarchar](50) NOT NULL,
	[TS] [smalldatetime] NOT NULL,
	[ExpiryDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_RefreshToken] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportedComment]    Script Date: 3/23/2024 1:03:46 PM ******/
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
/****** Object:  Table [dbo].[Resource]    Script Date: 3/23/2024 1:03:46 PM ******/
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
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResourceId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResourceUser]    Script Date: 3/23/2024 1:03:46 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 3/23/2024 1:03:46 PM ******/
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
/****** Object:  Table [dbo].[Test]    Script Date: 3/23/2024 1:03:46 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 3/23/2024 1:03:46 PM ******/
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
	[PasswordSalt] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserCourse]    Script Date: 3/23/2024 1:03:46 PM ******/
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
/****** Object:  Table [dbo].[UserTest]    Script Date: 3/23/2024 1:03:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTest](
	[UserTestId] [int] IDENTITY(1,1) NOT NULL,
	[TestId] [int] NULL,
	[UserId] [int] NULL,
	[Point] [float] NULL,
	[TestDate] [datetime] NULL,
	[TotalTime] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserTestId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Answer] ON 

INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (1, N'Dễ sử dụng', 1, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (21, N'Có thể phân tích (hiểu) được', 1, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (22, N'Có thể thay đổi được', 1, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (23, N'Ổn định và có thể kiểm tra được', 1, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (24, N'Phần mềm là một phần tử logic', 17, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (25, N'Phần mềm là sản phẩm được các kỹ sư phần mềm thiết kế và xây dựng', 17, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (26, N'Phần mềm là một phần tử vật lý', 17, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (27, N'Phần mềm là một tập các ứng dụng được xây dựng bởi các kỹ sư phần mềm', 17, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (28, N'HTTT gồm phần cứng và cơ sở hạ tầng mạng truyền thông, phần mềm, dữ liệu, con người và các quy trình đảm bảo HTTT được sử dụng hiệu quả và có khả năng bảo trì.', 18, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (29, N'Phần mềm là thành phần quan trọng nhất của HTTT', 18, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (30, N'Ngày nay, chí phí phát triển phần mềm thường chiếm đa số trong chi phí xây dựng HTTT', 18, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (31, N'Hệ thống thông tin (HTTT) là tên gọi khác của sản phẩm phần mềm', 18, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (32, N'không được phát triển theo khuôn mẫu có sẵn', 19, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (33, N'Chi phí phát triển phần mềm thường rất cao', 19, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (34, N'không bị thoái hóa như phần cứng và các thiết bị vật lý khác', 19, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (35, N'phức tạp, vô hình, được phát triển theo nhóm và thường xuyên bị thay đổi', 19, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (36, N'Phần mềm ứng dụng', 20, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (37, N'Phần mềm hệ thống', 20, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (38, N'Phần mềm tiện ích', 20, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (39, N'Phần mềm khoa học kỹ thuật', 20, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (40, N'Tính phù hợp', 21, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (41, N'Tính chính xác', 21, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (42, N'Tính hiệu quả', 21, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (43, N'Khả năng hợp tác làm việc và tính an toàn', 21, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (44, N'Tính hoàn thiện', 22, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (45, N'Khả năng chịu lỗi', 22, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (46, N'Khả năng chịu tải', 22, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (47, N'Khả năng phục hồi', 22, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (48, N'Dễ hiểu, dễ học', 23, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (49, N'Có thể sử dụng được', 23, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (50, N'Tính hấp dẫn', 23, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (51, N'Dễ bảo trì', 23, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (52, N'Đáp ứng thời gian', 24, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (53, N'Dễ sử dụng', 24, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (54, N'Sử dụng tài nguyên hiệu quả', 24, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (55, N'Tiết kiệm tài nguyên của hệ thống', 24, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (56, N'Kh? nang thích nghi', 9, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (57, N'Ho?t d?ng ?n d?nh, ít l?i', 9, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (58, N'Có th? cài d?t du?c', 9, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (59, N'Kh? nang cùng t?n t?i và có th? thay th? du?c', 9, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (60, N'Ti?n hóa ph?n m?m là vi?c thay th? m?t ph?n m?m b?ng m?t ph?n m?m khác có ch?c nang tuong t? nhung ch?t lu?ng t?t hon.', 10, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (61, N'Ph?n m?m ch? b? thay d?i (ti?n hóa) trong quá trình v?n hành', 10, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (62, N'Trong quá trình phát tri?n (xây d?ng) cung nhu v?n hành (s? d?ng), ph?n m?m có th? b? thay d?i (ti?n hóa) b?t c? lúc nào t?i b?t c? th?i di?m nào.', 10, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (63, N'Ph?n m?m ch? b? thay d?i (ti?n hóa) trong quá trình phát tri?n', 10, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (64, N'Ch? trong quá trình phát tri?n', 57, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (65, N'Ch? trong quá trình v?n hành b?o trì', 57, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (66, N'B?t c? khi nào trong quá trình phát tri?n và v?n hành', 57, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (67, N'Ch? trong quá trình thu th?p, phân tích và d?c t? yêu c?u', 57, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (68, N'LOC (Line of Code)', 58, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (69, N'FPs (function points)', 58, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (70, N'C? B và C', 58, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (71, N'S? yêu c?u ch?c nang', 58, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (72, N'Tài li?u d?c t? yêu c?u', 59, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (73, N'Tài li?u thu th?p yêu c?u', 59, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (74, N'Tài li?u nghiên c?u kh? thi', 59, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (75, N'Tài li?u th?m d?nh yêu c?u', 59, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (76, N'Tài li?u thi?t k?', 60, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (77, N'Tài li?u hu?ng d?n s? d?ng', 60, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (78, N'Tài li?u ki?m th?', 60, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (79, N'Tài li?u d?c t? yêu c?u', 60, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (80, N'LOC (Line of Code)', 61, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (81, N'FPs (function points)', 61, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (82, N'C? B và C', 61, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (83, N'S? yêu c?u ch?c nang', 61, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (84, N'LOC (Line of Code)', 62, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (85, N'FPs (function points)', 62, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (86, N'C? B và C', 62, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (87, N'S? yêu c?u ch?c nang', 62, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (88, N'LOC (Line of Code)', 63, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (89, N'FPs (function points)', 63, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (90, N'C? B và C', 63, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (91, N'S? yêu c?u ch?c nang', 63, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (92, N'LOC (Line of Code)', 64, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (93, N'FPs (function points)', 64, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (94, N'C? B và C', 64, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (95, N'S? yêu c?u ch?c nang', 64, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (96, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 25, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (97, N'Hi?u nang h? th?ng', 25, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (98, N'Ng? c?nh bài toán', 25, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (99, N'H?n m?c kinh phí c?a d? án', 25, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (100, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 26, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (101, N'Hi?u nang h? th?ng', 26, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (102, N'Ng? c?nh bài toán', 26, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (103, N'H?n m?c kinh phí c?a d? án', 26, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (104, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 27, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (105, N'Hi?u nang h? th?ng', 27, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (106, N'Ng? c?nh bài toán', 27, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (107, N'H?n m?c kinh phí c?a d? án', 27, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (108, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 28, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (109, N'Hi?u nang h? th?ng', 28, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (110, N'Ng? c?nh bài toán', 28, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (111, N'H?n m?c kinh phí c?a d? án', 28, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (112, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 29, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (113, N'Hi?u nang h? th?ng', 29, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (114, N'Ng? c?nh bài toán', 29, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (115, N'H?n m?c kinh phí c?a d? án', 29, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (116, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 30, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (117, N'Hi?u nang h? th?ng', 30, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (118, N'Ng? c?nh bài toán', 30, 0)
GO
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (119, N'H?n m?c kinh phí c?a d? án', 30, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (120, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 31, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (121, N'Hi?u nang h? th?ng', 31, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (122, N'Ng? c?nh bài toán', 31, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (123, N'H?n m?c kinh phí c?a d? án', 31, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (124, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 32, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (125, N'Hi?u nang h? th?ng', 32, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (126, N'Ng? c?nh bài toán', 32, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (127, N'H?n m?c kinh phí c?a d? án', 32, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (132, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 34, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (133, N'Hi?u nang h? th?ng', 34, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (134, N'Ng? c?nh bài toán', 34, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (135, N'H?n m?c kinh phí c?a d? án', 34, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (136, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 35, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (137, N'Hi?u nang h? th?ng', 35, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (138, N'Ng? c?nh bài toán', 35, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (139, N'H?n m?c kinh phí c?a d? án', 35, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (140, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 36, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (141, N'Hi?u nang h? th?ng', 36, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (142, N'Ng? c?nh bài toán', 36, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (143, N'H?n m?c kinh phí c?a d? án', 36, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (144, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 37, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (145, N'Hi?u nang h? th?ng', 37, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (146, N'Ng? c?nh bài toán', 37, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (147, N'H?n m?c kinh phí c?a d? án', 37, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (148, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 38, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (149, N'Hi?u nang h? th?ng', 38, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (150, N'Ng? c?nh bài toán', 38, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (151, N'H?n m?c kinh phí c?a d? án', 38, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (152, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 39, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (153, N'Hi?u nang h? th?ng', 39, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (154, N'Ng? c?nh bài toán', 39, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (155, N'H?n m?c kinh phí c?a d? án', 39, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (156, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 40, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (157, N'Hi?u nang h? th?ng', 40, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (158, N'Ng? c?nh bài toán', 40, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (159, N'H?n m?c kinh phí c?a d? án', 40, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (160, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 41, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (161, N'Hi?u nang h? th?ng', 41, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (162, N'Ng? c?nh bài toán', 41, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (163, N'H?n m?c kinh phí c?a d? án', 41, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (164, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 42, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (165, N'Hi?u nang h? th?ng', 42, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (166, N'Ng? c?nh bài toán', 42, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (167, N'H?n m?c kinh phí c?a d? án', 42, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (168, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 43, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (169, N'Hi?u nang h? th?ng', 43, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (170, N'Ng? c?nh bài toán', 43, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (171, N'H?n m?c kinh phí c?a d? án', 43, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (172, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 44, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (173, N'Hi?u nang h? th?ng', 44, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (174, N'Ng? c?nh bài toán', 44, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (175, N'H?n m?c kinh phí c?a d? án', 44, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (176, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 45, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (177, N'Hi?u nang h? th?ng', 45, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (178, N'Ng? c?nh bài toán', 45, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (179, N'H?n m?c kinh phí c?a d? án', 45, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (180, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 46, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (181, N'Hi?u nang h? th?ng', 46, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (182, N'Ng? c?nh bài toán', 46, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (183, N'H?n m?c kinh phí c?a d? án', 46, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (184, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 47, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (185, N'Hi?u nang h? th?ng', 47, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (186, N'Ng? c?nh bài toán', 47, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (187, N'H?n m?c kinh phí c?a d? án', 47, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (188, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 48, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (189, N'Hi?u nang h? th?ng', 48, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (190, N'Ng? c?nh bài toán', 48, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (191, N'H?n m?c kinh phí c?a d? án', 48, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (192, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 49, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (193, N'Hi?u nang h? th?ng', 49, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (194, N'Ng? c?nh bài toán', 49, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (195, N'H?n m?c kinh phí c?a d? án', 49, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (196, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 50, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (197, N'Hi?u nang h? th?ng', 50, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (198, N'Ng? c?nh bài toán', 50, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (199, N'H?n m?c kinh phí c?a d? án', 50, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (200, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 51, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (201, N'Hi?u nang h? th?ng', 51, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (202, N'Ng? c?nh bài toán', 51, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (203, N'H?n m?c kinh phí c?a d? án', 51, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (204, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 52, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (205, N'Hi?u nang h? th?ng', 52, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (206, N'Ng? c?nh bài toán', 52, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (207, N'H?n m?c kinh phí c?a d? án', 52, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (208, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 53, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (209, N'Hi?u nang h? th?ng', 53, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (210, N'Ng? c?nh bài toán', 53, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (211, N'H?n m?c kinh phí c?a d? án', 53, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (212, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 54, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (213, N'Hi?u nang h? th?ng', 54, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (214, N'Ng? c?nh bài toán', 54, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (215, N'H?n m?c kinh phí c?a d? án', 54, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (216, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 55, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (217, N'Hi?u nang h? th?ng', 55, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (218, N'Ng? c?nh bài toán', 55, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (219, N'H?n m?c kinh phí c?a d? án', 55, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (220, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 56, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (221, N'Hi?u nang h? th?ng', 56, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (222, N'Ng? c?nh bài toán', 56, 0)
GO
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (223, N'H?n m?c kinh phí c?a d? án', 56, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (224, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 65, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (225, N'Hi?u nang h? th?ng', 65, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (226, N'Ng? c?nh bài toán', 65, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (227, N'H?n m?c kinh phí c?a d? án', 65, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (228, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 66, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (229, N'Hi?u nang h? th?ng', 66, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (230, N'Ng? c?nh bài toán', 66, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (231, N'H?n m?c kinh phí c?a d? án', 66, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (232, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 67, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (233, N'Hi?u nang h? th?ng', 67, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (234, N'Ng? c?nh bài toán', 67, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (235, N'H?n m?c kinh phí c?a d? án', 67, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (236, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 68, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (237, N'Hi?u nang h? th?ng', 68, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (238, N'Ng? c?nh bài toán', 68, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (239, N'H?n m?c kinh phí c?a d? án', 68, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (240, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 69, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (241, N'Hi?u nang h? th?ng', 69, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (242, N'Ng? c?nh bài toán', 69, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (243, N'H?n m?c kinh phí c?a d? án', 69, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (244, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 70, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (245, N'Hi?u nang h? th?ng', 70, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (246, N'Ng? c?nh bài toán', 70, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (247, N'H?n m?c kinh phí c?a d? án', 70, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (248, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 71, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (249, N'Hi?u nang h? th?ng', 71, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (250, N'Ng? c?nh bài toán', 71, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (251, N'H?n m?c kinh phí c?a d? án', 71, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (252, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 72, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (253, N'Hi?u nang h? th?ng', 72, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (254, N'Ng? c?nh bài toán', 72, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (255, N'H?n m?c kinh phí c?a d? án', 72, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (256, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 73, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (257, N'Hi?u nang h? th?ng', 73, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (258, N'Ng? c?nh bài toán', 73, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (259, N'H?n m?c kinh phí c?a d? án', 73, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (260, N'M?c tiêu, ch?c nang và hi?u nang h? th?ng', 74, 1)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (261, N'Hi?u nang h? th?ng', 74, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (262, N'Ng? c?nh bài toán', 74, 0)
INSERT [dbo].[Answer] ([AnswerId], [Content], [QuestionId], [IsCorrect]) VALUES (263, N'H?n m?c kinh phí c?a d? án', 74, 0)
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
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (12, 1, 11)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (13, 2, 11)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (14, 3, 11)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (15, 4, 18)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (16, 5, 18)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (17, 7, 19)
INSERT [dbo].[CategoryCourse] ([CategoryCourseId], [CategoryId], [CourseId]) VALUES (18, 2, 20)
SET IDENTITY_INSERT [dbo].[CategoryCourse] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (3, 1, 1, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'0')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (4, 1, 2, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'0')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (5, 1, 3, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (6, 6, 4, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (7, 6, 5, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (8, 6, 6, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (9, 8, 7, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (10, 9, 8, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (11, 12, 9, N'Good', CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'0')
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
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (33, 2, 1, N'Hallu', CAST(N'2024-03-11T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (35, 4, 1, N'Test', CAST(N'2024-03-11T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (36, 1, 2, N'Good game', CAST(N'2024-03-11T21:49:07.023' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (37, 1, 1, N'hi everyone ', CAST(N'2024-03-11T22:38:21.560' AS DateTime), N'0')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (38, 1, 3, N'hoa ', CAST(N'2024-03-14T22:34:44.113' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (41, 23, 2, N'hi', CAST(N'2024-03-22T21:53:25.947' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (42, 23, 1, N'ban me', CAST(N'2024-03-22T21:58:59.860' AS DateTime), N'1')
INSERT [dbo].[Comment] ([CommentId], [UserId], [CourseId], [Content], [CommentDate], [Status]) VALUES (43, 23, 2, N'aaaaaaa', CAST(N'2024-03-22T23:00:06.967' AS DateTime), N'1')
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (1, N'Software', N'Software engineering updated', CAST(1234.00 AS Decimal(18, 2)), N'0')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (2, N'Google Analysis', N'Work with data of Google', CAST(12345.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (3, N'JavaScript Tutorial', N'Basic Java ', CAST(11.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (4, N'Font-End Basic', N'Html, Css Basic', CAST(44.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (5, N'Font-End Normal', N'Start with JavaScript', CAST(332.00 AS Decimal(18, 2)), N'0')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (6, N'Font-End High Level', N'Work with React 22', CAST(1643.00 AS Decimal(18, 2)), N'3')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (7, N'Back-End C Sharp', N'Get start with Repository Pattern', CAST(163.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (8, N'Back-End C Sharp Version 2', N'Project MVC', CAST(43.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (9, N'Back-End C Sharp', N'Project Razor', CAST(132.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (10, N'Test cate', N'cate test', CAST(123.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (11, N'Google course', N'google', CAST(111.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (13, N'abcdef', N'abcd', CAST(0.00 AS Decimal(18, 2)), N'2')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (14, N'hoangu', N'full stạck', CAST(1111.00 AS Decimal(18, 2)), N'2')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (18, N'Test 1', N'test', CAST(1234.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (19, N'Test 2', N'test', CAST(123456.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Course] ([CourseId], [CourseName], [Title], [Price], [Status]) VALUES (20, N'111', N'111', CAST(111.00 AS Decimal(18, 2)), N'1')
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (3, 1, 1, CAST(N'2024-03-09T00:00:00.000' AS DateTime), 12.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (4, 6, 2, CAST(N'2024-03-09T00:00:00.000' AS DateTime), 133.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (5, 8, 3, CAST(N'2024-03-09T00:00:00.000' AS DateTime), 125.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (6, 9, 4, CAST(N'2024-03-09T00:00:00.000' AS DateTime), 54.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (7, 12, 5, CAST(N'2024-03-09T00:00:00.000' AS DateTime), 57.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (8, 1, 6, CAST(N'2024-03-09T00:00:00.000' AS DateTime), 55.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (9, 6, 7, CAST(N'2024-03-09T00:00:00.000' AS DateTime), 13.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (10, 8, 8, CAST(N'2024-03-09T00:00:00.000' AS DateTime), 553.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (11, 9, 9, CAST(N'2024-03-09T00:00:00.000' AS DateTime), 332.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (12, 12, 1, CAST(N'2024-03-09T00:00:00.000' AS DateTime), 55.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (13, 1, 4, CAST(N'2024-03-12T00:00:00.000' AS DateTime), 44.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (14, 1, 4, CAST(N'2024-03-12T00:00:00.000' AS DateTime), 44.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (15, 1, NULL, CAST(N'2024-03-12T00:00:00.000' AS DateTime), 44.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (16, 1, 4, CAST(N'2024-03-12T02:25:23.803' AS DateTime), 44.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (17, 1, 4, CAST(N'2024-03-12T02:29:59.173' AS DateTime), 44.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (18, 1, 4, CAST(N'2024-03-12T02:31:54.667' AS DateTime), 44.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (19, 1, 3, CAST(N'2024-03-12T02:53:31.013' AS DateTime), 11.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (20, 1, 3, CAST(N'2024-03-12T02:58:07.213' AS DateTime), 11.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (21, 1, 3, CAST(N'2024-03-12T02:58:51.193' AS DateTime), 11.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (22, 1, 3, CAST(N'2024-03-12T03:02:00.947' AS DateTime), 11.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (23, 1, 3, CAST(N'2024-03-12T03:02:43.123' AS DateTime), 11.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (24, 1, 3, CAST(N'2024-03-14T21:42:17.137' AS DateTime), 10.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (25, 1, NULL, CAST(N'2024-03-14T21:46:56.700' AS DateTime), 20.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (26, 1, 3, CAST(N'2024-03-14T21:48:02.413' AS DateTime), 11.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (27, 1, NULL, CAST(N'2024-03-14T22:33:07.197' AS DateTime), 11.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (28, 1, 3, CAST(N'2024-03-14T22:34:26.050' AS DateTime), 11.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (29, 1, NULL, CAST(N'2024-03-14T22:51:37.467' AS DateTime), 11.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (30, 1, 3, CAST(N'2024-03-14T22:52:48.683' AS DateTime), 11.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (31, 1, NULL, CAST(N'2024-03-18T20:57:49.870' AS DateTime), 10.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (32, 1, 1, CAST(N'2024-03-19T22:06:21.073' AS DateTime), 112.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (33, 1, 1, CAST(N'2024-03-19T22:07:28.617' AS DateTime), 112.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (34, 1, 1, CAST(N'2024-03-19T22:10:31.957' AS DateTime), 112.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (35, 23, 1, CAST(N'2024-03-19T22:49:50.270' AS DateTime), 112.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (36, 23, 2, CAST(N'2024-03-22T10:55:18.993' AS DateTime), 3221.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (37, 23, 3, CAST(N'2024-03-22T11:08:27.707' AS DateTime), 11.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (38, 23, NULL, CAST(N'2024-03-22T16:23:48.640' AS DateTime), 11.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (39, 20, NULL, CAST(N'2024-03-22T20:52:18.623' AS DateTime), 1234.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (40, 20, 1, CAST(N'2024-03-22T20:52:31.410' AS DateTime), 1234.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (41, 23, NULL, CAST(N'2024-03-22T21:23:16.857' AS DateTime), 12.0000)
INSERT [dbo].[OrderDetail] ([OrderId], [UserId], [CourseId], [Date], [Total]) VALUES (42, 23, NULL, CAST(N'2024-03-22T21:27:02.643' AS DateTime), 13.0000)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (1, N'Đâu kHÔNG là độ đo về tính hiệu quả của một hệ thống phần mềm?', 1)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (9, N'Chọn phát biểu đúng nhất trong các phát biểu sau.', 9)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (10, N'Vòng đời phát triển phần mềm', 9)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (17, N'Chọn phát biểu đúng nhất về sản phẩm phần mềm.', 1)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (18, N'Chọn phát biểu sai trong những phát biểu sau đây.', 1)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (19, N'Chọn phát biểu SAI trong các phát biểu dưới đây.', 1)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (20, N'Đâu không là đặc trưng của một sản phẩm phần mềm?', 1)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (21, N'MS Word thuộc loại phần mềm nào?', 1)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (22, N'Đâu kHÔNG là độ đo về tính năng của một hệ thống phần mềm?', 1)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (23, N'Đâu kHÔNG là độ đo về độ tin cậy của một hệ thống phần mềm?', 1)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (24, N'Đâu kHÔNG là độ đo về tính khả dụng (dễ sử dụng) của một hệ thống phần mềm?', 1)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (25, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 2)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (26, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 2)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (27, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 2)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (28, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 2)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (29, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 2)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (30, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 2)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (31, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 2)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (32, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 2)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (34, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 5)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (35, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 5)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (36, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 5)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (37, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 5)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (38, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 5)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (39, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 5)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (40, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 5)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (41, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 7)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (42, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 7)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (43, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 7)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (44, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 7)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (45, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 7)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (46, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 7)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (47, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 7)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (48, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 7)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (49, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 8)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (50, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 8)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (51, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 8)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (52, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 8)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (53, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 8)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (54, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 8)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (55, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 8)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (56, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 8)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (57, N'Đâu KHÔNG là độ đo về tính dễ bảo trì của một hệ thống phần mềm?', 9)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (58, N'Đâu KHÔNG là độ đo về tính khả chuyển của một hệ thống phần mềm?', 9)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (59, N'Chọn phát biểu đúng', 9)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (60, N'Khi nào thì một phần mềm bị tiến hóa?', 9)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (61, N'Đâu là độ đo về kích cỡ (size) của một sản phẩm phần mềm?', 9)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (62, N'Tài liệu nào được tạo ra bởi pha phân tích và đặc tả yêu cầu?', 9)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (63, N'Đâu là tài liệu quan trọng nhất hỗ trợ giao tiếp giữa các bên liên quan trong quá trình phát triển phần mềm?', 9)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (64, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 9)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (65, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 6)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (66, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 6)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (67, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 6)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (68, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 6)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (69, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 6)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (70, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 6)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (71, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 6)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (72, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 6)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (73, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 6)
INSERT [dbo].[Question] ([QuestionId], [Content], [TestId]) VALUES (74, N'Để xác định chính xác phạm vi của phần mềm, chúng ta cần những đặc trưng nào trong các đặc trưng sau?', 6)
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
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (13, 1, 1, 4)
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (14, 1, 2, 3)
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (15, 1, 5, 4)
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (16, 1, 3, 3)
INSERT [dbo].[Rating] ([RatingId], [UserId], [CourseId], [Point]) VALUES (19, 23, 2, 5)
SET IDENTITY_INSERT [dbo].[Rating] OFF
GO
SET IDENTITY_INSERT [dbo].[RefreshToken] ON 

INSERT [dbo].[RefreshToken] ([Id], [UserId], [TokenHash], [TokenSalt], [TS], [ExpiryDate]) VALUES (12, 13, N'qJ1E6RP/3GFWo6bfIptJEtufa2l/NrzHORJQ8RLFrOU=', N'vOYuh5JrUxugL28+anA5R9vmxg7OB/8oXizu3KE4X8Y=', CAST(N'2024-03-19T02:28:00' AS SmallDateTime), CAST(N'2024-04-18T02:28:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([Id], [UserId], [TokenHash], [TokenSalt], [TS], [ExpiryDate]) VALUES (33, 18, N'BfofCffKe9VbRwCkNmShHyvzmY+Gpq5kfkJ7JLctev0=', N'drpS+n/m5Perl/mEOsbInAnp+RgCfUZ6a+EtymnFTkU=', CAST(N'2024-03-19T19:34:00' AS SmallDateTime), CAST(N'2024-04-18T19:34:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([Id], [UserId], [TokenHash], [TokenSalt], [TS], [ExpiryDate]) VALUES (49, 21, N'5fTckF0mLN6Ys5yuwMO6pHq1sPZ36SIutWQZjn1lMho=', N'jhNbYGseGYMYoS4u39oIg6zv2OvyEkBt6tlZQLSFleA=', CAST(N'2024-03-19T21:56:00' AS SmallDateTime), CAST(N'2024-04-18T21:56:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([Id], [UserId], [TokenHash], [TokenSalt], [TS], [ExpiryDate]) VALUES (50, 22, N'KxjZbVYCh/jtPyIDm4ltq3wuQJaxwS8WL/lKS0iaXlQ=', N'eoe0jma2tMzZ8pg+Z0GBuL0A0dr3K0vs2/7sH5vS1hc=', CAST(N'2024-03-19T22:10:00' AS SmallDateTime), CAST(N'2024-04-18T22:10:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([Id], [UserId], [TokenHash], [TokenSalt], [TS], [ExpiryDate]) VALUES (60, 24, N'z9wYkmuWl2kRbTdWC6OjxFSAoFGhD8WOpPVdtn3O32M=', N'eG5TWzN0900eg6jYXLWgWfTNB7utSFaBaSnDLK7yUZo=', CAST(N'2024-03-19T22:31:00' AS SmallDateTime), CAST(N'2024-04-18T22:31:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([Id], [UserId], [TokenHash], [TokenSalt], [TS], [ExpiryDate]) VALUES (80, 19, N's8cHT4lBN7sNFUBpy+RXzdes5L1TNb30A533MfzWTow=', N'GnjFeaM6RDhn243eOaPB9+2+PhZLW1GdaEQVNTGACiA=', CAST(N'2024-03-19T23:51:00' AS SmallDateTime), CAST(N'2024-04-18T23:51:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([Id], [UserId], [TokenHash], [TokenSalt], [TS], [ExpiryDate]) VALUES (102, 1, N'1fkTauUSU3lPZFMAddK4kr1wbawORQGmwtIBm52B4fg=', N'jhfTCDsY91nO/5UESmZvjIA8wohl0hs48jwiYdlvBRc=', CAST(N'2024-03-21T21:25:00' AS SmallDateTime), CAST(N'2024-04-20T21:25:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([Id], [UserId], [TokenHash], [TokenSalt], [TS], [ExpiryDate]) VALUES (118, 20, N'G+NppdcD7yZZxTsed9O/0Ate2vuEwjthT0ZnNV/vOiQ=', N'HpqDAnydL9SZAa8TfjuxXzkaMWyd/IixCio6uJ//r3o=', CAST(N'2024-03-22T20:49:00' AS SmallDateTime), CAST(N'2024-04-21T20:49:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([Id], [UserId], [TokenHash], [TokenSalt], [TS], [ExpiryDate]) VALUES (131, 10, N'jFrwaAtCOW+5QNDUbKJIgveFQNuylZf6rDs2ittedro=', N'tX8hL7BN6ublyUt6dZl+1K4IgXze8K++AuA/cR8SKSA=', CAST(N'2024-03-22T21:45:00' AS SmallDateTime), CAST(N'2024-04-21T21:45:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([Id], [UserId], [TokenHash], [TokenSalt], [TS], [ExpiryDate]) VALUES (181, 23, N'ysdKlBlzEQ1FPDmEZaL8ctlOxiwiTb5LhrvnQ4HDprM=', N'R+G7WADrydpmCXgddXIszaSp7xzVfN8N7/Zf71Igy3I=', CAST(N'2024-03-23T11:46:00' AS SmallDateTime), CAST(N'2024-04-22T11:46:00' AS SmallDateTime))
INSERT [dbo].[RefreshToken] ([Id], [UserId], [TokenHash], [TokenSalt], [TS], [ExpiryDate]) VALUES (182, 2, N'gzHgDRaXuKve1uGJbHoyh0sMGc8eD9W3J2Azu7iF28s=', N'+HmiLfEik82AWlS72BCTZ0O6ufFxfvMxok3tfylwx08=', CAST(N'2024-03-23T11:56:00' AS SmallDateTime), CAST(N'2024-04-22T11:56:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[RefreshToken] OFF
GO
SET IDENTITY_INSERT [dbo].[ReportedComment] ON 

INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (1, 3, 1, 2, CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'Fail')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (4, 4, 1, 4, CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'Fail')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (6, 10, 9, 4, CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'Fail')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (7, 11, 12, 4, CAST(N'2024-03-09T00:00:00.000' AS DateTime), N'Fail')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (8, 27, 1, 2, CAST(N'2024-03-11T15:30:22.973' AS DateTime), N'Te')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (9, 3, 1, 1, CAST(N'2024-03-11T18:08:36.883' AS DateTime), N'Lam cai gi z ha?')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (10, 23, 12, 1, CAST(N'2024-03-11T18:10:39.610' AS DateTime), N'a')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (11, 19, 9, 1, CAST(N'2024-03-14T22:35:06.857' AS DateTime), N'test thoi')
INSERT [dbo].[ReportedComment] ([ReportedCommentId], [CommentId], [UserCommentId], [UserReportId], [DateTime], [ReasonReport]) VALUES (12, 37, 1, 23, CAST(N'2024-03-22T22:03:19.367' AS DateTime), N'noi ngu')
SET IDENTITY_INSERT [dbo].[ReportedComment] OFF
GO
SET IDENTITY_INSERT [dbo].[Resource] ON 

INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (1, N'Noi dung 1', N'Des 1', 1, 0, 1, N'Reading', N'Introduce', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (2, N'Noi dung 2', N'Des 2', 1, 0, 2, N'Reading', N'Lesson 2 test', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (3, N'Noi dung 17', N'Des 1', 5, 0, 1, N'Reading', N'Introduce', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (4, N'https://www.youtube.com/embed/zoEtcR5EW08', N'Des 2', 5, 0, 2, N'Video', N'Lesson 2 test', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (5, N'Noi dung 16', N'Des 3', 2, 1, 1, N'Reading', N'Introduce', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (7, N'Noi dung 15', N'Des 4', 3, 0, 1, N'Reading', N'Introduce', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (9, N'Noi dung 14', N'Des 15', 4, 0, 1, N'Reading', N'Introduce', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (10, N'Noi dung 13', N'Des 14', 4, 0, 1, N'Reading', N'Introduce', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (11, N'Noi dung 12', N'Des 13', 3, 0, 2, N'Reading', N'Lesson 2', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (12, N'Noi dung 11', N'Des 12', 2, 0, 2, N'Reading', N'Lesson 2', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (14, N'Noi dung 10', N'Des 11', 6, 0, 1, N'Reading', N'Introduce', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (15, N'Noi dung 9', N'Des 10', 6, 0, 2, N'Reading', N'Lesson 2', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (16, N'Noi dung 8', N'Des 9', 7, 0, 1, N'Reading', N'Introduce', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (17, N'Noi dung 7', N'Des 8', 7, 0, 2, N'Reading', N'Lesson 2', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (18, N'Noi dung 6', N'Des 7', 8, 0, 1, N'Reading', N'Introduce', NULL)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (19, N'Noi dung 5', N'Des 6', 9, 0, 2, N'Reading', N'Lesson 2', NULL)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (20, N'Noi dung 4', N'Des 5', 9, 0, 2, N'Reading', N'Lesson 2', NULL)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (21, N'Noi dung 20', N'Des qq', 8, 0, 2, N'Reading', N'Lesson 2', NULL)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (22, N'Noi dung 21', N'Des qq', 8, 0, 3, N'Reading', N'Lesson 3', NULL)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (23, N'Noi dung 22', N'Des qq', 8, 0, 4, N'Reading', N'Lesson 4', NULL)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (24, N'https://www.youtube.com/embed/OrDB4jpA1g8', N'Des 3', 1, 0, 3, N'Video', N'Lesson 3', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (26, N'aaa', N'Test', 6, 1, 3, N'Video', N'Test', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (27, N'Test content', N'aaaa', 6, 0, 4, N'Reading', N'Test 2', 1)
INSERT [dbo].[Resource] ([ResourceId], [Content], [Description], [CourseId], [IsFree], [OrdinalNumber], [Type], [Name], [Status]) VALUES (28, N'1', N'1', 6, 0, 5, N'Reading', N'test font-end', 1)
SET IDENTITY_INSERT [dbo].[Resource] OFF
GO
SET IDENTITY_INSERT [dbo].[ResourceUser] ON 

INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (1, 1, 1, 1)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (2, 2, 1, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (3, 3, 6, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (4, 4, 12, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (5, 4, 6, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (6, 3, 12, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (7, 24, 1, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (8, 1, 1, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (9, 2, 1, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (10, 24, 1, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (11, 1, 1, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (12, 2, 1, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (13, 24, 1, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (14, 1, 1, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (15, 2, 1, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (16, 24, 1, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (17, 1, 23, 1)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (18, 2, 23, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (19, 24, 23, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (20, 5, 23, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (21, 12, 23, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (22, 7, 23, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (23, 11, 23, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (24, 1, 20, 1)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (25, 2, 20, 0)
INSERT [dbo].[ResourceUser] ([ResourceUserId], [ResourceId], [UserId], [IsComplete]) VALUES (26, 24, 20, 0)
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

INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (1, N'DungND', N'wcjp5/XIsetNjhkoGSTBpZ+Xuy/KjCHNR3v4/PVXiHo=', N'dacdung@gmail.com', 1, 9664.0000, 0, N'1YzAjC0zpy8e2m2tjHb54MEQPcN93LuZCmI0C7dHvAE=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (2, N'HoaTT', N'EabwjG1z8FEiUuNwVbGxZUon7jsjVJozIjHwHAMjRrI=', N'test@gmail.com', 2, 1345.6000, 1, N'Ya1rtSOtSufoAcNuwJI/oUdzuYWN7+tjhBjvDuFmKb8=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (4, N'Dungndhe16', N'123456', N'dungndhe16@fpt.edu.vn', 2, 2699.2000, 0, N'DaKGa9E/juiNM4FNjmtjpewgjUbs9w5ZAomY56tJPRU=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (6, N'userA', N'123456', N'userA@gmail.com', 1, 0.0000, 0, N'DaKGa9E/juiNM4FNjmtjpewgjUbs9w5ZAomY56tJPRU=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (8, N'userB', N'123456', N'userB@gmail.com', 1, 0.0000, 1, N'DaKGa9E/juiNM4FNjmtjpewgjUbs9w5ZAomY56tJPRU=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (9, N'Nguyen Van C', N'123456', N'userC@gmail.com', 1, 0.0000, 1, N'DaKGa9E/juiNM4FNjmtjpewgjUbs9w5ZAomY56tJPRU=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (10, N'Admin', N'13nfWMNuq2XIXNOUgqdcElnCAZFK0CiYGpvMODOZLPs=', N'admin@gmail.com', 3, 1011.2000, 1, N'0N8+FpOEuWipZ5wSrTZ42qFv3Ea5L/gzOEgmp44Xh6c=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (12, N'Tran van B', N'123456', N'vanB@gmail.com', 1, 0.0000, 1, N'DaKGa9E/juiNM4FNjmtjpewgjUbs9w5ZAomY56tJPRU=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (13, N'Nguyen Hong Son', N'rSqHnKt2tdxYRaJZH/lv6rgsaxCTXlaLHzM13yKbkow=', N'user@example.com', 1, 0.0000, 1, N'DaKGa9E/juiNM4FNjmtjpewgjUbs9w5ZAomY56tJPRU=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (16, N'teacher ', N'NE6lLegvd8vvrYW6Zuc1p6QSPhNqpcI9Wvc/73Q2wpE=', N'sonnh296@gmail.com', 2, 0.0000, 1, N'Di0MtnFuAnJfviVjLAM7yLI5dvKIZPJmetYBAaNSW/E=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (17, N'student', N'weshjLbA0Lh2kyW9MykPkuoVPqxZdx85IayHtSEB9rQ=', N'student@gmail.com', 1, 0.0000, 1, N'MNFI4Suprc7+XsW1quRwDiTqk77oCUsYdafs2/5tJvc=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (18, N'teacher 2', N'1o5GoWubLS9xmnE3nNITvbJQYvxCmvRQ12e/BbXmq68=', N'teacher1@gmail.com', 2, 0.0000, 1, N'LM0eOIP+7IdXG4W72OE9oItm80AgURcQ0uPFocwBKCk=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (19, N'qwer1234#', N'aUae6NvvLdrvvhHOYokhnobgaE7B9irOJzG+XZaCOeE=', N'stu1@gmail.com', 1, 0.0000, 1, N'C89QeKnOpnuPQOS/z/4EpptMKNsvHYrR9tFrFUGrjkE=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (20, N'tronghoa', N'ehWcLKtdp4WWfrcPSnuaJPUruaYD2cJO/Mni0v93Y0c=', N'doibuon777@gmail.com', 1, 0.0000, 1, N'u5AFSNirzhYRFU8BymJ8JmJqsg/Iw1oDhzbgHJ5He8s=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (21, N'NGUYỄN ĐẮC DŨNG', N'SZ1tt6Q/GZsEd7sumoRktw+JqfMfzU1Bixxpw6aUo70=', N'dacdung0984@gmail.com', 1, 10000.0000, 1, N'Fk7zn+5W3PBqK6aBOqOm+I0LkphEhbdO/u+3sy65leY=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (22, N'NGUYỄN ĐẮC DŨNG', N'/ddplPVW7n2IbOkZ8YJj1onyTWW7n9GqkHqG09988xg=', N'dacdung11110984@gmail.com', 1, 100000.0000, 1, N'uy+HMGFNj7hB3nPSsq3Ic3pJnl20I0Co60WGsmp8/Zs=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (23, N'dungnd', N'dT0TzCxKr4Z9eu57Y7cMriaFU2J6ZMffDx88jJiK+Z8=', N'thoiloan@gmail.com', 1, 96692.0000, 0, N'8ydIxJEPo8GBhk6XefRpKO+IWQ26fqSKaBDfOZhOUyM=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (24, N'2dungnd2', N'TbkZPOlPiVIsjiJGoWdKmjyP4bL2wz6x9282fkHed+Q=', N'2thoiloan2@gmail.com', 1, 100000.0000, 1, N'LRjnUhDlZml3NuIswBuv+eLEaFWVaYKVp6NRTaTzWCM=')
INSERT [dbo].[User] ([UserId], [UserName], [Password], [Email], [RoleId], [Balance], [IsActive], [PasswordSalt]) VALUES (25, N'Cường Đình Nguyễn', N'TFtOmeVnYsFxX29Bqnf4M7f7H4friLFbAbKpdo5C2f4=', N'dinhcuong031@gmail.com', 1, 0.0000, 1, N'/KELFM5TVWWi7tO7/T52CTWKUvfKfEkSe0PyfRMypmI=')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[UserCourse] ON 

INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (1, 1, 1, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (2, 1, 2, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (3, 2, 1, 0, N'0')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (4, 6, 5, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (6, 8, 3, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (7, 9, 4, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (8, 12, 5, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (9, 9, 6, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (10, 1, 5, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (12, 4, 2, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (13, 4, 3, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (14, 4, 4, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (15, 2, 5, 0, N'0')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (16, 2, 6, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (17, 2, 7, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (18, 4, 8, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (19, 4, 9, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (37, 2, 10, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (40, 2, 11, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (41, 1, 3, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (42, 1, 1, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (43, 1, 1, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (44, 1, 1, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (45, 2, 18, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (46, 16, 19, 0, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (47, 23, 1, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (48, 23, 2, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (49, 23, 3, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (50, 20, 1, 1, N'1')
INSERT [dbo].[UserCourse] ([UserCourseId], [UserId], [CourseId], [IsStudent], [Status]) VALUES (51, 2, 20, 0, N'1')
SET IDENTITY_INSERT [dbo].[UserCourse] OFF
GO
SET IDENTITY_INSERT [dbo].[UserTest] ON 

INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (1, 1, 1, 8, CAST(N'2024-03-11T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (2, 1, 1, 4, CAST(N'2024-02-10T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (3, 9, 1, 7, CAST(N'2024-03-10T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (4, 9, 1, 9, CAST(N'2024-03-14T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (5, 1, 1, 88.888888888888886, CAST(N'2024-03-19T11:12:51.663' AS DateTime), 0.89)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (6, 1, 1, 100, CAST(N'2024-03-19T11:53:27.700' AS DateTime), 1.1)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (7, 1, 23, 0, CAST(N'2024-03-22T14:50:50.437' AS DateTime), 0.17)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (8, 5, 23, 0, CAST(N'2024-03-22T17:47:05.567' AS DateTime), 0.04)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (9, 5, 23, 0, CAST(N'2024-03-22T18:03:01.740' AS DateTime), 0.04)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (10, 9, 23, 0, CAST(N'2024-03-22T18:21:11.360' AS DateTime), 0.05)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (12, 9, 23, 0, CAST(N'2024-03-22T18:41:34.050' AS DateTime), 0.05)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (13, 9, 23, 0, CAST(N'2024-03-22T18:41:47.993' AS DateTime), 0.06)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (14, 9, 23, 0, CAST(N'2024-03-22T18:42:27.187' AS DateTime), 0.04)
INSERT [dbo].[UserTest] ([UserTestId], [TestId], [UserId], [Point], [TestDate], [TotalTime]) VALUES (15, 9, 23, 0, CAST(N'2024-03-22T18:42:38.610' AS DateTime), 0.07)
SET IDENTITY_INSERT [dbo].[UserTest] OFF
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
ALTER TABLE [dbo].[RefreshToken]  WITH CHECK ADD  CONSTRAINT [FK_RefreshToken_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[RefreshToken] CHECK CONSTRAINT [FK_RefreshToken_User]
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
