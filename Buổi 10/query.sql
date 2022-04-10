
create database quan_ly_san_pham

use quan_ly_san_pham

create table nhan_vien
(
    ma_nhan_vien int identity(1,1) primary key,
    ho_ten varchar(100) not null,
    nam_sinh date not null,
    luong int null,
)

create table loai_san_pham
(
    ma_san_pham int identity(1,1) primary key,
    ten_loai_san_pham nvarchar(100) not null
)

create table san_pham
(
    ma_san_pham int identity(1,1) primary key,
    ten_san_pham nvarchar(100) not null,
    gia_tien int not null,
    ma_loai_san_pham int not null
)

create table khach_hang
(
    ma_khach_hang int identity(1,1) primary key,
    ten_khach_hang nvarchar(100) not null,
    dia_chi ntext null,
    so_dien_thoai char(15) not null,
    email nvarchar(50) not null
)

alter table nhan_vien
drop column nam_sinh

alter table nhan_vien
add nam_sinh int not null

alter table nhan_vien
add constraint ck_luong check (luong > 10000000)

create table loai_nhan_vien
(
    ma_loai_nv int identity(1,1) primary key,
    ten_loai_nv nvarchar(100) not null
)

alter table nhan_vien
add ma_loai_nv int not null

alter table nhan_vien
add constraint fk_ma_loai_nv foreign key (ma_loai_nv) references loai_nhan_vien(ma_loai_nv)
