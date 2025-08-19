import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_event.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
            },
            child: Text('Выйти с акаунта'),
          ),
        ],
      ),
    );
  }
}
