import 'package:polarize_app/features/Photo/domain/entity/image.dart';
import 'package:polarize_app/features/Photo/domain/repository/photo_repository.dart';

class GetImageCurrentDay {
  final PhotoRepository photoRepository;

  GetImageCurrentDay({required this.photoRepository});

  Future<List<UserImage>> call() async {
    final DateTime currentDay = DateTime.now();
    final DateTime date = DateTime(
      currentDay.day,
      currentDay.month,
      currentDay.year,
    );
    final List<UserImage> images = await photoRepository.getUserImages();
    final List<UserImage> imageCurrentDay = images
        .where((e) => e.createdAt == date)
        .toList();
    return imageCurrentDay;
  }
}
