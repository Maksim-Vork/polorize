import 'package:flutter/material.dart';
import 'package:polarize_app/features/Onboarding/presentation/on_boarding_screen.dart';

void main() {
  runApp(
    SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    ),
  );
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
      );
    });
    return Scaffold(
      backgroundColor: Color(0xFF2D2D2D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 15),
            Column(
              children: [
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
          ],
        ),
      ),
    );
  }
}
