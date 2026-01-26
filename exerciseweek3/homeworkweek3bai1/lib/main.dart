import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DemoNull(),
  ));
}

class DemoNull extends StatefulWidget {
  const DemoNull({super.key});

  @override
  State<DemoNull> createState() => _DemoNullState();
}

class _DemoNullState extends State<DemoNull> {
  String input = '';
  List<String> results = [];

  void testNull() {
    String? name = input.isEmpty ? null : input;

    setState(() {
      results = [
        '?: name = $name',
        '?. length = ${name?.length}',
        '?: length = ${name?.length ?? 0}',
        name != null ? 'let: Xin chào $name' : 'let: name là null',
        name == null
            ? '!!: nếu dùng sẽ crash'
            : '!!: length = ${name.length}',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Xử lý null')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              onChanged: (value) => input = value,
              decoration: const InputDecoration(
                hintText: 'Nhập tên (có thể để trống)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: testNull,
              child: const Text('Kiểm tra'),
            ),

            const SizedBox(height: 20),

            ...results.map((e) => Text(e)).toList(),
          ],
        ),
      ),
    );
  }
}
