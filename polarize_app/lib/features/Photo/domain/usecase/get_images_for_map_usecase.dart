import 'package:polarize_app/features/Photo/domain/entity/image.dart';
import 'package:polarize_app/features/Photo/domain/repository/photo_repository.dart';

class GetImagesForMapUsecase {
  final PhotoRepository photoRepository;

  GetImagesForMapUsecase({required this.photoRepository});

  Future<Map<String, List<UserImage>>> call() async {
    final List<UserImage> images = await photoRepository.getUserImages();

    final Map<String, List<UserImage>> imagesForGalary = {};

    for (var userImage in images) {
      final String key = userImage.createdAt.toString();

      imagesForGalary.putIfAbsent(key, () => []);
      imagesForGalary[key]!.add(userImage);
    }

    return imagesForGalary;
  }
}
