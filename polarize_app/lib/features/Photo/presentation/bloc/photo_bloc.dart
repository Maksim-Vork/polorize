import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/features/Photo/domain/entity/image.dart';
import 'package:polarize_app/features/Photo/domain/usecase/add_photo_usecase.dart';
import 'package:polarize_app/features/Photo/domain/usecase/get_photos_usecase.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_event.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final AddPhotoUsecase addPhotoForCameraUsecase;
  final GetPhotosUsecase getPhotosUsecase;
  PhotoBloc(this.addPhotoForCameraUsecase, this.getPhotosUsecase)
    : super(InitialPhotoState()) {
    on<AddPhotoEvent>(_onAddPhoto);
    on<GetPhotoEvent>(_onGetImages);
  }

  void _onAddPhoto(AddPhotoEvent event, Emitter<PhotoState> emit) async {
    emit(LoadingPhotoState());
    try {
      await addPhotoForCameraUsecase(event.forCamera);
      final List<UserImage> images = await getPhotosUsecase();
      emit(LoadedPhotoState(images: images));
    } catch (e) {
      emit(ErrorPhotoState(error: e.toString()));
    }
  }

  void _onGetImages(GetPhotoEvent event, Emitter<PhotoState> emit) async {
    emit(LoadingPhotoState());
    try {
      final List<UserImage> images = await getPhotosUsecase();
      emit(LoadedPhotoState(images: images));
    } catch (e) {
      emit(ErrorPhotoState(error: e.toString()));
    }
  }
}
