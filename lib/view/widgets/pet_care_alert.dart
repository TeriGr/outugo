import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';

class PetCareAlert extends StatelessWidget {
  const PetCareAlert({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      padding: EdgeInsets.all(8),
      color: Colors.red,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning,
            size: 25,
            color: Colors.white,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            softWrap: true,
            style: AppTheme.titleStyle().copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
