USE [assignment_com2012]
GO
/****** Object:  Table [dbo].[loai_sach]    Script Date: 30/03/2022 2:45:12 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loai_sach](
	[ma_loai_sach] [int] IDENTITY(1,1) NOT NULL,
	[ten_loai_sach] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ma_loai_sach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ten_loai_sach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lop]    Script Date: 30/03/2022 2:45:12 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lop](
	[ma_lop] [int] IDENTITY(1,1) NOT NULL,
	[ten_lop] [char](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ma_lop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ten_lop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[phieu_muon_sach]    Script Date: 30/03/2022 2:45:12 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phieu_muon_sach](
	[so_phieu] [int] IDENTITY(1,1) NOT NULL,
	[ma_sinh_vien] [int] NOT NULL,
	[ma_sach] [int] NOT NULL,
	[ngay_muon] [date] NOT NULL,
	[ngay_tra] [date] NULL,
	[trang_thai] [nchar](10) NOT NULL,
	[ghi_chu] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[so_phieu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sach]    Script Date: 30/03/2022 2:45:12 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sach](
	[ma_sach] [int] IDENTITY(1,1) NOT NULL,
	[tieu_de] [nvarchar](50) NOT NULL,
	[nha_xuat_ban] [nvarchar](50) NOT NULL,
	[tac_gia] [nvarchar](50) NOT NULL,
	[so_trang] [int] NOT NULL,
	[so_luong_ban_sao] [int] NOT NULL,
	[gia_tien] [int] NOT NULL,
	[ngay_nhap_kho] [date] NOT NULL,
	[vi_tri_dat_sach] [nvarchar](100) NOT NULL,
	[ma_loai_sach] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ma_sach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sinh_vien]    Script Date: 30/03/2022 2:45:12 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sinh_vien](
	[ma_sinh_vien] [int] IDENTITY(1,1) NOT NULL,
	[ten_sinh_vien] [nvarchar](50) NOT NULL,
	[ngay_het_han] [date] NOT NULL,
	[chuyen_nganh_hoc] [nvarchar](50) NOT NULL,
	[so_dien_thoai] [char](15) NOT NULL,
	[email] [char](30) NOT NULL,
	[ma_lop] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ma_sinh_vien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[so_dien_thoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[phieu_muon_sach] ADD  DEFAULT (getdate()) FOR [ngay_muon]
GO
ALTER TABLE [dbo].[phieu_muon_sach] ADD  DEFAULT (NULL) FOR [ngay_tra]
GO
ALTER TABLE [dbo].[phieu_muon_sach] ADD  DEFAULT (N'Chưa trả') FOR [trang_thai]
GO
ALTER TABLE [dbo].[sinh_vien] ADD  DEFAULT (N'Công nghệ thông tin') FOR [chuyen_nganh_hoc]
GO
ALTER TABLE [dbo].[phieu_muon_sach]  WITH CHECK ADD FOREIGN KEY([ma_sach])
REFERENCES [dbo].[sach] ([ma_sach])
GO
ALTER TABLE [dbo].[phieu_muon_sach]  WITH CHECK ADD FOREIGN KEY([ma_sinh_vien])
REFERENCES [dbo].[sinh_vien] ([ma_sinh_vien])
GO
ALTER TABLE [dbo].[sach]  WITH CHECK ADD FOREIGN KEY([ma_loai_sach])
REFERENCES [dbo].[loai_sach] ([ma_loai_sach])
GO
ALTER TABLE [dbo].[sinh_vien]  WITH CHECK ADD FOREIGN KEY([ma_lop])
REFERENCES [dbo].[lop] ([ma_lop])
GO
ALTER TABLE [dbo].[loai_sach]  WITH CHECK ADD  CONSTRAINT [ck_ten_loai_sach] CHECK  ((len([ten_loai_sach])>=(2)))
GO
ALTER TABLE [dbo].[loai_sach] CHECK CONSTRAINT [ck_ten_loai_sach]
GO
ALTER TABLE [dbo].[lop]  WITH CHECK ADD  CONSTRAINT [ck_ten_lop] CHECK  ((len([ten_lop])>=(5)))
GO
ALTER TABLE [dbo].[lop] CHECK CONSTRAINT [ck_ten_lop]
GO
ALTER TABLE [dbo].[phieu_muon_sach]  WITH CHECK ADD  CONSTRAINT [ck_ngay_muon] CHECK  (([ngay_muon]<=getdate()))
GO
ALTER TABLE [dbo].[phieu_muon_sach] CHECK CONSTRAINT [ck_ngay_muon]
GO
ALTER TABLE [dbo].[sach]  WITH CHECK ADD  CONSTRAINT [ck_gia_tien] CHECK  (([gia_tien]>(0)))
GO
ALTER TABLE [dbo].[sach] CHECK CONSTRAINT [ck_gia_tien]
GO
ALTER TABLE [dbo].[sach]  WITH CHECK ADD  CONSTRAINT [ck_len] CHECK  ((len([tieu_de])>=(0) AND len([nha_xuat_ban])>=(2) AND len([tac_gia])>=(2) AND len([vi_tri_dat_sach])>=(2)))
GO
ALTER TABLE [dbo].[sach] CHECK CONSTRAINT [ck_len]
GO
ALTER TABLE [dbo].[sach]  WITH CHECK ADD  CONSTRAINT [ck_so_luong_ban_sao] CHECK  (([so_luong_ban_sao]>(1)))
GO
ALTER TABLE [dbo].[sach] CHECK CONSTRAINT [ck_so_luong_ban_sao]
GO
ALTER TABLE [dbo].[sach]  WITH CHECK ADD  CONSTRAINT [ck_so_trang] CHECK  (([so_trang]>(5)))
GO
ALTER TABLE [dbo].[sach] CHECK CONSTRAINT [ck_so_trang]
GO
ALTER TABLE [dbo].[sinh_vien]  WITH CHECK ADD  CONSTRAINT [ck_chuyen_nganh_hoc] CHECK  ((len([chuyen_nganh_hoc])>(2)))
GO
ALTER TABLE [dbo].[sinh_vien] CHECK CONSTRAINT [ck_chuyen_nganh_hoc]
GO
ALTER TABLE [dbo].[sinh_vien]  WITH CHECK ADD  CONSTRAINT [ck_so_dien_thoai] CHECK  ((len([so_dien_thoai])>=(9)))
GO
ALTER TABLE [dbo].[sinh_vien] CHECK CONSTRAINT [ck_so_dien_thoai]
GO
ALTER TABLE [dbo].[sinh_vien]  WITH CHECK ADD  CONSTRAINT [ck_ten_sinh_vien] CHECK  ((len([ten_sinh_vien])>=(2)))
GO
ALTER TABLE [dbo].[sinh_vien] CHECK CONSTRAINT [ck_ten_sinh_vien]
GO
