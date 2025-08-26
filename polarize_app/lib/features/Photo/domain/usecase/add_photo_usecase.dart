import 'package:polarize_app/features/Photo/domain/entity/image.dart';
import 'package:polarize_app/features/Photo/domain/repository/photo_repository.dart';

class AddPhotoUsecase {
  final PhotoRepository photoRepository;

  AddPhotoUsecase({required this.photoRepository});

  Future<void> call(bool forCamera) async {
    final DateTime currentDay = DateTime.now();
    final DateTime date = DateTime(
      currentDay.year,
      currentDay.month,
      currentDay.day,
    );
    final List<UserImage> images = await photoRepository.getUserImages();
    final List<UserImage> imageCurrentDay = images
        .where((e) => e.createdAt == date)
        .toList();
    if (imageCurrentDay.length < 3) {
      print(imageCurrentDay.length);
      await photoRepository.addPhotoForCamera(forCamera);
    }
  }
}
