import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/features/Auth/data/datasource/remote_auth_datasource.dart';
import 'package:polarize_app/features/Auth/data/repository/auth_repository_impl.dart';
import 'package:polarize_app/features/Auth/domain/repository/auth_repository.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_event.dart';
import 'package:polarize_app/features/Photo/data/datasource/remote_photo_data.dart';
import 'package:polarize_app/features/Photo/data/repository/photo_repository_impl.dart';
import 'package:polarize_app/features/Photo/domain/repository/photo_repository.dart';
import 'package:polarize_app/features/Photo/domain/usecase/add_photo_usecase.dart';
import 'package:polarize_app/features/Photo/domain/usecase/delete_photo_usecase.dart';
import 'package:polarize_app/features/Photo/domain/usecase/get_image_current_day.dart';
import 'package:polarize_app/features/Photo/domain/usecase/get_photos_usecase.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_bloc.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_event.dart';
import 'package:polarize_app/features/auth/domain/usecase/check_auth_usecase.dart';
import 'package:polarize_app/features/auth/domain/usecase/login_with_email_and_password_usecase.dart';
import 'package:polarize_app/features/auth/domain/usecase/register_with_email_and_password_usecase.dart';
import 'package:polarize_app/features/auth/domain/usecase/sign_out_usecase.dart';
import 'package:polarize_app/features/auth/presentation/screen/register/register_screen.dart';
import 'package:polarize_app/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://ezeqtaszikjjnbmlqwzi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6ZXF0YXN6aWtqam5ibWxxd3ppIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ5OTI1ODQsImV4cCI6MjA3MDU2ODU4NH0.ZfRSFBlqVqQkERm72fJGMQvywgKiaY2jz295yy87CG8',
  );
  final RemoteAuthDatasource remoteAuthDatasource = RemoteAuthDatasource();
  final AuthRepository authRepository = AuthRepositoryImpl(
    remoteAuthDatasource: remoteAuthDatasource,
  );
  final CheckAuthUsecase checkAuthUsecase = CheckAuthUsecase(
    authRepository: authRepository,
  );
  final LoginWithEmailAndPasswordUsecase loginWithEmailAndPasswordUsecase =
      LoginWithEmailAndPasswordUsecase(authRepository: authRepository);
  final RegisterWithEmailAndPasswordUsecase
  registerWithEmailAndPasswordUsecase = RegisterWithEmailAndPasswordUsecase(
    authRepository: authRepository,
  );
  final SignOutUsecase signOutUsecase = SignOutUsecase(
    authRepository: authRepository,
  );
  final RemotePhotoData remotePhotoData = RemotePhotoData();
  final PhotoRepository photoRepository = PhotoRepositoryImpl(
    remotePhotoData: remotePhotoData,
  );
  final AddPhotoUsecase addPhotoForCameraUsecase = AddPhotoUsecase(
    photoRepository: photoRepository,
  );
  final GetPhotosUsecase getPhotosUsecase = GetPhotosUsecase(
    photoRepository: photoRepository,
  );
  final GetImageCurrentDay getImageCurrentDay = GetImageCurrentDay(
    photoRepository: photoRepository,
  );
  final DeletePhotoUsecase deletePhotoUsecase = DeletePhotoUsecase(
    photoRepository: photoRepository,
  );
  runApp(
    SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PhotoBloc(
              addPhotoForCameraUsecase,
              getPhotosUsecase,
              getImageCurrentDay,
              deletePhotoUsecase,
            )..add(GetPhotosEvent()),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              checkAuthUsecase,
              loginWithEmailAndPasswordUsecase,
              registerWithEmailAndPasswordUsecase,
              signOutUsecase,
            )..add(ChechAuthEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => RegisterScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 15),
            Text(
              'Your day - your story',
              style: TextStyle(
                color: const Color.fromARGB(255, 224, 224, 224),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
