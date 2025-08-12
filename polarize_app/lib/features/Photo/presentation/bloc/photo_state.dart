import 'package:polarize_app/features/Photo/domain/entity/image.dart';

abstract class PhotoState {}

class InitialPhotoState extends PhotoState {}

class LoadingPhotoState extends PhotoState {}

class LoadedPhotoState extends PhotoState {
  final List<UserImage> images;

  LoadedPhotoState({required this.images});
}

class ErrorPhotoState extends PhotoState {
  final String error;

  ErrorPhotoState({required this.error});
}
