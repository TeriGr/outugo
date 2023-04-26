import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/utils/enums.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';
import 'package:outugo_flutter_mobile/view/widgets/greyed_container.dart';

class OnGoingVisitTimeDuration extends StatelessWidget {
  OnGoingVisitTimeDuration({super.key});

  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (homeController.selectedActivityStatus ==
            InProgressActivityStatus.started) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GreyedContainer(),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      width: 90,
                      decoration: BoxDecoration(
                        color: AppTheme.buttonColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "${(homeController.distanceTravelled.value / 1.60934).round()} Miles",
                        style: AppTheme.titleStyle().copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      width: 90,
                      decoration: BoxDecoration(
                        color: AppTheme.buttonColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Obx(
                        () => Text(
                          "${homeController.minutesSpent.value} Mins",
                          style: AppTheme.titleStyle().copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
