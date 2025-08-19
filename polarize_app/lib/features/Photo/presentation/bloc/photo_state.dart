import 'package:polarize_app/features/Photo/domain/entity/image.dart';

abstract class PhotoState {}

class InitialPhotoState extends PhotoState {}

class LoadingPhotoState extends PhotoState {}

class LoadedPhotoState extends PhotoState {
  final List<UserImage> allImage;
  final List<UserImage> currentDayImage;
  final int? currentImage;
  final Map<String, List<UserImage>>? imagesByDate;

  LoadedPhotoState({
    required this.allImage,
    required this.currentDayImage,
    required this.currentImage,
    required this.imagesByDate,
  });

  LoadedPhotoState copyWith({
    final List<UserImage>? allImage,
    final List<UserImage>? currentDayImage,
    final int? currentImage,
    final Map<String, List<UserImage>>? imagesByDate,
  }) {
    return LoadedPhotoState(
      allImage: allImage ?? this.allImage,
      currentDayImage: currentDayImage ?? this.currentDayImage,
      currentImage: currentImage,
      imagesByDate: imagesByDate ?? this.imagesByDate,
    );
  }
}

class ErrorPhotoState extends PhotoState {
  final String error;

  ErrorPhotoState({required this.error});
}
