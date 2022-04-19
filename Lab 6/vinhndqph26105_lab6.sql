
-- Bài 1: Viết các câu truy vấn sau:
-- a. Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột sau: maHoaDon, maKhachHang, trangThai, maSanPham, soLuong, ngayMua
select
    hoa_don.ma_hoa_don,
    hoa_don.ma_khach_hang,
    hoa_don.trang_thai,
    hoa_don_chi_tiet.ma_san_pham,
    hoa_don_chi_tiet.so_luong,
    hoa_don.ngay_mua_hang
from hoa_don
    inner join hoa_don_chi_tiet on hoa_don_chi_tiet.ma_hoa_don = hoa_don.ma_hoa_don

-- b. Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột sau: maHoaDon, maKhachHang, trangThai, maSanPham, soLuong, ngayMua với điều kiện maKhachHang = ‘KH001’
select
    hoa_don.ma_hoa_don,
    hoa_don.ma_khach_hang,
    hoa_don.trang_thai,
    hoa_don_chi_tiet.ma_san_pham,
    hoa_don_chi_tiet.so_luong,
    hoa_don.ngay_mua_hang
from hoa_don_chi_tiet
    inner join hoa_don on hoa_don_chi_tiet.ma_hoa_don = hoa_don.ma_hoa_don
where hoa_don.ma_khach_hang = 'KH001'

-- c. Hiển thị thông tin từ 3 bảng Hoá đơn, Hoá đơn chi tiết và Sản phẩm gồm các cột sau: maHoaDon, ngayMua, tenSP, donGia, soLuong mua trong hoá đơn, thành tiền. Với thành tiền = donGia* soLuong
select
    hoa_don.ma_hoa_don,
    hoa_don.ngay_mua_hang,
    san_pham.ten_san_pham,
    san_pham.don_gia,
    hoa_don_chi_tiet.so_luong,
    san_pham.don_gia * hoa_don_chi_tiet.so_luong as 'thanh_tien'
from hoa_don
    inner join hoa_don_chi tiet on hoa_don_chi_tiet.ma_hoa_don = hoa_don.ma_hoa_don
    inner join san_pham on san_pham.ma_san_pham = hoa_don_chi_tiet.ma_san_pham

-- d. Hiển thị thông tin từ bảng khách hàng, bảng hoá đơn, hoá đơn chi tiết gồm các cột: họ và tên khách hàng, email, điện thoại, mã hoá đơn, trạng thái hoá đơn và tổng tiền đã mua trong hoá đơn. Chỉ hiển thị thông tin các hoá đơn chưa thanh toán.
select
    khach_hang.ho + ' ' + khach_hang.ten as 'ho_va_ten',
    khach_hang.email,
    khach_hang.so_dien_thoai,
    hoa_don.ma_hoa_don,
    hoa_don.trang_thai,
    count(san_pham.don_gia * hoa_don_chi_tiet.so_luong) as 'tong_tien_da_mua'
from hoa_don_chi_tiet
    inner join hoa_don on hoa_don_chi_tiet.ma_hoa_don = hoa_don.ma_hoa_don
    inner join khach_hang on hoa_don.ma_khach_hang = khach_hang.ma_khach_hang
where hoa_don.trang_thai = 'Chưa thanh toán'

-- e. Hiển thị maHoaDon, ngàyMuahang, tổng số tiền đã mua trong từng hoá đơn. Chỉ hiển thị những hóa đơn có tổng số tiền >=500.000 và sắp xếp theo thứ tự giảm dần của cột tổng tiền.
select
    hoa_don.ma_hoa_don,
    hoa_don.ngay_mua_hang,
    sum(san_pham.don_gia * hoa_don_chi_tiet.so_luong) as 'tong_tien'
from hoa_don_chi_tiet
    inner join hoa_don on hoa_don_chi_tiet.ma_hoa_don = hoa_don.ma_hoa_don
    inner join khach_hang on hoa_don.ma_khach_hang = khach_hang.ma_khach_hang
group by hoa_don.ma_hoa_don, hoa_don.ngay_mua_hang
having sum(san_pham.don_gia * hoa_don_chi_tiet.so_luong) >= 500000
order by tong_tien desc


-- Bài 2: Viết các câu truy vấn sau:
-- a. Hiển thị danh sách các khách hàng chưa mua hàng lần nào kể từ tháng 1/1/2016
select
    khach_hang.*
from hoa_don
    inner join khach_hang on hoa_don.ma_khach_hang = khach_hang.ma_khach_hang
where not khach_hang.ngay_mua_hang > 2016

-- b. Hiển thị mã sản phẩm, tên sản phẩm có lượt mua nhiều nhất trong tháng 12/2016
select
    san_pham.ma_san_pham,
    san_pham.ten_san_pham
from san_pham
where ma_san_pham = (
    select top 1
    ma_san_pham
from hoa_don_chi_tiet
group by ma_san_pham
order by count(ma_san_pham) desc
    )

-- c. Hiển thị top 5 khách hàng có tổng số tiền mua hàng nhiều nhất trong năm 2016
select *
from khach_hang
where ma_khach_hang in (
    select top 5
    hoa_don.ma_khach_hang
from hoa_don_chi_tiet
    inner join hoa_don on hoa_don_chi_tiet.ma_hoa_don = hoa_don.ma_hoa_don
group by hoa_don.ma_khach_hang
order by sum(san_pham.don_gia * hoa_don_chi_tiet.so_luong) desc
)

-- d. Hiển thị thông tin các khách hàng sống ở ‘Đà Nẵng’ có mua sản phẩm có tên “Iphone 7 32GB” trong tháng 12/2016 phẩm.
select
    khach_hang.*
from khach_hang
    inner join hoa_don on hoa_don.ma_khach_hang = khach_hang.ma_khach_hang
    inner join hoa_don_chi_tiet on hoa_don_chi_tiet.ma_hoa_don = hoa_don.ma_hoa_don
    inner join san_pham on san_pham.ma_san_pham = hoa_don_chi_tiet.ma_san_pham
where
    (khach_hang.dia_chi like '%Đà Nẵng%' and san_pham.ten_san_pham like '%Iphone 7 32GB' and year(hoa_don.ngay_mua_hang) = 2016 and month(hoa_don.ngay_mua_hang) = 12)

-- e. Hiển thị tên sản phẩm có lượt đặt mua nhỏ hơn lượt mua trung bình các sản phẩm
select
    san_pham.ten_san_pham
from san_pham
    inner join hoa_don_chi_tiet on hoa_don_chi_tiet.ma_san_pham = san_pham.ma_san_pham
group by san_pham.ma_san_pham, san_pham.ten_san_pham
having count(*) < (select avg(hoa_don_chi_tiet.so_luong)
from hoa_don_chi_tiet)