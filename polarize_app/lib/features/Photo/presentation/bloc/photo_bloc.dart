import 'dart:async';

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
  }

  void _onAddPhoto(AddPhotoEvent event, Emitter<PhotoState> emit) async {
    emit(LoadingPhotoState());
    try {
      await addPhotoForCameraUsecase(event.forCamera);
      final List<UserImage> allImage = await getPhotosUsecase();
      final List<UserImage> currentDayImage = await getImageCurrentDay();
      emit(
        LoadedPhotoState(allImage: allImage, currentDayImage: currentDayImage),
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
        LoadedPhotoState(allImage: allImage, currentDayImage: currentDayImage),
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
      emit(
        LoadedPhotoState(allImage: allImage, currentDayImage: currentDayImage),
      );
    } catch (e) {
      emit(ErrorPhotoState(error: e.toString()));
    }
  }
}
