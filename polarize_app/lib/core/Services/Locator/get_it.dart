import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:polarize_app/core/Services/StoredLocalSettings/first_start_services.dart';
import 'package:polarize_app/features/Activity/data/datasource/remote_activity_data.dart';
import 'package:polarize_app/features/Activity/data/repository/activity_repository_impl.dart';
import 'package:polarize_app/features/Activity/domain/repository/activity_repository.dart';
import 'package:polarize_app/features/Activity/domain/usecase/create_activity_for_new_user_usecase.dart';
import 'package:polarize_app/features/Activity/domain/usecase/get_activity_usecase.dart';
import 'package:polarize_app/features/Activity/domain/usecase/update_activity_usecase.dart';
import 'package:polarize_app/features/Auth/data/datasource/remote_auth_datasource.dart';
import 'package:polarize_app/features/Auth/data/repository/auth_repository_impl.dart';
import 'package:polarize_app/features/Auth/domain/repository/auth_repository.dart';
import 'package:polarize_app/features/Auth/domain/usecase/check_auth_usecase.dart';
import 'package:polarize_app/features/Auth/domain/usecase/login_with_email_and_password_usecase.dart';
import 'package:polarize_app/features/Auth/domain/usecase/register_with_email_and_password_usecase.dart';
import 'package:polarize_app/features/Auth/domain/usecase/sign_out_usecase.dart';
import 'package:polarize_app/features/Photo/data/datasource/remote_photo_data.dart';
import 'package:polarize_app/features/Photo/data/repository/photo_repository_impl.dart';
import 'package:polarize_app/features/Photo/domain/repository/photo_repository.dart';
import 'package:polarize_app/features/Photo/domain/usecase/add_photo_usecase.dart';
import 'package:polarize_app/features/Photo/domain/usecase/delete_photo_usecase.dart';
import 'package:polarize_app/features/Photo/domain/usecase/get_image_current_day.dart';
import 'package:polarize_app/features/Photo/domain/usecase/get_images_for_map_usecase.dart';
import 'package:polarize_app/features/Photo/domain/usecase/get_photos_usecase.dart';
import 'package:polarize_app/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://ezeqtaszikjjnbmlqwzi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6ZXF0YXN6aWtqam5ibWxxd3ppIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ5OTI1ODQsImV4cCI6MjA3MDU2ODU4NH0.ZfRSFBlqVqQkERm72fJGMQvywgKiaY2jz295yy87CG8',
  );
  //Services
  getIt.registerLazySingleton<FirstStartServices>(
    () => FirstStartServices(prefs: getIt<SharedPreferences>()),
  );

  //Data source
  getIt.registerLazySingleton<RemoteActivityData>(() => RemoteActivityData());
  getIt.registerLazySingleton<RemotePhotoData>(() => RemotePhotoData());
  getIt.registerLazySingleton<RemoteAuthDatasource>(
    () => RemoteAuthDatasource(),
  );

  //Repository
  getIt.registerLazySingleton<AuthRepository>(
    () =>
        AuthRepositoryImpl(remoteAuthDatasource: getIt<RemoteAuthDatasource>()),
  );
  getIt.registerLazySingleton<ActivityRepository>(
    () =>
        ActivityRepositoryImpl(remoteActivityData: getIt<RemoteActivityData>()),
  );
  getIt.registerLazySingleton<PhotoRepository>(
    () => PhotoRepositoryImpl(remotePhotoData: getIt<RemotePhotoData>()),
  );

  //Usecase

  //auth
  getIt.registerLazySingleton<CheckAuthUsecase>(
    () => CheckAuthUsecase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LoginWithEmailAndPasswordUsecase>(
    () => LoginWithEmailAndPasswordUsecase(
      authRepository: getIt<AuthRepository>(),
    ),
  );
  getIt.registerLazySingleton<RegisterWithEmailAndPasswordUsecase>(
    () => RegisterWithEmailAndPasswordUsecase(
      activityRepository: getIt<ActivityRepository>(),
      authRepository: getIt<AuthRepository>(),
    ),
  );
  getIt.registerLazySingleton<SignOutUsecase>(
    () => SignOutUsecase(authRepository: getIt<AuthRepository>()),
  );
  //photo
  getIt.registerLazySingleton<AddPhotoUsecase>(
    () => AddPhotoUsecase(photoRepository: getIt<PhotoRepository>()),
  );
  getIt.registerLazySingleton<GetPhotosUsecase>(
    () => GetPhotosUsecase(photoRepository: getIt<PhotoRepository>()),
  );
  getIt.registerLazySingleton<GetImageCurrentDayUsecase>(
    () => GetImageCurrentDayUsecase(photoRepository: getIt<PhotoRepository>()),
  );
  getIt.registerLazySingleton<DeletePhotoUsecase>(
    () => DeletePhotoUsecase(photoRepository: getIt<PhotoRepository>()),
  );
  //activity
  getIt.registerLazySingleton<GetActivityUsecase>(
    () => GetActivityUsecase(activityRepository: getIt<ActivityRepository>()),
  );
  getIt.registerLazySingleton<CreateActivityForNewUserUsecase>(
    () => CreateActivityForNewUserUsecase(
      activityRepository: getIt<ActivityRepository>(),
    ),
  );
  getIt.registerLazySingleton<UpdateActivityUsecase>(
    () =>
        UpdateActivityUsecase(activityRepository: getIt<ActivityRepository>()),
  );
  getIt.registerLazySingleton<GetImagesForMapUsecase>(
    () => GetImagesForMapUsecase(photoRepository: getIt<PhotoRepository>()),
  );
}
