



-- Drop the database 'assignment_com2012'
-- Connect to the 'master' database to run this snippet
USE master

GO

-- Uncomment the ALTER DATABASE statement below to set the database to SINGLE_USER mode if the drop database command fails because the database is in use.

-- ALTER DATABASE assignment_com2012 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- Drop the database if it exists
IF EXISTS (
    SELECT [name]
FROM sys.databases
WHERE [name] = N'assignment_com2012'
)
DROP DATABASE assignment_com2012
GO


-- Tạo database assignment_com2012
create database assignment_com2012

use assignment_com2012



-- Loại sách
create table loai_sach
(
    ma_loai_sach int identity,
    ten_loai_sach nvarchar(100) not null unique,
    constraint ck_ten_loai_sach check (len(ten_loai_sach) >= 2),
    primary key(ma_loai_sach)
)

drop table loai_sach

insert into loai_sach
    (ten_loai_sach)
values
    (N'Công nghệ thông tin'),
    (N'Kinh tế'),
    (N'Du lịch'),
    (N'Văn học'),
    (N'Ngoại ngữ'),
    (N'Thiết kế đồ họa')

select *
from loai_sach


-- Lớp
create table lop
(
    ma_lop int identity,
    ten_lop char(10) not null unique,
    constraint ck_ten_lop check (len(ten_lop) >= 5),
    primary key(ma_lop)
)

insert into lop
    (ten_lop)
values
    (N'WE17325'),
    (N'IT17325'),
    (N'CP17305'),
    (N'WE17330'),
    (N'IT16220')



-- Sách
create table sach
(
    ma_sach int identity,
    tieu_de nvarchar(50) not null,
    nha_xuat_ban nvarchar(50) not null,
    tac_gia nvarchar(50) not null,
    so_trang int not null,
    so_luong_ban_sao int not null,
    gia_tien int not null,
    ngay_nhap_kho date not null,
    vi_tri_dat_sach nvarchar(100) not null,
    ma_loai_sach int not null,
    constraint ck_len check (len(tieu_de) >= 0 and len(nha_xuat_ban) >= 2 and len(tac_gia) >= 2 and len(vi_tri_dat_sach) >= 2),
    constraint ck_so_trang check (so_trang > 5),
    constraint ck_so_luong_ban_sao check (so_luong_ban_sao > 1),
    constraint ck_gia_tien check (gia_tien > 0),
    foreign key (ma_loai_sach) references loai_sach(ma_loai_sach),
    primary key (ma_sach)
)

insert into sach
    (tieu_de, nha_xuat_ban, tac_gia, so_trang, so_luong_ban_sao, gia_tien, ngay_nhap_kho, vi_tri_dat_sach, ma_loai_sach)
values
    (N'Nhập môn cơ sở dữ liệu', N'Đại học Bách Khoa Hà Nội', N'Nguyễn Quang Vinh', 200, 500, 155000, '2021-11-11', N'Kệ 3 - Ngăn 1', 1),
    (N'Kinh tế vi mô', N'Đại học FPT', N'Nguyễn Văn Vinh', 251, 700, 251000, '2019-05-26', N'Kệ 5 - Ngăn 4', 2),
    (N'The Official Cambridge Guide to IELTS', N'Cambridge English Language Assessment', N'John Wick', 300, 1500, 212000, '2022-04-03', N'Kệ 3 - Ngăn 2', 5),
    (N'Tắt đèn', N'Văn học Việt Nam', N'Ngô Tất Tố', 279, 1400, 56000, '2019-04-28', N'Kệ 6 - Ngăn 2', 4),
    (N'Nhập môn Photoshop', N'Đại học Bách Khoa Hà Nội', N'Alex Nora', 249, 150, 156000, '2015-06-17', N'Kệ 1 - Ngăn 8', 6),
    (N'Việt Nam tươi đẹp', N'Kim Đồng', N'Hà Anh Tuấn', 151, 400, 91000, '2022-01-26', N'Kệ 8 - Ngăn 8', 3)

insert into sach
    (tieu_de, nha_xuat_ban, tac_gia, so_trang, so_luong_ban_sao, gia_tien, ngay_nhap_kho, vi_tri_dat_sach, ma_loai_sach)
values
    (N'Tuổi trẻ đáng giá bao nhiêu', N'Kim Đồng', N'Nguyễn Quang Vinh', 200, 500, 201000, '2021-11-11', N'Kệ 3 - Ngăn 1', 1)

select ma_loai_sach,sum(gia_tien)
from sach
group by ma_loai_sach
order by sum(gia_tien)

select
    sach.ma_sach,
    sach.tieu_de,
    sach.nha_xuat_ban,
    sach.tac_gia,
    sach.gia_tien,
    sach.ngay_nhap_kho,
    loai_sach.ten_loai_sach
from sach
    join loai_sach on sach.ma_loai_sach = loai_sach.ma_loai_sach



-- Sinh viên

create table sinh_vien
(
    ma_sinh_vien int identity,
    ten_sinh_vien nvarchar(50) not null,
    ngay_het_han date not null,
    chuyen_nganh_hoc nvarchar(50) not null default N'Công nghệ thông tin',
    so_dien_thoai char(15) not null unique,
    email char(30) not null unique,
    ma_lop int not null,
    constraint ck_ten_sinh_vien check(len(ten_sinh_vien) >= 2),
    constraint ck_chuyen_nganh_hoc check(len(chuyen_nganh_hoc) > 2),
    constraint ck_so_dien_thoai check(len(so_dien_thoai) >= 9),
    foreign key(ma_lop) references lop(ma_lop),
    primary key(ma_sinh_vien)
)

insert into sinh_vien
    (ten_sinh_vien, ngay_het_han, chuyen_nganh_hoc, so_dien_thoai, email, ma_lop)
values
    (N'Nguyễn Duy Quang Vinh', '2024-11-11', N'Công nghệ thông tin', '0931910JQK', 'vinh@gmail.com', 3),
    (N'Nguyễn Linh Anh', '2023-11-26', N'Digital Marketing', '0123456789', 'linann@gmail.com', 5),
    (N'Nguyễn Nam Long', '2024-06-17', N'Du lịch', '0987654321', 'nnl@gmail.com', 1),
    (N'Phùng Thị Huyền', '2025-12-12', N'Công nghệ thông tin', '0932713122', 'huyen@gmail.com', 2),
    (N'Hà Mạnh Tuấn', '2024-09-12', N'Tự động hóa', '0247183672', 'junookyo@gmail.com', 4)

select
    sinh_vien.ma_sinh_vien,
    sinh_vien.ten_sinh_vien,
    sinh_vien.ngay_het_han,
    sinh_vien.chuyen_nganh_hoc,
    sinh_vien.so_dien_thoai,
    sinh_vien.email,
    lop.ten_lop
from sinh_vien
    join lop on sinh_vien.ma_lop = lop.ma_lop



-- Phiếu mượn sách
create table phieu_muon_sach
(
    so_phieu int identity,
    ma_sinh_vien int not null,
    ma_sach int not null,
    ngay_muon date not null default getdate(),
    ngay_tra date default null,
    trang_thai nchar(10) not null default N'Chưa trả',
    ghi_chu ntext,
    constraint ck_ngay_muon check (ngay_muon <= getdate()),
    foreign key(ma_sinh_vien) references sinh_vien(ma_sinh_vien),
    foreign key(ma_sach) references sach(ma_sach),
    primary key(so_phieu)
)

drop table phieu_muon_sach

insert into phieu_muon_sach
    (ma_sinh_vien, ma_sach, ngay_muon, ngay_tra, trang_thai, ghi_chu)
values
    (3, 4, default, default, default , N''),
    (1, 5, '2022-03-26', '2022-03-29', N'Đã trả', N'Mượn sách mà láo'),
    (5, 2, '2022-01-19', default, default, N'Mượn sách trái ngành'),
    (2, 1, '2022-02-14', '2022-02-28', N'Đã trả', N''),
    (4, 3, '2022-03-14', default, default, N'Mượn sách ngày valentino')

insert into phieu_muon_sach
    (ma_sinh_vien, ma_sach, ngay_muon, ngay_tra, trang_thai, ghi_chu)
values
    (3, 5, default, default, default , N'')

select
    sinh_vien.ma_sinh_vien,
    sinh_vien.ten_sinh_vien,
    sinh_vien.chuyen_nganh_hoc,
    sinh_vien.so_dien_thoai,
    sinh_vien.email,
    lop.ten_lop,
    sach.tieu_de,
    sach.gia_tien,
    loai_sach.ten_loai_sach,
    phieu_muon_sach.ngay_muon,
    phieu_muon_sach.trang_thai,
    phieu_muon_sach.ghi_chu
from phieu_muon_sach
    join sinh_vien on sinh_vien.ma_sinh_vien = phieu_muon_sach.ma_sinh_vien
    join sach on sach.ma_sach = phieu_muon_sach.ma_sach
    join lop on lop.ma_lop = sinh_vien.ma_lop
    join loai_sach on loai_sach.ma_loai_sach = sach.ma_loai_sach
order by sinh_vien.ma_sinh_vien



-- 6.1.Liệt kê tất cả thông tin của các đầu sách gồm tên sách, mã sách, giá tiền , tác giả thuộc loại sách có mã “IT”.
select
    sach.tieu_de,
    sach.ma_sach,
    sach.gia_tien,
    sach.tac_gia
from sach
where sach.ma_loai_sach = (select ma_loai_sach
from loai_sach
where ten_loai_sach like N'%Công nghệ thông tin%')


-- 6.2.Liệt kê các phiếu mượn gồm các thông tin mã phiếu mượn, mã sách , ngày mượn, mã sinh viên có ngày mượn trong tháng 01/2017
select
    so_phieu,
    ma_sinh_vien,
    ma_sach,
    ngay_muon
from phieu_muon_sach
where (month(ngay_muon) = 1 and year(ngay_muon) = 2017)


-- 6.3.Liệt kê các phiếu mượn chưa trả sách cho thư viên theo thứ tự tăng dần của ngày mượn sách
select *
from phieu_muon_sach
where trang_thai = N'Chưa trả'
order by ngay_muon


-- 6.4.Liệt kê tổng số đầu sách của mỗi loại sách ( gồm mã loại sách, tên loại sách, tổng số lượng sách mỗi loại).
select
    loai_sach.ma_loai_sach,
    loai_sach.ten_loai_sach,
    count(*) as 'Số sách'
from sach
    join loai_sach on loai_sach.ma_loai_sach = sach.ma_loai_sach
group by loai_sach.ma_loai_sach, loai_sach.ten_loai_sach
order by loai_sach.ma_loai_sach


-- 6.5.Đếm xem có bao nhiêu lượt sinh viên đã mượn sách
select count(*) as 'Số lượt sinh viên mượn sách'
from phieu_muon_sach


-- 6.6.Hiển thị tất cả các quyển sách có tiêu đề chứa từ khoá “SQL”
select *
from sach
where tieu_de like '%SQL%'


-- 6.7.Hiển thị thông tin mượn sách gồm các thông tin: mã sinh viên, tên sinh viên, mã phiếu mượn, tiêu đề sách, ngày mượn, ngày trả. Sắp xếp thứ tự theo ngày mượn sách.
select
    sinh_vien.ma_sinh_vien,
    sinh_vien.ten_sinh_vien,
    phieu_muon_sach.so_phieu,
    sach.tieu_de,
    phieu_muon_sach.ngay_muon,
    phieu_muon_sach.ngay_tra
from phieu_muon_sach
    join sach on sach.ma_sach = phieu_muon_sach.ma_sach
    join sinh_vien on sinh_vien.ma_sinh_vien = phieu_muon_sach.ma_sinh_vien
order by phieu_muon_sach.ngay_muon desc


-- 6.8.Liệt kê các đầu sách có lượt mượn lớn hơn 20 lần.
select *
from sach
where ma_sach = (
    select ma_sach
from phieu_muon_sach
group by ma_sach
having count(ma_sach) > 20
)

select *
from sinh_vien
where ma_sinh_vien in (
    select top 3
        ma_sinh_vien
    from phieu_muon_sach
    group by ma_sinh_vien
    order by count(ma_sinh_vien) desc
)

select *
from sinh_vien
where ma_sinh_vien in (
    select top 3
        ma_sinh_vien,
        count(ma_sinh_vien)
    from phieu_muon_sach
    group by ma_sinh_vien
    order by count(ma_sinh_vien) desc
)



-- 6.9.Viết câu lệnh cập nhật lại giá tiền của các quyển sách có ngày nhập kho trước năm 2014 giảm 30%.
update sach
set gia_tien *= 0.3
where year(ngay_nhap_kho) < 2014


-- 6.10.Viết câu lệnh cập nhật lại trạng thái đã trả sách cho phiếu mượn của sinh viên có mã sinh viên PD12301
update phieu_muon_sach
set trang_thai = N'Đã trả'
where ma_sinh_vien = 3


-- 6.11.Lập danh sách các phiếu mượn quá hạn chưa trả gồm các thông tin: mã phiếu mượn, tên sinh viên, email, danh sách các sách đã mượn, ngày mượn
select
    phieu_muon_sach.so_phieu,
    sinh_vien.ten_sinh_vien,
    sinh_vien.email,
    sach.tieu_de,
    phieu_muon_sach.ngay_muon
from phieu_muon_sach
    join sinh_vien on sinh_vien.ma_sinh_vien = phieu_muon_sach.ma_sinh_vien
    join sach on sach.ma_sach = phieu_muon_sach.ma_sach
where (datediff(day, ngay_muon, getdate()) > 7)


-- 6.12.Viết câu lệnh cập nhật lại số lượng bản sao tăng lên 5 đơn vị đối với các đầu sách có lượt mượn lớn hơn 10
update sach
set so_luong_ban_sao += 5
where ma_sach = (
    select ma_sach
from phieu_muon_sach
group by ma_sach
having count(ma_sach) > 10
)


-- 6.13.Viết câu lệnh xoá các phiếu mượn có ngày mượn và ngày trả trước "1/1/2010‟
delete from phieu_muon_sach
where (year(ngay_muon) < 2010 and year(ngay_tra) < 2010)