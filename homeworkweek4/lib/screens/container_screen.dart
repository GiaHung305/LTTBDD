import 'package:flutter/material.dart';

class ContainerScreen extends StatelessWidget {
  const ContainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Container')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Container có thể làm nhiều việc khác nhau:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          // 1. Size + Color
          _item(
            title: '1. Kích thước + Màu sắc',
            child: Container(
              width: 120,
              height: 60,
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text(
                'Hello world',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          // 2. Padding
          _item(
            title: '2. Padding',
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Xin chao',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          // 3. Margin
          _item(
            title: '3. Margin',
            child: Container(
              margin: const EdgeInsets.all(20),
              color: Colors.orange,
              child: const Text('HELLO'),
            ),
          ),

          // 4. Border + Radius
          _item(
            title: '4. Border',
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('HI'),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _item({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        child,
        const SizedBox(height: 24),
      ],
    );
  }
}
