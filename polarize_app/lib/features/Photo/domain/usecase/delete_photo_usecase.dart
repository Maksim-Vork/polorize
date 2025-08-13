import 'package:polarize_app/features/Photo/domain/entity/image.dart';
import 'package:polarize_app/features/Photo/domain/repository/photo_repository.dart';

class DeletePhotoUsecase {
  final PhotoRepository photoRepository;

  DeletePhotoUsecase({required this.photoRepository});

  Future<void> call(UserImage userImage) async {
    await photoRepository.deleteImageById(userImage);
  }
}
