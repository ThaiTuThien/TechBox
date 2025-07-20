import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:techbox/src/features/auth/login/presentation/login.dart';
import 'package:techbox/src/features/onboarding/presentation/onboard_screen_1.dart';
import 'package:techbox/src/features/onboarding/presentation/onboard_screen_2.dart';
import 'package:techbox/src/features/onboarding/presentation/onboard_screen_3.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  PageController controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [OnBoardScreen1(), OnBoardScreen2(), OnBoardScreen3()],
          ),
          Container(
            alignment: Alignment(0, 0.9),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.animateToPage(
                        2,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      'Bỏ qua',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 10,
                      activeDotColor: Color(0xFF3C595D),
                      dotColor: Colors.grey.shade300,
                    ),
                  ),

                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child:
                        onLastPage
                            ? GestureDetector(
                              key: ValueKey('done'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text('Hoàn tất'),
                            )
                            : GestureDetector(
                              key: ValueKey('next'),
                              onTap: () {
                                controller.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: Text('Kế tiếp'),
                            ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
