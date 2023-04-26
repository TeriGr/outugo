import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/view/components/detail_view.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';

class HomeAccessScreen extends StatelessWidget {
  HomeAccessScreen({super.key});

  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailView(
          title: "ALARM",
          details: controller.customer.getAlarmData(),
        ),
        DetailView(
          title: "Doors",
          details: controller.customer.getDoorsData(),
        ),
        DetailView(
          title: "Directions & parking",
          details: controller.customer.getDirectionsParkingData(),
        ),
      ],
    );
  }
}
