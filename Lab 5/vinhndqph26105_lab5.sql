-- Bài 1: Viết các câu truy vấn sau:
-- a. Hiển thị tất cả thông tin có trong bảng khách hàng bao gồm tất cả các cột
select *
from khach_hang

-- b. Hiển thị 10 khách hàng đầu tiên trong bảng khách hàng bao gồm các cột: mã khách hàng, họ và tên, email, số điện thoại
select top 10
    ma_khach_hang,
    ho + ' ' + ten as 'ho_va_ten',
    email,
    so_dien_thoai
from khach_hang

-- c. Hiển thị thông tin từ bảng Sản phẩm gồm các cột: mã sản phẩm, tên sản phẩm, tổng tiền tồn kho. Với tổng tiền tồn kho = đơn giá* số lượng
select
    ma_san_pham,
    ten_san_pham,
    don_gia * so_luong as 'tong_tien_ton_kho'
from san_pham

/* d. Hiển thị danh sách khách hàng có tên bắt đầu bởi kí tự ‘H’ gồm các cột:
    maKhachHang, hoVaTen, diaChi. Trong đó cột hoVaTen ghép từ 2 cột hoVaTenLot và Ten */
select
    ma_khach_hang,
    ho + ' ' + ten as 'ho_va_ten',
    dia_chi
from khach_hang
where ten like 'H%'

-- e. Hiển thị tất cả thông tin các cột của khách hàng có địa chỉ chứa chuỗi ‘Đà Nẵng’
select *
from khach_hang
where dia_chi like '%Đà Nẵng%'

-- f. Hiển thị các sản phẩm có số lượng nằm trong khoảng từ 100 đến 500.
select *
from san_pham
where so_luong between 100 and 500

-- g. Hiển thị danh sách các hoá hơn có trạng thái là chưa thanh toán và ngày mua hàng trong năm 2016
select *
from hoa_don
where (trang_thai = 'Chưa thanh toán' and year(ngay_mua_hang) = 2016)

-- h. Hiển thị các hoá đơn có mã Khách hàng thuộc 1 trong 3 mã sau: KH001, KH003, KH006
select *
from hoa_don
where ma_khach_hang in ('KH001', 'KH003', 'KH006')


-- Bài 2: Viết các câu truy vấn sau:
-- a. Hiển thị số lượng khách hàng có trong bảng khách hàng
select count(*) as 'so_luong_khach_hang'
from khach_hang

-- b. Hiển thị đơn giá lớn nhất trong bảng SanPham
select max(don_gia) as 'don_gia_lon_nhat'
from san_pham

-- c. Hiển thị số lượng sản phẩm thấp nhất trong bảng sản phẩm
select min(so_luong) as 'so_luong_san_pham_thap_nhat'
from san_pham

-- d. Hiển thị tổng tất cả số lượng sản phẩm có trong bảng sản phẩm
select count(so_luong) as 'tong_so_luong_san_pham'
from san_pham

-- e. Hiển thị số hoá đơn đã xuất trong tháng 12/2016 mà có trạng thái chưa thanh toán
select count(*) as 'so_hoa_don_da_xuat'
from hoa_don
where (year(ngay_mua_hang) = 2016 and month(ngay_mua_hang) = 12 and trang_thai = 'Chưa thanh toán')

-- f. Hiển thị mã hoá đơn và số loại sản phẩm được mua trong từng hoá đơn.
select
    ma_hoa_don,
    count(ma_hoa_don)
from hoa_don_chi_tiet
group by ma_hoa_don

-- g. Hiển thị mã hoá đơn và số loại sản phẩm được mua trong từng hoá đơn. Yêu cầu chỉ hiển thị hàng nào có số loại sản phẩm được mua >=5.
select
    ma_hoa_don,
    count(ma_hoa_don)
from hoa_don_chi_tiet
group by ma_hoa_don
having count(ma_hoa_don) >= 5

-- h. Hiển thị thông tin bảng HoaDon gồm các cột maHoaDon, ngayMuaHang, maKhachHang. Sắp xếp theo thứ tự giảm dần của ngayMuaHang
select
    ma_hoa_don,
    ngay_mua_hang,
    ma_khach_hang
from hoa_don
order by ngay_mua_hang desc