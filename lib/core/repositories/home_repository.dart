// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:outugo_flutter_mobile/core/models/freezed_models.dart';
import 'package:outugo_flutter_mobile/core/models/normal_models.dart';
import 'package:outugo_flutter_mobile/core/repositories/auth_repository.dart';
import 'package:outugo_flutter_mobile/core/services/api/api_client.dart';
import 'package:outugo_flutter_mobile/core/services/api/method_crm_manager.dart';
import 'package:outugo_flutter_mobile/utils/enums.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';

class HomeRepostiory {
  final ApiClient apiClient;
  final MethodCRMManager methodCRMManager;

  HomeRepostiory({required this.apiClient, required this.methodCRMManager});

  GetStorage storage = GetStorage();
  Future<List<Activity>?> getActivities(DateTime forDate, String id) async {
    try {
      final response = await methodCRMManager.getAllActivitiesForDate(
          date: forDate, recordID: id);

      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<PetParentData?> getPetParentData(
      {required String customerId, required String petId}) async {
    try {
      var customer =
          await methodCRMManager.getCustomerDetail(customerID: customerId);
      var petDetails = await methodCRMManager.getPetDetail(petID: petId);
      return PetParentData(customer: customer!, petDetails: petDetails!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> startVisit(
      StartActivityModel payload, StartActivityPayload data) async {
    try {
      return await methodCRMManager
          .updateIAmHereStatus(payload: payload)
          .then((value) async {
        if (value) {
          var response = await apiClient.request(
              requestType: RequestType.post,
              path: 'activity/iamHere',
              data: data.toJson());
          log(response.toString());
          return response['success'] ? response['data'] : null;
        }
        return null;
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> endVisit(
      EndActivityModel payload, EndActivityPayload data) async {
    try {
      return await methodCRMManager
          .updatedIAmDoneStatus(payload: payload)
          .then((value) async {
        if (value) {
          var response = await apiClient.request(
              requestType: RequestType.post,
              path: 'activity/iamHere',
              data: data.toJson());
          log(response.toString());
          return true;
        }
        return false;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> uploadImage({
    required String userId,
    required File body,
  }) async {
    try {
      return await apiClient.uploadImage(
          'activity/uploadImage/?userId=${userId}', body, '');
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<dynamic> uploadActivityImage({
    required String recordId,
    required String userId,
    required File body,
    bool isMapImage = false,
  }) async {
    return await apiClient.uploadImage(
      'activity/uploadImage/?userId=${userId}&internalActivityId=${recordId}',
      body,
      isMapImage ? '_map' : '_image',
    );
  }

  Future<bool> sendSummary(
    InProgressActivity inProgressActivity,
  ) async {
    var status = getSummaryStatuses(inProgressActivity);
    bool success = await methodCRMManager.sendSummary(
      activityID: inProgressActivity.activity!.RecordID!,
      sitterComments: inProgressActivity.noteForOffice ?? '',
      emailBody: inProgressActivity.noteForCustomer ?? '',
      hashCode: inProgressActivity.uniqueId!,
      isConfirmed: status.first == 1,
    );

    log('sendSummary: $success');

    if (success) {
      AuthRepository authRepository = Get.find();
      var body = <String, dynamic>{
        "activityStatus": 3, //data.ActivityStatus_RecordID,
        "lastModifiedByAppTimestamp": DateTime.now().millisecondsSinceEpoch,
        "typeMessage": inProgressActivity.noteForOffice ?? '',
        "notificationMessage": inProgressActivity.noteForCustomer,
        "visitNotificationType": status.elementAt(1),
        "visitSummaryNeedToSend": status.last == 1,
        "replyTo": authRepository.getTenantUser()!.defaultEmailAddress,
      };

      try {
        final response = await apiClient.request(
            requestType: RequestType.post,
            path:
                'activity/sendSummary?internalActivityId=${inProgressActivity.internalJobID}',
            data: body);
        return response['success'];
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Set<int> getSummaryStatuses(InProgressActivity inProgressActivity) {
    int shouldSendNotification = 0;
    int isConfirmed = 0;

    var visitNotificationType = 0;
    if (inProgressActivity.activity!.IsEntitySendVisitCompleteNotification! ==
        "true") {
      shouldSendNotification = 1;
      if (inProgressActivity.activity!.CustomerSendNotificationVia! ==
          "SMS and Email") {
        visitNotificationType = 3;
        if (inProgressActivity.activity!.EntityEmail!.isNotEmpty &&
            inProgressActivity.activity!.EntityPhone!.isNotEmpty) {
          isConfirmed = 1;
        }
      } else if (inProgressActivity.activity!.CustomerSendNotificationVia! ==
          "SMS") {
        visitNotificationType = 1;
        if (inProgressActivity.activity!.EntityPhone!.isNotEmpty) {
          isConfirmed = 1;
        }
      } else if (inProgressActivity.activity!.CustomerSendNotificationVia ==
          "Email") {
        visitNotificationType = 0;
        if (inProgressActivity.activity!.EntityEmail!.isNotEmpty) {
          isConfirmed = 1;
        }
      }
    }

    return {isConfirmed, shouldSendNotification, visitNotificationType};
  }

  saveSession(SessionModel sessionModel) {
    storage.write('session', sessionModel.toJson());
  }

  getSession() {
    return storage.read('session');
  }

  savethis(List<LatLng> locationData) {
    storage.remove('location');
    storage.write('location', locationData);
  }

  List<LatLng> getthis() {
    return storage.read('location');
  }

  sendHouseSittingFinalContactPP(
      InProgressActivity inProgressActivity, int distance) async {
    bool isGPSCheckInException = distance > 150;
    return await methodCRMManager.sendHouseSittingFinalContactedPP(
      activityID: inProgressActivity.activity!.RecordID!,
      dateTime: DateTime.now(),
      isGPSCheckInException: isGPSCheckInException,
      gpsCheckInExceptionDistance: distance.toString(),
      sitterComments: "", //widget.inProgressActivity.notesForOffice,
      emailBody: "", //widget.inProgressActivity.notesForCustomer,
      hashCode: "", //widget.inProgressActivity.uniqueId,
    );
  }

  Future<bool> sendHouseSittingFinalSummary(
      InProgressActivity inProgressActivity, int distance) async {
    bool isGPSCheckInException = distance > 150;
    return await methodCRMManager.sendHouseSittingFinalSummary(
      activityID: inProgressActivity.activity!.RecordID!,
      dateTime: DateTime.now(),
      isGPSCheckInException: isGPSCheckInException,
      gpsCheckInExceptionDistance: distance.toString(),
      sitterComments: "", //widget.inProgressActivity.notesForOffice,
      emailBody: "", //widget.inProgressActivity.notesForCustomer,
      hashCode: "", //wi
    );
  }

  Future<bool> sendHouseSittingSummary(
      InProgressActivity inProgressActivity, int distance) async {
    bool isGPSCheckInException = distance > 150;
    return await methodCRMManager.sendHouseSittingSummary(
      activityID: inProgressActivity.activity!.RecordID!,
      dateTime: DateTime.now(),
      isGPSCheckInException: isGPSCheckInException,
      gpsCheckInExceptionDistance: distance.toString(),
      sitterComments: "", //widget.inProgressActivity.notesForOffice,
      emailBody: "", //widget.inProgressActivity.notesForCustomer,
      hashCode: "", //wi
    );
  }
}
