import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/components/image_source_sheet.dart';
import 'package:outugo_flutter_mobile/view/components/page_with_appbar.dart';
import 'package:outugo_flutter_mobile/view/components/profile_tile.dart';
import 'package:outugo_flutter_mobile/view/controllers/auth_controller.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return PageWithAppBar(
      title: "Edit Profile",
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
              ),
              CircleAvatar(
                radius: 50,
              ),
              IconButton(
                  onPressed: () {
                    Get.bottomSheet(ImageSourceSheet(onImageSelected: (source) {
                      takePhoto(source);
                    }));
                  },
                  icon: Icon(Icons.add_a_photo))
            ],
          ),
          SizedBox(
            height: 60,
          ),
          ProfileTile(
            title: "NAME",
            subTitle:
                '${authController.userModel.userFirstName ?? ''} ${authController.userModel.userLastName}',
          ),
          ProfileTile(
            title: "USERNAME",
            subTitle: authController.user.UserName ?? '',
          ),
          ProfileTile(
            title: "EMAIL",
            subTitle: authController.user.Email ?? '',
          ),
          ProfileTile(
            title: "PHONE",
            subTitle: authController.user.Phone ?? '',
          ),
        ],
      ),
    );
  }
}
