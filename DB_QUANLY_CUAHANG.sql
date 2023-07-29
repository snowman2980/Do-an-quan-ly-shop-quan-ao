CREATE DATABASE DB_QUANLY_CUAHANG
GO
USE DB_QUANLY_CUAHANG
GO

-----------------------------TẠO-BẢNG-----------------------------------
CREATE TABLE NHANVIEN
(
    MANV NCHAR(5) NOT NULL UNIQUE,
    TENNV NVARCHAR(30),
    SODT NVARCHAR(20),
    DIACHI NVARCHAR(30),
    NGAYSINH DATE,
    GIOITINH NVARCHAR(30),
	LUONG INT,
    CONSTRAINT PK_NV PRIMARY KEY (MANV)
)

CREATE TABLE KHACHHANG
(
    MAKH NCHAR(5) NOT NULL,
    TENKH NVARCHAR(30),
    SODT NVARCHAR(20),
    DIACHI NVARCHAR(30),
    GIOITINH NCHAR(5),
    CONSTRAINT PK_KH PRIMARY KEY (MAKH)
)

CREATE TABLE NHACUNGCAP
(
    MANCC NCHAR(5) NOT NULL,
    TENNCC NVARCHAR(30),
    SODT NVARCHAR(20) ,
    DIACHI NVARCHAR(30),
    CONSTRAINT PK_NCC PRIMARY KEY (MANCC)
	
)
CREATE TABLE CHATLIEU
(
	MACL NCHAR(5),
	TENCL NVARCHAR(30),
	CONSTRAINT PK_CL PRIMARY KEY (MACL)
)

CREATE TABLE MATHANG
(
    MAMH NCHAR(5) NOT NULL,
    TENMH NVARCHAR(30),
	DONGIANHAP INT,
	DONGIABAN INT,
    TENNCC NVARCHAR(30),
	TENCL NVARCHAR(30),
	SOLUONG INT,
	GHICHU NVARCHAR(30) DEFAULT 'CHUA XAC DINH',
    CONSTRAINT PK_MH PRIMARY KEY (MAMH)
 
)

CREATE TABLE HOADONBAN    
(
    MAHD NCHAR(5) NOT NULL,
	MANV NCHAR(5) NOT NULL,
	MAKH NCHAR(5) NOT NULL,
	MAMH NCHAR(5) NOT NULL,
    TENMH NVARCHAR(30),
    SL INT  ,
	DONGIA INT ,
	GIAMGIA INT ,  
    TONGTIEN INT ,
	NGAYBAN DATE,
    CONSTRAINT PK_HDB PRIMARY KEY (MAHD),
	CONSTRAINT FK_HDB_NV FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV),
    CONSTRAINT FK_HDB_MH FOREIGN KEY(MAMH) REFERENCES MATHANG(MAMH),
	CONSTRAINT CHK_SL CHECK (SL > 0)
   
)
CREATE TABLE CT_HOADONBAN    
(
	MAHD NCHAR(5) NOT NULL,
    MAKH NCHAR(5) NOT NULL,	
    NGAYMUA DATE,
    TONGTIEN INT ,
    
    CONSTRAINT FK_CT_HDB_HD FOREIGN KEY(MAHD) REFERENCES HOADONBAN(MAHD),
    CONSTRAINT FK_CT_HDB_KH FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH)
)
CREATE TABLE CT_HANGNHAP
(
    MANCC NCHAR(5) NOT NULL,	
	MAMH NCHAR(5) NOT NULL,
    SL INT,
	NGAYNHAP DATE,
    DONGIANHAP INT,
	DONGIABAN INT,
    CONSTRAINT FK_HDN_NCC FOREIGN KEY(MANCC) REFERENCES NHACUNGCAP(MANCC),
    CONSTRAINT FK_HDN_MHH FOREIGN KEY(MAMH) REFERENCES MATHANG(MAMH)
)

CREATE TABLE KHO
(
    MAMH NCHAR(5) NOT NULL,
    SOLUONG INT,
    TINHTRANG NVARCHAR(30),
    CONSTRAINT FK_MH_KHO FOREIGN KEY(MAMH) REFERENCES MATHANG(MAMH)
)
CREATE TABLE NGUOIDUNG
(
    TAIKHOAN NVARCHAR(50) NOT NULL,
    MATKHAU NVARCHAR(50),
	CONSTRAINT PK_ND PRIMARY KEY (TAIKHOAN)
)

CREATE TABLE KHOACHUONGTRINH
(
    MAKHOA NVARCHAR(50)
)


-----------------------------NHẬP-THÔNG-TIN-----------------------------------

INSERT INTO NGUOIDUNG VALUES
('chitai','2803'),
('minhhieu','0603')

INSERT INTO KHOACHUONGTRINH VALUES
('123')

SELECT *FROM NGUOIDUNG
SELECT *FROM KHOACHUONGTRINH
drop table KHOACHUONGTRINH
drop table NGUOIDUNG


INSERT INTO NHANVIEN VALUES
('NV01',N'Nguyễn Chí Tài','0933108601',N'Long An','2002/03/28','Nam',2000),
('NV02',N'Lê Văn Phát','012333108',N'Đồng Nai','2000/03/02','Nam',2000),
('NV03',N'Trần Chí Phúc','0945733888',N'Thành Phố','2001/07/09',N'Nữ',2000),
('NV04',N'Bùi Thành Phong','0987878798',N'Tiền Giang','2007/09/28',N'Nữ',2000),
('NV05',N'Nguyễn Thanh Phúc','0934546550',N'Bến Tre','1999/07/06','Nam',2000)

--trigger--
CREATE TRIGGER KT_TUOI ON NHANVIEN
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @tuoi_nvmoi INT
    SET @tuoi_nvmoi = ( SELECT YEAR(GETDATE())-YEAR(NGAYSINH) FROM inserted)
    IF (@tuoi_nvmoi < 18)
        BEGIN
            PRINT N'Nhân viên không được nhỏ hơn 18 tuổi'
            ROLLBACK TRANSACTION
        END
END
DROP TRIGGER KT_TUOI
INSERT INTO NHANVIEN VALUES ('NV08',N'Nguyễn Chí Tài Em','0933108601',N'Long An','2006/03/28','Nam')
SELECT *FROM NHANVIEN
DELETE FROM NHANVIEN WHERE MANV = 'NV08'

INSERT INTO KHACHHANG VALUES
('KH01',N'Nguyễn Là Nữ','0989751723',N'Cà Mau',N'Nữ'),
('KH02',N'Trần Tiểu Tèo','0992331563',N'Hà Giang','Nam'),
('KH03',N'Lê Chí Tứ','0933561789',N'Hà Nội Giang','Nam'),
('KH04',N'Bùi Thị Lục','0937753875',N'Bắc Giang',N'Nữ'),
('KH05',N'Nguyễn Thảo Thảo','0990631656',N'Kiên Giang',N'Nữ')

INSERT INTO NHACUNGCAP VALUES
('GC',N'Gucci','0989829747',N'Đà Nẵng'),
('AD',N'Adidas','0928347206',N'Long An'),
('NK',N'Nike','0992739879',N'Tân Phú'),
('TP',N'TP Shop','0992846192',N'Tân Bình'),
('DM',N'Duma','0987592877',N'Bình Chánh')

INSERT INTO CHATLIEU VALUES
('CT',N'Vải Cotton'),
('DU',N'Vải dù'),
('BONG',N'Vải bông'),
('KAKI',N'Vải kaki'),
('JEAN',N'Vải jean')

INSERT INTO MATHANG VALUES
('QS',N'Quần Short','50000','70000','Gucci',N'Vải jean','100',''),
('QP',N'Quần Pjyama','40000','90000','Nike',N'Vải Cotton','100',''),
('AT',N'Áo Thun','30000','40000','Duma',N'Vải Cotton','100',''),
('ASM',N'Áo Sơ Mi','70000','100000','TP Shop',N'Vải kaki','100',''),
('AK',N'Áo Khoác','90000','120000','Gucci',N'Vải dù','100',''),
('QT',N'Quần Tây','90000','120000','Adidas',N'Vải kaki','100','')

INSERT INTO HOADONBAN VALUES
('HD01','NV02','KH01','QS',N'Quần Short','2','70000','10000','139000','2021/03/07'),
('HD02','NV03','KH02','QT',N'Quần Tây','1','120000','12000','108000','2019/03/17'),
('HD03','NV05','KH03','AT',N'Áo Thun','2','40000','0','80000','2022/03/19'),
('HD04','NV04','KH04','AK',N'Áo Khoác','3','120000','0','360000','2022/03/20'),
('HD05','NV01','KH05','ASM',N'Áo Sơ Mi','2','100000','200','98800','2020/03/22')

INSERT INTO CT_HOADONBAN VALUES
('HD01','KH01','2021/03/07','139000'),
('HD02','KH02','2029/03/17','108000'),
('HD03','KH03','2022/03/19','80000'),
('HD04','KH04','2022/03/20','360000'),
('HD05','KH05','2020/03/22','98800')

INSERT INTO CT_HANGNHAP VALUES
('GC','QS','100','2022/09/15','50000','70000'),
('DM','AT','100','2021/09/10','30000','40000'),
('TP','ASM','100','2020/09/15','70000','100000'),
('DM','AK','100','2012/09/12','90000','120000'),
('AD','QT','100','2019/09/13','90000','120000')

INSERT INTO KHO VALUES
('QP','30',N'Còn hàng'),
('AT','20',N'Còn hàng'),
('AK','90',N'Còn hàng'),
('ASM','0',N'Hết hàng'),
('QS','10',N'Còn hàng'),
('QT','50',N'Còn hàng')


--SELECT *FROM KHO, MATHANG,  
--WHERE KHO.MAMH = MATHANG.MAMH

-------------------------------------TẠO BẢNG-------------------------------------
SELECT *FROM NHANVIEN
SELECT *FROM KHACHHANG
SELECT *FROM NHACUNGCAP
SELECT *FROM CHATLIEU
SELECT *FROM MATHANG
SELECT *FROM HOADONBAN
SELECT *FROM CT_HOADONBAN
SELECT *FROM CT_HANGNHAP
SELECT *FROM KHO

select MAHD, HOADONBAN.MAMH, TONGTIEN, NGAYBAN  from HOADONBAN
where YEAR(NGAYBAN) = 2019
DELETE FROM KHO
WHERE KHO.MAMH = 'AT'

update KHO set SOLUONG = 100,TINHTRANG = N'Còn Hàng' WHERE MAMH = 'ASM'
update HOADONBAN set SL = 2, DONGIA = 70000 where MAHD ='HD01' and MANV ='NV03' AND MAKH ='KH02'
delete from MATHANG where MATHANG.MAMH ='AM'
select *from MATHANG where MATHANG.MAMH ='AT'

--------------------------------------XÓA BẢNG------------------------------------
DROP TABLE KHACHHANG
DROP TABLE CT_HOADONBAN
DROP TABLE CT_HANGNHAP
DROP TABLE HOADONBAN
DROP TABLE NHANVIEN
DROP TABLE MATHANG
DROP TABLE NHACUNGCAP
DROP TABLE CHATLIEU
DROP TABLE KHO

------------------------------------TẠO THỦ TỤC------------------------------------
--1 Đọc và in ra Họ tên của nhân viên có mã x
--Tạo thủ tục
CREATE PROC	IN_THONG_TIN_NV @MaNV char(5)
AS
    --Bỏ message (x row(s) affected)
    SET NOCOUNT ON
    DECLARE @Hoten nvarchar(30)
    --
    SELECT *--@Hoten = TENNV
    FROM NHANVIEN
    WHERE MANV = @MaNV
    --
    --PRINT N'Họ tên của nhân viên là: ' + @Hoten
GO
--Gọi thực hiện thủ tục
EXEC IN_THONG_TIN_NV NV01
--Hoặc
EXEC IN_THONG_TIN_NV @MaNV = 'NV01'
--Hoặc
DECLARE @MaNV char(5) = 'NV01'
EXEC IN_THONG_TIN_NV @MaNV
DROP PROC IN_THONG_TIN_NV

--2 Đọc và trả ra Họ tên của khách hàng có mã x
--Tạo thủ tục
CREATE PROC TRA_THONG_TIN_KH @MaKH char(5), @Hoten nvarchar(30) OUT
AS
    --Bỏ message (x row(s) affected)
    SET NOCOUNT ON
    --
    SELECT @Hoten = TENKH
    FROM KHACHHANG
    WHERE MAKH = @MaKH
GO
--Gọi thực hiện thủ tục
DECLARE @MaKH char(5) = 'KH01'
DECLARE @Hoten nvarchar(30)
EXEC TRA_THONG_TIN_KH @MaKH, @Hoten OUT
PRINT N'Họ tên của khách hàng là: ' + @Hoten

--3 Đếm số mặt hàng
--Tạo thủ tục
CREATE PROC DEM_SO_MAT_HANG @TenNCC nvarchar(30) = NULL
AS
    DECLARE @Dem int
    --Đếm số mặt hàng của nhà cung cấp
    SELECT @Dem = COUNT(*)
    FROM MATHANG
    WHERE TENNCC = @TenNCC OR @TenNCC IS NULL
    --
    PRINT N'Số mặt hàng là: ' + STR(@Dem)
GO
--Gọi thực hiện thủ tục
--a Đếm số mặt hàng của nhà cung cấp x
EXEC DEM_SO_MAT_HANG @TenNCC = N'Gucci'
--b Đếm số mặt hàng của tất cả nhà cung cấp
EXEC DEM_SO_MAT_HANG

--4 Thêm khách hàng
--Tạo thủ tục
CREATE PROCEDURE THEM_KHACH_HANG @MaKH char(5), @Hoten nvarchar(30), @SDT nvarchar(20), @DiaChi nvarchar(30), @GioiTinh nvarchar(5)
AS
	INSERT INTO KHACHHANG
	VALUES(@MaKH,@Hoten,@SDT,@DiaChi,@GioiTinh)
--Gọi thực hiện thủ tục
EXEC THEM_KHACH_HANG 'KH06',N'Lê Tài','0975656723',N'Hậu Giang','Nam'
SELECT * FROM KHACHHANG

--5 Cập nhật kho
CREATE PROCEDURE CAP_NHAT_KHO @MaMH char(5), @SL int, @TinhTrang nvarchar(30)
AS
	UPDATE KHO SET SOLUONG = @SL
	WHERE MAMH = @MaMH
--Gọi thực hiện thủ tục
EXEC CAP_NHAT_KHO 'AT','50',N'Còn hàng'
SELECT * FROM KHO

--- tạo function---
--6 Kiểm tra mặt hàng nào còn trong kho
CREATE FUNCTION fn_KT_KHO()
RETURNS @tb TABLE (mamh_kho NVARCHAR(30), sl_kho INT, tinhtrang_kho NVARCHAR(30))
AS
BEGIN
	INSERT INTO @tb (mamh_kho, sl_kho, tinhtrang_kho)
		SELECT MAMH, SOLUONG, TINHTRANG FROM KHO WHERE SOLUONG > 0
		
	RETURN;
END

SELECT* FROM DBO.fn_KT_KHO()

--7 update số lượng mặt hàng tùy chọn trong kho (CHUA LAM DC)
--CREATE FUNCTION fn_UD_KHO(@mamh NVARCHAR(5),@sl int)
--RETURNS  @tb TABLE (mamh_kho NVARCHAR(5), sl_kho INT) 
--AS
--BEGIN
		--UPDATE KHO
		--SET MAMH = @mamh
		--WHERE SOLUONG = @sl
--	RETURN;
--END

--SELECT* FROM DBO.fn_UD_KHO('QP','70')

--8 trả về bảng nhân viên có mã nhân viên do người dùng nhập
CREATE FUNCTION fn_TIMNV(@manv NVARCHAR(5))
RETURNS TABLE
AS
		RETURN
		(SELECT *FROM NHANVIEN
		WHERE MANV = @manv)

SELECT* FROM DBO.fn_TIMNV('NV01')
--9 trả về bảng khách hàng có giới tính là nữ
CREATE FUNCTION fn_TIMKH_nu(@gt NVARCHAR(30))
RETURNS TABLE
AS
		RETURN
		(SELECT *FROM KHACHHANG
		WHERE GIOITINH = @gt)

SELECT* FROM DBO.fn_TIMKH_nu(N'Nữ')
--10 tính tiền lời cho 1 mặt hàng nhập về bán
CREATE FUNCTION fn_TINHTIENLOI()
RETURNS @tb TABLE (mamh NVARCHAR(30), tenmh NVARCHAR(30),dongianhap INT,dongiaban INT, sl int, tienloi float)
AS
BEGIN
	INSERT INTO @tb (mamh, tenmh, dongianhap, dongiaban, sl, tienloi)
		SELECT MAMH, TENMH, DONGIANHAP, DONGIABAN, SOLUONG, DONGIABAN-DONGIANHAP FROM MATHANG
		
	RETURN;
END

SELECT* FROM DBO.fn_TINHTIENLOI()

SELECT *FROM NHANVIEN
--11 Cập nhật lương cho nhân viên

DECLARE nhanviencursor CURSOR FOR SELECT MANV,YEAR(GETDATE()) - YEAR(NGAYSINH) FROM NHANVIEN
OPEN nhanviencursor
DECLARE @Manv NCHAR(5)
DECLARE @tuoi int

FETCH NEXT FROM nhanviencursor INTO @Manv, @tuoi
WHILE @@FETCH_STATUS = 0
BEGIN
	IF(@tuoi > 18)
	BEGIN
		UPDATE	NHANVIEN SET LUONG = 2500000 WHERE MANV = @Manv
	END
	ELSE
	BEGIN
		UPDATE NHANVIEN SET LUONG = 2000000 WHERE MANV = @Manv
	END

	FETCH NEXT FROM nhanviencursor INTO @Manv, @tuoi
END
CLOSE nhanviencursor
DEALLOCATE nhanviencursor

--12 select all nhân viên
CREATE PROC	NHANVIEN_SelectAll 
AS
    --Bỏ message (x row(s) affected)
    SET NOCOUNT ON
   
    SELECT *
    FROM NHANVIEN

GO
EXEC NHANVIEN_SelectAll
--13 tìm khách hàng nam
CREATE FUNCTION fn_TIMKH_nam(@gt NVARCHAR(30))
RETURNS TABLE
AS
		RETURN
		(SELECT *FROM KHACHHANG
		WHERE GIOITINH = @gt)

SELECT* FROM DBO.fn_TIMKH_nam(N'Nam')