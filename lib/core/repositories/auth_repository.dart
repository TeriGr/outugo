import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:outugo_flutter_mobile/core/models/freezed_models.dart';
import 'package:outugo_flutter_mobile/core/models/normal_models.dart';
import 'package:outugo_flutter_mobile/core/services/api/api_client.dart';
import 'package:outugo_flutter_mobile/core/services/api/method_crm_manager.dart';
import 'package:outugo_flutter_mobile/utils/enums.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:xml/xml.dart';

class AuthRepository {
  final ApiClient apiClient;
  final MethodCRMManager methodCRMManager;

  AuthRepository({required this.apiClient, required this.methodCRMManager});

  GetStorage box = GetStorage();

  Future<XMLUser?> login(UserToLogin payload) async {
    try {
      final response = await apiClient.request(
          requestType: RequestType.post,
          path: 'users/userlogin',
          data: payload.toJson());
      if (response['success'] == true) {
        var user = UserModel.fromJson(response['data']);
        return await methodCRMManager
            .getUserDetail(username: user.userName!)
            .then((value) async {
          if (value != null) {
            if (value.IsActive == 'true' &&
                value.EmployeeIsOUGRestrictMobileAccess == 'false') {
              await loadTenant(value.TenantID!);
              box.write('xmlUser', value.toJson());
              box.write('user', user.toJson());
              return value;
            } else {
              toast("Error", "You are not allowed to login");
              return null;
            }
          } else {
            toast("Error", "Could not get user details");
            return null;
          }
        });
      } else {
        toast("Error", response["message"]);
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool> logout() async {
    try {
      box.erase();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<Tenant?> loadTenant(String id) async {
    try {
      await methodCRMManager.getTenantDetail(tenantID: id).then((value) {
        if (value != null) {
          box.write('tenant', value.toJson());
          return value;
        } else {
          toast("Error", "Could not get tenant details");
          return null;
        }
      });
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  XMLUser? getXMLUser() {
    if (box.hasData('xmlUser')) return XMLUser.fromJson(box.read('xmlUser'));
    return null;
  }

  UserModel? getUser() {
    if (box.hasData('user')) return UserModel.fromJson(box.read('user'));
    return null;
  }

  Tenant? getTenantUser() {
    if (box.hasData('tenant')) return Tenant.fromJson(box.read('tenant'));
    return null;
  }
}
