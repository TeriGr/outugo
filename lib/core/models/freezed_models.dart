import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:outugo_flutter_mobile/core/models/normal_models.dart';

part 'freezed_models.freezed.dart';
part 'freezed_models.g.dart';

/// helper functions
String? _toString(dynamic val) {
  if (val == null) {
    return null;
  }
  if (val is String) {
    if (val.isEmpty) return null;
    return val;
  }
  if (val is List<dynamic>) {
    return val.map((e) => "$e").toList().join("\n");
  }
  return val.toString();
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
      {int? userId,
      String? userFirstName,
      String? userLastName,
      String? password,
      String? userEmail,
      String? mobileNumber,
      String? externalId,
      String? employeePreferredName,
      String? recordID,
      String? userName,
      String? profilePic,
      String? visitsAppURL}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class UserToLogin with _$UserToLogin {
  const factory UserToLogin({
    String? userName,
    String? password,
  }) = _UserToLogin;

  factory UserToLogin.fromJson(Map<String, dynamic> json) =>
      _$UserToLoginFromJson(json);
}

@freezed
class StartActivityPayload with _$StartActivityPayload {
  const factory StartActivityPayload({
    required String customerEmail,
    required String customerMobile,
    required String customerName,
    required String dueDateStart,
    //Expecting String
    required String dueDateEnd,
    //Expecting String
    required String entityRecordID,
    required String gpsCheckInExceptionDistance,
    //Expecting Double
    required bool gpscheckInException,
    required String loggedUserName,
    required int ougAppStart,
    //Expecting Date and Time
    required bool missedVisitWindow,
    //activeJob.isMissedVisitWindow,
    required String ougVisitLength,
    required String petId,
    required String petNamesOUG,
    required String recordID,
    required String shipAddressAddr2,
    required String shipAddressAddr3,
    required String shipAddressCity,
    required String shipAddressPostalCode,
    required String shipAddressState,
    required String visitType,
    required String visitTypeRecordID,
  }) = _StartActivityPayload;

  factory StartActivityPayload.fromJson(Map<String, dynamic> json) =>
      _$StartActivityPayloadFromJson(json);
}

@freezed
class EndActivityPayload with _$EndActivityPayload {
  const factory EndActivityPayload({
    required String activityStatus,
    required List<dynamic> gpsCoordinatesList,
    required int lastModifiedByAppTimestamp,
    required String ougAppActualVisitDuration, // should be in minutes
    required int ougAppEnd,
    required String ougAppVisit,
    required String typeMessage,
    required bool shortenedVisit,
  }) = _EndActivityPayload;

  factory EndActivityPayload.fromJson(Map<String, dynamic> json) =>
      _$EndActivityPayloadFromJson(json);
}
