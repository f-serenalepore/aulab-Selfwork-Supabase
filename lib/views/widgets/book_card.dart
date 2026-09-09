import 'package:flutter/material.dart';
import 'package:supabase_app/models/book_image.dart';
import 'package:supabase_app/models/book_model.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final BookImage? image;
  final VoidCallback? onTap;

  const BookCard({super.key, required this.book, this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            if (image != null)
              Expanded(
                child: Image.network(
                  image!.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            Text(book.title, maxLines: 1, overflow: TextOverflow.ellipsis),

            Text(book.author, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
