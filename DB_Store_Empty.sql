USE [DB_Store]
GO
/****** Object:  Table [dbo].[Access]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Delivery]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discuss]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EarnBill]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemCategory]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemRate]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Message]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaidBill]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publisher]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Receipt]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 02/01/2021 4:03:58 CH ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Access] ON 

INSERT [dbo].[Access] ([AccessId], [Name]) VALUES (1, N'ADMIN')
INSERT [dbo].[Access] ([AccessId], [Name]) VALUES (2, N'MEMBER')
SET IDENTITY_INSERT [dbo].[Access] OFF
GO
INSERT [dbo].[Account] ([Username], [Password], [Name], [CreateDate], [Birthday], [Address], [Phone], [AccessId], [Email]) VALUES (N'admin', N'1', N'Nguyễn Khoa Đảnh', CAST(N'2000-12-13' AS Date), CAST(N'2000-12-13' AS Date), N'Việt Nam', N'0923202850     ', 1, N'dannk1312@gmail.com')
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (33, N'Sách Giáo Khoa', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (34, N'Văn Học', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (35, N'Phiêu Lưu', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (36, N'Kỳ Ảo', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (37, N'Hành Động', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (38, N'Tiểu Thuyết', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (39, N'Lịch Sử', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (40, N'Khoa học công nghệ ', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (41, N'Tâm Lý', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (42, N'Giáo Dục', NULL)
INSERT [dbo].[Category] ([CategoryId], [Name], [Introduce]) VALUES (43, N'Thiếu Nhi', NULL)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Discuss] ON 

INSERT [dbo].[Discuss] ([DiscussId], [Name], [StartDate], [Introduce], [Username]) VALUES (62, N'#New', CAST(N'2020-12-13T00:00:00.000' AS DateTime), N'Nói về tin tức', N'admin')
SET IDENTITY_INSERT [dbo].[Discuss] OFF
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
