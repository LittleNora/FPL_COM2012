
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
order by ngay_muon asc


-- 6.4.Liệt kê tổng số đầu sách của mỗi loại sách (gồm mã loại sách, tên loại sách, tổng số lượng sách mỗi loại).
select
    loai_sach.ma_loai_sach,
    loai_sach.ten_loai_sach,
    count(*) as 'Số sách'
from sach
    inner join loai_sach on loai_sach.ma_loai_sach = sach.ma_loai_sach
group by loai_sach.ma_loai_sach, loai_sach.ten_loai_sach


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
from sinh_vien
    inner join phieu_muon_sach on phieu_muon_sach.ma_sinh_vien = sinh_vien.ma_sinh_vien
    inner join sach on sach.ma_sach = phieu_muon_sach.ma_sach
order by phieu_muon_sach.ngay_muon desc


-- 6.8.Liệt kê các đầu sách có lượt mượn lớn hơn 20 lần.
select *
from sach
where ma_sach in (select ma_sach
from phieu_muon_sach
group by ma_sach
having count(ma_sach) > 20
)


-- 6.9.Viết câu lệnh cập nhật lại giá tiền của các quyển sách có ngày nhập kho trước năm 2014 giảm 30%.
update sach
set gia_tien -= gia_tien * 0.3
where year(ngay_nhap_kho) < 2014


-- 6.10.Viết câu lệnh cập nhật lại trạng thái đã trả sách cho phiếu mượn của sinh viên có mã sinh viên PD12301
update phieu_muon_sach
set trang_thai = N'Đã trả'
where ma_sinh_vien = 'PD12301'


-- 6.11.Lập danh sách các phiếu mượn quá hạn chưa trả gồm các thông tin: mã phiếu mượn, tên sinh viên, email, danh sách các sách đã mượn, ngày mượn
select
    phieu_muon_sach.so_phieu,
    sinh_vien.ten_sinh_vien,
    sinh_vien.email,
    sach.tieu_de,
    phieu_muon_sach.ngay_muon
from sinh_vien
    inner join phieu_muon_sach on phieu_muon_sach.ma_sinh_vien = sinh_vien.ma_sinh_vien
    inner join sach on sach.ma_sach = phieu_muon_sach.ma_sach
where (datediff(day, ngay_muon, getdate()) > 7)


-- 6.12.Viết câu lệnh cập nhật lại số lượng bản sao tăng lên 5 đơn vị đối với các đầu sách có lượt mượn lớn hơn 10
update sach
set so_luong_ban_sao += 5
where ma_sach in (select ma_sach
from phieu_muon_sach
group by ma_sach
having count(ma_sach) > 10
)


-- 6.13.Viết câu lệnh xoá các phiếu mượn có ngày mượn và ngày trả trước "1/1/2010‟
delete from phieu_muon_sach
where (year(ngay_muon) < 2010 and year(ngay_tra) < 2010)