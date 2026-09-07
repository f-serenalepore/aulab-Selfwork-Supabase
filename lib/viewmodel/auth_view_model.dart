import 'package:flutter/material.dart';
import 'package:supabase_app/core/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoading = false;
  Session? session;

  AuthViewModel() {
    session = _authService.currentSession;
  }

  //metodo per login
  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _authService.signIn(email, password);
      session = response.session;
    } catch (e) {
      print("errore login $e");
    }
    isLoading = false;
    notifyListeners();
  }

  //metodo per registrazione
  Future<void> register(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _authService.signUp(email, password);
      session = response.session;
    } catch (e) {
      print("errore registrazione $e");
    }
    isLoading = false;
    notifyListeners();
  }

  //metodo per logout
  Future<void> logout() async {
    await _authService.signOut();
    session = null;
    notifyListeners();
  }
}
