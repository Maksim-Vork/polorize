import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_bloc.dart';
import 'package:polarize_app/features/Photo/presentation/bloc/photo_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/background_fon.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: 273,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 38),
                height: 186,
                width: 186,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 28, 28, 28),
                  borderRadius: BorderRadius.circular(300),
                ),
                child: Center(
                  child: Container(
                    height: 176,
                    width: 176,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 175, 175),
                      borderRadius: BorderRadius.circular(100),
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
              child: BlocBuilder<PhotoBloc, PhotoState>(
                builder: (context, state) {
                  if (state is InitialPhotoState ||
                      state is LoadingPhotoState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is LoadedPhotoState) {
                    return Center(
                      child: Image.network(state.images[1].imageUrl),
                    );
                  } else if (state is ErrorPhotoState) {
                    print(state.error);
                    return Center(child: Text(state.error));
                  } else {
                    return Center(child: Text('error'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
