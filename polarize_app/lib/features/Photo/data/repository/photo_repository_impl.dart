import 'package:polarize_app/features/Photo/data/datasource/remote_photo_data.dart';
import 'package:polarize_app/features/Photo/data/models/image_model.dart';
import 'package:polarize_app/features/Photo/domain/entity/image.dart';
import 'package:polarize_app/features/Photo/domain/repository/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final RemotePhotoData remotePhotoData;

  PhotoRepositoryImpl({required this.remotePhotoData});

  @override
  Future<void> addPhotoForCamera(bool forCamera) async {
    try {
      await remotePhotoData.addPhotoForCamera(forCamera);
    } catch (e) {
      throw Exception('Ошибка при выборе фото: $e');
    }
  }

  @override
  Future<List<UserImage>> getUserImages() async {
    try {
      final List<ImageModel> imageModel = await remotePhotoData.getUserImages();
      return imageModel
          .map(
            (e) => UserImage(
              id: e.id!,
              imageUrl: e.imageUrl,
              createdAt: e.createdAt!,
            ),
          )
          .toList();
    } catch (e) {
      print('ОШИБКА ОШИБКА ОШИБКА: $e');
      throw Exception('Ошибка при получении фото: $e');
    }
  }
}
