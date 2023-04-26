import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/view/components/map/custom_map.dart';
import 'package:outugo_flutter_mobile/view/components/page_with_appbar.dart';
import 'package:outugo_flutter_mobile/view/components/visit_detail_card.dart';
import 'package:outugo_flutter_mobile/view/components/visit_tabs.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';
import 'package:outugo_flutter_mobile/view/widgets/ModalProgressHUD.dart';

import '../../shared/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _tabController = TabController(length: 2, vsync: this);
    });
  }

  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageWithAppBar(
          title: "My Visits",
          hasCallButton: true,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 30)),
                          lastDate: DateTime.now().add(Duration(days: 2 * 30)),
                        ).then((value) {
                          if (value != null) {
                            homeController.selectedDate.value = value;
                            homeController.getActivities();
                          }
                        });
                      },
                      child: Column(
                        children: [
                          Icon(Icons.event),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() => Text(
                              DateFormat.MMMd()
                                  .format(homeController.selectedDate.value),
                              style: AppTheme.subTitleBoldStyle())),
                        ],
                      ),
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          CustomContainerTabs(
                            titles: ["List", "Map"],
                            onTabSelected: (value) {
                              _tabController.index = value;
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => Text(
                              "(${homeController.activities.length} visit)",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Obx(
                          () => CupertinoSwitch(
                            value: homeController.completSwitchValue.value,
                            onChanged: (value) {
                              homeController.completSwitchValue.value = value;
                              homeController.filterCompleted();
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Completed", style: AppTheme.subTitleBoldStyle()),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 1,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    Obx(() {
                      // if (homeController.status.isLoading) {
                      //   return Center(child: CircularProgressIndicator());
                      // }
                      if (homeController.activitiesToShow.length == 0) {
                        return Center(child: Text("No data"));
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            await homeController.getActivities();
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return VisitDetailCard(
                                activity:
                                    homeController.activitiesToShow[index],
                                isStarted:
                                    homeController.selectedItemIndex == index,
                              );
                            },
                            itemCount: homeController.activitiesToShow.length,
                          ),
                        );
                      }
                    }),
                    CustomMap(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Obx(() => ModalProgressHUD(
            inAsyncCall: homeController.status.isLoading,
            child: const SizedBox()))
      ],
    );
  }
}
