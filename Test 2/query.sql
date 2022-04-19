CREATE DATABASE ThucTap

USE ThucTap

CREATE TABLE Khoa
(
    makhoa CHAR(10) PRIMARY KEY,
    tenkhoa CHAR(30) NOT NULL,
    dienthoai CHAR(10) NOT NULL
)

CREATE TABLE GiangVien
(
    magv INT IDENTITY(1,1) PRIMARY KEY,
    hotengv CHAR(30) NOT NULL,
    luong INT NOT NULL,
    makhoa CHAR(10) NOT NULL,
    FOREIGN KEY (makhoa) REFERENCES Khoa(makhoa)
)

CREATE TABLE SinhVien
(
    masv INT IDENTITY(1,1) PRIMARY KEY,
    hotensv CHAR(30) NOT NULL,
    makhoa CHAR(10) NOT NULL,
    namsinh INT NOT NULL,
    quequan CHAR(30) NOT NULL,
    FOREIGN KEY (makhoa) REFERENCES Khoa(makhoa)
)

CREATE TABLE DeTai
(
    madt CHAR(10) PRIMARY KEY,
    tendt CHAR(30) NOT NULL,
    kinhphi INT NOT NULL,
    NoiThucTap CHAR(30)
)

CREATE TABLE HuongDan
(
    masv INT NOT NULL,
    madt CHAR(10) NOT NULL,
    magv INT NOT NULL,
    ketqua INT,
    FOREIGN KEY (masv) REFERENCES SinhVien(masv),
    FOREIGN KEY (magv) REFERENCES GiangVien(magv),
    FOREIGN KEY (madt) REFERENCES DeTai(madt)
)

-- 1.	Đưa ra thông tin gồm mã số, họ tên và tên khoa của tất cả các giảng viên
SELECT
    GiangVien.magv,
    GiangVien.hotengv,
    Khoa.tenkhoa
FROM GiangVien
    INNER JOIN Khoa ON Khoa.makhoa = GiangVien.makhoa

-- 2.	Đưa ra thông tin gồm mã số, họ tênvà tên khoa của các giảng viên của khoa ‘DIA LY va QLTN’
SELECT
    GiangVien.magv,
    GiangVien.hotengv,
    Khoa.tenkhoa
FROM GiangVien
    INNER JOIN Khoa ON Khoa.makhoa = GiangVien.makhoa
WHERE Khoa.tenkhoa IN ('DIA LY', 'QLTN')

-- 3.	Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’
SELECT COUNT(*) AS SO_SINH_VIEN_KHOA_CNSH
FROM SinhVien
WHERE makhoa =
(SELECT makhoa
FROM Khoa
WHERE tenkhoa = 'CONG NGHE SINH HOC')

-- 4.	Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘TOAN’
SELECT
    SinhVien.masv,
    SinhVien.hotensv,
    YEAR(GETDATE()) - SinhVien.namsinh AS TUOI
FROM SinhVien
WHERE SinhVien.makhoa = (SELECT makhoa
FROM Khoa
WHERE tenkhoa = 'TOAN')

-- 5.	Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’
SELECT COUNT(*) AS SO_GIANG_VIEN_KHOA_CNSH
FROM GiangVien
WHERE makhoa =
(SELECT makhoa
FROM Khoa
WHERE tenkhoa = 'CONG NGHE SINH HOC')

-- 6.	Cho biết thông tin về sinh viên không tham gia thực tập
SELECT
    *
FROM SinhVien
WHERE masv NOT IN (SELECT masv
FROM HuongDan)

-- 7.	Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
SELECT
    GiangVien.makhoa,
    Khoa.tenkhoa,
    COUNT(*) AS SO_GIANG_VIEN_MOI_KHOA
FROM Khoa
    INNER JOIN GiangVien ON GiangVien.makhoa = Khoa.makhoa
GROUP BY GiangVien.makhoa, Khoa.tenkhoa

-- 8.	Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học
SELECT
    Khoa.dienthoai
FROM Khoa
WHERE makhoa = (SELECT makhoa
FROM SinhVien
WHERE hotensv LIKE 'Le van son')


-- 1.	Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
SELECT
    DeTai.madt,
    DeTai.tendt
FROM DeTai
WHERE madt IN (
    SELECT madt
FROM HuongDan
WHERE magv = (SELECT magv
FROM GiangVien
WHERE hotengv = 'Tran son')
GROUP BY madt
)

-- 2.	Cho biết tên đề tài không có sinh viên nào thực tập
SELECT
    DeTai.madt,
    DeTai.tendt
FROM DeTai
WHERE madt NOT IN (SELECT madt
FROM HuongDan
GROUP BY madt)

-- 3.	Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên.
SELECT GiangVien.magv,
    GiangVien.hotengv,
    Khoa.tenkhoa
FROM GiangVien
    INNER JOIN Khoa ON Khoa.makhoa = GiangVien.makhoa
WHERE magv IN (
SELECT magv
FROM HuongDan
GROUP BY magv
HAVING COUNT(*) > 3
)

-- 4.	Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
SELECT
    DeTai.madt,
    DeTai.tendt
FROM DeTai
WHERE kinhphi >= (SELECT MAX(kinhphi)
FROM DeTai)

-- 5.	Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
SELECT
    DeTai.madt,
    DeTai.tendt
FROM DeTai
WHERE madt IN (
SELECT madt
FROM HuongDan
GROUP BY madt
HAVING COUNT(*) > 2
)

-- 6.	Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
SELECT
    SinhVien.masv,
    SinhVien.hotensv,
    HuongDan.ketqua
FROM HuongDan
    INNER JOIN SinhVien ON HuongDan.masv = SinhVien.masv
    INNER JOIN Khoa ON KHOA.makhoa = SinhVien.makhoa
WHERE Khoa.tenkhoa IN ('DIA LY', 'QLTN')

-- 7.	Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
SELECT
    KHOA.tenkhoa,
    COUNT(*) AS SO_LUONG_SINH_VIEN_MOI_KHOA
FROM SinhVien
    INNER JOIN Khoa ON Khoa.makhoa = SinhVien.makhoa
GROUP BY SinhVien.makhoa, KHOA.tenkhoa

-- 8.	Cho biết thông tin về các sinh viên thực tập tại quê nhà
SELECT
    SinhVien.*
FROM SinhVien
    INNER JOIN HuongDan ON HuongDan.masv = SinhVien.masv
    INNER JOIN DeTai ON DeTai.madt = HuongDan.madt
WHERE SinhVien.quequan = DeTai.NoiThucTap

-- 9.	Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
SELECT
    SinhVien.*
FROM SinhVien
    INNER JOIN HuongDan ON HuongDan.masv = SinhVien.masv
WHERE HuongDan.ketqua IS NULL

-- 10.	Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
SELECT
    SinhVien.masv,
    SinhVien.hotensv
FROM SinhVien
    INNER JOIN HuongDan ON HuongDan.masv = SinhVien.masv
WHERE HuongDan.ketqua = 0