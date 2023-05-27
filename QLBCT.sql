CREATE DATABASE QLBCT
GO
USE QLBCT
GO
CREATE TABLE NCC
(
	MaNCC nvarchar(10) PRIMARY KEY,
	TenNCC nvarchar(100) NOT NULL,
)
GO
CREATE TABLE LoaiMH
(
	MaLMH nvarchar(10) PRIMARY KEY,
	TenLMH nvarchar(100) NOT NULL,
)
GO
CREATE TABLE MatHang
(
    MaMH nvarchar(10) PRIMARY KEY,
	TenMH nvarchar(50) NOT NULL,
	SoLuongTon int NOT NULL,
    GiaMH int NOT NULL,
	MoTa nvarchar(300),
	AnhMH nvarchar(50),
	MaLMH nvarchar(10) NOT NULL FOREIGN KEY REFERENCES LoaiMH(MaLMH),
	MaNCC nvarchar(10) FOREIGN KEY REFERENCES NCC(MaNCC),
)
GO
CREATE TABLE NhanVien
(
    MaNV nvarchar(10) PRIMARY KEY,
	HoNV nvarchar(50) NOT NULL,
	TenNV nvarchar(10) NOT NULL,
	GioiTinh bit DEFAULT(1),
	NgaySinh date,
	Luong int,
	DiaChi nvarchar(100),
	SDT nvarchar(10), 
	Email varchar(50) NOT NULL,
	Password nvarchar(50),
	Admin bit DEFAULT(0),
)
GO
CREATE TABLE KhachHang
(
    MaKH nvarchar(10) PRIMARY KEY,
	HoKH nvarchar(50) NOT NULL,
	TenKH nvarchar(10) NOT NULL,
	GioiTinh bit DEFAULT(1),
	NgaySinh date,
	DiaChi nvarchar(100) NOT NULL,
	SDT nvarchar(10),
	Email varchar(50) NOT NULL,
	Password nvarchar(50),
)
GO
CREATE TABLE HoaDon
(
	MaHD nvarchar(10) PRIMARY KEY,
	NgayDat datetime NOT NULL,
	NgayNhan datetime,
	DiaChiNhan NVARCHAR(100) NOT NULL,
	TinhTrang bit DEFAULT(0),
	MaNV nvarchar(10) NOT NULL FOREIGN KEY REFERENCES NhanVien(MaNV),
	MaKH nvarchar(10) NOT NULL FOREIGN KEY REFERENCES KhachHang(MaKH),
)
GO
CREATE TABLE CTHD
(
	MaHD nvarchar(10) FOREIGN KEY REFERENCES HoaDon(MaHD),
	MaMH nvarchar(10) FOREIGN KEY REFERENCES MatHang(MaMH),
	SoLuong int NOT NULL,
	Gia int NOT NULL,
	PRIMARY KEY(MaHD, MaMH),
)
GO
INSERT INTO NCC (MaNCC, TenNCC)
VALUES
    (N'NCC001', N'Công ty gạo A'),
    (N'NCC002', N'Công ty gà B'),
    (N'NCC003', N'Công ty bò C');
GO
INSERT INTO LoaiMH (MaLMH, TenLMH)
VALUES
    (N'LMH001', N'Cơm'),
	(N'LMH002', N'Phụ'),
    (N'LMH003', N'Nước');
GO
INSERT INTO MatHang (MaMH, TenMH, SoLuongTon, GiaMH, MoTa, AnhMH, MaLMH, MaNCC)
VALUES
    (N'MH001', N'Cơm sườn', 100, 20000, N'Cơm trắng + 1 miếng sườn nướng', N'anh1.jpg', N'LMH001', null),
    (N'MH002', N'Cơm gà', 150, 22000, N'Cơm trắng + 1 đùi gà', N'anh2.jpg', N'LMH002', null),
    (N'MH003', N'Cơm chiên trứng', 80, 25000, N'Cơm chiên với trứng', N'anh3.jpg', N'LMH001', null)
GO
INSERT INTO NhanVien (MaNV, HoNV, TenNV, GioiTinh, NgaySinh, Luong, DiaChi, SDT, Email, Password, Admin)
VALUES
    (N'NV001', N'Lê Hải', N'Anh', 1, '1990-01-01', 5000000, N'Hà Nội', N'0987654321', 'anhlh@ntu.edu.com', '123', 1),
    (N'NV002', N'Trần Thị', N'Bích', 0, '1995-02-02', 4500000, N'Hồ Chí Minh', N'0912345678', 'bichth@gmail.com', '123', 0),
    (N'NV003', N'Lê Thành', N'Can', 1, '1993-03-03', 4800000, N'Đà Nẵng', N'0976543210', 'canlt@gmail.com', '123', 0);
GO
INSERT INTO KhachHang (MaKH, HoKH, TenKH, GioiTinh, NgaySinh, DiaChi, SDT, Email, Password)
VALUES
    (N'KH001', N'Nguyễn Thị', N'Dung', 0, '1992-04-04', N'Hà Nội', N'0901234567', 'dungnt@gmail.com', '123'),
    (N'KH002', N'Trần Thành', N'Nam', 1, '1997-05-05', N'Hồ Chí Minh', N'0912345678', 'namtt@gmail.com', '123'),
    (N'KH003', N'Lê Văn', N'Minh', 1, '1994-06-06', N'Đà Nẵng', N'0987654321', 'minhlv@gmail.com', '123');
GO
INSERT INTO HoaDon (MaHD, NgayDat, NgayNhan, DiaChiNhan, TinhTrang, MaNV, MaKH)
VALUES
    (N'HD001', '2023-05-01 10:00:00', '2023-05-01 12:00:00', N'Hà Nội', 1, N'NV001', N'KH001'),
    (N'HD002', '2023-05-02 11:00:00', '2023-05-02 13:00:00', N'Hồ Chí Minh', 0, N'NV002', N'KH002'),
    (N'HD003', '2023-05-03 12:00:00', '2023-05-03 14:00:00', N'Đà Nẵng', 1, N'NV003', N'KH003');
GO
INSERT INTO CTHD (MaHD, MaMH, SoLuong, Gia)
VALUES
    (N'HD001', N'MH001', 2, 20000),
    (N'HD001', N'MH002', 3, 22000),
    (N'HD002', N'MH003', 1, 25000)
GO