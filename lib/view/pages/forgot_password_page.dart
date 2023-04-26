import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/utils/constants/asset_constants/image_constants.dart';
import 'package:outugo_flutter_mobile/view/components/oug_dialog.dart';
import 'package:outugo_flutter_mobile/view/components/page_with_appbar.dart';
import 'package:outugo_flutter_mobile/view/widgets/custom_button.dart';
import 'package:outugo_flutter_mobile/view/widgets/custom_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PageWithAppBar(
        title: "Forgot Password",
        leftIcon: Icons.chevron_left,
        leftIconOnPressed: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              ImageConstants.logo,
              height: 60,
            ),
            SizedBox(
              height: 20,
            ),
            CustomField(
              hint: "Username",
              obscure: false,
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              controller: usernameController,
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
                title: "Get New Password",
                onPressed: () {
                  if (usernameController.text.isNotEmpty) {
                  } else {
                    Get.dialog(OUGDialog(
                      type: AlertDialogType.ERROR,
                      content: 'Please fill necessary fields.',
                    ));
                  }
                })
          ]),
        ));
  }
}
