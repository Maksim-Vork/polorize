import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/core/Bloc/first_start_bloc.dart';
import 'package:polarize_app/core/Bloc/first_start_event.dart';
import 'package:polarize_app/core/Bloc/first_start_state.dart';
import 'package:polarize_app/core/Services/Locator/get_it.dart';
import 'package:polarize_app/features/Activity/presentation/bloc/activity_bloc.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_event.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_bloc.dart';
import 'package:polarize_app/features/Splash/presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(
    SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => StartBloc()..add(CheckFirstStartEvent()),
          ),
          BlocProvider(create: (context) => ActivityBloc()),
          BlocProvider(
            create: (context) => PhotoBloc(context.read<ActivityBloc>()),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              context.read<ActivityBloc>(),
              context.read<PhotoBloc>(),
            )..add(ChechAuthEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,

          home: BlocBuilder<StartBloc, StartState>(
            builder: (context, state) {
              return SplashScreen();
            },
          ),
        ),
      ),
    ),
  );
}
