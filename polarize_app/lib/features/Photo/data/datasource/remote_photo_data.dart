import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polarize_app/features/Photo/data/models/image_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemotePhotoData {
  final SupabaseClient supabase = Supabase.instance.client;
  String? getUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return null;
  }

  Future<void> addPhotoForCamera(bool forCamera) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(
      source: forCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1200,
      imageQuality: 80,
    );

    if (image == null) return;
    final File imageFile = File(image.path);
    final String fileName = 'user_${DateTime.now().microsecondsSinceEpoch}.jpg';

    try {
      await supabase.storage.from('user_images').upload(fileName, imageFile);
      final String imageUrl = supabase.storage
          .from('user_images')
          .getPublicUrl(fileName);

      final userId = getUserId();
      final ImageModel imageModel = ImageModel(imageUrl: imageUrl);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('images')
          .doc(imageModel.id)
          .set(imageModel.toMap());
    } catch (e) {
      throw Exception('Фото не загружино с ошибкой: $e');
    }
  }

  Future<List<ImageModel>> getUserImages() async {
    try {
      final userId = getUserId();
      final imagesFromFirebase = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('images')
          .get();
      print(' Изображения получены');
      final List<ImageModel> userImages = imagesFromFirebase.docs
          .map((e) => ImageModel.fromMap(e.data(), e.id))
          .toList();
      return userImages;
    } catch (e) {
      throw Exception('Ошибка получения фото: $e');
    }
  }
}
