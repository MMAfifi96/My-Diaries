import 'package:flutter/material.dart';

class ReusableFormField extends StatelessWidget {
  final TextEditingController formFieldController;
  final TextInputType formFieldTextType;
  final void Function(String?)? formFieldOnSubmitted;
  final void Function(String?)? formFieldOnChanged;
  final FormFieldValidator<String>? formFieldValidator;
  final String formFieldLabelText;
  final IconData formFieldPrefixIcon;
  final IconData? formFieldSuffixIcon;
  final String? hintName;
  final double? fieldHeight;
  final double? fieldWidth;
  final int? fieldMinLines;
  final int? fieldMaxLines;
  final bool isPassword ;
  final VoidCallback? formFieldSuffixIconPressed;
  final VoidCallback? formFieldOnTap;
  const ReusableFormField({
    Key? key,
    required this.formFieldController,
    required this.formFieldTextType,
    this.formFieldValidator,
    required this.formFieldLabelText,
    required this.formFieldPrefixIcon,
    this.fieldHeight,
    this.formFieldSuffixIcon,
    this.hintName,
    this.isPassword = false,
    this.fieldWidth,
    this.fieldMinLines,
    this.fieldMaxLines,
    this.formFieldSuffixIconPressed,
    this.formFieldOnTap,
    this.formFieldOnSubmitted,
    this.formFieldOnChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: fieldHeight,
      width: fieldWidth,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: formFieldLabelText,
          hintText: hintName,
          prefixIcon: Icon(formFieldPrefixIcon),
          suffixIcon: formFieldSuffixIcon != null
              ? GestureDetector(
                  onTap: formFieldSuffixIconPressed,
                  child: Icon(formFieldSuffixIcon),
                )
              : null,
          border: const OutlineInputBorder(),
        ),
        obscureText: isPassword,
        validator: formFieldValidator,
        controller: formFieldController,
        keyboardType: formFieldTextType,
        onFieldSubmitted: formFieldOnSubmitted,
        onChanged: formFieldOnChanged,
        onTap: formFieldOnTap,
        minLines: fieldMinLines,
        maxLines: fieldMaxLines,
      ),
    );
  }
}
