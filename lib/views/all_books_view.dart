import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_app/viewmodel/book_view_model.dart';
import 'package:supabase_app/views/widgets/book_list_widget.dart';

class AllBooksView extends StatefulWidget {
  const AllBooksView({super.key});

  @override
  State<AllBooksView> createState() => _AllBooksViewState();
}

class _AllBooksViewState extends State<AllBooksView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<BookViewModel>().loadBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutti i miei libri"),
        centerTitle: true,
      ),
      body: Consumer<BookViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.books.isEmpty) {
            return const Center(
              child: Text(
                "Non hai inserito alcun libro",
                textAlign: TextAlign.center,
              ),
            );
          }

          return const BookListWidget();
        },
      ),
    );
  }
}
