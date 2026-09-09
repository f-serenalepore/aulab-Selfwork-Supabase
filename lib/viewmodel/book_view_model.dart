import 'package:flutter/material.dart';
import 'package:supabase_app/core/book_service.dart';
import 'package:supabase_app/models/book_model.dart';

class BookViewModel extends ChangeNotifier {
  final BookService _bookService = BookService();
  List<Book> _books = [];
  bool isLoading = false;

  List<Book> get books => _books;

  Future<void> loadAllBooks() async {
    isLoading = true;
    notifyListeners();
    try {
      _books = await _bookService.fetchBooks();
    } catch (e) {
      print("Errore caricamento lista libri $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadBooks() async {
    isLoading = true;
    notifyListeners();
    try {
      _books = await _bookService.fetchBookForCurrentUser();
    } catch (e) {
      print("Errore caricamento libri $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    try {
      await _bookService.createBook(book);
      _books.insert(0, book);
    } catch (e) {
      print("errore creazione libro $e");
    }
  }

  Future<void> updateBook(Book updatedBook) async {
    try {
      await _bookService.updateBook(updatedBook);
      final index = _books.indexWhere((b) => b.id == updatedBook.id);
      if (index != -1) {
        _books[index] = updatedBook;
        notifyListeners();
      }
    } catch (e) {
      print("errore aggiornamento libro $e");
    }
  }

  Future<void> deleteBook(String bookId) async {
    try {
      await _bookService.deleteBook(bookId);
      _books.removeWhere((b) => b.id == bookId);
      notifyListeners();
    } catch (e) {
      print("errore cancellazione libro $e");
    }
  }
}
