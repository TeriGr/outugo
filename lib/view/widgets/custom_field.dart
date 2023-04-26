import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';

class CustomField extends StatelessWidget {
  final String? hint;
  final bool? obscure;
  final Icon? icon;
  final validator;
  final onSaved;
  final controller;
  final bool readOnly;
  final String initialValue;
  final TextInputType keyboardType;

  CustomField(
      {this.hint,
      this.obscure = false,
      this.icon,
      this.validator,
      this.onSaved,
      this.keyboardType = TextInputType.emailAddress,
      this.readOnly = false,
      this.initialValue = "",
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: AppTheme.dividerColor,
          ),
        ),
      ),
      child: TextFormField(
        obscureText: obscure!,
        validator: validator,
        controller: controller,
        keyboardAppearance: Brightness.dark,
        keyboardType: keyboardType,
        readOnly: readOnly,
        autocorrect: false,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          icon: icon,
          border: InputBorder.none,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          contentPadding: const EdgeInsets.only(
            top: 20.0,
            right: 45.0,
            bottom: 15.0,
            left: 5.0,
          ),
        ),
      ),
    );
  }
}
