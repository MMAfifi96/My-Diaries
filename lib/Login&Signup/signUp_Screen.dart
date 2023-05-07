import 'package:flutter/material.dart';
import 'package:my_diary/Login&Signup/Database/Database_Helper.dart';
import 'package:my_diary/Reusable_Components/Reusable_FormField.dart';
import 'package:my_diary/Reusable_Components/components.dart';
import 'package:my_diary/Reusable_Components/Reusable_Button.dart';

import 'Models/UserModel.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var signUpFirstNameController = TextEditingController();
  var signUpSecondNameController = TextEditingController();
  var signUpEmailController = TextEditingController();
  var signUpPasswordController = TextEditingController();
  var signUpConfirmPasswordController = TextEditingController();
  var signUpFormKey = GlobalKey<FormState>();
  var dbHelper;
  bool isPassword = true;

  @override
  initState() {
    super.initState();
    dbHelper = DatabaseHelper();
  }

  signUp() async {
    if (signUpFormKey.currentState!.validate()) {
      print('First Name is : ${signUpFirstNameController.text}');
      print('Second Name is : ${signUpSecondNameController.text}');
      print('Sign up Email is : ${signUpEmailController.text}');
      print('Sign up Password is : ${signUpPasswordController.text}');
      print('Confirm Password is : ${signUpConfirmPasswordController.text}');

      if (signUpFormKey.currentState!.validate()) {
        if (signUpPasswordController.text !=
            signUpConfirmPasswordController.text) {
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
                          'Error !',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Center(
                          child: Text(
                            'Password Mismatch Confirm Password',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    )),
                  ));
          print('error');
        } else {
          signUpFormKey.currentState!.save();

          UserModel uModel = UserModel(
            signUpEmailController.text,
            signUpPasswordController.text,
            // UserModel.generateUserId(),
          );

          await dbHelper.saveData(uModel).then((userData) {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      insetPadding: const EdgeInsets.symmetric(
                        horizontal: 75.0,
                        vertical: 300.0,
                      ),
                      title: Container(
                        height: 60,
                        color: Colors.green,
                        child: const Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      content: Center(
                          child: Column(
                        children: const [
                          Text(
                            'sign Done !',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Center(
                            child: Text(
                              'data saving is successfully done',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                    ));
            print('saved');
          }).catchError((error) {
            print('Error Happened While Signing Up : $error');
          });

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          });
        }
      }
    }
  }

  validateEmail(String email) {
    final emailReg = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailReg.hasMatch(email);
  }

  validatePassword(String password) {
    final passwordReg =
        RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
    return passwordReg.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: signUpFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ReusableFormField(
                        formFieldController: signUpFirstNameController,
                        formFieldTextType: TextInputType.name,
                        formFieldLabelText: 'First Name',
                        formFieldPrefixIcon: Icons.supervised_user_circle,
                        formFieldValidator: (value) {
                          if (value!.isEmpty) {
                            return 'First Name must not be empty'.toUpperCase();
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ReusableFormField(
                        formFieldValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Second Name must not be empty'
                                .toUpperCase();
                          }
                        },
                        formFieldController: signUpSecondNameController,
                        formFieldTextType: TextInputType.name,
                        formFieldLabelText: 'Second Name',
                        formFieldPrefixIcon: Icons.supervised_user_circle,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ReusableFormField(
                  formFieldValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email must not be empty'.toUpperCase();
                    }
                    if (!validateEmail(value)) {
                      return 'please enter valid email format'.toUpperCase();
                    }
                    return null;
                  },
                  formFieldController: signUpEmailController,
                  formFieldTextType: TextInputType.emailAddress,
                  formFieldLabelText: 'Email',
                  formFieldPrefixIcon: Icons.email,
                ),
                const SizedBox(
                  height: 30,
                ),
                ReusableFormField(
                    isPassword: isPassword,
                    fieldMaxLines: 1,
                    formFieldValidator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty'.toUpperCase();
                      }
                      if (!validatePassword(value)) {
                        return 'must be at least 8 characters\nat least 1 capital Letter\nat least 1 small Letter\nat least 1 special character \nand at least 1 number'
                            .toUpperCase();
                      }
                    },
                    formFieldController: signUpPasswordController,
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
                    }),
                const SizedBox(
                  height: 30,
                ),
                ReusableFormField(
                    isPassword: isPassword,
                    fieldMaxLines: 1,
                    formFieldValidator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm Password must not be empty'
                            .toUpperCase();
                      }
                    },
                    formFieldController: signUpConfirmPasswordController,
                    formFieldTextType: TextInputType.visiblePassword,
                    formFieldLabelText: 'Confirm Password',
                    formFieldPrefixIcon: Icons.lock,
                    formFieldSuffixIcon: isPassword
                        ? Icons.remove_red_eye
                        : Icons.visibility_off,
                    formFieldSuffixIconPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    }),
                const SizedBox(
                  height: 30,
                ),
                ReusableButton(
                  buttonWidth: double.infinity,
                  buttonText: 'Sign Up',
                  buttonBackgroundColor: Colors.blue,
                  buttonOnPressed: () {
                    signUp();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
