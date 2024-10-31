Create database QLSINHVIEN
Go
Use QLSINHVIEN
GO
/*
Bài 1: Viết những truy vấn lọc và sắp xếp dữ liệu

1. Cho biết danh sách các môn học,
gồm các thông tin sau: Mã môn học, Tên môn  học, Số tiết.  
*/
Select *
From Monhoc
GO
Select MaMH as [Mã môn học], TenMH as [Tên môn học], SoTiet [Số tiết]
FROM MonHoc
GO

/*
2. Liệt kê danh sách sinh viên, gồm các thông tin sau:
Mã sinh viên, Họ sinh viên,  Tên sinh viên, Học bổng.
Danh sách sẽ được sắp xếp theo thứ tự Mã sinh viên  tăng dần.
*/
Select MaSV as 'Mã sinh viên', HoSV as [Họ sinh viên]
    , TenSV as [Tên sinh viên], HocBong [Học bổng]
From SinhVien
Order by MaSV ASC
GO

/*
3. Danh sách các sinh viên, gồm các thông tin sau:
Mã sinh viên, Tên sinh viên,  Phái, Ngày sinh.
Danh sách sẽ được sắp xếp theo thứ tự của tên.  
*/
Select MaSV,TenSV,Phai, NgaySinh
From SinhVien
Order By TenSV ASC

/*
4. Thông tin các sinh viên gồm:
Họ tên sinh viên, Ngày sinh, Học bổng.
Thông tin  sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần và Học bổng giảm dần.
*/
Select  HoSV + ' ' + TenSV as [Họ tên sinh viên]
        , NgaySinh as [Ngày sinh]
        , HocBong as [Học bổng]
From SinhVien
Order By NgaySinh asc, 3 DESC

/*
5. Danh sách các môn học có tên bắt đầu bằng chữ T,  
gồm các thông tin: Mã môn,  Tên môn, Số tiết.  
*/ -- So sánh tương đối
Select MaMH, TenMH, Sotiet
From MonHoc
Where TenMH Like N'T%'
GO
/*
6. Liệt kê danh sách những sinh viên
có chữ cái cuối cùng trong tên là i,
gồm các  thông tin: Họ tên sinh viên, Ngày sinh, Phái  
*/
Select [HoSV],[TenSV],[Phai],[NgaySinh]
From SinhVien
Where TenSV Like N'%i'
GO

/*
7. Danh sách những khoa có ký tự thứ hai của tên khoa có chứa chữ N,
gồm các  thông tin: Mã khoa, Tên khoa.  
*/
Select MaKH, TenKH
From Khoa
Where TenKH Like N'_N%'
GO

/*
8. Liệt kê những sinh viên mà họ có chứa chữ Thị.
*/
Select *
From  SinhVien
Where HoSV like N'%thị%'
GO

/*
9. Cho biết danh sách những sinh viên ký tự đầu tiên của tên nằm trong khoảng
từ a đến m, gồm các thông tin: Mã sinh viên,Họ tên sinh viên,Phái, Học bổng.
*/
Select MaSV, HoSV, TenSV, Phai, HocBong
From SinhVien
Where TenSV like N'[a-m]%'
GO

/*
10. Cho biết danh sách những sinh viên mà tên có chứa ký tự nằm trong khoảng từ
a đến m, gồm các thông tin: Họ tên sinh viên, Ngày sinh, Nơi sinh, Học bổng.
Danh sách được sắp xếp tăng dần theo họ tên sinh viên.
*/
Select MaSV, HoSV+ ' ' + TenSV as [Họ tên sinh viên],NgaySinh, NoiSinh, HocBong
From SinhVien
Where TenSV like N'%[a-m]%'
Order By 2 ASC
GO
/*
11. Cho biết danh sách các sinh viên của khoa Anh văn, gồm các thông tin sau: Mã
sinh viên, Họ tên sinh viên, Ngày sinh, Mã khoa.
*/
Select MaSV, HoSV+ ' ' + TenSV as [Họ tên sinh viên], NgaySinh, MaKH
From SinhVien
Where MaKH = 'AV'

/*
12. Liệt kê danh sách sinh viên của khoa Vật Lý, gồm các thông tin sau: Mã sinh viên,
Họ tên sinh viên, Ngày sinh. Danh sách sẽ được sắp xếp theo thứ tự Ngày sinh
giảm dần.
*/
Select MaSV, HoSV+ ' ' + TenSV as [Họ tên sinh viên]
    ,Convert(Char(10),NgaySinh,103) as [Ngày sinh]
    , MaKH
From SinhVien
Where MaKH = 'TH'
Order By NgaySinh DESC
GO
Select * from Khoa
/*
13. Cho biết danh sách các sinh viên có học bổng lớn hơn 500,000, gồm các thông
tin: Mã sinh viên, Họ tên sinh viên, Mã khoa, Học bổng. Danh sách sẽ được sắp
xếp theo thứ tự Mã khoa giảm dần.
*/
Select MaSV, HoSV, TenSV, MaKH, HocBong
From SinhVien
Where HocBong > 50000
Order By MaKH DESC
GO

/*
14. Liệt kê danh sách sinh viên sinh vào ngày 20/12/1987, gồm các thông tin: Họ
tên sinh viên, Mã khoa, Học bổng.
*/
Select HoSV+ ' ' + TenSV as [Họ tên sinh viên], MaKH, HocBong
        , Convert(Char(10),NgaySinh,103) as [Ngày sinh]
From SinhVien
Where Convert(Char(10),NgaySinh,103) = '20/12/1987'
GO
Select HoSV+ ' ' + TenSV as [Họ tên sinh viên], MaKH, HocBong
        , Convert(Char(10),NgaySinh,103) as [Ngày sinh]
From SinhVien
Where Day(ngaysinh) = 20 and Month(Ngaysinh)=12 and Year(NgaySinh)=1987
GO

/*
15. Cho biết các sinh viên sinh sau ngày 20/12/1977, gồm các thông tin: Họ tên sinh
viên, Ngày sinh, Nơi sinh, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự
ngày sinh giảm dần.
*/
Select HoSV+ ' ' + TenSV as [Họ tên sinh viên], MaKH, HocBong
        , Convert(Char(10),NgaySinh,103) as [Ngày sinh]
From SinhVien
Where Convert(Char(10),NgaySinh,103) > '20/12/1987'
Order by NgaySinh DESC
GO
/*
16. Liệt kê các sinh viên có học bổng lớn hơn 100,000 và sinh ở Tp HCM, gồm các
thông tin: Họ tên sinh viên, Mã khoa, Nơi sinh, Học bổng.
*/
Select *
From SinhVien
Where HocBong > 100000 and NoiSinh Like N'%Tp. HCM%'
GO
/*
17. Danh sách các sinh viên của khoa Anh văn và khoa Triết, gồm các thông tin: Mã
sinh viên, Mã khoa, Phái.
*/
Select *
From SinhVien
Where  MaKH = 'AV' Or MaKH = 'TR'
GO
Select *
From SinhVien
Where  MaKH IN ('AV','TR')
GO