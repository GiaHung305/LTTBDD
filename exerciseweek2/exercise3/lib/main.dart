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
      home: Practice03Page(),
    );
  }
}

class Practice03Page extends StatefulWidget {
  const Practice03Page({super.key});

  @override
  State<Practice03Page> createState() => _Practice03PageState();
}

class _Practice03PageState extends State<Practice03Page> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();

  String selectedOp = "";
  double? result;

  void calculate(String op) {
    double? a = double.tryParse(_aController.text);
    double? b = double.tryParse(_bController.text);

    if (a == null || b == null) {
      setState(() {
        result = null;
        selectedOp = op;
      });
      return;
    }

    double temp = 0;

    switch (op) {
      case '+':
        temp = a + b;
        break;
      case '-':
        temp = a - b;
        break;
      case '*':
        temp = a * b;
        break;
      case '/':
        temp = b != 0 ? a / b : 0;
        break;
    }

    setState(() {
      selectedOp = op;
      result = temp;
    });
  }

  Widget buildOperatorButton(String op, Color color) {
    bool isSelected = selectedOp == op;

    return GestureDetector(
      onTap: () => calculate(op),
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: Colors.black, width: 2)
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          op,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 100),

            const Text(
              "Thực hành 03",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: _aController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildOperatorButton('+', Colors.red),
                buildOperatorButton('-', Colors.amber),
                buildOperatorButton('*', Colors.deepPurple),
                buildOperatorButton('/', Colors.black),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _bController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                result == null
                    ? "Kết quả:"
                    : "Kết quả: ${result!.toStringAsFixed(0)}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
