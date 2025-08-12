import 'package:polarize_app/features/Photo/domain/repository/photo_repository.dart';

class AddPhotoUsecase {
  final PhotoRepository photoRepository;

  AddPhotoUsecase({required this.photoRepository});

  Future<void> call(bool forCamera) async {
    await photoRepository.addPhotoForCamera(forCamera);
  }
}
