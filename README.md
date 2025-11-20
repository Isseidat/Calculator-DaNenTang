Chạy ứng dụng Calculator đa nền tảng với Flutter Dart
  ![Uploading z7246121707473_f7dffcfdde5ca9ae63f0d3716a40f68f.jpg  …]()

Ứng dụng hỗ trợ các phép toán cơ bản, xử lý ưu tiên nhân/chia trước cộng/trừ, hiển thị kết quả *live result*, và có giao diện giống với thiết kế trên Figma.

---
### 🔢 Tính năng chính
- Nhập và xử lý các phép toán: `+`, `-`, `×`, `÷`
- Hỗ trợ:
  - `=`  
  - `C` (Clear)  
  - `+/-` (đổi dấu)  
  - `%` (percentage)  
  - `.` (decimal input)
- **Live Result**: Hiển thị kết quả tức thời khi người dùng nhập phép toán
- Giữ nguyên biểu thức sau khi nhấn `=`, chỉ update kết quả bên dưới
- Xử lý lỗi: chia cho 0 → hiển thị `Error`
- Tự động định dạng số (1.0 → 1)

---

- Giao diện được xây dựng theo mẫu Figma
- Responsive cho mọi kích thước màn hình
- Font chữ, màu sắc, spacing đúng theo thiết kế
- Button layout theo chuẩn máy tính iOS


Cách chạy:
  Nhập bài toán cần phải xử lí, VD: 1 + 2 + 3
  Nhấn nút = để cho ra kết quả
  Có thể thay thế bằng các phép tính + - * / % khác nhau cho phù hợp với cách sử dụng
  Nút +/- thay đổi từ dương sang âm và ngược lại


Cấu trúc thư mục:
  CALCULATOR_APP
    lib
      calculator_logic.dart
      main.dart
