import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class UserViewModel with ChangeNotifier {
  final supabase = Supabase.instance.client;

  Future<String?> uploadUserImage(File imageFile, String userId) async {
    try {
      final fileName = path.basename(imageFile.path);
      await supabase.storage
          .from('users-image')
          .upload('$userId/$fileName', imageFile);
      final imageUrl = supabase.storage
          .from('users-image')
          .getPublicUrl('$userId/$fileName');
      return imageUrl;
    } catch (e) {
      print('Error al subir la imagen: $e');
      return null;
    }
  }

  Future<void> updateUserImage(String userId, String imageUrl) async {
    try {
      final response = await supabase
          .from('users')
          .update({'image': imageUrl}).eq('id', userId);
      print('Imagen actualizada: $response');
    } catch (e) {
      print('Error al actualizar la imagen: $e');
    }
  }

  Future<void> selectAndUploadImage(String userId) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        final imageUrl = await uploadUserImage(imageFile, userId);
        if (imageUrl != null) {
          await updateUserImage(userId, imageUrl);
        }
      }
    } catch (e) {
      print('Error al seleccionar o subir la imagen: $e');
    }
  }
}
