import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_bloc.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_event.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_state.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  void updateSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 65,
        title: Image.asset('assets/logo_polarize.png', width: 150),
      ),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is InitialPhotoState || state is LoadingPhotoState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoadedPhotoState) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/background_fon.png',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 273,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Spacer(),
                        SizedBox(width: 60),
                        Container(
                          height: 186,
                          width: 186,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 28, 28, 28),
                            borderRadius: BorderRadius.circular(300),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(300),
                              child: Container(
                                height: 179,
                                width: 179,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    223,
                                    223,
                                    223,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: state.currentDayImage.isEmpty
                                    ? Center(
                                        child: Icon(
                                          Icons.photo_camera_outlined,
                                          color: const Color.fromARGB(
                                            255,
                                            105,
                                            105,
                                            105,
                                          ),
                                          size: 70,
                                        ),
                                      )
                                    : Image.network(
                                        width: 179,
                                        fit: BoxFit.cover,

                                        state
                                            .currentDayImage[selectedIndex]
                                            .imageUrl,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              height: 200,
                              width: 45,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${selectedIndex + 1}/3',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<PhotoBloc>(context).add(
                                        DeleteImageByIdEvent(
                                          userImage: state
                                              .currentDayImage[selectedIndex],
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.delete, size: 25),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 300,
                      height: 25,
                      margin: EdgeInsets.only(top: 225),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          state.currentDayImage.length,
                          (index) => InkWell(
                            onTap: () => updateSelectedIndex(index),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              width: 52,
                              height: 23,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                border: Border.all(
                                  width: 2,
                                  color: const Color.fromARGB(255, 75, 75, 75),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  state.currentDayImage[index].imageUrl,
                                  width: 52,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 260),
                    width: double.infinity,
                    height: 1000,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 30, 30, 30),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 33,
                        vertical: 34,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Твой стрик: 10 Дней подряд!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ErrorPhotoState) {
            return Center(child: Text(state.error));
          } else {
            return Center(child: Text('error'));
          }
        },
      ),
    );
  }
}
