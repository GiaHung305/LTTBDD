import 'package:flutter/material.dart';

class FlexibleScreen extends StatelessWidget {
  const FlexibleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flexible')),
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(color: Colors.orange),
          ),
          Flexible(
            flex: 2,
            child: Container(color: Colors.green),
          ),
        ],
      ),
    );
  }
}
