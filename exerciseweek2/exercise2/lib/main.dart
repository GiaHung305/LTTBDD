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
      home: Practice02Page(),
    );
  }
}

class Practice02Page extends StatefulWidget {
  const Practice02Page({super.key});

  @override
  State<Practice02Page> createState() => _Practice02PageState();
}

class _Practice02PageState extends State<Practice02Page> {
  final TextEditingController _controller = TextEditingController();

  List<int> numbers = [];
  String errorMessage = "";

  void createList() {
    String input = _controller.text.trim();
    int? value = int.tryParse(input);

    setState(() {
      numbers.clear();
      errorMessage = "";

      if (value == null || value <= 0) {
        errorMessage = "Dữ liệu bạn nhập không hợp lệ";
      } else {
        for (int i = 1; i <= value; i++) {
          numbers.add(i);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // 👈 CĂN DƯỚI
                children: [
                  const Text(
                    "Thực hành 02",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Nhập vào số lượng",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: createList,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        ),
                        child: const Text("Tạo"),
                      ),
                    ],
                  ),

                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                  const SizedBox(height: 20),
                ],
              ),
            ),

            Expanded(
              flex: 5,
              child: ListView.builder(
                itemCount: numbers.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      numbers[index].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
