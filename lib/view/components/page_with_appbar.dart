import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/utils/constants/asset_constants/image_constants.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/components/custom_app_bar.dart';
import 'package:outugo_flutter_mobile/view/components/custom_drawer.dart';

class PageWithAppBar extends StatelessWidget {
  PageWithAppBar(
      {super.key,
      required this.title,
      required this.child,
      this.leftIcon,
      this.leftIconOnPressed,
      this.hasCallButton = false});

  final Widget child;
  final String title;
  final IconData? leftIcon;
  final bool hasCallButton;
  final Function()? leftIconOnPressed;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(title,
              style:
                  AppTheme.subHeadlineStyle().copyWith(color: AppTheme.black)),
          leading: IconButton(
            icon: Icon(
              leftIcon ?? Icons.menu,
              color: AppTheme.black,
            ),
            onPressed: () {
              leftIconOnPressed != null
                  ? leftIconOnPressed!()
                  : _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        drawer: CustomDrawer(),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(ImageConstants.background),
              fit: BoxFit.cover,
            )),
            child: child),
        floatingActionButton: hasCallButton
            ? FloatingActionButton(
                backgroundColor: AppTheme.secondaryButtonColor,
                onPressed: () {
                  showCallPopup(context);
                },
                child: Icon(Icons.tty),
              )
            : null);
  }
}
