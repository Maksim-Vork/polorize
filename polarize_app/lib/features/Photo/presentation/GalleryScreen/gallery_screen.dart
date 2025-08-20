import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/features/Photo/domain/entity/image.dart';
import 'package:polarize_app/features/Photo/presentation/PreviewPhotoScreen/view_photo_screen.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_bloc.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_state.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: Colors.black, height: 1),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 75,
        title: Text(
          'Галерея',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is InitialPhotoState || state is LoadingPhotoState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoadedPhotoState) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                    child: Image.asset(
                      'assets/background_fon.png',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 288,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'В этот день',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Год назад',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 162,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 28, 28, 28),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(16),
                              child: Container(
                                height: 160,
                                width: 248,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    223,
                                    223,
                                    223,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child:
                                    state.currentImage == null ||
                                        state.currentDayImage.isEmpty
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
                                    : InkWell(
                                        onTap: () {},
                                        child: Image.network(
                                          width: 248,
                                          fit: BoxFit.cover,

                                          state
                                              .currentDayImage[state
                                                  .currentImage!]
                                              .imageUrl,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 260),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 33),
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 30, 30, 30),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: state.imagesByDate?.length != null
                        ? Expanded(
                            child: Column(
                              children: [
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.imagesByDate!.length,
                                  itemBuilder: (context, index) {
                                    return GalaryDayImage(
                                      imagesFromDay: state.imagesByDate![index],
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        : SizedBox.expand(),
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

class GalaryDayImage extends StatelessWidget {
  final MapEntry<String, List<UserImage>> imagesFromDay;

  const GalaryDayImage({super.key, required this.imagesFromDay});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              imagesFromDay.key,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        SizedBox(
          width: 400,
          height: 89,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imagesFromDay.value.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Viewphotoscreen(
                        imageUrl: imagesFromDay.value[index].imageUrl,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 6),
                  width: 89,
                  height: 89,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(15),
                    child: Image.network(
                      imagesFromDay.value[index].imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
