import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/core/models/normal_models.dart';
import 'package:outugo_flutter_mobile/shared/routes/app_routes.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';

class VisitDetailCard extends StatelessWidget {
  VisitDetailCard({super.key, required this.activity, this.isStarted = false});

  final Activity activity;
  final bool isStarted;

  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.selectedActivity.RecordID == activity.RecordID
            ? activity.VisitType_RecordID == "1" ||
                    activity.VisitType_RecordID == "7"
                ? Get.toNamed(AppRoutes.homeDetailPage)
                : Get.toNamed(AppRoutes.visitDetailPage)
            : homeController.setSelectedActivity(activity);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: isStarted ? AppTheme.primaryColor.withAlpha(30) : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: Get.width * 0.12,
                  height: Get.width * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Get.width * 0.12 / 2),
                    border: Border.all(
                      color: AppTheme.buttonColor,
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: Get.width * 0.12 - 5,
                      height: Get.width * 0.12 - 5,
                      decoration: BoxDecoration(
                        color: AppTheme.buttonColor,
                        borderRadius:
                            BorderRadius.circular((Get.width * 0.12 - 5) / 2),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          activity.OUGVisitLength ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: AppTheme.subHeadlineStyle()
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Text("MIN"),
              ],
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * 0.8,
                  child: Text(
                    activity.PetNamesOUG!,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.subHeadlineStyle(),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 15,
                      color: AppTheme.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(activity.getVisitTimeRange()),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 15,
                      color: AppTheme.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(activity.getFormattedAddress()),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.vpn_key,
                          size: 15,
                          color: AppTheme.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(activity.KeyTagOUG ?? "No key available"),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.pets,
                          size: 15,
                          color: AppTheme.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(activity.VisitType ?? ""),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
