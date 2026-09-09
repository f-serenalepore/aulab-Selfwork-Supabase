import 'package:flutter/material.dart';
import 'package:supabase_app/core/book_service.dart';
import 'package:supabase_app/models/book_model.dart';
import 'package:supabase_app/core/book_image_service.dart';
import 'package:supabase_app/models/book_image.dart';

class BookViewModel extends ChangeNotifier {
  final BookService _bookService = BookService();
  List<Book> _books = [];
  final BookImageService _bookImageService = BookImageService();
  Map<String, List<BookImage>> _bookImages = {};
  bool isLoading = false;

  List<Book> get books => _books;
  Map<String, List<BookImage>> get bookImages => _bookImages;

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

  //////////////////////////////////////////////
  Future<void> loadBooks() async {
    isLoading = true;
    notifyListeners();

    try {
      final books = await _bookService.fetchBookForCurrentUser();

      _books = [];

      for (final book in books) {
        final images = await _bookImageService.fetchImagesFromBook(book.id);

        final bookWithImages = Book(
          id: book.id,
          userId: book.userId,
          title: book.title,
          genre: book.genre,
          author: book.author,
          pages: book.pages,
          rating: book.rating,
          comment: book.comment,
          status: book.status,
          createdAt: book.createdAt,
          images: images,
        );
        _books.add(bookWithImages);
      }
    } catch (e) {
      print("Errore caricamento libri $e");
    }

    isLoading = false;
    notifyListeners();
  }
  //////////////////////////////////////////////

  /*
  Future<void> loadBooks() async {
    isLoading = true;
    notifyListeners();
    try {
      _books = await _bookService.fetchBookForCurrentUser();
      for (final book in _books) {
        _bookImages[book.id] = await _bookImageService.fetchImagesFromBook(
          book.id,
        );
      }
    } catch (e) {
      print("Errore caricamento libri $e");
    }
    isLoading = false;
    notifyListeners();
  }
*/

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
