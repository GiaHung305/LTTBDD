import 'package:flutter/material.dart';

class AlignScreen extends StatelessWidget {
  const AlignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Align – Căn vị trí')),
      body: Container(
        color: Colors.grey[300], // vùng cha
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 80,
            height: 80,
            color: Colors.purple,
            alignment: Alignment.center,
            child: const Text(
              'goc duoi phai',
              style: TextStyle(color: Colors.white),
            ),
          ),

        ),
      ),
    );
  }
}
