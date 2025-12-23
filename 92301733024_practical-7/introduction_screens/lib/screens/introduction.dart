import 'package:introduction_screens/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> listPagesViewModel = [
      introPageModel(
        "Welcome",
        "Welcome to this awesome intro screen app.",
        "assets/images/intro_1.png",
        const Color.fromRGBO(126, 196, 128, 1),
      ),
      introPageModel(
        "Awesome App",
        "This is an awesome app, of intro screen design",
        "assets/images/intro_2.png",
        const Color.fromRGBO(98, 181, 243, 1),
      ),
      introPageModel(
        "Flutter App",
        "Flutter is awesome fro app development",
        "assets/images/intro_3.png",
        const Color.fromRGBO(123, 133, 205, 1),
      ),
    ];

    return Scaffold(
      body: IntroductionScreen(
        pages: listPagesViewModel,
        showSkipButton: true,
        skip: const Text("Skip", style: TextStyle(color: Colors.black)),
        next: const Icon(Icons.arrow_forward, color: Colors.black),
        done: const Icon(Icons.check, color: Colors.black),
        onDone: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('firstTime', false);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardPage()),
          );
        },
        onSkip: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('firstTime', false);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardPage()),
          );
        },
        controlsPadding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10),
          activeSize: const Size(20, 20),
          activeColor: Colors.red,
          color: Colors.grey[300]!,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }

  introPageModel(
    String title,
    String bodyText,
    String imgPath,
    Color backColor,
  ) {
    return PageViewModel(
      title: title,
      body: bodyText,
      image: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 500,
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Image.asset(imgPath, fit: BoxFit.contain),
      ),
      reverse: true,
      decoration: PageDecoration(
        pageMargin: const EdgeInsets.all(0),
        titlePadding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        bodyPadding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        imagePadding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
        pageColor: backColor,
        titleTextStyle: const TextStyle(
          fontSize: 42,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: const TextStyle(fontSize: 28, color: Colors.white),
      ),
    );
  }
}
