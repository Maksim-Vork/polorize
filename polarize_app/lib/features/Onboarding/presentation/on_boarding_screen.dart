import 'package:flutter/material.dart';
import 'package:polarize_app/features/Auth/presentation/screen/register/register_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _countScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 10),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 600,
                child: PageView(
                  controller: _pageController,
                  children: [
                    PageViewCart(
                      urlImg: 'assets/onboard_1.png',
                      upText: 'Save the best moments to',
                      text: 'remember with a smile',
                    ),
                    PageViewCart(
                      urlImg: 'assets/onboard_3.png',
                      upText: 'Collect your history',
                      text: 'in one place',
                    ),
                    PageViewCart(
                      urlImg: 'assets/onboard_2.png',
                      upText: 'Can you fit a day',
                      text: 'into 3 frames?',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 48),
              SizedBox(
                width: 326,
                height: 71,
                child: _countScreen == 2
                    ? ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => RegisterScreen()),
                          );
                        },
                        child: Text(
                          'Finish',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                        ),
                        onPressed: () {
                          setState(() {
                            _countScreen++;
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          });
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageViewCart extends StatelessWidget {
  final String urlImg;
  final String upText;
  final String text;
  const PageViewCart({
    super.key,
    required this.urlImg,
    required this.upText,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 600,
      child: Column(
        children: [
          Image.asset(urlImg),
          SizedBox(height: 43),
          Text(
            upText,
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),

              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 221, 221, 221),
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
