import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/shared/routes/app_routes.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/utils/enums.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/components/custom_app_bar.dart';
import 'package:outugo_flutter_mobile/view/components/map/custom_map.dart';
import 'package:outugo_flutter_mobile/view/components/notes_view_popup.dart';
import 'package:outugo_flutter_mobile/view/components/ongoing_visit_details.dart';
import 'package:outugo_flutter_mobile/view/components/oug_dialog.dart';
import 'package:outugo_flutter_mobile/view/components/visit_detail_card.dart';
import 'package:outugo_flutter_mobile/view/components/visit_started_options.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';
import 'package:outugo_flutter_mobile/view/widgets/ModalProgressHUD.dart';
import 'package:outugo_flutter_mobile/view/widgets/blue_container.dart';
import 'package:outugo_flutter_mobile/view/widgets/custom_button.dart';
import 'package:outugo_flutter_mobile/view/widgets/greyed_container.dart';

class VisitSummaryPage extends StatefulWidget {
  const VisitSummaryPage({super.key});

  @override
  State<VisitSummaryPage> createState() => _VisitSummaryPageState();
}

class _VisitSummaryPageState extends State<VisitSummaryPage> {
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            child:
                Image.memory(homeController.screenshotImage, fit: BoxFit.cover),
          ),
          Column(
            children: [
              CustomAppBar(
                title: 'Visit Summary',
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
              if (homeController.selectedActivity.Comments != null)
                BlueContainer(title: homeController.selectedActivity.Comments!),
              SizedBox(
                height: 10,
              ),
              OnGoingVisitTimeDuration()
            ],
          ),
          Obx(() {
            if (homeController.selectedActivityStatus ==
                InProgressActivityStatus.completed) {
              return Positioned(
                  bottom: Get.height * 0.26, child: VisitStartedOptions());
            } else {
              return Container();
            }
          }),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: Get.height * 0.25,
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              margin: EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              width: 34,
                              height: 34,
                              child: Icon(
                                Icons.grading,
                                size: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Report Card Summary',
                              textAlign: TextAlign.start,
                              style: AppTheme.subHeadlineStyle(),
                            ),
                          ],
                        ),
                        onTap: () {
                          Get.dialog(NotesViewPopup(
                            title: 'Report Card for Pet Parent',
                            buttonLabel: 'Save',
                            clickEvent: (value) {
                              homeController.selectedInProgressActivity
                                  .noteForCustomer = value;
                              homeController.reportCardSummary.value = value;
                            },
                            text: homeController.selectedInProgressActivity
                                    .noteForCustomer ??
                                '',
                          ));
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() => SizedBox(
                            height: Get.height * 0.13,
                            child: SingleChildScrollView(
                              child: Text(
                                homeController.reportCardSummary.value,
                              ),
                            ),
                          ))
                    ],
                  ),
                  CustomButton(
                      title: "Send Summary",
                      onPressed: () {
                        if (homeController.selectedInProgressActivity
                                    .noteForCustomer ==
                                null ||
                            homeController.selectedInProgressActivity
                                .noteForCustomer!.isEmpty) {
                          Get.dialog(OUGDialog(
                            type: AlertDialogType.ERROR,
                            title: 'Please add a note for Customer',
                            buttonLabel: 'Ok',
                            content: 'Please add a note for Customer',
                          ));
                        } else {
                          homeController.sendVisitSummary();
                        }
                      }),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: FloatingActionButton(
                heroTag: 'call',
                backgroundColor: AppTheme.secondaryButtonColor,
                onPressed: () {
                  showCallPopup(context);
                },
                child: Icon(Icons.tty),
              )),
          Obx(() => ModalProgressHUD(
              inAsyncCall: homeController.status.isLoading,
              child: const SizedBox()))
        ],
      ),
    ));
  }
}
