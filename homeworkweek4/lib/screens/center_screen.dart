import 'package:flutter/material.dart';

class CenterScreen extends StatelessWidget {
  const CenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Center – Căn giữa')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.orange,
            child: const Text(
              'Không dùng Center',
              textAlign: TextAlign.left,
            ),
          ),

          const SizedBox(height: 32),

          const Text(
            'Dùng Center',
            style: TextStyle(fontWeight: FontWeight.bold),

          ),

        ],
      ),
    );
  }
}
