
-- 8. Hiển thị tên và cấp độ của tất cả các kỹ năng của chuyên gia có MaChuyenGia là 1.

SELECT k.TenKyNang, ck.CapDo
FROM ChuyenGia_KyNang ck
JOIN KyNang k ON ck.MaKyNang = k.MaKyNang
WHERE ck.MaChuyenGia = 1;

-- 9. Liệt kê tên các chuyên gia tham gia dự án có MaDuAn là 2.
SELECT c.HoTen
FROM ChuyenGia_DuAn cd
JOIN ChuyenGia c ON cd.MaChuyenGia = c.MaChuyenGia
WHERE cd.MaDuAn = 2;


-- 10. Hiển thị tên công ty và tên dự án của tất cả các dự án.
SELECT ct.TenCongTy, da.TenDuAn
FROM DuAn da
JOIN CongTy ct ON da.MaCongTy = ct.MaCongTy;


-- 11. Đếm số lượng chuyên gia trong mỗi chuyên ngành.
SELECT ChuyenNganh, COUNT(*) AS SoLuongChuyenGia
FROM ChuyenGia
GROUP BY ChuyenNganh;


-- 12. Tìm chuyên gia có số năm kinh nghiệm cao nhất.
SELECT HoTen, NamKinhNghiem
FROM ChuyenGia
WHERE NamKinhNghiem = (SELECT MAX(NamKinhNghiem) FROM ChuyenGia);

-- 13. Liệt kê tên các chuyên gia và số lượng dự án họ tham gia.
SELECT c.HoTen, COUNT(cd.MaDuAn) AS SoLuongDuAn
FROM ChuyenGia c
LEFT JOIN ChuyenGia_DuAn cd ON c.MaChuyenGia = cd.MaChuyenGia
GROUP BY c.HoTen;


-- 14. Hiển thị tên công ty và số lượng dự án của mỗi công ty.
SELECT ct.TenCongTy, COUNT(da.MaDuAn) AS SoLuongDuAn
FROM CongTy ct
LEFT JOIN DuAn da ON ct.MaCongTy = da.MaCongTy
GROUP BY ct.TenCongTy;


-- 15. Tìm kỹ năng được sở hữu bởi nhiều chuyên gia nhất.
SELECT k.TenKyNang, COUNT(ck.MaChuyenGia) AS SoLuongChuyenGia
FROM KyNang k
JOIN ChuyenGia_KyNang ck ON k.MaKyNang = ck.MaKyNang
GROUP BY k.TenKyNang
ORDER BY SoLuongChuyenGia DESC
;


-- 16. Liệt kê tên các chuyên gia có kỹ năng 'Python' với cấp độ từ 4 trở lên.
SELECT c.HoTen
FROM ChuyenGia c
JOIN ChuyenGia_KyNang ck ON c.MaChuyenGia = ck.MaChuyenGia
JOIN KyNang k ON ck.MaKyNang = k.MaKyNang
WHERE k.TenKyNang = 'Python' AND ck.CapDo >= 4;


-- 17. Tìm dự án có nhiều chuyên gia tham gia nhất.
SELECT da.TenDuAn, COUNT(cd.MaChuyenGia) AS SoLuongChuyenGia
FROM DuAn da
JOIN ChuyenGia_DuAn cd ON da.MaDuAn = cd.MaDuAn
GROUP BY da.TenDuAn
ORDER BY SoLuongChuyenGia DESC
;


-- 18. Hiển thị tên và số lượng kỹ năng của mỗi chuyên gia.
SELECT c.HoTen, COUNT(ck.MaKyNang) AS SoLuongKyNang
FROM ChuyenGia c
LEFT JOIN ChuyenGia_KyNang ck ON c.MaChuyenGia = ck.MaChuyenGia
GROUP BY c.HoTen;

-- 19. Tìm các cặp chuyên gia làm việc cùng dự án.
SELECT c1.HoTen AS ChuyenGia1, c2.HoTen AS ChuyenGia2, da.TenDuAn
FROM ChuyenGia_DuAn cd1
JOIN ChuyenGia_DuAn cd2 ON cd1.MaDuAn = cd2.MaDuAn AND cd1.MaChuyenGia < cd2.MaChuyenGia
JOIN ChuyenGia c1 ON cd1.MaChuyenGia = c1.MaChuyenGia
JOIN ChuyenGia c2 ON cd2.MaChuyenGia = c2.MaChuyenGia
JOIN DuAn da ON cd1.MaDuAn = da.MaDuAn;


-- 20. Liệt kê tên các chuyên gia và số lượng kỹ năng cấp độ 5 của họ.
SELECT c.HoTen, COUNT(*) AS SoLuongKyNangCap5
FROM ChuyenGia c
JOIN ChuyenGia_KyNang ck ON c.MaChuyenGia = ck.MaChuyenGia
WHERE ck.CapDo = 5
GROUP BY c.HoTen;

-- 21. Tìm các công ty không có dự án nào.
SELECT ct.TenCongTy
FROM CongTy ct
LEFT JOIN DuAn da ON ct.MaCongTy = da.MaCongTy
WHERE da.MaDuAn IS NULL;


-- 22. Hiển thị tên chuyên gia và tên dự án họ tham gia, bao gồm cả chuyên gia không tham gia dự án nào.
SELECT c.HoTen, da.TenDuAn
FROM ChuyenGia c
LEFT JOIN ChuyenGia_DuAn cd ON c.MaChuyenGia = cd.MaChuyenGia
LEFT JOIN DuAn da ON cd.MaDuAn = da.MaDuAn;


-- 23. Tìm các chuyên gia có ít nhất 3 kỹ năng.
SELECT c.HoTen
FROM ChuyenGia c
JOIN ChuyenGia_KyNang ck ON c.MaChuyenGia = ck.MaChuyenGia
GROUP BY c.HoTen
HAVING COUNT(ck.MaKyNang) >= 3;


-- 24. Hiển thị tên công ty và tổng số năm kinh nghiệm của tất cả chuyên gia trong các dự án của công ty đó.
SELECT ct.TenCongTy, SUM(c.NamKinhNghiem) AS TongNamKinhNghiem
FROM CongTy ct
JOIN DuAn da ON ct.MaCongTy = da.MaCongTy
JOIN ChuyenGia_DuAn cd ON da.MaDuAn = cd.MaDuAn
JOIN ChuyenGia c ON cd.MaChuyenGia = c.MaChuyenGia
GROUP BY ct.TenCongTy;


-- 25. Tìm các chuyên gia có kỹ năng 'Java' nhưng không có kỹ năng 'Python'.
SELECT c.HoTen
FROM ChuyenGia c
JOIN ChuyenGia_KyNang ck1 ON c.MaChuyenGia = ck1.MaChuyenGia
JOIN KyNang k1 ON ck1.MaKyNang = k1.MaKyNang
WHERE k1.TenKyNang = 'Java'
AND c.MaChuyenGia NOT IN (
    SELECT ck2.MaChuyenGia
    FROM ChuyenGia_KyNang ck2
    JOIN KyNang k2 ON ck2.MaKyNang = k2.MaKyNang
    WHERE k2.TenKyNang = 'Python'
);

-- 76. Tìm chuyên gia có số lượng kỹ năng nhiều nhất.
SELECT c.HoTen, COUNT(ck.MaKyNang) AS SoLuongKyNang
FROM ChuyenGia c
JOIN ChuyenGia_KyNang ck ON c.MaChuyenGia = ck.MaChuyenGia
GROUP BY c.HoTen
ORDER BY SoLuongKyNang DESC
;


-- 77. Liệt kê các cặp chuyên gia có cùng chuyên ngành.
SELECT c1.HoTen AS ChuyenGia1, c2.HoTen AS ChuyenGia2, c1.ChuyenNganh
FROM ChuyenGia c1
JOIN ChuyenGia c2 ON c1.ChuyenNganh = c2.ChuyenNganh AND c1.MaChuyenGia < c2.MaChuyenGia;

-- 78. Tìm công ty có tổng số năm kinh nghiệm của các chuyên gia trong dự án cao nhất.
SELECT ct.TenCongTy, SUM(c.NamKinhNghiem) AS TongNamKinhNghiem
FROM CongTy ct
JOIN DuAn da ON ct.MaCongTy = da.MaCongTy
JOIN ChuyenGia_DuAn cd ON da.MaDuAn = cd.MaDuAn
JOIN ChuyenGia c ON cd.MaChuyenGia = c.MaChuyenGia
GROUP BY ct.TenCongTy
ORDER BY TongNamKinhNghiem DESC
;


-- 79. Tìm kỹ năng được sở hữu bởi tất cả các chuyên gia.
SELECT k.TenKyNang
FROM KyNang k
JOIN ChuyenGia_KyNang ck ON k.MaKyNang = ck.MaKyNang
GROUP BY k.TenKyNang
HAVING COUNT(DISTINCT ck.MaChuyenGia) = (SELECT COUNT(*) FROM ChuyenGia)