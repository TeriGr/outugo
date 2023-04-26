import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/utils/enums.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/components/custom_app_bar.dart';
import 'package:outugo_flutter_mobile/view/components/map/custom_map.dart';
import 'package:outugo_flutter_mobile/view/components/notes_view_popup.dart';
import 'package:outugo_flutter_mobile/view/components/ongoing_visit_details.dart';
import 'package:outugo_flutter_mobile/view/components/visit_detail_card.dart';
import 'package:outugo_flutter_mobile/view/components/visit_started_options.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';
import 'package:outugo_flutter_mobile/view/widgets/ModalProgressHUD.dart';
import 'package:outugo_flutter_mobile/view/widgets/blue_container.dart';
import 'package:outugo_flutter_mobile/view/widgets/custom_button.dart';

class VisitDetailPage extends StatefulWidget {
  const VisitDetailPage({super.key});

  @override
  State<VisitDetailPage> createState() => _VisitDetailPageState();
}

class _VisitDetailPageState extends State<VisitDetailPage> {
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          CustomMap(
            isDetail: true,
          ),
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
                InProgressActivityStatus.started) {
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Instructions for Today's Visit",
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
                    ),
                  ),
                  Obx(
                    () => CustomButton(
                        title: homeController.selectedActivityStatus ==
                                InProgressActivityStatus.empty
                            ? "I'm Here"
                            : homeController.selectedActivityStatus ==
                                    InProgressActivityStatus.started
                                ? "I'm Done"
                                : "Completed",
                        onPressed: () {
                          log(homeController.selectedInProgressActivity.status
                              .toString());
                          if (homeController
                                  .selectedInProgressActivity.status ==
                              InProgressActivityStatus.empty) {
                            homeController.startActivity();
                          } else if (homeController
                                  .selectedInProgressActivity.status ==
                              InProgressActivityStatus.started) {
                            homeController.completeActivity();
                          }
                        }),
                  )
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
          Obx(
            () {
              if (homeController.selectedActivityStatus ==
                  InProgressActivityStatus.started) {
                return Positioned(
                    bottom: 10,
                    left: 10,
                    child: FloatingActionButton(
                      heroTag: 'note',
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        Get.dialog(NotesViewPopup(
                          title: 'Report Card for Pet Parent',
                          buttonLabel: 'Save',
                          clickEvent: (value) {
                            homeController.selectedInProgressActivity
                                .noteForCustomer = value;
                            homeController.reportCardSummary.value = value;
                          },
                          text: homeController
                                  .selectedInProgressActivity.noteForCustomer ??
                              '',
                        ));
                      },
                      child: Icon(Icons.note_add),
                    ));
              } else {
                return Container();
              }
            },
          ),
          Obx(() => ModalProgressHUD(
              inAsyncCall: homeController.status.isLoading,
              child: const SizedBox()))
        ],
      ),
    ));
  }
}
