import 'package:flutter/material.dart';

class PaddingScreen extends StatelessWidget {
  const PaddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Padding – Khoảng cách bên trong')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'KHÔNG dùng Padding',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Container(
            color: Colors.red,
            child: const Text(
              'Text ',
              style: TextStyle(color: Colors.white),
            ),
          ),

          const SizedBox(height: 32),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'CÓ Padding',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              color: Colors.green,
              child: const Text(
                'Text có khoảng trống bên trong',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
