abstract class PhotoEvent {}

class AddPhotoEvent extends PhotoEvent {
  final bool forCamera;

  AddPhotoEvent({required this.forCamera});
}

class GetPhotoEvent extends PhotoEvent {}
