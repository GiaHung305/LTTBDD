import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Exerciseclass01Page(),
    );
  }
}

class Exerciseclass01Page extends StatefulWidget {
  const Exerciseclass01Page({super.key});

  @override
  State<Exerciseclass01Page> createState() => _Exerciseclass01PageState();
}

class _Exerciseclass01PageState extends State<Exerciseclass01Page> {
  final TextEditingController _controller = TextEditingController();
  String errorMessage = "";
  Color messageColor = Colors.red;

  void checkEmail() {
    String input = _controller.text.trim();

    setState(() {
      if(input.isEmpty){
        errorMessage = "Email ko hợp lệ";
        messageColor = Colors.red;
      }
      else if (input.contains("@")) {
        errorMessage = "Email hợp lệ";
        messageColor = Colors.green;

      }
      else {
        errorMessage = "Email ban nhap ko hợp lệ";
        messageColor = Colors.red;

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Thực hành 02",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                errorMessage,
                style: TextStyle(
                  color: messageColor,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: checkEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Kiểm tra",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}