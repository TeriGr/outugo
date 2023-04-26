import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';

//TODO: MOHIT - Cleanup this class

class CustomButton extends StatelessWidget {
  final String title;
  final bool? obscure;
  final Icon? icon;
  final validator;
  final onSaved;
  final controller;
  final TextInputType keyboardType;
  final VoidCallback onPressed;

  CustomButton({
    required this.title,
    required this.onPressed,
    this.obscure,
    this.icon,
    this.validator,
    this.onSaved,
    this.keyboardType = TextInputType.emailAddress,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: 35.0,
        decoration: BoxDecoration(
          color: AppTheme.primaryButtonColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            this.title,
            style: AppTheme.subTitleBoldStyle()
                .merge(TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
