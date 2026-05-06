-- Tốc độ (Short-circuit): NOT EXISTS chỉ cần tìm thấy 1 dòng duy nhất thỏa mãn là nó dừng lại 
-- và bỏ qua các dòng còn lại. NOT IN thường phải quét sạch cả danh sách để đối chiếu.

-- Tiết kiệm RAM: NOT IN phải tải danh sách ID (có thể lên tới hàng triệu) vào bộ nhớ. NOT EXISTS 
-- chạy theo kiểu kiểm tra sự tồn tại nên tiêu tốn rất ít tài nguyên.

-- An toàn với NULL: Nếu bảng Payments có một dòng bị NULL ở cột ID, NOT IN sẽ trả về kết quả rỗng 
-- (sai nghiệp vụ). NOT EXISTS không bị ảnh hưởng bởi lỗi này.

-- Chốt hạ: Với dữ liệu lớn, NOT EXISTS nhanh hơn, ít tốn RAM hơn và kết quả luôn chính xác.

USE SS7;
SELECT s.email
FROM Students AS s
WHERE NOT EXISTS (
    SELECT 1 
    FROM Payments AS p 
    WHERE p.student_id = s.id 
      AND p.payment_date >= '2024-01-01' 
      AND p.payment_date <= '2024-12-31'
);