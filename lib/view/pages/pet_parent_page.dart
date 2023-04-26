import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/view/components/custom_app_bar.dart';
import 'package:outugo_flutter_mobile/view/pages/pet_parent_screens/home_access_screen.dart';
import 'package:outugo_flutter_mobile/view/pages/pet_parent_screens/home_care_screen.dart';
import 'package:outugo_flutter_mobile/view/pages/pet_parent_screens/pet_care_screen.dart';
import 'package:outugo_flutter_mobile/view/widgets/blue_container.dart';

class PetParentNotesPage extends StatefulWidget {
  const PetParentNotesPage({super.key});

  @override
  State<PetParentNotesPage> createState() => _PetParentNotesPageState();
}

class _PetParentNotesPageState extends State<PetParentNotesPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // a scaffold with custom app bar of title "Pet Parent Notes" and a left icon of close and leftIconPressed to pop the page, a body of tabs with 3 tabs each with a row of Icon and Text as Tabs, the three tabs are a lock Icon with text "Home Access", a dog feet Icon with text "Pet Care" and a Home Icon with text "Home Care", The body of the tabs are empty containers with a text "Coming Soon". Active tab has a color of AppTheme.primaryColor and inactive tab has a color of AppTheme.grey
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pet Parent Notes',
          style: AppTheme.subHeadlineStyle().copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: Colors.grey[400],
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          tabs: [
            Tab(
              height: 52,
              child: Column(
                children: const [
                  Icon(Icons.lock),
                  SizedBox(height: 10),
                  Text("Home Access"),
                ],
              ),
            ),
            Tab(
              height: 52,
              child: Column(
                children: const [
                  Icon(Icons.pets),
                  SizedBox(height: 10),
                  Text("Pet Care"),
                ],
              ),
            ),
            Tab(
              height: 52,
              child: Column(
                children: const [
                  Icon(Icons.home),
                  SizedBox(height: 10),
                  Text("Home Care"),
                ],
              ),
            ),
          ],
        ),
      ),
      // body: Column(children: [
      // CustomAppBar(
      //   title: "Pet Parent Notes",
      //   leftIcon: Icons.close,
      //   leftIconOnPressed: () => Get.back(),
      //   extra: TabBar(
      //     controller: _tabController,
      //     labelColor: AppTheme.primaryColor,
      //     unselectedLabelColor: Colors.grey[400],
      //     padding: const EdgeInsets.symmetric(
      //       vertical: 5,
      //     ),
      //     tabs: [
      //       Tab(
      //         height: 52,
      //         child: Column(
      //           children: const [
      //             Icon(Icons.lock),
      //             SizedBox(height: 10),
      //             Text("Home Access"),
      //           ],
      //         ),
      //       ),
      //       Tab(
      //         height: 52,
      //         child: Column(
      //           children: const [
      //             Icon(Icons.pets),
      //             SizedBox(height: 10),
      //             Text("Pet Care"),
      //           ],
      //         ),
      //       ),
      //       Tab(
      //         height: 52,
      //         child: Column(
      //           children: const [
      //             Icon(Icons.home),
      //             SizedBox(height: 10),
      //             Text("Home Care"),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      // Expanded(
      body: TabBarView(
        controller: _tabController,
        children: [HomeAccessScreen(), PetCareScreen(), HomeCareScreen()],
      ),
      // ),
      // ]),
    );
  }
}
