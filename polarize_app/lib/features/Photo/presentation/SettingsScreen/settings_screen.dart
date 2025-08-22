import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_event.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 30, 30),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            height: 1,
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        title: Text(
          'Настройки',
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 135,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromARGB(255, 43, 43, 43),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 86,
                        height: 86,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(126, 203, 203, 203),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Username',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Text(
                                    'email@gmail.com',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: const Color.fromARGB(
                                        255,
                                        220,
                                        220,
                                        220,
                                      ),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              TextButton(
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(
                                    context,
                                  ).add(SignOutEvent());
                                },
                                child: Text('Выйти с аккаунта'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
