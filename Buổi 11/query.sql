
-- Drop the database 'ql_khach_san'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Uncomment the ALTER DATABASE statement below to set the database to SINGLE_USER mode if the drop database command fails because the database is in use.
-- ALTER DATABASE ql_khach_san SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- Drop the database if it exists

create database ql_khach_san

use ql_khach_san

create table loai_phong
(
    ma_loai_phong int identity primary key,
    ten_loai_phong nvarchar(20) unique not null
)

create table phong
(
    ma_phong int identity primary key,
    ten_phong nvarchar(20) unique not null,
    don_gia int not null,
    ma_loai int not null,
    constraint check_gia check (don_gia > 0),
    foreign key(ma_loai) references loai_phong(ma_loai_phong)
)

create table khach_hang
(
    ma_khach_hang int identity primary key,
    ho nvarchar(10) not null,
    ten nvarchar(10) not null,
    nam_sinh date not null,
    dia_chi nvarchar(200) not null,
    muc_thu_nhap int not null,
    constraint check_thu_nhap check (muc_thu_nhap > 0)
)

create table dat_phong
(
    ma_dat_phong int identity primary key,
    ma_khach_hang int not null,
    ma_phong int not null,
    so_gio_thue int not null,
    ngay_dat date not null,
    constraint check_gio_dat check (so_gio_thue > 0),
    constraint fk_khach_hang foreign key(ma_khach_hang) references khach_hang(ma_khach_hang),
    constraint fk_phong foreign key(ma_phong) references phong(ma_phong)
)

alter table khach_hang
add email nvarchar(50) not null

alter table khach_hang
add constraint unq_email unique(email)

insert into loai_phong(ten_loai_phong)
values
    (N'Phòng Vip'),
    (N'Phòng bình dân')
select * from khach_hang

select * from phong