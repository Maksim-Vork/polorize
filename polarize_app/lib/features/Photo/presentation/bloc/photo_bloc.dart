import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/features/Photo/domain/entity/image.dart';
import 'package:polarize_app/features/Photo/domain/usecase/add_photo_usecase.dart';
import 'package:polarize_app/features/Photo/domain/usecase/delete_photo_usecase.dart';
import 'package:polarize_app/features/Photo/domain/usecase/get_image_current_day.dart';
import 'package:polarize_app/features/Photo/domain/usecase/get_photos_usecase.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_event.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final AddPhotoUsecase addPhotoForCameraUsecase;
  final GetPhotosUsecase getPhotosUsecase;
  final GetImageCurrentDay getImageCurrentDay;
  final DeletePhotoUsecase deletePhotoUsecase;
  PhotoBloc(
    this.addPhotoForCameraUsecase,
    this.getPhotosUsecase,
    this.getImageCurrentDay,
    this.deletePhotoUsecase,
  ) : super(InitialPhotoState()) {
    on<AddPhotoEvent>(_onAddPhoto);
    on<GetPhotosEvent>(_onGetPhotos);
    on<DeleteImageByIdEvent>(_onDeleteImage);
    on<SelectCurrentImageEvent>(_onSelectCurrentImage);
  }

  void _onAddPhoto(AddPhotoEvent event, Emitter<PhotoState> emit) async {
    emit(LoadingPhotoState());
    try {
      await addPhotoForCameraUsecase(event.forCamera);
      final List<UserImage> allImage = await getPhotosUsecase();
      final List<UserImage> currentDayImage = await getImageCurrentDay();

      emit(
        LoadedPhotoState(
          allImage: allImage,
          currentDayImage: currentDayImage,
          currentImage: 0,
        ),
      );
    } catch (e) {
      emit(ErrorPhotoState(error: e.toString()));
    }
  }

  void _onGetPhotos(GetPhotosEvent event, Emitter<PhotoState> emit) async {
    try {
      final List<UserImage> allImage = await getPhotosUsecase();
      final List<UserImage> currentDayImage = await getImageCurrentDay();

      emit(
        LoadedPhotoState(
          allImage: allImage,
          currentDayImage: currentDayImage,
          currentImage: currentDayImage.isNotEmpty
              ? currentDayImage.length
              : null,
        ),
      );
    } catch (e) {
      emit(ErrorPhotoState(error: e.toString()));
    }
  }

  void _onDeleteImage(
    DeleteImageByIdEvent event,
    Emitter<PhotoState> emit,
  ) async {
    try {
      await deletePhotoUsecase(event.userImage);
      final List<UserImage> allImage = await getPhotosUsecase();
      final List<UserImage> currentDayImage = await getImageCurrentDay();

      int? newCurrentIndex;
      if (currentDayImage.isNotEmpty) {
        // Если текущий индекс больше последнего, сдвигаем его влево
        newCurrentIndex = state is LoadedPhotoState
            ? ((state as LoadedPhotoState).currentImage ?? 0)
            : 0;
        if (newCurrentIndex >= currentDayImage.length) {
          newCurrentIndex = currentDayImage.length - 1;
        }
      } else {
        newCurrentIndex = null; // Фото больше нет
      }
      emit(
        LoadedPhotoState(
          allImage: allImage,
          currentDayImage: currentDayImage,
          currentImage: newCurrentIndex,
        ),
      );
    } catch (e) {
      emit(ErrorPhotoState(error: e.toString()));
    }
  }

  void _onSelectCurrentImage(
    SelectCurrentImageEvent event,
    Emitter<PhotoState> emit,
  ) async {
    final currentState = state as LoadedPhotoState;
    emit(currentState.copyWith(currentImage: event.currentIndex));
  }
}
