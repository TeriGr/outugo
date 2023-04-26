import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/utils/constants/asset_constants/image_constants.dart';
import 'package:outugo_flutter_mobile/view/controllers/auth_controller.dart';

class UserAvatarCard extends StatelessWidget {
  UserAvatarCard({super.key});

  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage(
              ImageConstants.userPhotoHolder,
            ),
            radius: 35,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authController.user.UserName ?? '',
                style: AppTheme.title16black600(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "\"Out-U-Go\" ${authController.tenant.name}",
                style: AppTheme.detail14black400(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
