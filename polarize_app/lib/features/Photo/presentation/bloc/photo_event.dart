import 'package:polarize_app/features/Photo/domain/entity/image.dart';

abstract class PhotoEvent {}

class AddPhotoEvent extends PhotoEvent {
  final bool forCamera;

  AddPhotoEvent({required this.forCamera});
}

class GetPhotosEvent extends PhotoEvent {}

class DeleteImageByIdEvent extends PhotoEvent {
  final UserImage userImage;

  DeleteImageByIdEvent({required this.userImage});
}
