import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_app/viewmodel/book_view_model.dart';
import 'package:supabase_app/views/book_detail_view.dart';
import 'package:supabase_app/views/widgets/book_card.dart';

class BookListWidget extends StatelessWidget {
  const BookListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BookViewModel>();
    final books = viewModel.books;

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              final images = viewModel.bookImages[book.id];

              return BookCard(
                book: book,
                image: images != null && images.isNotEmpty
                    ? images.first
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailView(book: book),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
