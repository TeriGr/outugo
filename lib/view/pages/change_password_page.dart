import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/view/components/page_with_appbar.dart';
import 'package:outugo_flutter_mobile/view/widgets/custom_button.dart';
import 'package:outugo_flutter_mobile/view/widgets/custom_field.dart';

import '../components/oug_dialog.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PageWithAppBar(
      title: "Change Password",
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
        ),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          CustomField(
            hint: "Old Password",
            obscure: true,
            icon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            controller: oldPasswordController,
          ),
          CustomField(
            hint: "New Password",
            obscure: true,
            icon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            controller: newPasswordController,
          ),
          CustomField(
            hint: "Confirm New Password",
            obscure: true,
            icon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            controller: confirmNewPasswordController,
          ),
          SizedBox(
            height: 20,
          ),
          CustomButton(
              title: "Change Password",
              onPressed: () {
                if (oldPasswordController.text.isNotEmpty &&
                    newPasswordController.text.isNotEmpty &&
                    confirmNewPasswordController.text.isNotEmpty) {
                } else if (newPasswordController.text !=
                    confirmNewPasswordController.text) {
                  Get.dialog(OUGDialog(
                    type: AlertDialogType.ERROR,
                    content:
                        'New password and confirm new password must be same.',
                  ));
                } else {
                  Get.dialog(OUGDialog(
                    type: AlertDialogType.ERROR,
                    content: 'Please fill necessary fields.',
                  ));
                }
              })
        ]),
      ),
    );
  }
}
