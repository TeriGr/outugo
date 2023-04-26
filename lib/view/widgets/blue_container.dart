import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';

class BlueContainer extends StatelessWidget {
  const BlueContainer({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.listHeaderColor,
        width: Get.width,
        padding: EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Center(
          child: Text(
            title.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: AppTheme.titleStyle()
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
