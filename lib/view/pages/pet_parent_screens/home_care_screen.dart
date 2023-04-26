import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';

class HomeCareScreen extends StatelessWidget {
  HomeCareScreen({super.key});

  HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    var homeCareList = controller.customer.getHomeCareData();
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildNotes(
          homeCareList.keys.elementAt(index),
          homeCareList.values.elementAt(index),
        );
      },
      itemCount: homeCareList.length,
    );
  }
}
