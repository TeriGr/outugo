import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/utils/enums.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/components/custom_app_bar.dart';
import 'package:outugo_flutter_mobile/view/components/notes_view_popup.dart';
import 'package:outugo_flutter_mobile/view/components/page_with_appbar.dart';
import 'package:outugo_flutter_mobile/view/components/visit_detail_card.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';
import 'package:outugo_flutter_mobile/view/widgets/ModalProgressHUD.dart';
import 'package:outugo_flutter_mobile/view/widgets/blue_container.dart';
import 'package:outugo_flutter_mobile/view/widgets/custom_button.dart';

class HomeVisitDetailPage extends StatefulWidget {
  const HomeVisitDetailPage({super.key});

  @override
  State<HomeVisitDetailPage> createState() => _HomeVisitDetailPageState();
}

class _HomeVisitDetailPageState extends State<HomeVisitDetailPage> {
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                CustomAppBar(
                  title: 'Visit Detail',
                  leftIcon: Icons.chevron_left,
                  leftIconOnPressed: () {
                    Get.back();
                  },
                  rightIcon: [
                    IconButton(
                      icon: Icon(
                        Icons.description,
                        color: AppTheme.black,
                        size: 32,
                      ),
                      onPressed: () {
                        homeController.getPetParentData();
                      },
                    ),
                  ],
                ),
                if (homeController.selectedActivity.Entity != null)
                  BlueContainer(title: homeController.selectedActivity.Entity!),
                VisitDetailCard(
                  activity: homeController.selectedActivity,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.0,
                        ),
                      ),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "House Sitting Notes",
                            style: AppTheme.subHeadlineStyle(),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            homeController
                                    .selectedActivity.WorkOrderInstructions ??
                                '',
                            style: AppTheme.titleStyle(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => homeController.selectedInProgressActivity
                                    .activity!.ActivityStatus_RecordID !=
                                "3"
                            ? CustomButton(
                                title: "I Contacted PP's",
                                onPressed: () {
                                  if (homeController.selectedInProgressActivity
                                          .activity!.VisitType_RecordID ==
                                      "7") {
                                    homeController.houseSittingFinalContactPP();
                                  } else {
                                    homeController.houseSittingSendSummary();
                                  }
                                })
                            : SizedBox(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => homeController.selectedInProgressActivity
                                    .activity!.ActivityStatus_RecordID !=
                                "10"
                            ? Column(children: [
                                Text(
                                  homeController.selectedInProgressActivity
                                              .activity!.VisitType_RecordID ==
                                          "7"
                                      ? 'Contacted PP\'s at:'
                                      : 'Reported Pet Parent Check In Time:',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  homeController.houseCheckinTime.value,
                                  textAlign: TextAlign.start,
                                  style: AppTheme.titleStyle()
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ])
                            : SizedBox(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() => homeController.selectedInProgressActivity
                                  .activity!.VisitType_RecordID ==
                              "7"
                          ? Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.22,
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: AppTheme.dividerColor,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Final Check Out',
                                        textAlign: TextAlign.center,
                                        style: AppTheme.subHeadlineStyle(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Bathroom - Tidy\n'
                                        'Kitchen - Tidy\n'
                                        'Sleeping Area - Tidy\n'
                                        'Personal Item - Collect',
                                        textAlign: TextAlign.center,
                                        style: AppTheme.titleStyle(),
                                      ),
                                    ],
                                  ),
                                ),
                                if (homeController.selectedInProgressActivity
                                        .activity!.ActivityStatus_RecordID !=
                                    "3")
                                  CustomButton(
                                    title: 'I\'m Leaving',
                                    onPressed: () {
                                      homeController
                                          .houseSittingFinalSendSumary();
                                    },
                                  ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'I Left At:',
                                  textAlign: TextAlign.start,
                                  style: AppTheme.titleStyle(),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  homeController.houseLeftTime.value,
                                  textAlign: TextAlign.start,
                                  style: AppTheme.titleStyle()
                                      .copyWith(fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          : SizedBox())
                    ],
                  ),
                ),
              ],
            ),
            Obx(() => ModalProgressHUD(
                inAsyncCall: homeController.status.isLoading,
                child: const SizedBox()))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'call',
        backgroundColor: AppTheme.secondaryButtonColor,
        onPressed: () {
          showCallPopup(context);
        },
        child: Icon(Icons.tty),
      ),
    );
  }
}
