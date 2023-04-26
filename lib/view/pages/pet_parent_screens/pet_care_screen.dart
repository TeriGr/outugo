import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/core/models/normal_models.dart';
import 'package:outugo_flutter_mobile/view/components/detail_view.dart';
import 'package:outugo_flutter_mobile/view/components/pet_detail_card.dart';
import 'package:outugo_flutter_mobile/view/components/visit_tabs.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';
import 'package:outugo_flutter_mobile/view/widgets/pet_care_alert.dart';

class PetCareScreen extends StatefulWidget {
  PetCareScreen({super.key});

  @override
  State<PetCareScreen> createState() => _PetCareScreenState();
}

class _PetCareScreenState extends State<PetCareScreen> {
  HomeController controller = Get.find();

  late PetDetail petDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    petDetail = controller.petDetails.first;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 10),
          CustomContainerTabs(
            titles: controller.petDetails.map((e) => e.Name!).toList(),
            onTabSelected: (value) {
              setState(() {
                petDetail = controller.petDetails[value];
              });
            },
            width: Get.width * 0.8,
          ),
          PetDetailCard(pet: petDetail),
          if (petDetail.IsSpecialNeeds != null &&
              petDetail.IsSpecialNeeds == "true")
            PetCareAlert(title: petDetail.SpecialNeedsDesc ?? ''),
          Column(
            children: [
              DetailView(
                title: 'visit summary',
                details: petDetail.getVisitSummaryData(),
              ),
              DetailView(
                title: 'behavior',
                details: petDetail.getBehaviorData(),
              ),
              DetailView(
                title: "visit routine",
                details: petDetail.getVisitRoutineData(),
              ),
              DetailView(
                title: "food & treats",
                details: petDetail.getFoodTreatData(),
              ),
              DetailView(
                title: "medication",
                details: petDetail.getMedicationData(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
