import 'package:polarize_app/features/Photo/domain/entity/image.dart';

abstract class PhotoState {}

class InitialPhotoState extends PhotoState {}

class LoadingPhotoState extends PhotoState {}

class LoadedPhotoState extends PhotoState {
  final List<UserImage> allImage;
  final List<UserImage> currentDayImage;

  LoadedPhotoState({required this.allImage, required this.currentDayImage});

  LoadedPhotoState copyWith({
    final List<UserImage>? allImage,
    final List<UserImage>? currentDayImage,
  }) {
    return LoadedPhotoState(
      allImage: allImage ?? this.allImage,
      currentDayImage: currentDayImage ?? this.allImage,
    );
  }
}

class ErrorPhotoState extends PhotoState {
  final String error;

  ErrorPhotoState({required this.error});
}
