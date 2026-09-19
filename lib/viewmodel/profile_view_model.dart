import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_app/core/profile_service.dart';
import 'package:supabase_app/core/storage_service.dart';
import 'package:supabase_app/models/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();
  final StorageService _storageService = StorageService();
  final SupabaseClient _client = Supabase.instance.client;

  UserProfile? profile;
  bool isLoading = false;

  Future<void> loadUserProfile() async {
    isLoading = true;
    profile = null;
    notifyListeners();
    try {
      profile = await _profileService.fetchUserProfile();
    } catch (e) {
      print("errore caricamento profilo $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> createUserProfile(String username, DateTime birthdate) async {
    final id = _client.auth.currentUser?.id;
    if (id == null) return;
    final newProfile = UserProfile(
      id: id,
      username: username,
      birthdate: birthdate,
      avatarUrl: null,
    );
    try {
      await _profileService.createUserProfile(newProfile);
      profile = newProfile;
    } catch (e) {
      print("errore nella creazione del profilo utente $e");
    }
    notifyListeners();
  }

  Future<void> updateUserProfile(
    UserProfile updateUserProfile, {
    File? imageFile,
  }) async {
    try {
      String? avatarUrl = updateUserProfile.avatarUrl;
      if (imageFile != null) {
        avatarUrl = await _storageService.uploadProfileImage(
          imageFile,
          updateUserProfile.id,
        );
      }
      final updatedProfile = UserProfile(
        id: updateUserProfile.id,
        username: updateUserProfile.username,
        birthdate: updateUserProfile.birthdate,
        avatarUrl: avatarUrl,
      );
      await _profileService.updateUserProfile(updatedProfile);
      profile = updatedProfile;
    } catch (e) {
      print("errore aggiornamento profilo utente $e");
    }
    notifyListeners();
  }
}
