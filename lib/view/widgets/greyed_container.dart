import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';

class GreyedContainer extends StatelessWidget {
  GreyedContainer({super.key});

  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 90,
      decoration: BoxDecoration(
        color: AppTheme.buttonColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 4,
          ),
          Text(
            'Remaining',
            style: AppTheme.textBodyStyle().copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Obx(
            () => Text(
              printDuration(homeController.durationRemaining),
              style: AppTheme.titleStyle().copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'Visit Ends At:',
            style: AppTheme.textBodyStyle().copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            DateFormat('hh:mm')
                .format(homeController.selectedInProgressActivity.endTime!),
            style: AppTheme.titleStyle().copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
