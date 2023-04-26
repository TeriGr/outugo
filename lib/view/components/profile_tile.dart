import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String subTitle;
  ProfileTile({
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: 1),
      child: Container(
        height: deviceSize.height * 0.088,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]!,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: 5.0, top: 6.0, right: 16.0, bottom: 6.0),
              // child: Image.asset(iconPath),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 8.0,
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style: AppTheme.title16black600(),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(subTitle, style: AppTheme.titleStyle()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
