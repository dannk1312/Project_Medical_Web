USE [master]
GO
/****** Object:  Database [DB_Store]    Script Date: 1/3/2021 4:52:10 PM ******/
CREATE DATABASE [DB_Store]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_Store', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DB_Store.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DB_Store_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DB_Store_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DB_Store] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_Store].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_Store] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_Store] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_Store] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_Store] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_Store] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_Store] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB_Store] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_Store] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_Store] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_Store] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_Store] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_Store] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_Store] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_Store] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_Store] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DB_Store] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_Store] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_Store] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_Store] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_Store] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_Store] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_Store] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_Store] SET RECOVERY FULL 
GO
ALTER DATABASE [DB_Store] SET  MULTI_USER 
GO
ALTER DATABASE [DB_Store] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_Store] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_Store] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_Store] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DB_Store] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DB_Store', N'ON'
GO
ALTER DATABASE [DB_Store] SET QUERY_STORE = OFF
GO
USE [DB_Store]
GO
/****** Object:  Table [dbo].[Access]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Access](
	[AccessId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [ntext] NULL,
 CONSTRAINT [PK_Access] PRIMARY KEY CLUSTERED 
(
	[AccessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Name] [ntext] NULL,
	[CreateDate] [date] NULL,
	[Birthday] [date] NULL,
	[Address] [ntext] NULL,
	[Phone] [char](15) NOT NULL,
	[AccessId] [int] NOT NULL,
	[Email] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[AuthorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [ntext] NULL,
	[Introduce] [ntext] NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[AuthorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [ntext] NOT NULL,
	[Introduce] [ntext] NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Delivery]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delivery](
	[ItemId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[BillId] [int] NOT NULL,
 CONSTRAINT [PK_Delivery] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC,
	[BillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discuss]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discuss](
	[DiscussId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [ntext] NULL,
	[StartDate] [datetime] NULL,
	[Introduce] [ntext] NULL,
	[Username] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Discuss] PRIMARY KEY CLUSTERED 
(
	[DiscussId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EarnBill]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EarnBill](
	[BillId] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[StatusId] [int] NULL,
	[Username] [varchar](50) NOT NULL,
	[Price] [money] NULL,
	[Address] [ntext] NOT NULL,
 CONSTRAINT [PK_EarnBill] PRIMARY KEY CLUSTERED 
(
	[BillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [ntext] NOT NULL,
	[PublishDate] [date] NULL,
	[AuthorId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[Introduce] [ntext] NULL,
	[ImagePath] [text] NULL,
	[DiscussId] [int] NULL,
	[Sale] [int] NULL,
	[Rate] [float] NULL,
	[QuantitySold] [int] NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemCategory]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemCategory](
	[CategoryId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
 CONSTRAINT [PK_BookType] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC,
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemRate]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemRate](
	[ItemId] [int] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Rate] [float] NOT NULL,
	[Comment] [ntext] NULL,
 CONSTRAINT [PK_BookRate] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC,
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Message]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message](
	[DiscussId] [int] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[MessageId] [int] IDENTITY(1,1) NOT NULL,
	[Content] [ntext] NULL,
	[Time] [datetime] NULL,
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[DiscussId] ASC,
	[Username] ASC,
	[MessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[NewsId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Content] [ntext] NOT NULL,
	[isPublic] [bit] NOT NULL,
	[DiscussId] [int] NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[NewsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaidBill]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaidBill](
	[BillId] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[StatusId] [int] NOT NULL,
	[PublisherId] [int] NOT NULL,
	[Price] [money] NULL,
 CONSTRAINT [PK_PaidBill] PRIMARY KEY CLUSTERED 
(
	[BillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publisher]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publisher](
	[PublisherId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [ntext] NULL,
	[Introduce] [ntext] NULL,
	[Phone] [char](15) NULL,
	[Address] [ntext] NULL,
 CONSTRAINT [PK_Publisher] PRIMARY KEY CLUSTERED 
(
	[PublisherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Receipt]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Receipt](
	[ItemId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[BillId] [int] NOT NULL,
 CONSTRAINT [PK_Receipt] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC,
	[BillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 1/3/2021 4:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Access] ON 

INSERT [dbo].[Access] ([AccessId], [Name]) VALUES (1, N'ADMIN')
INSERT [dbo].[Access] ([AccessId], [Name]) VALUES (2, N'MEMBER')
SET IDENTITY_INSERT [dbo].[Access] OFF
GO
INSERT [dbo].[Account] ([Username], [Password], [Name], [CreateDate], [Birthday], [Address], [Phone], [AccessId], [Email]) VALUES (N'admin', N'1', N'Nguyễn Khoa Đảnh', CAST(N'2000-12-13' AS Date), CAST(N'2000-12-13' AS Date), N'Việt Nam', N'0923202850     ', 1, N'dannk1312@gmail.com')
GO
SET IDENTITY_INSERT [dbo].[Author] ON 

INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (1, N'MEGA', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (2, N'Công ty cổ phần Dược phẩm Imexpharm', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (3, N'MEBIPHAR JSC', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (4, N'Hisamitsu Việt Nam', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (5, N'Mentholatum Việt Nam', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (6, N'Công ty TNHH B.Braun Việt Nam', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (7, N'BIDIPHAR', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (8, N'International Pharma', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (9, N' Công ty Cổ phần Dược phẩm TV.Pharm', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (10, N'Công ty cổ phần Hóa - Dược phẩm Mekophar', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (11, N'Bình Dương - Nhà máy Dược phẩm OPC', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (12, N'MTV Dược phẩm OPC Bình Dương', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (13, N'Dược Trung ương Mediplantex', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (14, N'Công ty TNHH Liên doanh Stada - Việt Nam', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (15, N'Công ty TNHH Liên doanh Stada - Việt Nam', NULL)
INSERT [dbo].[Author] ([AuthorId], [Name], [Introduce]) VALUES (16, N'Công ty cổ phần Dược phẩm Trung ương 25 (UPHACE', NULL)
SET IDENTITY_INSERT [dbo].[Author] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (46, N'Thuốc cảm lạnh, ho', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (47, N'Thuốc dành cho nam', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (48, N'Giảm đau, hạ sốt', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (49, N'Thuốc cơ xương khớp', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (50, N'Thuốc da liễu', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (51, N'Thuốc dành cho phụ nữ', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (52, N'Thuốc giảm cân', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (53, N'Thuốc kháng dị ứng', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (54, N'Thuốc kháng viêm', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (55, N'Thuốc Mắt/Tai/Mũi', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (56, N'Thuốc ngừa thai', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (57, N'Thuốc thần kinh', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (58, N'Thuốc tiêu hóa', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (59, N'Vitamin & Khoáng chất', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (60, N'Thuốc khác', NULL)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Discuss] ON 

INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (62, N'#New', CAST(N'2020-12-13T00:00:00.000' AS DateTime), N'Nói về tin tức', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (63, N'#TL', CAST(N'2021-01-02T20:10:10.690' AS DateTime), N'Nói về sách Eugica (Hộp 10 vỉ x 10 viên nang mềm)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (64, N'#TL', CAST(N'2021-01-02T20:11:38.677' AS DateTime), N'Nói về sách Eugica (Hộp 10 vỉ x 10 viên nang mềm)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (65, N'#TL', CAST(N'2021-01-02T20:15:45.983' AS DateTime), N'Nói về sách Eugica (Hộp 10 vỉ x 10 viên nang mềm)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (66, N'#TL', CAST(N'2021-01-02T20:23:46.953' AS DateTime), N'Nói về sách Efferalgan (500mg)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (67, N'#TL', CAST(N'2021-01-02T20:25:14.173' AS DateTime), N'Nói về sách Panadol (20 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (68, N'#TL', CAST(N'2021-01-02T20:25:58.293' AS DateTime), N'Nói về sách Panadol Extra (180 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (69, N'#TL', CAST(N'2021-01-03T12:42:01.900' AS DateTime), N'Nói về sách Tyrotab (24 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (70, N'#TL', CAST(N'2021-01-03T12:42:47.187' AS DateTime), N'Nói về sách Thuốc xịt họng Betadine 0.45% (50ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (71, N'#TL', CAST(N'2021-01-03T12:43:12.097' AS DateTime), N'Nói về sách Prospan (100ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (72, N'#TL', CAST(N'2021-01-03T12:43:48.950' AS DateTime), N'Nói về sách Danospan (Chai 100ml/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (73, N'#TL', CAST(N'2021-01-03T12:44:41.483' AS DateTime), N'Nói về sách Dầu gió Trường Sơn (6ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (74, N'#TL', CAST(N'2021-01-03T15:01:35.960' AS DateTime), N'Nói về sách Efferalgan (500mg)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (75, N'#TL', CAST(N'2021-01-03T15:02:40.517' AS DateTime), N'Nói về sách Thuốc giảm đau, hạ sốt Efferalgan (300mg)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (76, N'#TL', CAST(N'2021-01-03T15:04:26.013' AS DateTime), N'Nói về sách Thuốc giảm đau, hạ sốt cho trẻ Hapacol (80mg)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (77, N'#TL', CAST(N'2021-01-03T15:15:35.200' AS DateTime), N'Nói về sách Thuốc giảm đau, hạ sốt Hapacol 325 (10 vỉ x 10 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (78, N'#TL', CAST(N'2021-01-03T15:16:15.790' AS DateTime), N'Nói về sách Thuốc giảm đau, hạ sốt Hapacol 650mg (Chai 100 viên)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (79, N'#TL', CAST(N'2021-01-03T15:16:53.573' AS DateTime), N'Nói về sách Thuốc giảm đau, hạ sốt Hapacol 325 (10 vỉ x 10 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (80, N'#TL', CAST(N'2021-01-03T15:17:32.433' AS DateTime), N'Nói về sách Thuốc hạ sốt, giảm đau Glotadol 650 (10 vỉ x 10 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (81, N'#TL', CAST(N'2021-01-03T15:18:15.733' AS DateTime), N'Nói về sách Thuốc hạ sốt, giảm đau Glotadol 650 (10 vỉ x 10 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (82, N'#TL', CAST(N'2021-01-03T15:19:20.853' AS DateTime), N'Nói về sách Thuốc giảm đau, hạ sốt cho trẻ Hapacol (80mg)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (83, N'#TL', CAST(N'2021-01-03T15:20:23.567' AS DateTime), N'Nói về sách Osla (15ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (84, N'#TL', CAST(N'2021-01-03T15:21:03.753' AS DateTime), N'Nói về sách Nước súc miệng Natri Clorid (500ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (85, N'#TL', CAST(N'2021-01-03T15:22:30.970' AS DateTime), N'Nói về sách Dầu nóng Trường Sơn (10ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (86, N'#TL', CAST(N'2021-01-03T15:24:25.693' AS DateTime), N'Nói về sách Berocca Performance (10 viên/tuýp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (87, N'#TL', CAST(N'2021-01-03T15:25:21.210' AS DateTime), N'Nói về sách Dầu gió xanh Thiên Thảo (12ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (88, N'#TL', CAST(N'2021-01-03T15:27:17.390' AS DateTime), N'Nói về sách Bạch Hổ hoạt lạc cao (20g)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (89, N'#TL', CAST(N'2021-01-03T15:28:02.420' AS DateTime), N'Nói về sách Dầu Phật Linh Trường Sơn (5ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (90, N'#TL', CAST(N'2021-01-03T15:29:21.607' AS DateTime), N'Nói về sách Salonpas Hisamitsu (12 miếng/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (91, N'#TL', CAST(N'2021-01-03T15:30:05.123' AS DateTime), N'Nói về sách Zentel 200mg (2 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (92, N'#TL', CAST(N'2021-01-03T15:31:06.410' AS DateTime), N'Nói về sách Dung dịch sát khuẩn Povidine Povidon Iod 10% (90ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (93, N'#TL', CAST(N'2021-01-03T15:31:54.047' AS DateTime), N'Nói về sách Thuốc điều loét dạ dày-tá tràng Sucralfate (2 vỉ x 10 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (94, N'#TL', CAST(N'2021-01-03T15:32:31.310' AS DateTime), N'Nói về sách V.Rohto New (13ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (95, N'#TL', CAST(N'2021-01-03T15:33:20.307' AS DateTime), N'Nói về sách Genshu (3 vỉ x 10 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (96, N'#TL', CAST(N'2021-01-03T15:34:03.410' AS DateTime), N'Nói về sách Cao hổ đỏ giảm đau nhức cơ Tiger Balm Red (19.4g)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (97, N'#TL', CAST(N'2021-01-03T15:35:07.527' AS DateTime), N'Nói về sách Dầu gió Nâu (10ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (98, N'#TL', CAST(N'2021-01-03T15:35:49.660' AS DateTime), N'Nói về sách Dung dịch vệ sinh phụ nữ Gynofar (250ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (99, N'#TL', CAST(N'2021-01-03T15:36:54.240' AS DateTime), N'Nói về sách Cufo Lozenges (2 vỉ x 12 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (100, N'#TL', CAST(N'2021-01-03T15:37:34.740' AS DateTime), N'Nói về sách Cufo Lozenges hỗ trợ điều trị trong nhiễm khuẩn hầu, họng, miệng và đau rát họng.', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (101, N'#TL', CAST(N'2021-01-03T15:38:13.900' AS DateTime), N'Nói về sách Strepsils Orange & Vita C (2 vỉ x 12 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (102, N'#TL', CAST(N'2021-01-03T15:38:52.773' AS DateTime), N'Nói về sách Strepsils Throat Irritation & Cough (12 x 2 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (103, N'#TL', CAST(N'2021-01-03T15:40:40.220' AS DateTime), N'Nói về sách Strepsils Throat Irritation & Cough (12 x 2 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (104, N'#TL', CAST(N'2021-01-03T15:41:27.653' AS DateTime), N'Nói về sách Mucosolvan 30mg (2 vỉ x 10 viên/hộp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (105, N'#TL', CAST(N'2021-01-03T15:44:37.520' AS DateTime), N'Nói về sách Thuốc điều trị táo bón cho trẻ em Microclism 3g (Hộp 6 tuýp)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (106, N'#TL', CAST(N'2021-01-03T15:45:11.580' AS DateTime), N'Nói về sách Zysmas (Hộp 3 vỉ x 10 viên)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (107, N'#TL', CAST(N'2021-01-03T15:45:48.330' AS DateTime), N'Nói về sách Hagifen 400mg (Hộp 10 vỉ x 10 viên)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (108, N'#TL', CAST(N'2021-01-03T15:46:27.427' AS DateTime), N'Nói về sách New Ameflu Night Time (Hộp 1 chai siro 60ml)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (109, N'#TL', CAST(N'2021-01-03T15:47:09.397' AS DateTime), N'Nói về sách Usaallerz 120mg (Hộp 10 vỉ x 10 viên)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (110, N'#TL', CAST(N'2021-01-03T15:47:56.073' AS DateTime), N'Nói về sách My Para 500mg (Hộp 10 vỉ x 10 viên)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (111, N'#TL', CAST(N'2021-01-03T15:51:00.520' AS DateTime), N'Nói về sách Thuốc mỡ Hồng Linh Cốt (10g)', N'admin')
INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (112, N'#TL', CAST(N'2021-01-03T15:51:36.900' AS DateTime), N'Nói về sách Gamalate B6 (Hộp 1 chai 80ml)', N'admin')
SET IDENTITY_INSERT [dbo].[Discuss] OFF
GO
SET IDENTITY_INSERT [dbo].[Item] ON 

INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (3, N'Eugica (Hộp 10 vỉ x 10 viên nang mềm)', CAST(N'2020-02-02' AS Date), 1, 0, 63000.0000, N'<p><strong>1. Chống chỉ định:</strong><br />
Qu&aacute; mẫn cảm với c&aacute;c th&agrave;nh phần của thuốc. Ho do suyễn, ho lao, suy h&ocirc; hấp, trẻ em dưới 30 th&aacute;ng tuổi, trẻ em c&oacute; tiền sử động kinh hoặc sốt cao.</p>

<p><strong>2. Hướng dẫn sử dụng:</strong><br />
<strong>Chỉ định:</strong><br />
Điều trị c&aacute;c chứng ho, đau họng, sổ mũi, cảm c&uacute;m. L&agrave;m lo&atilde;ng ni&ecirc;m dịch, l&agrave;m dịu ho.<br />
<strong>Liều d&ugrave;ng v&agrave; c&aacute;ch d&ugrave;ng:</strong><br />
Trẻ em tr&ecirc;n 30 th&aacute;ng tuổi: Uống 1 vi&ecirc;n x 3 lần/ng&agrave;y.<br />
Người lớn: Uống 2 vi&ecirc;n x 3 lần/ng&agrave;y.<br />
Hoặc theo chỉ dẫn của Thầy thuốc.<br />
<strong>Thận trọng:</strong><br />
Menthol c&oacute; t&iacute;nh ức chế h&ocirc; hấp qua đường thở (h&iacute;t v&agrave;o mũi) nhất l&agrave; đối với trẻ con &iacute;t tuổi, trẻ sơ sinh.<br />
<strong>Bảo quản:&nbsp;</strong><br />
Bảo quản ở nhiệt độ kh&ocirc;ng qu&aacute; 30 độ C.</p>

<p><strong>3. Th&ocirc;ng tin thuốc:</strong><br />
<strong>Th&agrave;nh phần:</strong><br />
Eucalyptol 100mg, Menthol 0.5mg, Tinh dầu tần 0.18mg, Tinh dầu gừng 0.5mg. T&aacute; dược vừa đủ 1 vi&ecirc;n nang mềm.<br />
<strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i:</strong>&nbsp;Hộp 10 vỉ x 10 vi&ecirc;n<br />
<strong>Xuất xứ thương hiệu:&nbsp;</strong>Th&aacute;i Lan<br />
<strong>Sản xuất tại:&nbsp;</strong>Việt Nam</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00252_1_l.jpg', 65, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (4, N'Efferalgan (500mg)', CAST(N'2020-02-04' AS Date), 5, 0, 46000.0000, N'<p>Thuốc d&ugrave;ng điều trị c&aacute;c chứng đau hoặc sốt như đau đầu, t&igrave;nh trạng như c&uacute;m, đau răng, nhức mỏi cơ, đau bụng kinh. Dạng vi&ecirc;n n&eacute;n sủi bọt sễ bẻ, dễ uống, tiện lợi cho người sử dụng.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00126_1_l.jpg', 66, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (5, N'Panadol (20 viên/hộp)', CAST(N'2020-12-26' AS Date), 16, 0, 58000.0000, NULL, N'https://image.pharmacity.vn/live/uploads/2019/04/P00007_1_l.jpg', 67, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (6, N'Panadol Extra (180 viên/hộp)', CAST(N'2020-11-12' AS Date), 5, 0, 214000.0000, N'<p>Panadol Extra c&oacute; chứa Paracetamol gi&uacute;p giảm đau &ndash; hạ sốt hữu hiệu. Điều trị đau nhẹ đến đau vừa v&agrave; hạ sốt như đau đầu, đau nửa đầu, đau bụng kinh, đau xương, sốt v&agrave; đau sau khi ti&ecirc;m Vacxin, đau sau nhỏ răng hoặc sau c&aacute;c thủ thuật nha khoa, đau răng, đau do vi&ecirc;m xương khớp.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P01392_1_l.jpg', 68, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (7, N'Tyrotab (24 viên/hộp)', CAST(N'2021-12-22' AS Date), 13, 0, 11000.0000, N'<p><strong>1. Chống chỉ định:</strong><br />
Mẫn cảm với c&aacute;c th&agrave;nh phần của thuốc.</p>

<p><strong>2. Hướng dẫn sử dụng:</strong><br />
<strong>Chỉ định:</strong><br />
Điều trị tại chỗ c&aacute;c bệnh ở họng như vi&ecirc;m họng, vi&ecirc;m Amidan, bệnh vi&ecirc;m Vincent v&agrave; c&aacute;c bệnh ở miệng như vi&ecirc;m miệng, vi&ecirc;m lưỡi, vi&ecirc;m lợi, vi&ecirc;m quanh răng.<br />
<strong>Liều d&ugrave;ng v&agrave; c&aacute;ch d&ugrave;ng:</strong><br />
Ngậm 8 &ndash; 10 vi&ecirc;n một ng&agrave;y, để tan chậm trong miệng.<br />
<strong>Thận trọng:</strong><br />
Kh&ocirc;ng d&ugrave;ng qu&aacute; 10 ng&agrave;y.&nbsp;Kh&ocirc;ng d&ugrave;ng cho trẻ em dưới 3 tuổi.<br />
<strong>Bảo quản:&nbsp;</strong><br />
Bảo quản ở nhiệt độ kh&ocirc;ng qu&aacute; 30 độ C.</p>

<p><strong>3. Th&ocirc;ng tin thuốc:</strong><br />
<strong>Th&agrave;nh phần:</strong><br />
Tyrothricin 1mg, Tetracain hydroclorid 0.1mg, t&aacute; dược vừa đủ 1 vi&ecirc;n.<br />
<strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i:</strong>&nbsp;Hộp 24 vi&ecirc;n<br />
<strong>Xuất xứ thương hiệu:</strong>&nbsp;Việt Nam<br />
<strong>Nh&agrave; sản xuất:</strong>&nbsp;Pharmedic</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00355_1_l.jpg', 69, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (8, N'Thuốc xịt họng Betadine 0.45% (50ml)', CAST(N'2018-02-22' AS Date), 16, 0, 95000.0000, N'<p><strong>3. Th&ocirc;ng tin thuốc</strong><br />
<strong>Th&agrave;nh phần:</strong><br />
Povidone-Iodine 0.45% kl/tt.<br />
T&aacute; dược: Glycerol, menthol, eucalyptus oil, Kali iodide, nước tinh khiết<br />
<strong>Dung t&iacute;ch:&nbsp;</strong>50ml<br />
<strong>Xuất xứ thương hiệu:</strong>&nbsp;Mỹ</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P10066_1_l.jpg', 70, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (9, N'Prospan (100ml)', CAST(N'2020-11-12' AS Date), 1, 0, 68000.0000, N'<p><strong>3. Th&ocirc;ng tin thuốc:</strong><br />
<strong>Th&agrave;nh phần:&nbsp;</strong>Cao kh&ocirc; l&aacute; thường xu&acirc;n 0.7g, t&aacute; dược vừa đủ.&nbsp;<br />
<strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i:</strong>&nbsp;Hộp 1 chai 100ml&nbsp;<br />
<strong>Xuất xứ thương hiệu:</strong>&nbsp;Đức<br />
<strong>Nh&agrave; sản xuất:</strong>&nbsp;Engelhard</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00296_1_l.jpg', 71, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (10, N'Danospan (Chai 100ml/hộp)', CAST(N'2021-02-21' AS Date), 3, 0, 10000.0000, N'<p><strong>3. Th&ocirc;ng tin thuốc:<br />
Th&agrave;nh phần:</strong><br />
Cao kh&ocirc; l&aacute; Thường xu&acirc;n: 0.7g (tương ứng 4.55g l&aacute; Thường xu&acirc;n (Folium Hederae)<br />
T&aacute; dược vừa đủ 100ml<br />
<strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i:</strong>&nbsp;Hộp 1 chai 100ml<br />
<strong>Xuất xứ thương hiệu:</strong>&nbsp;Việt Nam</p>
', N'https://image.pharmacity.vn/live/uploads/2019/10/P14745_1_l.jpg', 72, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (11, N'Dầu gió Trường Sơn (6ml)', CAST(N'2020-12-20' AS Date), 6, 0, 15000.0000, N'<p><strong>Th&agrave;nh phần:</strong><br />
Chiết xuất tinh dầu bạc h&agrave;: 3g, Menthol: 22g, tinh dầu đinh hương: 0.2g, long n&atilde;o: 2g, Eucalypol: 4.8g.Dầu Parafin vđ: 100ml.</p>

<p><strong>C&ocirc;ng dụng:</strong><br />
Trị cảm ho, sổ mũi, nhức đầu, đau bụng, ch&oacute;ng mặt, nhức mỏi tay ch&acirc;n, say s&oacute;ng khi đi t&agrave;u xe, buồn n&ocirc;n, sưng vi&ecirc;m, trật g&acirc;n, kiến cắn, muỗi ch&iacute;ch&hellip;</p>

<p><strong>C&aacute;ch sử dụng:&nbsp;</strong><br />
Thoa v&agrave; xoa b&oacute;p chỗ đau, pha với nước ấm để x&ocirc;ng, thoa b&ocirc;i l&ecirc;n mũi để h&iacute;t v&agrave; ngửi.</p>

<p><strong>Bảo quản:&nbsp;</strong><br />
Nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t, tr&aacute;nh &aacute;nh nắng trực tiếp.</p>

<p><strong>Dung t&iacute;ch:&nbsp;</strong>Chai 6ml</p>

<p><strong>Xuất xứ thương hiệu:</strong>&nbsp;Việt Nam</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00024_1_l.jpg', 73, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (12, N'Efferalgan (500mg)', CAST(N'2020-12-22' AS Date), 4, 0, 70000.0000, N'<p><strong>3. Th&ocirc;ng tin thuốc:</strong><br />
<strong>Th&agrave;nh phần:&nbsp;</strong>Paracetamol 500mg, t&aacute; dược vừa đủ.<br />
<strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i:</strong>&nbsp;Hộp 16 vi&ecirc;n<br />
<strong>Xuất xứ thương hiệu:</strong>&nbsp;Ph&aacute;p</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00126_1_l.jpg', 74, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (13, N'Thuốc giảm đau, hạ sốt Efferalgan (300mg)', CAST(N'2021-02-25' AS Date), 10, 0, 450000.0000, N'<p><strong>3. Th&ocirc;ng tin thuốc:</strong></p>

<p><strong>Th&agrave;nh phần:&nbsp;</strong>Paracetamol 300mg, T&aacute; dược vừa đủ 1 vi&ecirc;n đạn.<br />
<strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i:</strong>&nbsp;Hộp 10 vi&ecirc;n<br />
<strong>Xuất xứ thương hiệu:</strong>&nbsp;Ph&aacute;p</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00014_1_l.jpg', 75, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (14, N'Thuốc giảm đau, hạ sốt cho trẻ Hapacol (80mg)', CAST(N'2021-12-22' AS Date), 7, 0, 15000.0000, N'<p>Hạ sốt, giảm đau cho trẻ trong c&aacute;c trường hợp: Cảm, c&uacute;m, sốt xuất huyết, nhiễm khuẩn, nhiễm si&ecirc;u vi, mọc răng, sau khi ti&ecirc;m chủng, sau phẫu thuật. Thuốc dạng vi&ecirc;n sủi gi&uacute;p trẻ dễ uống</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00020_1_l.jpg', 76, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (15, N'Thuốc giảm đau, hạ sốt Hapacol 325 (10 vỉ x 10 viên/hộp)', CAST(N'2020-12-20' AS Date), 6, 0, 56000.0000, N'<p><strong>Liều d&ugrave;ng v&agrave; c&aacute;ch d&ugrave;ng:</strong><br />
C&aacute;ch mỗi 6 giờ uống một lần.<br />
Trẻ em từ 6 đến 12 tuổi: Uống 1 vi&ecirc;n/ lần.<br />
Người lớn v&agrave; trẻ em tr&ecirc;n 12 tuổi: Uống 1&nbsp;<sup>1</sup>/2 vi&ecirc;n/lần.<br />
<strong>Thận trọng:</strong><br />
Uống nhiều rượu c&oacute; thể g&acirc;y tăng độc t&iacute;nh với gan của Paracetamol, n&ecirc;n tr&aacute;nh hoặc hạn chế uống rượu.<br />
<strong>Bảo quản:&nbsp;</strong><br />
Bảo quản ở nhiệt độ kh&ocirc;ng qu&aacute; 30 độ C.</p>

<p><strong>3. Th&ocirc;ng tin thuốc:</strong><br />
<strong>Th&agrave;nh phần:&nbsp;</strong>Paracetamol 325mg, t&aacute; dược vừa đủ.<br />
<strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i:</strong>&nbsp;Hộp 10 vỉ x 10 vi&ecirc;n n&eacute;n d&agrave;i<br />
<strong>Xuất xứ thương hiệu:&nbsp;</strong>Việt Nam</p>
', N'https://image.pharmacity.vn/live/uploads/2019/05/P00514_1-1087x800.jpg', 77, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (16, N'Thuốc giảm đau, hạ sốt Hapacol 650mg (Chai 100 viên)', CAST(N'2020-02-22' AS Date), 8, 0, 78000.0000, N'<p><strong>2. Hướng dẫn sử dụng:</strong><br />
<strong>Chỉ định:</strong><br />
L&agrave;m giảm c&aacute;c cơn đau như đau đầu, đau họng, đau bụng kinh, đau răng, đau nhức cơ, g&acirc;n, đau do chấn thương, đau nhức do vi&ecirc;m xoang, cảm lạnh, cảm c&uacute;m. Hạ sốt.<br />
<strong>Liều d&ugrave;ng v&agrave; c&aacute;ch d&ugrave;ng:</strong><br />
Người lớn v&agrave; trẻ em tr&ecirc;n 12 tuổi: Uống 1 vi&ecirc;n x 3 &ndash; 4 lần/ ng&agrave;y. Khoảng c&aacute;ch giữa hai lần uống từ 4 &ndash; 6 giờ. Kh&ocirc;ng uống qu&aacute; 6 vi&ecirc;n/ ng&agrave;y.<br />
Trường hợp bệnh nh&acirc;n suy thận nặng (độ thanh thải creatinin &lt; 10 ml/ ph&uacute;t), khoảng c&aacute;ch giữa c&aacute;c liều uống phải &iacute;t nhất l&agrave; 8 giờ.<br />
Hoặc theo chỉ dẫn của Thầy thuốc.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P10719_1_l.jpg', 78, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (17, N'Thuốc giảm đau, hạ sốt Hapacol 325 (10 vỉ x 10 viên/hộp)', CAST(N'2020-02-22' AS Date), 9, 0, 45000.0000, N'<p>Hapacol 325mg điều trị c&aacute;c triệu chứng đau trong c&aacute;c trường hợp: Đau đầu, đau nửa đầu, đau răng, đau nhức do cảm c&uacute;m, đau họng, đau nhức cơ xương, đau do vi&ecirc;m khớp, đau sau khi ti&ecirc;m ngừa hay nhổ răng. Hạ sốt ở bệnh nh&acirc;n bị cảm hay những bệnh c&oacute; li&ecirc;n quan đến sốt.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/05/P00514_1-1087x800.jpg', 79, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (18, N'Thuốc hạ sốt, giảm đau Glotadol 650 (10 vỉ x 10 viên/hộp)', CAST(N'2020-02-20' AS Date), 5, 0, 15000.0000, N'<p>Glotadol 650 l&agrave; thuốc hạ sốt v&agrave; g&oacute;p phần l&agrave;m giảm c&aacute;c cơn đau từ nhẹ đến vừa như đau đầu v&agrave; đau cơ th&ocirc;ng thường, đau nhức do cảm c&uacute;m hay cảm lạnh, đau lưng, đau răng, đau do vi&ecirc;m khớp nhẹ v&agrave; đau do h&agrave;nh kinh.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/05/P10316_1.jpg', 80, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (19, N'Thuốc hạ sốt, giảm đau Glotadol 650 (10 vỉ x 10 viên/hộp)', CAST(N'2020-02-20' AS Date), 13, 0, 214000.0000, N'<p>Glotadol 650 l&agrave; thuốc hạ sốt v&agrave; g&oacute;p phần l&agrave;m giảm c&aacute;c cơn đau từ nhẹ đến vừa như đau đầu v&agrave; đau cơ th&ocirc;ng thường, đau nhức do cảm c&uacute;m hay cảm lạnh, đau lưng, đau răng, đau do vi&ecirc;m khớp nhẹ v&agrave; đau do h&agrave;nh kinh.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/05/P10316_1.jpg', 81, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (20, N'Thuốc giảm đau, hạ sốt cho trẻ Hapacol (80mg)', CAST(N'2019-12-23' AS Date), 5, 0, 480000.0000, N'<p>Hạ sốt, giảm đau cho trẻ trong c&aacute;c trường hợp: Cảm, c&uacute;m, sốt xuất huyết, nhiễm khuẩn, nhiễm si&ecirc;u vi, mọc răng, sau khi ti&ecirc;m chủng, sau phẫu thuật. Thuốc dạng vi&ecirc;n sủi gi&uacute;p trẻ dễ uống.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00020_1_l.jpg', 82, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (21, N'Osla (15ml)', CAST(N'2010-08-30' AS Date), 12, 0, 17000.0000, N'<p>Thuốc nhỏ mắt d&ugrave;ng cho mỏi mắt, mắt kh&ocirc;, ngứa, cộm, đỏ mắt, mờ mắt, chảy nước mắt v&agrave; kh&oacute; chịu mắt. Rửa mắt để loại bỏ c&aacute;c vật lạ như bụi bẩn v&agrave;o mắt, l&agrave;m sạch gh&egrave;n mắt. Ph&ograve;ng ngừa c&aacute;c bệnh đau mắt.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00541_1_l.jpg', 83, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (22, N'Nước súc miệng Natri Clorid (500ml)', CAST(N'2020-10-23' AS Date), 14, 0, 41500.0000, N'<p>Nước s&uacute;c miệng Natri Clorid chứa Natri Clorid được pha lo&atilde;ng với nước tinh khiết tỉ lệ 0.9%. Nước muối s&uacute;c miệng Natri Clorid 0.9% sau khi qua hệ thống lọc đều được chạy qua tia UV để ti&ecirc;u diệt 99.99% vi khuẩn v&agrave; loại bỏ tất cả những tạp chất c&oacute; trong nước, gi&uacute;p bạn ho&agrave;n to&agrave;n an t&acirc;m về chất lượng sản phẩm.</p>

<p>C&ograve;n h&agrave;ng</p>
', N'https://image.pharmacity.vn/live/uploads/2019/08/P14351_1_l.jpg', 84, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (23, N'Dầu nóng Trường Sơn (10ml)', CAST(N'2020-09-12' AS Date), 10, 0, 70000.0000, N'<p>Dầu n&oacute;ng Trường Sơn chủ trị cảm, ho, sổ mũi, tr&uacute;ng gi&oacute;, nhức đầu, say t&agrave;u xe, xoa b&oacute;p chống vi&ecirc;m cảm, muỗi ch&iacute;ch, kiến cắn, buồn n&ocirc;n, đau bụng, nhức mỏi tay ch&acirc;n, đau khớp, trật g&acirc;n.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00056_1_l.jpg', 85, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (24, N'Berocca Performance (10 viên/tuýp)', CAST(N'2020-12-20' AS Date), 11, 0, 90000.0000, N'<p>Vi&ecirc;n sủi bổ sung Vitamin Berocca Performance d&ugrave;ng để ph&ograve;ng ngừa v&agrave; bổ sung trong c&aacute;c t&igrave;nh trạng tăng nhu cầu hoặc tăng nguy cơ thiếu Vitamin, như khi bị stress hoặc mệt mỏi, bứt rứt kh&oacute; chịu, mất ngủ.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00053_1_l.jpg', 86, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (25, N'Dầu gió xanh Thiên Thảo (12ml)', NULL, 9, 0, 160000.0000, N'<p>Dầu gi&oacute; xanh Thi&ecirc;n Thảo với c&aacute;c th&agrave;nh phần đến từ tự nhi&ecirc;n như tinh dầu bạc h&agrave;, tinh dầu đinh hương v&agrave; một số th&agrave;nh phần kh&aacute;c gi&uacute;p điều trị cảm, ho, sổ mũi, nhức đầu, nhức mỏi&hellip; Tiện lợi cho sức khỏe gia đ&igrave;nh bạn.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00066_1_l.jpg', 87, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (26, N'Bạch Hổ hoạt lạc cao (20g)', CAST(N'2020-01-12' AS Date), 11, 0, 21000.0000, N'<p>Cao xoa b&oacute;p Bạch Hổ hoạt lạc cao với c&aacute;c th&agrave;nh phần c&oacute; nguồn gốc từ tự nhi&ecirc;n gi&uacute;p trị c&aacute;c chứng đau lưng cấp, m&atilde;n t&iacute;nh, đau thần kinh tọa, vi&ecirc;m khớp ch&acirc;n tay, co duỗi kh&oacute; khăn, t&eacute; ng&atilde;, bong trật g&acirc;n do lao động hoặc khi chơi thể thao, nhức mỏi cơ bắp, trẹo cổ, mỏi g&aacute;y, đau đầu, c&ocirc;n tr&ugrave;ng cắn.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00058_1_l.jpg', 88, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (27, N'Dầu Phật Linh Trường Sơn (5ml)', CAST(N'2018-12-20' AS Date), 13, 0, 45810.0000, N'<p>Dầu Phật Linh Trường Sơn với c&aacute;c th&agrave;nh phần đến từ tự nhi&ecirc;n như tinh dầu bạc h&agrave;, tinh dầu đinh hương v&agrave; khuynh diệp gi&uacute;p điều trị cảm, ho, sổ mũi, nhức đầu, nhức mỏi. Tiện lợi cho sức khỏe gia đ&igrave;nh bạn.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00054_1_l.jpg', 89, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (28, N'Salonpas Hisamitsu (12 miếng/hộp)', CAST(N'2016-02-20' AS Date), 14, 0, 14000.0000, N'<p>Salonpas d&ugrave;ng để giảm đau nhanh ch&oacute;ng, kh&aacute;ng vi&ecirc;m trong c&aacute;c cơn đau li&ecirc;n quan đến c&aacute;c triệu chứng đau khớp, đau cơ, đau lưng, căng cơ, bong g&acirc;n, đau răng. Tiện lợi cho sức khỏe gia đ&igrave;nh bạn.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00073_1_l.jpg', 90, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (29, N'Zentel 200mg (2 viên/hộp)', CAST(N'2012-10-21' AS Date), 2, 0, 20000.0000, N'<p>Zentel 200mg c&oacute; chứa th&agrave;nh phần ch&iacute;nh Albendazole gi&uacute;p điều trị nhiễm giun đũa, giun kim, giun m&oacute;c, giun t&oacute;c.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00224_1_l.jpg', 91, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (30, N'Dung dịch sát khuẩn Povidine Povidon Iod 10% (90ml)', CAST(N'2015-10-20' AS Date), 14, 0, 78000.0000, N'<p>Dung dịch s&aacute;t khuẩn Povidine 10% gi&uacute;p s&aacute;t khuẩn da, ni&ecirc;m mạc trước khi phẫu thuật. Khử tr&ugrave;ng dụng cụ trước khi tiệt tr&ugrave;ng.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P01875_1_l.jpg', 92, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (31, N'Thuốc điều loét dạ dày-tá tràng Sucralfate (2 vỉ x 10 viên/hộp)', CAST(N'2018-12-20' AS Date), 12, 0, 48500.0000, N'<p>Sucralfate điều trị lo&eacute;t dạ d&agrave;y &ndash; t&aacute; tr&agrave;ng, vi&ecirc;m dạ d&agrave;y m&atilde;n t&iacute;nh, lo&eacute;t l&agrave;nh t&iacute;nh. Ph&ograve;ng t&aacute;i ph&aacute;t lo&eacute;t t&aacute; tr&agrave;ng, ph&ograve;ng lo&eacute;t dạ d&agrave;y do stress. Điều trị bệnh tr&agrave;o ngược dạ d&agrave;y &ndash; thưc quản.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P01246_1_l.jpg', 93, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (32, N'V.Rohto New (13ml)', NULL, 15, 0, 15000.0000, N'<p>Thuốc nhỏ mắt điều trị mỏi mắt, đỏ mắt v&agrave; giữ ẩm cho mắt V.Rohto New d&ugrave;ng trong c&aacute;c trường hợp mỏi mắt, xung huyết kết mạc, bệnh mắt do tia cực t&iacute;m, nh&igrave;n mờ do tiết dịch, ngứa mắt do bụi bẩn, mồ h&ocirc;i rơi v&agrave;o mắt, khắc phục t&igrave;nh trạng kh&oacute; chịu, giữ ẩm cho mắt mang lại cho bạn đ&ocirc;i mắt khỏe đẹp hơn.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00057_1_l.jpg', 94, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (33, N'Genshu (3 vỉ x 10 viên/hộp)', CAST(N'2020-02-21' AS Date), 16, 0, 36500.0000, N'<p>Thuốc Genshu với th&agrave;nh phần chứa c&aacute;c loại thảo dược qu&yacute; hiếm c&oacute; t&aacute;c dụng bổ thận, tr&aacute;ng dương, sinh tinh ở nam giới, gia tăng lượng testosterone trong m&aacute;u, bồi bổ nguy&ecirc;n kh&iacute; v&agrave; n&acirc;ng cao sức khỏe to&agrave;n diện cho c&aacute;nh m&agrave;y r&acirc;u.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/06/P14100_1_l.jpg', 95, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (34, N'Cao hổ đỏ giảm đau nhức cơ Tiger Balm Red (19.4g)', CAST(N'2018-02-25' AS Date), 11, 0, 125000.0000, N'<p>Tiger Balm Red với hỗn chất từ tự nhi&ecirc;n gi&uacute;p giảm c&aacute;c chứng đau đầu, ngạt mũi, đau do c&ocirc;n tr&ugrave;ng cắn, ngứa, đau nhức cơ, bong g&acirc;n v&agrave; đầy hơi.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P01292_1_l.jpg', 96, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (35, N'Dầu gió Nâu (10ml)', CAST(N'2017-09-12' AS Date), 13, 0, 36000.0000, N'<p><strong>Thận trọng:</strong><br />
Kh&ocirc;ng b&ocirc;i dầu l&ecirc;n ni&ecirc;m mạc, vết thương hở hoặc vết thương chảy m&aacute;u.<br />
Kh&ocirc;ng thoa v&ugrave;ng v&uacute; khi cho con b&uacute;.</p>

<p><strong>Bảo quản:&nbsp;</strong><br />
Bảo quản ở nhiệt độ kh&ocirc;ng qu&aacute; 30 độ C.</p>

<p><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i:</strong>&nbsp;Chai 10ml</p>

<p><strong>Xuất xứ thương hiệu:&nbsp;</strong>Việt Nam</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00814_1_l.jpg', 97, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (36, N'Dung dịch vệ sinh phụ nữ Gynofar (250ml)', CAST(N'2018-12-21' AS Date), 11, 0, 18000.0000, N'<p>Dung dịch vệ sinh phụ nữ Gynofar gi&uacute;p trị ngứa &acirc;m hộ, vi&ecirc;m &acirc;m đạo, huyết trắng. Đồng thời s&aacute;t tr&ugrave;ng ngo&agrave;i da như vết thương, mụn nhọt, r&ocirc;m sảy.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00802_1_l.jpg', 98, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (37, N'Cufo Lozenges (2 vỉ x 12 viên/hộp)', CAST(N'2010-02-12' AS Date), 13, 0, 86000.0000, N'<p>Cufo Lozenges hỗ trợ điều trị trong nhiễm khuẩn hầu, họng, miệng v&agrave; đau r&aacute;t họng.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/08/P14103_1_l.jpg', 99, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (38, N'Cufo Lozenges hỗ trợ điều trị trong nhiễm khuẩn hầu, họng, miệng và đau rát họng.', CAST(N'2020-02-20' AS Date), 10, 0, 25400.0000, N'<p>Vi&ecirc;n ngậm kh&aacute;ng khuẩn, giảm ho Strepsils Original đem lại sự dễ chịu, giảm đau họng. Mỗi vi&ecirc;n ngậm chứa sự kết hợp 2 chất kh&aacute;ng khuẩn, gi&uacute;p giảm đau họng th&iacute;ch hợp cho cả trẻ em v&agrave; người lớn.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00030_1_l.jpg', 100, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (39, N'Strepsils Orange & Vita C (2 vỉ x 12 viên/hộp)', CAST(N'2015-05-20' AS Date), 12, 0, 15000.0000, N'<p>Vi&ecirc;n ngậm Strepsils Orange &amp; Vitamin C gi&uacute;p kh&aacute;ng khuẩn l&agrave;m giảm đau họng d&ugrave;ng cho trẻ em v&agrave; người lớn.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00307_1_l.jpg', 101, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (40, N'Strepsils Throat Irritation & Cough (12 x 2 viên/hộp)', CAST(N'2014-10-20' AS Date), 1, 0, 145000.0000, N'<p>Vi&ecirc;m ngậm Strepsils Throat Irritation &amp; Cough l&agrave;m sạch đường thở, kiểm so&aacute;t ho do phổi g&acirc;y ra bởi chất dịch nhầy dầy đặc.</p>
', N'https://image.pharmacity.vn/live/uploads/2020/12/P13702_1_l.jpg', 102, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (41, N'Strepsils Throat Irritation & Cough (12 x 2 viên/hộp)', CAST(N'2014-10-25' AS Date), 16, 0, 100000.0000, N'<p>Vi&ecirc;m ngậm Strepsils Throat Irritation &amp; Cough l&agrave;m sạch đường thở, kiểm so&aacute;t ho do phổi g&acirc;y ra bởi chất dịch nhầy dầy đặc.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P06367_1_l.jpg', 103, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (42, N'Mucosolvan 30mg (2 vỉ x 10 viên/hộp)', CAST(N'2014-02-21' AS Date), 14, 0, 20700.0000, N'<p>Thuốc l&agrave;m giảm dịch đờm ở bệnh phế quản phổi cấp v&agrave; m&atilde;n t&iacute;nh li&ecirc;n quan đến sự tiết dịch nhầy bất thường v&agrave; sự vận chuyển chất nhầy.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00602_1_l.jpg', 104, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (43, N'Thuốc điều trị táo bón cho trẻ em Microclism 3g (Hộp 6 tuýp)', CAST(N'2010-12-20' AS Date), 12, 0, 7000.0000, N'<p>Thuốc điều trị t&aacute;o b&oacute;n Microclism 3g Trẻ em trong thời gian ngắn gi&uacute;p cho việc b&agrave;i tiết nhanh v&agrave; dễ hơn.</p>
', N'https://image.pharmacity.vn/live/uploads/2019/04/P00566_1_l.jpg', 105, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (44, N'Zysmas (Hộp 3 vỉ x 10 viên)', CAST(N'2018-10-23' AS Date), 1, 0, 135000.0000, N'<p>Hoạt chất: Alpha amylase (dưới dạng Fungal diastase 1 : 800) &ndash; 100mg; Papain &ndash; 100mg; Simethicon &ndash; 30mg.C&ocirc;ng dụng: D&ugrave;ng khi kh&oacute; ti&ecirc;u, ăn kh&ocirc;ng ngon, đầy hơi, đầy bụng sau ăn. Thiếu enzyme ti&ecirc;u h&oacute;a như: thiểu năng tụy, xơ nang tụy. K&iacute;ch th&iacute;ch ti&ecirc;u h&oacute;a sau phẫu thuật đường ti&ecirc;u h&oacute;a.Đối tượng sử dụng: Người lớn v&agrave; trẻ em tr&ecirc;n 12 tuổi. Trẻ dưới 12 tuổi phải c&oacute; hướng dẫn của thầy thuốc.H&igrave;nh thức: Vi&ecirc;n nang cứng.Thương hiệu: XL Laboratories Pvt., Ltd (Ấn Độ)</p>
', N'https://image.pharmacity.vn/live/uploads/2020/12/P15317_1_l.jpg', 106, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (45, N'Hagifen 400mg (Hộp 10 vỉ x 10 viên)', CAST(N'2016-10-12' AS Date), 13, 0, 50000.0000, N'<p>Hoạt chất: Ibuprofen (400mg)C&ocirc;ng dụng: Giảm đau v&agrave; kh&aacute;ng vi&ecirc;m từ nhẹ đến vừa trong c&aacute;c trường hợp: Đau đầu, đau răng, đau bụng kinh, đau khớp, đau m&ocirc; mềm trong chấn thương v&agrave; đau sau mổ.H&igrave;nh thức: Vi&ecirc;n n&eacute;n d&agrave;i bao phim.Thương hiệu: DHG Pharma (Việt Nam).</p>
', N'https://image.pharmacity.vn/live/uploads/2020/12/P14978_1_l.jpg', 107, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (46, N'New Ameflu Night Time (Hộp 1 chai siro 60ml)', CAST(N'2020-10-20' AS Date), 12, 0, 156000.0000, N'<p>Hoạt chất: Mỗi muỗng c&agrave; ph&ecirc; (5ml) siro chứa:<br />
Clorpheniramin maleat 1mg.<br />
Acetaminophen 160mg.<br />
Phenylephrine HCl 2.5mg.</p>

<p>C&ocirc;ng dụng: Giảm c&aacute;c triệu chứng cảm lạnh (chảy mũi, sốt, nhức đầu, ho, đau họng).</p>

<p>Đối tượng sử dụng: Trẻ em tr&ecirc;n 4 tuổi.</p>

<p>H&igrave;nh thức: Siro.</p>
', N'https://image.pharmacity.vn/live/uploads/2020/12/P00698_1_l.jpg', 108, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (47, N'Usaallerz 120mg (Hộp 10 vỉ x 10 viên)', CAST(N'2015-10-23' AS Date), 13, 0, 57000.0000, N'<p><strong>Hoạt chất:</strong>&nbsp;Fexofenadin hydroclorid (120 mg).</p>

<p><strong>C&ocirc;ng dụng:</strong><br />
Điều trị triệu chứng vi&ecirc;m mũi dị ứng theo m&ugrave;a.<br />
Bệnh nổi m&agrave;y đay mạn t&iacute;nh v&ocirc; căn.</p>

<p><strong>Đối tượng sử dụng:</strong>&nbsp;Người lớn v&agrave; trẻ em từ 12 tuổi trở l&ecirc;n.</p>

<p><strong>H&igrave;nh thức:</strong>&nbsp;Vi&ecirc;n n&eacute;n bao phim.</p>

<p><strong>Thương hiệu:</strong>&nbsp;AMPHARCO U.S.A (Việt Nam).</p>
', N'https://image.pharmacity.vn/live/uploads/2020/11/P15227_1_l.jpg', 109, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (48, N'My Para 500mg (Hộp 10 vỉ x 10 viên)', CAST(N'2009-04-25' AS Date), 13, 0, 26000.0000, N'<p><strong>Hoạt chất:</strong>&nbsp;Paracetamol 500mg</p>

<p><strong>C&ocirc;ng dụng:</strong>&nbsp;Điều trị c&aacute;c chứng đau v&agrave; sốt từ nhẹ đến vừa.</p>

<p><strong>Đối tượng sử dụng:</strong>&nbsp;Người lớn v&agrave; trẻ em từ 6 tuổi trở l&ecirc;n.</p>

<p><strong>H&igrave;nh thức:</strong>&nbsp;Vi&ecirc;n n&eacute;n d&agrave;i bao phim.</p>
', N'https://image.pharmacity.vn/live/uploads/2020/12/P13559_1_l.jpg', 110, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (49, N'Thuốc mỡ Hồng Linh Cốt (10g)', CAST(N'2018-02-25' AS Date), 1, 0, 30000.0000, N'<p><strong>Hoạt chất:</strong>&nbsp;Nọc rắn hổ mang kh&ocirc;, tinh dầu bạc h&agrave;, long n&atilde;o&hellip;</p>

<p><strong>C&ocirc;ng dụng:</strong>&nbsp;D&ugrave;ng điều trị c&aacute;c bệnh thấp khớp, vi&ecirc;m đau khớp, vi&ecirc;m cơ&hellip;</p>

<p><strong>Đối tượng sử dụng:</strong>&nbsp;Người lớn v&agrave; trẻ em tr&ecirc;n 30 th&aacute;ng tuổi. Kh&ocirc;ng d&ugrave;ng cho PNCT &amp; PNCCB.</p>

<p><strong>H&igrave;nh thức:</strong>&nbsp;Mỡ b&ocirc;i ngo&agrave;i da.</p>

<p><strong>Thương hiệu:</strong>&nbsp;Hồng Linh Cốt (Việt Nam).</p>
', N'https://image.pharmacity.vn/live/uploads/2020/12/P12025_1_l.jpg', 111, NULL, 0, 0)
INSERT [dbo].[Item] ([ItemId], [Name], [PublishDate], [AuthorId], [Quantity], [Price], [Introduce], [ImagePath], [DiscussId], [Sale], [Rate], [QuantitySold]) VALUES (50, N'Gamalate B6 (Hộp 1 chai 80ml)', CAST(N'2008-04-04' AS Date), 14, 0, 79000.0000, N'<p><strong>Hoạt chất:</strong>&nbsp;Cho mỗi 5ml:<br />
Magne glutamate hydrobromide &hellip;&hellip;&hellip; 100mg<br />
y-amino-butyric acid (GABA) &hellip;&hellip;&hellip; 100mg<br />
y-amino&ndash;hydroxy-butyric acid (GABOB) &hellip;&hellip;&hellip; 50 mg<br />
Vitamin B6 &hellip;&hellip;&hellip; 50mg</p>

<p><strong>C&ocirc;ng dụng:</strong>&nbsp;Hỗ trợ trong điều trị suy nhược thần kinh chức năng.</p>

<p><strong>Đối tượng sử dụng:</strong>&nbsp;Trẻ em v&agrave; người lớn.</p>

<p><strong>H&igrave;nh thức:</strong>&nbsp;Dung dịch uống.Thương hiệu: Ferrer International (T&acirc;y Ban Nha)</p>
', N'https://image.pharmacity.vn/live/uploads/2020/12/P06108_1_l.jpg', 112, NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[Item] OFF
GO
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 3)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 4)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 5)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 6)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 7)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 8)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 10)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 11)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 12)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 14)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 15)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 16)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 19)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 20)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 21)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 22)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 24)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 25)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 26)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 28)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 30)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 31)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 33)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 37)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 42)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (46, 43)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 7)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 8)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 13)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 14)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 17)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 20)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 22)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 23)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 24)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 25)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 26)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 28)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 30)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 31)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 32)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 33)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 34)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 35)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 36)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 38)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 40)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 41)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 45)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 46)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 48)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (47, 50)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 4)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 5)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 6)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 11)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 12)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 21)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 22)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 24)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 30)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 31)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 32)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 33)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 35)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 37)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 39)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 41)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 42)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 45)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 47)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (48, 49)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (49, 10)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (49, 11)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (49, 13)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (49, 15)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (49, 23)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (49, 27)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (49, 34)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (49, 36)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (49, 39)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (49, 43)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (49, 48)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (49, 49)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (50, 19)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (50, 41)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (50, 44)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (51, 20)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (51, 21)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (51, 28)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (51, 32)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (51, 40)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (51, 45)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (51, 46)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (51, 50)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (52, 7)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (52, 10)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (52, 13)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (52, 14)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (52, 17)
GO
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (52, 18)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (52, 20)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (52, 26)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (52, 27)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (52, 39)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (52, 42)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (53, 4)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (53, 8)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (53, 18)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (53, 47)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (53, 49)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (54, 17)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (54, 20)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (54, 25)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (54, 46)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (54, 50)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (55, 16)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (55, 29)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (55, 44)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (56, 19)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (56, 28)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (56, 35)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (56, 36)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (56, 37)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (56, 40)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (57, 22)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (57, 23)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (57, 34)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (57, 38)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (57, 48)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (58, 35)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (58, 40)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (58, 41)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (58, 43)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (58, 44)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (59, 16)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (59, 19)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (59, 26)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (59, 27)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (59, 38)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (60, 15)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (60, 18)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (60, 20)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (60, 27)
INSERT [dbo].[ItemCategory] ([CategoryId], [ItemId]) VALUES (60, 32)
GO
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([NewsId], [Username], [Content], [isPublic], [DiscussId], [Date]) VALUES (7, N'admin', N'<p style="text-align:center"><span style="color:#c0392b"><span style="font-size:20px"><strong>LỜI GIỚI THIỆU</strong></span></span></p>

<p>daithuvien.com&nbsp;l&agrave; trang thương mại điện tử của&nbsp;<strong>Nh&agrave; S&aacute;ch Hiếu Đảnh</strong>, hệ thống nh&agrave; s&aacute;ch th&acirc;n thuộc của nhiều gia đ&igrave;nh Việt kể từ nh&agrave; s&aacute;ch đầu ti&ecirc;n ra đời năm 2020&nbsp;đến nay.&nbsp;&nbsp;</p>

<p>&nbsp;</p>

<p>Đến với kh&ocirc;ng gian mua sắm trực tuyến daithuvien.com, kh&aacute;ch h&agrave;ng c&oacute; thể dễ d&agrave;ng t&igrave;m thấy những cuốn s&aacute;ch hay, đa thể loại của nhiều nh&agrave; xuất bản, c&ocirc;ng ty s&aacute;ch trong v&agrave; ngo&agrave;i nước c&ugrave;ng nhiều dụng cụ học tập, văn ph&ograve;ng phẩm, qu&agrave; lưu niệm, đồ chơi gi&aacute;o dục ch&iacute;nh h&atilde;ng của những thương hiệu uy t&iacute;n.&nbsp;C&ugrave;ng ti&ecirc;u ch&iacute; kh&ocirc;ng ngừng ho&agrave;n thiện, n&acirc;ng cao chất lượng sản phẩm, dịch vụ, Nh&agrave; S&aacute;ch Phương Nam cam kết mang đến cho kh&aacute;ch h&agrave;ng trải nghiệm mua sắm trực tuyến an to&agrave;n, tiện lợi: c&aacute;ch đặt h&agrave;ng đơn giản, phương thức thanh to&aacute;n đa dạng, dịch vụ chăm s&oacute;c kh&aacute;ch h&agrave;ng tận t&igrave;nh, chu đ&aacute;o.&nbsp;</p>

<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>

<table border="1" cellpadding="1" cellspacing="1" style="width:100%">
	<tbody>
		<tr>
			<td>
			<p style="text-align:center">S&aacute;ng lập: Nguyễn Khoa Đảnh (Backend)</p>

			<p style="text-align:center"><img alt="" src="https://scontent.fsgn5-2.fna.fbcdn.net/v/t1.0-9/76922066_433874144167980_1601990623513018368_o.jpg?_nc_cat=105&amp;ccb=2&amp;_nc_sid=454319&amp;_nc_ohc=UrxBoIzL920AX_NSqSy&amp;_nc_ht=scontent.fsgn5-2.fna&amp;oh=15dbdd5d025905406ee918e59d918466&amp;oe=5FFB30C3" style="height:400px; width:300px" /></p>
			</td>
			<td>
			<p style="text-align:center">Đồng s&aacute;ng lập: B&ugrave;i Trung Hiếu (Frontend)</p>

			<p style="text-align:center"><img alt="" src="https://scontent.fsgn5-7.fna.fbcdn.net/v/t1.0-9/107498183_2698048370513230_8417862590277377964_n.jpg?_nc_cat=109&amp;ccb=2&amp;_nc_sid=09cbfe&amp;_nc_ohc=CQZ7XHTi-70AX8_8Xip&amp;_nc_ht=scontent.fsgn5-7.fna&amp;oh=9c289ac2918e67079328ff757847d522&amp;oe=5FFC16C3" style="height:400px; width:400px" /></p>
			</td>
		</tr>
	</tbody>
</table>

<p>&nbsp;</p>

<p>&nbsp;</p>
', 1, 62, CAST(N'2020-12-14T14:50:38.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[News] OFF
GO
SET IDENTITY_INSERT [dbo].[Publisher] ON 

INSERT [dbo].[Publisher] ([PublisherId], [Name], [Introduce], [Phone], [Address]) VALUES (1, N'Kim Đồng', N'<p>Rất nổi tiếng</p>
', NULL, N'VietNam, TpHCM')
INSERT [dbo].[Publisher] ([PublisherId], [Name], [Introduce], [Phone], [Address]) VALUES (2, N'GDVN', N'<p>S&aacute;ch nh&agrave; nước đ&oacute; fen</p>
', NULL, N'Việt Nam')
SET IDENTITY_INSERT [dbo].[Publisher] OFF
GO
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([StatusId], [Name]) VALUES (1, N'Đang Chờ')
INSERT [dbo].[Status] ([StatusId], [Name]) VALUES (2, N'Đang Xử Lí')
INSERT [dbo].[Status] ([StatusId], [Name]) VALUES (3, N'Đang Vận Chuyển')
INSERT [dbo].[Status] ([StatusId], [Name]) VALUES (4, N'Đã Hoàn Thành')
INSERT [dbo].[Status] ([StatusId], [Name]) VALUES (5, N'Đã Huỷ')
INSERT [dbo].[Status] ([StatusId], [Name]) VALUES (6, N'Đặt Hàng')
SET IDENTITY_INSERT [dbo].[Status] OFF
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Access] FOREIGN KEY([AccessId])
REFERENCES [dbo].[Access] ([AccessId])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Access]
GO
ALTER TABLE [dbo].[Delivery]  WITH CHECK ADD  CONSTRAINT [FK_Delivery_EarnBill] FOREIGN KEY([BillId])
REFERENCES [dbo].[EarnBill] ([BillId])
GO
ALTER TABLE [dbo].[Delivery] CHECK CONSTRAINT [FK_Delivery_EarnBill]
GO
ALTER TABLE [dbo].[Delivery]  WITH CHECK ADD  CONSTRAINT [FK_Delivery_Item] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([ItemId])
GO
ALTER TABLE [dbo].[Delivery] CHECK CONSTRAINT [FK_Delivery_Item]
GO
ALTER TABLE [dbo].[Discuss]  WITH CHECK ADD  CONSTRAINT [FK_Discuss_Account] FOREIGN KEY([Username])
REFERENCES [dbo].[Account] ([Username])
GO
ALTER TABLE [dbo].[Discuss] CHECK CONSTRAINT [FK_Discuss_Account]
GO
ALTER TABLE [dbo].[EarnBill]  WITH CHECK ADD  CONSTRAINT [FK_EarnBill_Account] FOREIGN KEY([Username])
REFERENCES [dbo].[Account] ([Username])
GO
ALTER TABLE [dbo].[EarnBill] CHECK CONSTRAINT [FK_EarnBill_Account]
GO
ALTER TABLE [dbo].[EarnBill]  WITH CHECK ADD  CONSTRAINT [FK_EarnBill_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[EarnBill] CHECK CONSTRAINT [FK_EarnBill_Status]
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Book_Author] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Author] ([AuthorId])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Book_Author]
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Discuss] FOREIGN KEY([DiscussId])
REFERENCES [dbo].[Discuss] ([DiscussId])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_Discuss]
GO
ALTER TABLE [dbo].[ItemCategory]  WITH CHECK ADD  CONSTRAINT [FK_BookType_Book] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([ItemId])
GO
ALTER TABLE [dbo].[ItemCategory] CHECK CONSTRAINT [FK_BookType_Book]
GO
ALTER TABLE [dbo].[ItemCategory]  WITH CHECK ADD  CONSTRAINT [FK_BookType_Type] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[ItemCategory] CHECK CONSTRAINT [FK_BookType_Type]
GO
ALTER TABLE [dbo].[ItemRate]  WITH CHECK ADD  CONSTRAINT [FK_BookRate_Account] FOREIGN KEY([Username])
REFERENCES [dbo].[Account] ([Username])
GO
ALTER TABLE [dbo].[ItemRate] CHECK CONSTRAINT [FK_BookRate_Account]
GO
ALTER TABLE [dbo].[ItemRate]  WITH CHECK ADD  CONSTRAINT [FK_BookRate_Book] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([ItemId])
GO
ALTER TABLE [dbo].[ItemRate] CHECK CONSTRAINT [FK_BookRate_Book]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Account] FOREIGN KEY([Username])
REFERENCES [dbo].[Account] ([Username])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Account]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Discuss] FOREIGN KEY([DiscussId])
REFERENCES [dbo].[Discuss] ([DiscussId])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Discuss]
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK_News_Account] FOREIGN KEY([Username])
REFERENCES [dbo].[Account] ([Username])
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK_News_Account]
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK_News_Discuss] FOREIGN KEY([DiscussId])
REFERENCES [dbo].[Discuss] ([DiscussId])
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK_News_Discuss]
GO
ALTER TABLE [dbo].[PaidBill]  WITH CHECK ADD  CONSTRAINT [FK_PaidBill_Publisher] FOREIGN KEY([PublisherId])
REFERENCES [dbo].[Publisher] ([PublisherId])
GO
ALTER TABLE [dbo].[PaidBill] CHECK CONSTRAINT [FK_PaidBill_Publisher]
GO
ALTER TABLE [dbo].[PaidBill]  WITH CHECK ADD  CONSTRAINT [FK_PaidBill_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[PaidBill] CHECK CONSTRAINT [FK_PaidBill_Status]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Receipt_Item] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([ItemId])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Receipt_Item]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Receipt_PaidBill] FOREIGN KEY([BillId])
REFERENCES [dbo].[PaidBill] ([BillId])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Receipt_PaidBill]
GO
USE [master]
GO
ALTER DATABASE [DB_Store] SET  READ_WRITE 
GO
