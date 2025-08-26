import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/features/Photo/presentation/AddPhotoScreen/add_photo_screen.dart';
import 'package:polarize_app/features/Photo/presentation/DashBoardScreen/dash_board_screen.dart';
import 'package:polarize_app/features/Photo/presentation/GalleryScreen/gallery_screen.dart';
import 'package:polarize_app/features/Photo/presentation/SettingsScreen/settings_screen.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_bloc.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_state.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int currentIndex = 0;
  int previousImageCount = 0;
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      DashboardScreen(),
      AddPhotoScreen(),
      GalleryScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      body: BlocListener<PhotoBloc, PhotoState>(
        listener: (context, state) {
          if (state is LoadedPhotoState) {
            if (state.currentDayImage.length > previousImageCount) {
              final double screenHeight = MediaQuery.of(context).size.height;
              Future.delayed(Duration(milliseconds: 520), () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(
                      bottom: screenHeight - 165,
                      right: 20,
                      left: 20,
                    ),

                    animation: CurvedAnimation(
                      // ignore: use_build_context_synchronously
                      parent: ModalRoute.of(context)!.animation!,
                      curve: Curves.linear,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: const Color.fromARGB(253, 205, 255, 202),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    backgroundColor: const Color(0xFF2D2D2D),
                    duration: Duration(seconds: 3),
                    content: Text(
                      '✨ Момент сохранен!',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              });
            }

            previousImageCount = state.currentDayImage.length;
          }
        },
        child: Scaffold(body: screens[currentIndex]),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white, width: 1.0)),
          ),
          child: BottomNavigationBar(
            selectedItemColor: Color.fromARGB(207, 205, 16, 16),
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromARGB(255, 30, 30, 30),
            iconSize: 32,
            currentIndex: currentIndex,
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                icon: Transform.translate(
                  offset: Offset(0, 10),
                  child: Icon(Icons.home),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Transform.translate(
                  offset: Offset(0, 10),
                  child: Icon(Icons.add),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Transform.translate(
                  offset: Offset(0, 10),
                  child: Icon(Icons.filter),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Transform.translate(
                  offset: Offset(0, 10),
                  child: Icon(Icons.settings),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
