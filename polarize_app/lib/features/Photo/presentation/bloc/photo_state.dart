import 'package:polarize_app/features/Photo/domain/entity/image.dart';

abstract class PhotoState {}

class InitialPhotoState extends PhotoState {}

class LoadingPhotoState extends PhotoState {}

class LoadedPhotoState extends PhotoState {
  final List<UserImage> allImage;
  final List<UserImage> currentDayImage;
  final int? currentImage;

  LoadedPhotoState({
    required this.allImage,
    required this.currentDayImage,
    required this.currentImage,
  });

  LoadedPhotoState copyWith({
    final List<UserImage>? allImage,
    final List<UserImage>? currentDayImage,
    final int? currentImage,
  }) {
    return LoadedPhotoState(
      allImage: allImage ?? this.allImage,
      currentDayImage: currentDayImage ?? this.currentDayImage,
      currentImage: currentImage,
    );
  }
}

class ErrorPhotoState extends PhotoState {
  final String error;

  ErrorPhotoState({required this.error});
}
