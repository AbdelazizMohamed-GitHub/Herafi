import 'dart:typed_data';

import 'package:herafi_app/app/funcation/funcation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<String?> uploadImage({
    required Uint8List fileBytes,
    required String fileExtension, // مثلا: 'jpg' أو 'png'
  }) async {
    try {
    
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
 Future<void> deleteImageByUrl(String url) async {
  const bucket = 'users'; // غيّره لاسم الـ bucket عندك

  final path = HerafiFunctions.extractStoragePath(url, bucket: bucket);
  if (path == null) {
    throw Exception('رابط الصورة غير صالح: $url');
  }

  await Supabase.instance.client.storage.from(bucket).remove([path]);
}
}
