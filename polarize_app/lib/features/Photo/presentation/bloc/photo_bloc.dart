import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/core/Services/Locator/get_it.dart';
import 'package:polarize_app/features/Activity/presentation/bloc/activity_bloc.dart';
import 'package:polarize_app/features/Photo/domain/entity/image.dart';
import 'package:polarize_app/features/Photo/domain/usecase/add_photo_usecase.dart';
import 'package:polarize_app/features/Photo/domain/usecase/delete_photo_usecase.dart';
import 'package:polarize_app/features/Photo/domain/usecase/get_image_current_day.dart';
import 'package:polarize_app/features/Photo/domain/usecase/get_images_for_map_usecase.dart';
import 'package:polarize_app/features/Photo/domain/usecase/get_photos_usecase.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_event.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final AddPhotoUsecase addPhotoForCameraUsecase = getIt<AddPhotoUsecase>();
  final GetPhotosUsecase getPhotosUsecase = getIt<GetPhotosUsecase>();
  final GetImageCurrentDayUsecase getImageCurrentDay =
      getIt<GetImageCurrentDayUsecase>();
  final DeletePhotoUsecase deletePhotoUsecase = getIt<DeletePhotoUsecase>();
  final GetImagesForMapUsecase getImagesForMapUsecase =
      getIt<GetImagesForMapUsecase>();
  final ActivityBloc activityBloc;

  PhotoBloc(this.activityBloc) : super(InitialPhotoState()) {
    on<AddPhotoEvent>(_onAddPhoto);
    on<GetPhotosEvent>(_onGetPhotos);
    on<DeleteImageByIdEvent>(_onDeleteImage);
    on<SelectCurrentImageEvent>(_onSelectCurrentImage);
    on<ResetPhohoEvent>(_onRessetPhoto);
  }

  void _onAddPhoto(AddPhotoEvent event, Emitter<PhotoState> emit) async {
    emit(LoadingPhotoState());
    try {
      await addPhotoForCameraUsecase(event.forCamera);
      final List<UserImage> allImage = await getPhotosUsecase();
      final List<UserImage> currentDayImage = await getImageCurrentDay();
      final List<MapEntry<String, List<UserImage>>> imagesByDay =
          await getImagesForMapUsecase();
      await activityBloc.updateActivityUsecase();
      emit(
        LoadedPhotoState(
          allImage: allImage,
          currentDayImage: currentDayImage,
          currentImage: 0,
          imagesByDate: imagesByDay,
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
      final List<MapEntry<String, List<UserImage>>> imagesByDay =
          await getImagesForMapUsecase();

      emit(
        LoadedPhotoState(
          allImage: allImage,
          currentDayImage: currentDayImage,
          currentImage: currentDayImage.isNotEmpty
              ? currentDayImage.length - 1
              : null,
          imagesByDate: imagesByDay,
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
      final List<MapEntry<String, List<UserImage>>> imagesByDay =
          await getImagesForMapUsecase();

      int? newCurrentIndex;
      if (currentDayImage.isNotEmpty) {
        newCurrentIndex = state is LoadedPhotoState
            ? ((state as LoadedPhotoState).currentImage ?? 0)
            : 0;
        if (newCurrentIndex >= currentDayImage.length) {
          newCurrentIndex = currentDayImage.length - 1;
        }
      } else {
        newCurrentIndex = null;
      }
      emit(
        LoadedPhotoState(
          allImage: allImage,
          currentDayImage: currentDayImage,
          currentImage: newCurrentIndex,
          imagesByDate: imagesByDay,
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

  void _onRessetPhoto(ResetPhohoEvent event, Emitter<PhotoState> emit) async {
    emit(InitialPhotoState());
    try {
      final List<UserImage> allImage = await getPhotosUsecase();

      final List<UserImage> currentDayImage = await getImageCurrentDay();
      final List<MapEntry<String, List<UserImage>>> imagesByDay =
          await getImagesForMapUsecase();

      emit(
        LoadedPhotoState(
          allImage: allImage,
          currentDayImage: currentDayImage,
          currentImage: currentDayImage.isNotEmpty
              ? currentDayImage.length - 1
              : null,
          imagesByDate: imagesByDay,
        ),
      );
    } catch (e) {
      emit(ErrorPhotoState(error: e.toString()));
    }
  }
}
