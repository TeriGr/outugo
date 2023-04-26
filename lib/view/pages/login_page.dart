import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/shared/routes/app_routes.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/utils/constants/asset_constants/image_constants.dart';
import 'package:outugo_flutter_mobile/view/components/oug_dialog.dart';
import 'package:outugo_flutter_mobile/view/controllers/auth_controller.dart';
import 'package:outugo_flutter_mobile/view/widgets/ModalProgressHUD.dart';
import 'package:outugo_flutter_mobile/view/widgets/custom_button.dart';
import 'package:outugo_flutter_mobile/view/widgets/custom_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(ImageConstants.background),
              fit: BoxFit.cover,
            )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Image.asset(ImageConstants.logo),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Staff Login",
                  ),
                  CustomField(
                    hint: "Username",
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    controller: usernameController,
                  ),
                  CustomField(
                    hint: "Password",
                    obscure: true,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    controller: passwordController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      title: "Login",
                      onPressed: () {
                        if (usernameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          // Get.toNamed(AppRoutes.homePage);
                          authController.login(
                            // userName: 'Alysel', password: 'asdf'
                            userName: usernameController.text,
                            password: passwordController.text,
                          );
                        } else {
                          Get.dialog(OUGDialog(
                            type: AlertDialogType.ERROR,
                            content: "Please fill necessary fields",
                            title: "Error",
                            clickEvent: () {
                              Navigator.pop(context);
                            },
                          ));
                        }
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.signUpPage);
                        },
                        child: Text(
                          "Sign Up",
                          style: AppTheme.title16black600(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.forgotPasswordPage);
                    },
                    child: Text(
                      "Forgot Password?",
                      style: AppTheme.title16black600().copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() => ModalProgressHUD(
              inAsyncCall: authController.status.isLoading, child: SizedBox()))
        ],
      ),
    );
  }
}
