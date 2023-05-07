import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_diary/Diaries_HomeLayout/cubit.dart';
import 'package:my_diary/Login&Signup/Models/UserModel.dart';
import 'package:my_diary/Login&Signup/signUp_Screen.dart';
import 'package:my_diary/Reusable_Components/Reusable_FormField.dart';
import 'package:my_diary/Reusable_Components/components.dart';
import 'package:my_diary/Reusable_Components/Reusable_Button.dart';
import 'package:my_diary/Diaries_HomeLayout/home_layout.dart';

import 'Database/Database_Helper.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var passwordController = TextEditingController();

  var emailController = TextEditingController();

  var formKey = new GlobalKey<FormState>();

  bool isPassword = true;
  String imageURL =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0D_0L9VtoKXAWQ-gGlXdFJqowi9odaE77Xg&usqp=CAU';

  var dbHelper;
  @override
  initState() {
    super.initState();
    dbHelper = DatabaseHelper();
  }

  // login() async {
  //   String email = emailController.text;
  //   String passwd = passwordController.text;
  //   if (email.isEmpty) {
  //     return 'email must not be empty'.toUpperCase();
  //   } else if (passwd.isEmpty) {
  //     return 'password must not be empty'.toUpperCase();
  //   } else {
  //     // check (emailController.text,passwordController.text)
  //     await dbHelper.getUserLoginDetails(email, passwd).then((userData) {
  //       print(userData);
  //       if (userData != null) {
  //         DiariesCubit.get(context).userId = userData.email;
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => HomeLayout()),
  //           (Route<dynamic> route) => false,
  //         );
  //         print('log in success');
  //         print('log in Email is : ${userData.email}');
  //         print('log in Password is : ${userData.password}');
  //       } else {
  //         showDialog(
  //           context: context,
  //           builder: (_) => AlertDialog(
  //             insetPadding: const EdgeInsets.symmetric(
  //               horizontal: 75.0,
  //               vertical: 300.0,
  //             ),
  //             title: Container(
  //               height: 60,
  //               color: Colors.red,
  //               child: const Icon(
  //                 Icons.error,
  //                 color: Colors.white,
  //                 size: 30.0,
  //               ),
  //             ),
  //             content: Center(
  //                 child: Column(
  //               children: const [
  //                 Text(
  //                   'Login Failure !',
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 Text(
  //                   'please check your user details again , Email and password does not match ',
  //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
  //                 ),
  //               ],
  //             )),
  //           ),
  //         );
  //       }
  //     }).catchError((error) {
  //       print('Error Happened While Logging In $error');
  //       showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //           insetPadding: const EdgeInsets.symmetric(
  //             horizontal: 75.0,
  //             vertical: 300.0,
  //           ),
  //           title: Container(
  //             height: 60,
  //             color: Colors.red,
  //             child: const Icon(
  //               Icons.error,
  //               color: Colors.white,
  //               size: 30.0,
  //             ),
  //           ),
  //           content: Center(
  //               child: Column(
  //             children: const [
  //               Text(
  //                 'Login Failed !',
  //                 style: TextStyle(fontWeight: FontWeight.bold),
  //               ),
  //               Text(
  //                 'Login Failed !',
  //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
  //               ),
  //             ],
  //           )),
  //         ),
  //       );
  //     });
  //   }
  // }

  login() async {
    print('login pressed ');
    String email = emailController.text;
    String passwd = passwordController.text;
    if (email.isEmpty) {
      return 'email must not be empty'.toUpperCase();
    } else if (passwd.isEmpty) {
      return 'password must not be empty'.toUpperCase();
    } else {
      // check (emailController.text,passwordController.text)
      await dbHelper.getUserLoginDetails(email, passwd).then((userData) {
        if (userData != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeLayout()),
                (Route<dynamic> route) => false,
          );
          print('log in success');
          print('log in Email is : ${emailController.text}');
          print('log in Password is : ${passwordController.text}');
        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                insetPadding: const EdgeInsets.symmetric(
                  horizontal: 75.0,
                  vertical: 300.0,
                ),
                title: Container(
                  height: 60,
                  color: Colors.red,
                  child: const Icon(
                    Icons.error,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
                content: Center(
                    child: Column(
                      children: const [
                        Text(
                          'Login Failure !',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'please check your user details again , Email and password does not match ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    )),
              ));
        }
      }).catchError((error) {
        print('Error Happened While Logging In $error');
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 75.0,
                vertical: 300.0,
              ),
              title: Container(
                height: 60,
                color: Colors.red,
                child: const Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              content: Center(
                  child: Column(
                    children: const [
                      Text(
                        'Login Failed !',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Login Failed !',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  )),
            ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: Image.network(imageURL),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Welcome To My Diary !',
                    style: TextStyle(fontSize: 35),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ReusableFormField(
                    formFieldValidator: (value) {
                      if (value!.isEmpty) {
                        return 'email must not be empty'.toUpperCase();
                      }
                      if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                          .hasMatch(value)) {
                        return 'Please enter valid email format '.toUpperCase();
                      }
                      return null;
                    },
                    formFieldController: emailController,
                    formFieldTextType: TextInputType.emailAddress,
                    formFieldLabelText: 'Email',
                    formFieldPrefixIcon: Icons.email,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ReusableFormField(
                    fieldMaxLines: 1,
                    isPassword: isPassword,
                    formFieldValidator: (value) {
                      if (value!.isEmpty) {
                        return 'password must not be empty'.toUpperCase();
                      }
                    },
                    formFieldController: passwordController,
                    formFieldTextType: TextInputType.visiblePassword,
                    formFieldLabelText: 'Password',
                    formFieldPrefixIcon: Icons.lock,
                    formFieldSuffixIcon: isPassword
                        ? Icons.remove_red_eye
                        : Icons.visibility_off,
                    formFieldSuffixIconPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ReusableButton(
                    buttonBackgroundColor: CupertinoColors.activeGreen,
                    buttonWidth: double.infinity,
                    buttonOnPressed: () {
                      login();
                    },
                    buttonText: 'Log in',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Text('Don\'t Have an Account ?'),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
