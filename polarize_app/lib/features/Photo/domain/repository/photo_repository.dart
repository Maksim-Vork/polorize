import 'package:polarize_app/features/Photo/domain/entity/image.dart';

abstract class PhotoRepository {
  Future<void> addPhotoForCamera(bool forCamera);
  Future<List<UserImage>> getUserImages();
}
