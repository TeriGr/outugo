import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/shared/routes/app_routes.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/view/components/user_avatar_card.dart';
import 'package:outugo_flutter_mobile/view/controllers/auth_controller.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            UserAvatarCard(),
            SizedBox(
              height: 15,
            ),
            listItem(
              Icons.home,
              "My Visits",
              onTap: () {
                Get.offAndToNamed(AppRoutes.homePage);
              },
            ),
            listItem(Icons.person, "Edit Profile", onTap: () {
              Get.offAndToNamed(AppRoutes.editprofilePage);
            }),
            listItem(Icons.lock, "Change Password", onTap: () {
              Get.offAndToNamed(AppRoutes.changePasswordPage);
            }),
            listItem(Icons.language, "Classic Checkin System", onTap: () {
              Get.offAndToNamed(AppRoutes.classicCheckinPage);
            }),
            listItem(Icons.help, "Resources", onTap: () {
              Get.offAndToNamed(AppRoutes.resourcesPage);
            }),
            listItem(Icons.logout, "Logout", onTap: () {
              authController.logout();
            }),
            SizedBox(
              height: 15,
            ),
            Text(
              "Version 1.0.0",
              style: AppTheme.detail14black400(),
            )
          ],
        ),
      ),
    );
  }

  Widget listItem(IconData iconData, String title, {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppTheme.grey, width: 0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: AppTheme.largeTitleStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
