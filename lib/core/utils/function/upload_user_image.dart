import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<String?> uploadUserImageToSupabase(File imageFile) async {
  try {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();

    final path = '$userId/$fileName.png';

    final supabase = Supabase.instance.client;

    final response = await supabase.storage
        .from('users_images')
        .upload(path, imageFile);

    if (response.isEmpty) {
      throw Exception("Upload failed");
    }

    // رجّع اللينك المباشر
    final publicUrl = supabase.storage
        .from('users_images')
        .getPublicUrl(path);

    return publicUrl;
  } catch (e) {
    print("Supabase upload error: $e");
    return null;
  }
}
