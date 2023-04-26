import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.leftIcon,
    this.leftIconOnPressed,
    this.rightIcon,
    this.extra,
  });
  final IconData? leftIcon;
  final Function()? leftIconOnPressed;
  final List<Widget>? rightIcon;
  final Widget? extra;

  final String title;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: AppTheme.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leftIcon != null
                    ? IconButton(
                        icon: Icon(
                          leftIcon,
                          color: AppTheme.buttonColor,
                          size: 30,
                        ),
                        onPressed: leftIconOnPressed,
                      )
                    : SizedBox(
                        width: 20,
                      ),
                Text(title, style: AppTheme.subHeadlineStyle()),
                rightIcon != null
                    ? Row(
                        children: rightIcon!,
                      )
                    : SizedBox(
                        width: 20,
                      ),
              ],
            ),
            SizedBox(height: 10),
            extra != null ? extra! : Container(),
          ],
        ),
      ),
    );
  }
}
