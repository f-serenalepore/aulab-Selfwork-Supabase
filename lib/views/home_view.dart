import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_app/viewmodel/auth_view_model.dart';
import 'package:supabase_app/views/add_book_view.dart';
import 'package:supabase_app/views/all_books_view.dart';
import 'package:supabase_app/views/auth/login_view.dart';
import 'package:supabase_app/views/widgets/bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home View"),
        actions: [
          IconButton(
            onPressed: () async {
              await vm.logout();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginView()),
                );
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllBooksView()),
                );
              },
              child: Text("Esplora tutti ilibri"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddBookView()),
                );
              },
              child: Text("Aggiungi Libro"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}
