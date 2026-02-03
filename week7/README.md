# week7

## Mô tả
Bài tập yêu cầu phát triển ứng dụng SmartTasks bằng Flutter, cho phép người dùng liệt kê công việc. Ứng dụng sử dụng Provider (MVVM) để quản lý trạng thái và SharedPreferences / SQLite để lưu trữ dữ liệu cục bộ (offline).

## Mục tiêu của bài tập
•	Nắm vững cách xây dựng ứng dụng Flutter theo mô hình MVVM
•	Quản lý task theo từng user
•	Lưu dữ liệu offline, không mất dữ liệu khi thoát ứng dụng
•	Thiết kế giao diện thân thiện, dễ sử dụng
## AuthViewModel
Quản lý trạng thái đăng nhập
•	currentUser → lưu user hiện tại
•	isLoading → hiển thị loading khi xử lý
•	errorMessage → thông báo lỗi
•	signInWithEmail()
→ Gọi AuthService để đăng nhập và cập nhật UI

## TaskViewModel
Quản lý danh sách task
•	loadTasks(userId)
→ Tải task của user hiện tại
•	addTask(task)
→ Thêm task mới
•	toggleTaskComplete(taskId)
→ Đánh dấu task hoàn thành / chưa hoàn thành
•	deleteTask(taskId)
→ Xóa task
## Hình ảnh
<img width="442" height="739" alt="image" src="https://github.com/user-attachments/assets/010f4d10-7e20-4521-8e86-049bb05ddf58" />
<img width="431" height="750" alt="image" src="https://github.com/user-attachments/assets/03c8e2f3-b5fe-4fb1-8cc0-3fbc2a75dfe6" />
<img width="439" height="770" alt="image" src="https://github.com/user-attachments/assets/dec4814d-c8f3-495b-a185-1e08d4af876e" />

