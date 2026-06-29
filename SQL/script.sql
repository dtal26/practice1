USE [master]
GO
/****** Объект:  Database [LibraryDB]    Дата создания скрипта: 22.06.2026 20:22:09 ******/ 
CREATE DATABASE [LibraryDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LibraryDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\LibraryDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LibraryDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\LibraryDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [LibraryDB] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LibraryDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LibraryDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LibraryDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LibraryDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LibraryDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LibraryDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [LibraryDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LibraryDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LibraryDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LibraryDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LibraryDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LibraryDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LibraryDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LibraryDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LibraryDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LibraryDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LibraryDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LibraryDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LibraryDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LibraryDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LibraryDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LibraryDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LibraryDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LibraryDB] SET RECOVERY FULL 
GO
ALTER DATABASE [LibraryDB] SET  MULTI_USER 
GO
ALTER DATABASE [LibraryDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LibraryDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LibraryDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LibraryDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LibraryDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LibraryDB] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [LibraryDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [LibraryDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [LibraryDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [LibraryDB]
GO
/****** Объект:  Table [dbo].[BookCategories]    Дата создания скрипта: 22.06.2026 20:22:09 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookCategories](
	[BookID] [uniqueidentifier] NOT NULL,
	[CategoryID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BookID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Books]    Дата создания скрипта: 22.06.2026 20:22:09 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[BookID] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Author] [nvarchar](150) NOT NULL,
	[ISBN] [nvarchar](20) NOT NULL,
	[PublishYear] [int] NULL,
	[IsAvailable] [bit] NULL,
	[AddedDate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Categories]    Дата создания скрипта: 22.06.2026 20:22:09 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Fines]    Дата создания скрипта: 22.06.2026 20:22:09 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fines](
	[FineID] [int] IDENTITY(1,1) NOT NULL,
	[LoanID] [int] NOT NULL,
	[Amount] [decimal](10, 2) NOT NULL,
	[IssueDate] [date] NULL,
	[IsPaid] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[FineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Loans]    Дата создания скрипта: 22.06.2026 20:22:09 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loans](
	[LoanID] [int] IDENTITY(1,1) NOT NULL,
	[BookID] [uniqueidentifier] NOT NULL,
	[ReaderID] [int] NOT NULL,
	[LoanDate] [datetime2](7) NULL,
	[DueDate] [datetime2](7) NOT NULL,
	[ReturnDate] [datetime2](7) NULL,
	[IsReturned] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[LoanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Readers]    Дата создания скрипта: 22.06.2026 20:22:09 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Readers](
	[ReaderID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[LibraryCardNumber] [nvarchar](20) NOT NULL,
	[Phone] [nvarchar](20) NULL,
	[RegistrationDate] [date] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReaderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'8cc354cf-5ea2-44d8-a436-0ec4645e3c67', 2)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'8cc354cf-5ea2-44d8-a436-0ec4645e3c67', 3)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'a90b9ee2-a3cc-4254-bca2-12d008188fec', 1)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'a90b9ee2-a3cc-4254-bca2-12d008188fec', 5)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'9a8e5804-3a31-4f68-9b4d-18a47a72405d', 3)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'ca60ba5b-42c9-417e-9134-272286794fdd', 2)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'ca60ba5b-42c9-417e-9134-272286794fdd', 5)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'efe77176-d813-4881-bb08-95c829a65d9b', 1)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'efe77176-d813-4881-bb08-95c829a65d9b', 3)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'663955ba-ad15-4a18-b456-b007fddf5b16', 1)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'663955ba-ad15-4a18-b456-b007fddf5b16', 5)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'2c05ec4a-c633-4721-8578-bdb4d0eaceef', 4)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'e158c038-c615-45ba-943a-c558140def8a', 1)
INSERT [dbo].[BookCategories] ([BookID], [CategoryID]) VALUES (N'e158c038-c615-45ba-943a-c558140def8a', 3)
GO
INSERT [dbo].[Books] ([BookID], [Title], [Author], [ISBN], [PublishYear], [IsAvailable], [AddedDate]) VALUES (N'8cc354cf-5ea2-44d8-a436-0ec4645e3c67', N'Преступление и наказание', N'Федор Достоевский', N'978-5-699-23456-7', 1866, 1, CAST(N'2026-06-22T12:05:19.8733333' AS DateTime2))
INSERT [dbo].[Books] ([BookID], [Title], [Author], [ISBN], [PublishYear], [IsAvailable], [AddedDate]) VALUES (N'a90b9ee2-a3cc-4254-bca2-12d008188fec', N'Властелин колец', N'Джон Толкин', N'978-5-699-56789-0', 1954, 1, CAST(N'2026-06-22T12:05:19.8733333' AS DateTime2))
INSERT [dbo].[Books] ([BookID], [Title], [Author], [ISBN], [PublishYear], [IsAvailable], [AddedDate]) VALUES (N'9a8e5804-3a31-4f68-9b4d-18a47a72405d', N'Война и мир', N'Лев Толстой', N'978-5-699-34567-8', 1869, 0, CAST(N'2026-06-22T12:05:19.8733333' AS DateTime2))
INSERT [dbo].[Books] ([BookID], [Title], [Author], [ISBN], [PublishYear], [IsAvailable], [AddedDate]) VALUES (N'ca60ba5b-42c9-417e-9134-272286794fdd', N'Шерлок Холмс', N'Артур Конан Дойл', N'978-5-699-67890-1', 1892, 0, CAST(N'2026-06-22T12:05:19.8733333' AS DateTime2))
INSERT [dbo].[Books] ([BookID], [Title], [Author], [ISBN], [PublishYear], [IsAvailable], [AddedDate]) VALUES (N'efe77176-d813-4881-bb08-95c829a65d9b', N'Мастер и Маргарита', N'Михаил Булгаков', N'978-5-699-89012-3', 1967, 1, CAST(N'2026-06-22T12:05:19.8733333' AS DateTime2))
INSERT [dbo].[Books] ([BookID], [Title], [Author], [ISBN], [PublishYear], [IsAvailable], [AddedDate]) VALUES (N'663955ba-ad15-4a18-b456-b007fddf5b16', N'Гарри Поттер и философский камень', N'Джоан Роулинг', N'978-5-699-12345-6', 1997, 1, CAST(N'2026-06-22T12:05:19.8733333' AS DateTime2))
INSERT [dbo].[Books] ([BookID], [Title], [Author], [ISBN], [PublishYear], [IsAvailable], [AddedDate]) VALUES (N'2c05ec4a-c633-4721-8578-bdb4d0eaceef', N'Краткая история времени', N'Стивен Хокинг', N'978-5-699-45678-9', 1988, 1, CAST(N'2026-06-22T12:05:19.8733333' AS DateTime2))
INSERT [dbo].[Books] ([BookID], [Title], [Author], [ISBN], [PublishYear], [IsAvailable], [AddedDate]) VALUES (N'e158c038-c615-45ba-943a-c558140def8a', N'1984', N'Джордж Оруэлл', N'978-5-699-78901-2', 1949, 1, CAST(N'2026-06-22T12:05:19.8733333' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (1, N'Фантастика', N'Научная фантастика и фэнтези')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (2, N'Детективы', N'Криминальные истории и расследования')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (3, N'Классика', N'Классическая литература')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (4, N'Наука', N'Научно-популярные книги')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (5, N'Приключения', N'Приключенческие романы')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Fines] ON 

INSERT [dbo].[Fines] ([FineID], [LoanID], [Amount], [IssueDate], [IsPaid]) VALUES (1, 2, CAST(60.00 AS Decimal(10, 2)), CAST(N'2026-06-22' AS Date), 0)
INSERT [dbo].[Fines] ([FineID], [LoanID], [Amount], [IssueDate], [IsPaid]) VALUES (2, 3, CAST(500.00 AS Decimal(10, 2)), CAST(N'2026-06-22' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Fines] OFF
GO
SET IDENTITY_INSERT [dbo].[Loans] ON 

INSERT [dbo].[Loans] ([LoanID], [BookID], [ReaderID], [LoanDate], [DueDate], [ReturnDate], [IsReturned]) VALUES (1, N'663955ba-ad15-4a18-b456-b007fddf5b16', 1, CAST(N'2026-06-12T12:05:19.9733333' AS DateTime2), CAST(N'2026-06-26T12:05:19.9733333' AS DateTime2), NULL, 0)
INSERT [dbo].[Loans] ([LoanID], [BookID], [ReaderID], [LoanDate], [DueDate], [ReturnDate], [IsReturned]) VALUES (2, N'9a8e5804-3a31-4f68-9b4d-18a47a72405d', 2, CAST(N'2026-06-02T12:05:19.9800000' AS DateTime2), CAST(N'2026-06-16T12:05:19.9800000' AS DateTime2), NULL, 0)
INSERT [dbo].[Loans] ([LoanID], [BookID], [ReaderID], [LoanDate], [DueDate], [ReturnDate], [IsReturned]) VALUES (3, N'ca60ba5b-42c9-417e-9134-272286794fdd', 3, CAST(N'2026-06-17T12:05:19.9866667' AS DateTime2), CAST(N'2026-07-01T12:05:19.9866667' AS DateTime2), CAST(N'2026-06-20T12:05:19.9866667' AS DateTime2), 1)
INSERT [dbo].[Loans] ([LoanID], [BookID], [ReaderID], [LoanDate], [DueDate], [ReturnDate], [IsReturned]) VALUES (4, N'2c05ec4a-c633-4721-8578-bdb4d0eaceef', 5, CAST(N'2026-06-21T12:05:19.9933333' AS DateTime2), CAST(N'2026-07-05T12:05:19.9933333' AS DateTime2), NULL, 0)
SET IDENTITY_INSERT [dbo].[Loans] OFF
GO
SET IDENTITY_INSERT [dbo].[Readers] ON 

INSERT [dbo].[Readers] ([ReaderID], [FirstName], [LastName], [LibraryCardNumber], [Phone], [RegistrationDate], [IsActive]) VALUES (1, N'Анна', N'Иванова', N'LIB-2025-001', N'+7 (999) 111-11-11', CAST(N'2026-06-22' AS Date), 1)
INSERT [dbo].[Readers] ([ReaderID], [FirstName], [LastName], [LibraryCardNumber], [Phone], [RegistrationDate], [IsActive]) VALUES (2, N'Петр', N'Сидоров', N'LIB-2025-002', N'+7 (999) 222-22-22', CAST(N'2026-06-22' AS Date), 1)
INSERT [dbo].[Readers] ([ReaderID], [FirstName], [LastName], [LibraryCardNumber], [Phone], [RegistrationDate], [IsActive]) VALUES (3, N'Мария', N'Петрова', N'LIB-2025-003', N'+7 (999) 333-33-33', CAST(N'2026-06-22' AS Date), 1)
INSERT [dbo].[Readers] ([ReaderID], [FirstName], [LastName], [LibraryCardNumber], [Phone], [RegistrationDate], [IsActive]) VALUES (4, N'Иван', N'Смирнов', N'LIB-2025-004', N'+7 (999) 444-44-44', CAST(N'2026-06-22' AS Date), 0)
INSERT [dbo].[Readers] ([ReaderID], [FirstName], [LastName], [LibraryCardNumber], [Phone], [RegistrationDate], [IsActive]) VALUES (5, N'Елена', N'Козлова', N'LIB-2025-005', N'+7 (999) 555-55-55', CAST(N'2026-06-22' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Readers] OFF
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_Books_ISBN]    Дата создания скрипта: 22.06.2026 20:22:09 ******/ 
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Books_ISBN] ON [dbo].[Books]
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_Readers_LibraryCardNumber]    Дата создания скрипта: 22.06.2026 20:22:09 ******/ 
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Readers_LibraryCardNumber] ON [dbo].[Readers]
(
	[LibraryCardNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT (newid()) FOR [BookID]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT ((1)) FOR [IsAvailable]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT (getdate()) FOR [AddedDate]
GO
ALTER TABLE [dbo].[Fines] ADD  DEFAULT (getdate()) FOR [IssueDate]
GO
ALTER TABLE [dbo].[Fines] ADD  DEFAULT ((0)) FOR [IsPaid]
GO
ALTER TABLE [dbo].[Loans] ADD  DEFAULT (getdate()) FOR [LoanDate]
GO
ALTER TABLE [dbo].[Loans] ADD  DEFAULT ((0)) FOR [IsReturned]
GO
ALTER TABLE [dbo].[Readers] ADD  DEFAULT (getdate()) FOR [RegistrationDate]
GO
ALTER TABLE [dbo].[Readers] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[BookCategories]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [dbo].[Books] ([BookID])
GO
ALTER TABLE [dbo].[BookCategories]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Fines]  WITH CHECK ADD FOREIGN KEY([LoanID])
REFERENCES [dbo].[Loans] ([LoanID])
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [dbo].[Books] ([BookID])
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD FOREIGN KEY([ReaderID])
REFERENCES [dbo].[Readers] ([ReaderID])
GO
USE [master]
GO
ALTER DATABASE [LibraryDB] SET  READ_WRITE 
GO
