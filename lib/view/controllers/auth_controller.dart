import 'dart:developer';

import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/core/models/freezed_models.dart';
import 'package:outugo_flutter_mobile/core/models/normal_models.dart';
import 'package:outugo_flutter_mobile/core/repositories/auth_repository.dart';
import 'package:outugo_flutter_mobile/shared/routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;

  AuthController({
    required this.authRepository,
  });

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getXmlUser();
    getTenant();
  }

  final _status = RxStatus.empty().obs;
  RxStatus get status => _status.value;
  set status(RxStatus value) {
    _status.value = value;
  }

  final _user = XMLUser().obs;
  XMLUser get user => _user.value;
  set user(XMLUser value) {
    _user.value = value;
  }

  final _userModel = UserModel().obs;
  UserModel get userModel => _userModel.value;
  set userModel(UserModel value) {
    _userModel.value = value;
  }

  final _tenant = Tenant().obs;
  Tenant get tenant => _tenant.value;
  set tenant(Tenant value) {
    _tenant.value = value;
  }

  Future<void> login(
      {required String userName, required String password}) async {
    status = RxStatus.loading();
    try {
      await authRepository
          .login(UserToLogin(userName: userName, password: password))
          .then((value) {
        if (value != null) {
          user = value;
          getTenant();
          status = RxStatus.success();
          Get.toNamed(AppRoutes.homePage);
        } else {
          status = RxStatus.error();
        }
      });
    } catch (e) {
      status = RxStatus.error();
    }
  }

  getXmlUser() {
    var data = authRepository.getXMLUser();
    if (data != null) {
      user = data;
    }
  }

  getUserModel() {
    var data = authRepository.getUser();
    if (data != null) {
      userModel = data;
    }
  }

  getTenant() async {
    var data = authRepository.getTenantUser();
    if (data != null) {
      tenant = data;
    }
  }

  logout() {
    authRepository.logout();
    Get.offAndToNamed(AppRoutes.loginPage);
  }
}
