import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    final session = supabase.auth.currentSession;

    if (!mounted) return;

    if (session != null) {
      Navigator.of(context).pushReplacementNamed('/account');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 844,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Container(
            width: 396,
            height: 565,
            child: Stack(
              children: [
                Positioned(
                  left: 0, // Set left to 0 to center the image
                  top: 0,
                  child: Container(
                    width: 396,
                    height: 565,
                    decoration: const BoxDecoration(color: Color(0xFFC4C4C4)),
                  ),
                ),
                Positioned(
                  left: 23, // Adjusted to center the image
                  top: 0,
                  child: Container(
                    width: 350, // Adjusted width to fit the container
                    height: 565, // Keep the same height as the container
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/onboardingpic.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment.center, // Center the image
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 372,
            child: Container(
              width: 390,
              height: 193,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(0.00, -1.00),
                  end: const Alignment(0, 1),
                  colors: [Colors.white.withOpacity(0), Colors.white],
                ),
              ),
            ),
          ),
          Positioned(
            left: 76,
            top: 617,
            child: Container(
              width: 71,
              height: 14,
              decoration: const BoxDecoration(color: Color(0xFFBBF246)),
            ),
          ),
          const Positioned(
            left: 60,
            top: 574,
            child: SizedBox(
              width: 270,
              child: Text(
                'Wherever You Are Health Is Number One',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF192126),
                  fontSize: 24,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 67,
            top: 656,
            child: Text(
              'There is no instant way to a healthy life',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0x7F192126),
                fontSize: 15,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 157,
            top: 713,
            child: SizedBox(
              width: 65,
              height: 5,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 65,
                      height: 5,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF192126),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 1,
                    top: 1,
                    child: Container(
                      width: 21,
                      height: 3,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFBBF246),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 764,
            child: SizedBox(
              width: 350,
              height: 56,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 350,
                      height: 56,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF192126),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 134,
                    top: 16,
                    child: Text(
                      'Get Started',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                      ),
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
