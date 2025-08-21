import 'package:polarize_app/features/Photo/domain/entity/image.dart';
import 'package:polarize_app/features/Photo/domain/repository/photo_repository.dart';

class GetImagesForMapUsecase {
  final PhotoRepository photoRepository;

  GetImagesForMapUsecase({required this.photoRepository});

  Future<List<MapEntry<String, List<UserImage>>>> call() async {
    final List<UserImage> images = await photoRepository.getUserImages();

    final Map<String, List<UserImage>> imagesForGalary = {};

    for (var userImage in images) {
      final DateTime dateCreated = userImage.createdAt;
      final int currentYear = DateTime.now().year;
      String formatDate;
      if (dateCreated.year != currentYear) {
        formatDate =
            '${dateCreated.day.toString().padLeft(2, '0')}.${dateCreated.month.toString().padLeft(2, '0')}.${dateCreated.year}';
        imagesForGalary.putIfAbsent(formatDate, () => []);
      }
      {
        formatDate =
            '${dateCreated.day.toString().padLeft(2, '0')}.${dateCreated.month.toString().padLeft(2, '0')}';
        imagesForGalary.putIfAbsent(formatDate, () => []);
      }

      imagesForGalary[formatDate]!.add(userImage);
    }

    final List<MapEntry<String, List<UserImage>>> imagesForGalaryList =
        imagesForGalary.entries.toList()..reversed;

    return imagesForGalaryList;
  }
}
