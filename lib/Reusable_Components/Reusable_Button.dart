import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final double buttonHeight = 50;
  final double buttonWidth;
  final String buttonText;
  final Color buttonBackgroundColor;
  final Color buttonTextColor = Colors.white;
  final VoidCallback buttonOnPressed;

  const ReusableButton(
      {Key? key,
      required this.buttonWidth,
      required this.buttonText,
      required this.buttonBackgroundColor,
      required this.buttonOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: buttonBackgroundColor,
      ),
      width: buttonWidth,
      height: buttonHeight,
      child: MaterialButton(
        child: Text(
          buttonText,
          style: TextStyle(
              color: buttonTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        onPressed: buttonOnPressed,
      ),
    );
  }
}
