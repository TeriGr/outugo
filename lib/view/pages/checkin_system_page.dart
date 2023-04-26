import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/view/components/oug_web_view.dart';
import 'package:outugo_flutter_mobile/view/components/page_with_appbar.dart';
import 'package:outugo_flutter_mobile/view/controllers/auth_controller.dart';

class CheckinSystemPage extends StatelessWidget {
  const CheckinSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWithAppBar(
        title: "Classic Check-In System",
        child: OUGWebView(
          url: Get.find<AuthController>().userModel.visitsAppURL!,
        ));
  }
}
