import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/user.dart';
import 'list_book.dart';
import 'user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  /// Dữ liệu
  List<User> users = [
    User("Nguyen Van A"),
    User("Tran Thi B"),
  ];

  User currentUser = User("Nguyen Van A");

  List<Book> books = [
    Book(name: "Sách 01"),
    Book(name: "Sách 02"),
  ];

  TextEditingController bookController = TextEditingController();

  /// Thêm sách
  void addBook() {
    if (bookController.text.isNotEmpty) {
      setState(() {
        books.add(Book(name: bookController.text));
        bookController.clear();
      });
    }
  }

  /// Mượn / trả sách
  void borrowBook(Book book, bool value) {
    setState(() {
      book.isBorrowed = value;
      book.borrowedBy = value ? currentUser.name : "";
    });
  }
  ///doi sach
  void changeUser() {
    User selectedUser = currentUser;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text("Chọn nhân viên"),
            content: DropdownButton<User>(
              value: selectedUser,
              isExpanded: true,
              items: users.map((user) {
                return DropdownMenuItem<User>(
                  value: user,
                  child: Text(user.name),
                );
              }).toList(),
              onChanged: (value) {
                setStateDialog(() {
                  selectedUser = value!;
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    currentUser = selectedUser;
                  });
                  Navigator.pop(context);
                },
                child: const Text("Xác nhận"),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Trang quản lý
  Widget buildManage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Hệ thống\nQuản lý Thư viện",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),

          const Text("Nhân viên"),
          Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: currentUser.name,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: changeUser,
                child: const Text("Đổi"),
              ),
            ],
          ),

          const SizedBox(height: 20),
          const Text("Danh sách sách"),

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: books.map((book) {
                return Card(
                  child: CheckboxListTile(
                    value: book.isBorrowed,
                    title: Text(book.name),
                    onChanged: (value) =>
                        borrowBook(book, value!),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),
          TextField(
            controller: bookController,
            decoration: const InputDecoration(
              hintText: "Nhập tên sách",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: addBook,
              child: const Text("Thêm"),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          buildManage(),
          ListBookScreen(books: books),
          UserScreen(users: users),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Quản lý"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: "DS Sách"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Nhân viên"),
        ],
      ),
    );
  }
}