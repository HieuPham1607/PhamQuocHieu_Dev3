Create database QLSINHVIEN
Go
Use QLSINHVIEN
GO
/*Bài 2*/
/*1. Liệt kê danh sách sinh viên gồm các thông tin sau: Họ và tên sinh viên, 
Giới tính,Tuổi, Mã khoa. Trong đó Giới tính hiển thị ở 
dạng Nam/Nữ tuỳ theo giá trị củafield Phai là True hay False, 
Tuổi sẽ được tính bằng cách lấy năm hiện hành trừ cho năm sinh. 
Danh sách sẽ được sắp xếp theo thứ tự Tuổi giảm dần*/

SELECT HoSV as'Họ' ,TenSV as'Tên',
          [Giới tính] =CASE
		                       WHEN Phai =1 THEN N'Nữ'
							   WHEN Phai =0 THEN N'Nam'
							END,
[Tuổi]= YEAR(GETDATE())-YEAR(NgaySinh)
From SinhVien
ORDER by YEAR(GETDATE())-YEAR(NgaySinh) DESC
go

/*2. Liệt kê danh sách sinh viên, gồm các thông tin sau: Mã sinh viên, Họ sinh viên,
Tên sinh viên, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự Mã sinh viên
tăng dần.*/

SELECT HoSV AS 'Họ', TenSV AS'Tên',
[Phải]= CASE WHEN phai =1 THEN N'Nữ'
            WHEN phai =0 THEN N'Nam'
			END,
DAY(NgaySinh)
FROM dbo.SinhVien
WHERE MONTH(NgaySinh)=2 AND YEAR(NgaySinh)=1994
GO

/*3. Danh sách các sinh viên, gồm các thông tin sau: Mã sinh viên, Tên sinh viên,
Phái, Ngày sinh. Danh sách sẽ được sắp xếp theo thứ tự của tên.*/

SELECT * FROM dbo.SinhVien
ORDER BY NgaySinh DESC
GO

/*4. Thông tin các sinh viên gồm: Họ tên sinh viên, Ngày sinh, Học bổng. Thông tin
sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần và Học bổng giảm dần.*/
SELECT MaSV AS 'Mã sinh viên',Phai AS 'Phái',MaKH AS 'Mã khoa',
[Mức học bổng]=CASE WHEN HocBong >500000 THEN N'Học bổng cao'
                    ELSE N'Mức trung bình'
				END
FROM dbo.SinhVien
GO

/*5. Cho biết điểm thi của các sinh viên, gồm các thông tin: Họ tên sinh viên, Mã
môn học, Điểm. Kết quả sẽ được sắp theo thứ tự Họ tên sinh viên và mã môn
học tăng dần*/

SELECT HoSV AS 'Họ', TenSV AS 'Tên',
MonHoc.MaMH AS 'Mã môn học', Diem AS 'Điểm'
FROM dbo.SinhVien JOIN dbo.Ketqua ON Ketqua.MaSV = SinhVien.MaSV JOIN
dbo.MonHoc ON MonHoc.MaMH = Ketqua.MaMH
ORDER BY Họ , Tên , MonHoc.MaMH
GO

/*6. Danh sách sinh viên của khoa Anh văn, điều kiện lọc phải sử dụng tên khoa, gồm
các thông tin sau: Họ tên sinh viên, Giới tính, Tên khoa. Trong đó, Giới tính sẽ
hiển thị dạng Nam/Nữ*/

SELECT HoSV AS' Họ', TenSV AS 'Tên',
[Giới tính] = CASE
                    WHEN Phai =1 THEN N'Nữ'
					WHEN Phai =0 THEN N'Nam'
				END
,TenKH AS 'Tên khoa'
FROM dbo.SinhVien JOIN dbo.Khoa ON Khoa.MaKH = SinhVien.MaKH
WHERE Khoa.MaKH = 'AV'
GO
/*7. Liệt kê bảng điểm của sinh viên khoa Tin Học, gồm các thông tin:Tên khoa, Họ
tên sinh viên, Tên môn học, Số tiết, Điểm*/

SELECT
TenKH AS 'Tên khoa',
HoSV AS 'Họ',
TenSV AS 'Tên',
TenMH AS 'Tên môn học',
Sotiet AS 'Số tiết',
Diem AS 'Điểm'

FROM dbo.SinhVien JOIN dbo.Khoa ON Khoa.MaKH = SinhVien.MaKH JOIN dbo.Ketqua ON
Ketqua.MaSV = SinhVien.MaSV JOIN dbo.MonHoc ON MonHoc.MaMH = Ketqua.MaMH
WHERE Khoa.MaKH='TH'
GO

/*8. Kết quả học tập của sinh viên, gồm các thông tin: Họ tên sinh viên, Mã khoa,
Tên môn học, Điểm thi, Loại. Trong đó, Loại sẽ là Giỏi nếu điểm thi > 8, từ 6 đến
8 thì Loại là Khá, nhỏ hơn 6 thì loại là Trung Bình*/

SELECT
HoSV AS 'Họ',
TenSV AS 'Tên',
MaKH AS 'Mã khoa',
TenMH AS 'Tên môn học',
Diem AS 'Điểm',
[Loại]= CASE WHEN Diem >8 THEN N'Giỏi'
                 WHEN Diem BETWEEN 6 AND 8 THEN N'Khá'
				 WHEN Diem <6 THEN N'Trung bình'
				 END
FROM dbo.SinhVien JOIN dbo.Ketqua ON Ketqua.MaSV = SinhVien.MaSV
JOIN dbo.Monhoc ON MonHoc.MaMH = Ketqua.MaMH
GO

