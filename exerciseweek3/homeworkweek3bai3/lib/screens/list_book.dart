import 'package:flutter/material.dart';
import '../models/book.dart';

class ListBookScreen extends StatelessWidget {
  final List<Book> books;

  const ListBookScreen({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(book.name),
            subtitle: Text(
              book.isBorrowed
                  ? "Đã mượn bởi ${book.borrowedBy}"
                  : "Chưa mượn",
            ),
          ),
        );
      },
    );
  }
}