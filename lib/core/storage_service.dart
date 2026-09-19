import 'dart:io';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient _client = Supabase.instance.client;
  final String bucket = 'media';

  //metodo per il caricamento delle immagini dei libri
  Future<String> uploadImage(File imageFile, String bookId) async {
    final fileName =
        "${DateTime.now().microsecondsSinceEpoch}_${basename(imageFile.path)}";
    final filePath = "$bookId/$fileName";
    await _client.storage.from(bucket).upload(filePath, imageFile);
    final publicUrl = _client.storage.from(bucket).getPublicUrl(filePath);
    return publicUrl;
  }

  //metodo per il caricamento dell'immagine del profilo
  Future<String> uploadProfileImage(File imageFile, String userId) async {
    final fileName =
        "${DateTime.now().microsecondsSinceEpoch}_${basename(imageFile.path)}";
    final filePath = "profiles/$userId/$fileName";
    await _client.storage.from(bucket).upload(filePath, imageFile);
    final publicUrl = _client.storage.from(bucket).getPublicUrl(filePath);
    return publicUrl;
  }
}
