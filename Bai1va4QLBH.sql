--Bài 1--

--Phần III --

--Câu 12: Tìm các hóa đơn mua sản phẩm có mã số "BB01" hoặc "BB02" , mỗi sản phẩm mua với số lượng từ 10 đến 20--
SELECT DISTINCT CT.SOHD
FROM CTHD CT
WHERE (CT.MASP = 'BB01' OR CT.MASP = 'BB02')
  AND CT.SL BETWEEN 10 AND 20;

--Câu 13: Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã os61 "BB01" và "BB02", mỗi sản phẩm mua với số lượng từ 10 đến 20--
SELECT CT1.SOHD
FROM CTHD CT1
JOIN CTHD CT2 ON CT1.SOHD = CT2.SOHD
WHERE CT1.MASP = 'BB01' 
  AND CT2.MASP = 'BB02'
  AND CT1.SL BETWEEN 10 AND 20
  AND CT2.SL BETWEEN 10 AND 20;

-- Bài 4--

--Phần III--

--Câu 14: In ra danh sách các sản phẩm (MASP, TENSP) do "Trung Quoc" sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007--
SELECT DISTINCT SP.MASP, SP.TENSP
FROM SANPHAM SP
LEFT JOIN CTHD CT ON SP.MASP = CT.MASP
LEFT JOIN HOADON HD ON CT.SOHD = HD.SOHD
WHERE SP.NUOCSX = 'Trung Quoc'
   OR HD.NGHD = '2007-01-01';

--Câu 15: In ra danh sách các sản phẩm (MASP, TENSP) không bán đươc---
SELECT SP.MASP, SP.TENSP
FROM SANPHAM SP
WHERE SP.MASP NOT IN (
    SELECT DISTINCT CT.MASP
    FROM CTHD CT
);

--Câu 16: In ra danh sách các sản phẩm (MASP, TENSP) không bán đuoợc trong năm 2006--
SELECT SP.MASP, SP.TENSP
FROM SANPHAM SP
WHERE SP.MASP NOT IN (
    SELECT DISTINCT CT.MASP
    FROM CTHD CT
    JOIN HOADON HD ON CT.SOHD = HD.SOHD
    WHERE YEAR(HD.NGHD) = 2006
);

--Câu 17: In ra danh sách các sản phẩm (MASP, TENSP) do "Trung Quoc" sản xuất không bán được torng năm 2006--
SELECT SP.MASP, SP.TENSP
FROM SANPHAM SP
WHERE NUOCSX = 'Trung Quoc'
	AND SP.MASP NOT IN (
	SELECT DISTINCT CT.MASP
	FROM CTHD CT
	JOIN HOADON HD ON CT.SOHD = HD.SOHD
	WHERE YEAR(HD.NGHD) = 2006
	);

--Câu 18: Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả cả các sản phẩm do Singapore sản xuất--
SELECT HD.SOHD
FROM HOADON HD
JOIN CTHD CT ON HD.SOHD = CT.SOHD
JOIN SANPHAM SP ON CT.MASP = SP.MASP
WHERE SP.NUOCSX = 'Singapore' 
  AND YEAR(HD.NGHD) = 2006
GROUP BY HD.SOHD
HAVING COUNT(DISTINCT SP.MASP) = (
    SELECT COUNT(*) 
    FROM SANPHAM 
    WHERE NUOCSX = 'Singapore'
);

