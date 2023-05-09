import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_diary/Login&Signup/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 5500)).then((value) {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => LoginScreen(),
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_d0gmxgy5KG.json'),
            const SizedBox(
              height: 10,
            ),
            Lottie.network(
                'https://assets2.lottiefiles.com/packages/lf20_llbjwp92qL.json'),
          ],
        ),
      ),
    );
  }
}
