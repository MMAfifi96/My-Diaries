import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_diary/Login&Signup/login_screen.dart';
import 'package:my_diary/Login&Signup/signUp_Screen.dart';
import 'package:my_diary/Diaries_HomeLayout/bloc_observer.dart';
import 'package:my_diary/Diaries_HomeLayout/home_layout.dart';
import 'package:my_diary/Splash_Screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //to remove the debug banner in the top right corner
      home: SplashScreen(),
    );
  }
}
