import 'package:flutter/material.dart';
import 'package:polarize_app/features/Photo/presentation/AddPhotoScreen/add_photo_screen.dart';
import 'package:polarize_app/features/Photo/presentation/DashBoardScreen/dash_board_screen.dart';
import 'package:polarize_app/features/Photo/presentation/GalleryScreen/gallery_screen.dart';
import 'package:polarize_app/features/Photo/presentation/SettingsScreen/settings_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int currentIndex = 0;
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
      body: screens[currentIndex],
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
