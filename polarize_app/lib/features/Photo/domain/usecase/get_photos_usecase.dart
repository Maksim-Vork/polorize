import 'package:polarize_app/features/Photo/domain/entity/image.dart';
import 'package:polarize_app/features/Photo/domain/repository/photo_repository.dart';

class GetPhotosUsecase {
  final PhotoRepository photoRepository;

  GetPhotosUsecase({required this.photoRepository});

  Future<List<UserImage>> call() async {
    return await photoRepository.getUserImages();
  }
}
