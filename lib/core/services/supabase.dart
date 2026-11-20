import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<String?> uploadImage({
    required Uint8List fileBytes,
    required String fileExtension, // مثلا: 'jpg' أو 'png'
  }) async {
    try {
      print('Uploading image...');
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

      final response = await supabase.storage
          .from('users')
          .uploadBinary(
            fileName,
            fileBytes,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      if (response.isEmpty) {
        throw Exception('Upload failed');
      }

      return supabase.storage.from('users').getPublicUrl(fileName);
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}
