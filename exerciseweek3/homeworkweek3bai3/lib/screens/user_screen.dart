import 'package:flutter/material.dart';
import '../models/user.dart';

class UserScreen extends StatelessWidget {
  final List<User> users;

  const UserScreen({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(Icons.person),
            title: Text(users[index].name),
          ),
        );
      },
    );
  }
}