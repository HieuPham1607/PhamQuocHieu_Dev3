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
/*Bài 3*/

/*1. Cho biết trung bình điểm thi theo từng môn, gồm các thông tin: Mã môn, Tên
môn, Trung bình điểm thi*/

SELECT MonHoc.MaMH as N'Mã môn',
TenMH as N'Tên môn',
AVG(Diem) as N'Trung bình điểm thi'
FROM dbo.SinhVien JOIN dbo.Ketqua ON Ketqua.MaSV = SinhVien.MaSV JOIN dbo.MonHoc ON
MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH,TenMH,DiemTrungBinh
GO

/*2. Danh sách số môn thi của từng sinh viên, gồm các thông tin: Họ tên sinh viên,
Tên khoa, Tổng số môn thi*/

SELECT HoSV AS 'Họ', TenSV AS 'Tên',TenKH AS 'Tên khoa',
[Tổng môn thi] = COUNT(Ketqua.MaMH)
FROM dbo.SinhVien
JOIN dbo.Ketqua ON Ketqua.MaSV = SinhVien.MaSV JOIN dbo.MonHoc
ON MonHoc.MaMH = Ketqua.MaMH JOIN dbo.Khoa ON Khoa.MaKH = SinhVien.MaKH
GROUP BY HoSV,
         TenSV,
		 TenKH
GO

/*3. Tổng điểm thi của từng sinh viên, các thông tin: Tên sinh viên, Tên khoa, Phái,
Tổng điểm thi*/

/*4. Cho biết tổng số sinh viên ở mỗi khoa, gồmcác thông tin: Tên khoa, Tổng số sinh
viên*/

SELECT TenKH AS 'Tên khoa',[Tổng số sinh viên]=COUNT(MaSV)
FROM dbo.Khoa JOIN dbo.SinhVien ON SinhVien.MaKH = Khoa.MaKH
GROUP BY TenKH
GO

/*5. Cho biết điểm cao nhất của mỗi sinh viên, gồm thông tin:Họ tên sinh viên, Điểm*/
SELECT HoSV AS 'Họ',TenSV AS 'Tên', [Điểm] = MAX(Diem) FROM
dbo.SinhVien JOIN dbo.Ketqua ON Ketqua.MaSV = SinhVien.MaSV
GROUP BY HoSV,
         TenSV
GO

/*Bài 4*/
/*1*/
DECLARE @MaKH NVARCHAR(10);
SET @MaKH = 'AV';

SELECT 
     SinhVien.MaSV AS 'Mã sinh viên',
	 SinhVien.TenSV AS 'Họ tên sinh viên',
	 SinhVien.Phai AS 'Giới tính',
	 Khoa.TenKH AS 'Tên khoa'
FROM
    dbo.SinhVien
JOIN
    dbo.Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE 
    Khoa.MaKH = @MaKH;
GO

/*2*/
DECLARE @Diem FLOAT;
SET @Diem = 5.0;

SELECT 
     SinhVien.MaSV AS 'Mã sinh viên',
	 SinhVien.TenSV AS 'Họ tên sinh viên',
	 MonHoc.TenMH AS 'Tên môn',
	 Ketqua.Diem AS 'Điểm'
FROM
    dbo.SinhVien
JOIN
    dbo.Ketqua ON SinhVien.MaKH = Ketqua.MaSV
JOIN 
    dbo.MonHoc ON  Ketqua.MaMH = MonHoc.MaMH
WHERE 
    MonHoc.TenMH = N'Cơ sở dữ liệu' AND Ketqua.Diem > @Diem
GO
/*3*/

DECLARE @TenMH NVARCHAR(10);
SET TenMH = 'Cở sở dữ liệu';

SELECT 
     SinhVien.MaSV AS 'Mã sinh viên',
	 SinhVien.TenSV AS 'Họ tên sinh viên',
	 Khoa.TenKH AS 'Tên khoa',
	 MonHoc.TenMH AS 'Tên môn',
	 Ketqua.Diem AS 'Điểm'
FROM
     dbo.SinhVien
JOIN 
     dbo.Khoa ON SinhVien.MaKH = Khoa.MaKH
JOIN 
     dbo.Ketqua ON SinhVien.MaSV = Ketqua.MaSV
JOIN
     dbo.MonHoc ON Ketqua.MaMH = MonHoc.MaMH
WHERE
     MonHoc.TenMH = @TenMH;
 GO

 /*Bài5*/
/*11*/
SELECT 
      SV.MaSV AS 'Mã sinh viên',
	  SV.TenSV AS 'Tên sinh viên',
	  MH.TenMH AS 'Tên môn',
	  KQ.Diem AS 'Điểm'
FROM
      dbo.SinhVien AS SV
JOIN 
      dbo.Ketqua AS KQ ON SV.MaSV = KQ.MaSV
JOIN
      dbo.MonHoc AS MH ON KQ.MaMH = MH.MaMH
WHERE
      KQ.Diem = 
	  (
	   SELECT MAX(Diem)
	   FROM dbo.Ketqua
	   WHERE MaMH = MH.MaMH
	  );
GO

/*10*/
SELECT 
    SV.MaSV AS 'Mã sinh viên',
	SV.TenSV AS 'Tên sinh viên',
	SV.NoiSinh AS 'Nơi sinh',
	SV.HocBong AS 'Học bổng'
FROM
    dbo.SinhVien AS SV
WHERE
    SV.NoiSinh = (
	SELECT TOP 1 NoiSinh
	FROM dbo.SinhVien
	WHERE MaKH = (SELECT MaKH FROM dbo.Khoa WHERE TenKH = N'Anh Văn')
	ORDER BY HocBong DESC
	);
GO

/*Bài 8*/
/*1*/
UPDATE MonHoc
SET SoTiet = 45
WHERE TenMH = N'Tiếng Anh cơ bản';
GO
/*2*/
UPDATE SinhVien
SET TenSV = N'Trần Thanh Kỳ'
WHERE TenSV = N'Trần Thị Mai';
GO
/*3*/
UPDATE SinhVien
SET Phai = 0
WHERE TenSV = N'Trần Thanh Kỳ';
GO
/*4*/
UPDATE SinhVien
SET NgaySinh = '1990-07-05'
WHERE TenSV = N'Trần Thị Thu Thủy';
GO
/*5*/
UPDATE SinhVien
SET HocBong = HocBong + 100000
WHERE MaKH = N'AV';
GO
/*6*/
UPDATE Ketqua
SET Diem = CASE  
                WHEN Diem + 5 >10 THEN 10
				ELSE Diem + 5
		   END
WHERE MaMH = '02'
AND MaSV IN (SELECT MaSV FROM SinhVien WHERE MaKH = 'AV');
/*7*/
UPDATE SinhVien
SET HocBong = CASE
                WHEN Phai = 1 AND MaKH = N'AV' THEN HocBong + 100000
				WHEN Phai = 0 AND MaKH = N'TH' THEN HocBong + 150000
				ELSE HocBong + 50000
				END;

/*8*/
UPDATE Ketqua
SET Diem = CASE 
                WHEN MaSV IN (SELECT MaSV FROM SinhVien WHERE MaKH = N'AV') THEN LEAST(Diem + 2, 10) --Tăng hai điểm cho sinh viên khoa khác
				WHEN MaSV IN (SELECT MaSV FROM SinhVien WHERE MaKH = N'TH') THEN GREATEST(Diem - 1, 0) --Giảm điểm cho sinh viên khoa khác
				ELSE Diem -- không thay đổi điểm cho sinh viên khoa khác
		   END
WHERE MaMH = '01'; --Cập nhập chỉ cho môn có mã '01'