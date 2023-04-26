import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/core/repositories/home_repository.dart';
import 'package:outugo_flutter_mobile/core/services/location_service.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LocationService>(LocationService());
    Get.put<HomeRepostiory>(
        HomeRepostiory(apiClient: Get.find(), methodCRMManager: Get.find()));
    Get.put<HomeController>(HomeController(
        homeRepostiory: Get.find(), locationService: Get.find()));
  }
}
