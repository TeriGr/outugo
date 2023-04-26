import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/core/repositories/auth_repository.dart';
import 'package:outugo_flutter_mobile/core/services/api/api_client.dart';
import 'package:outugo_flutter_mobile/core/services/api/method_crm_manager.dart';
import 'package:outugo_flutter_mobile/view/controllers/auth_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dio(), fenix: true);
    Get.lazyPut(() => Connectivity(), fenix: true);
    Get.lazyPut(() => ApiClient(dio: Get.find(), connectivity: Get.find()),
        fenix: true);
    Get.lazyPut(() => MethodCRMManager(apiClient: Get.find()), fenix: true);
    Get.put<AuthRepository>(
        AuthRepository(apiClient: Get.find(), methodCRMManager: Get.find()));
    Get.put<AuthController>(AuthController(authRepository: Get.find()));
  }
}
