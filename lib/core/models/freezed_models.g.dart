// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezed_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      userId: json['userId'] as int?,
      userFirstName: json['userFirstName'] as String?,
      userLastName: json['userLastName'] as String?,
      password: json['password'] as String?,
      userEmail: json['userEmail'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      externalId: json['externalId'] as String?,
      employeePreferredName: json['employeePreferredName'] as String?,
      recordID: json['recordID'] as String?,
      userName: json['userName'] as String?,
      profilePic: json['profilePic'] as String?,
      visitsAppURL: json['visitsAppURL'] as String?,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userFirstName': instance.userFirstName,
      'userLastName': instance.userLastName,
      'password': instance.password,
      'userEmail': instance.userEmail,
      'mobileNumber': instance.mobileNumber,
      'externalId': instance.externalId,
      'employeePreferredName': instance.employeePreferredName,
      'recordID': instance.recordID,
      'userName': instance.userName,
      'profilePic': instance.profilePic,
      'visitsAppURL': instance.visitsAppURL,
    };

_$_UserToLogin _$$_UserToLoginFromJson(Map<String, dynamic> json) =>
    _$_UserToLogin(
      userName: json['userName'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$$_UserToLoginToJson(_$_UserToLogin instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
    };

_$_StartActivityPayload _$$_StartActivityPayloadFromJson(
        Map<String, dynamic> json) =>
    _$_StartActivityPayload(
      customerEmail: json['customerEmail'] as String,
      customerMobile: json['customerMobile'] as String,
      customerName: json['customerName'] as String,
      dueDateStart: json['dueDateStart'] as String,
      dueDateEnd: json['dueDateEnd'] as String,
      entityRecordID: json['entityRecordID'] as String,
      gpsCheckInExceptionDistance:
          json['gpsCheckInExceptionDistance'] as String,
      gpscheckInException: json['gpscheckInException'] as bool,
      loggedUserName: json['loggedUserName'] as String,
      ougAppStart: json['ougAppStart'] as int,
      missedVisitWindow: json['missedVisitWindow'] as bool,
      ougVisitLength: json['ougVisitLength'] as String,
      petId: json['petId'] as String,
      petNamesOUG: json['petNamesOUG'] as String,
      recordID: json['recordID'] as String,
      shipAddressAddr2: json['shipAddressAddr2'] as String,
      shipAddressAddr3: json['shipAddressAddr3'] as String,
      shipAddressCity: json['shipAddressCity'] as String,
      shipAddressPostalCode: json['shipAddressPostalCode'] as String,
      shipAddressState: json['shipAddressState'] as String,
      visitType: json['visitType'] as String,
      visitTypeRecordID: json['visitTypeRecordID'] as String,
    );

Map<String, dynamic> _$$_StartActivityPayloadToJson(
        _$_StartActivityPayload instance) =>
    <String, dynamic>{
      'customerEmail': instance.customerEmail,
      'customerMobile': instance.customerMobile,
      'customerName': instance.customerName,
      'dueDateStart': instance.dueDateStart,
      'dueDateEnd': instance.dueDateEnd,
      'entityRecordID': instance.entityRecordID,
      'gpsCheckInExceptionDistance': instance.gpsCheckInExceptionDistance,
      'gpscheckInException': instance.gpscheckInException,
      'loggedUserName': instance.loggedUserName,
      'ougAppStart': instance.ougAppStart,
      'missedVisitWindow': instance.missedVisitWindow,
      'ougVisitLength': instance.ougVisitLength,
      'petId': instance.petId,
      'petNamesOUG': instance.petNamesOUG,
      'recordID': instance.recordID,
      'shipAddressAddr2': instance.shipAddressAddr2,
      'shipAddressAddr3': instance.shipAddressAddr3,
      'shipAddressCity': instance.shipAddressCity,
      'shipAddressPostalCode': instance.shipAddressPostalCode,
      'shipAddressState': instance.shipAddressState,
      'visitType': instance.visitType,
      'visitTypeRecordID': instance.visitTypeRecordID,
    };

_$_EndActivityPayload _$$_EndActivityPayloadFromJson(
        Map<String, dynamic> json) =>
    _$_EndActivityPayload(
      activityStatus: json['activityStatus'] as String,
      gpsCoordinatesList: json['gpsCoordinatesList'] as List<dynamic>,
      lastModifiedByAppTimestamp: json['lastModifiedByAppTimestamp'] as int,
      ougAppActualVisitDuration: json['ougAppActualVisitDuration'] as String,
      ougAppEnd: json['ougAppEnd'] as int,
      ougAppVisit: json['ougAppVisit'] as String,
      typeMessage: json['typeMessage'] as String,
      shortenedVisit: json['shortenedVisit'] as bool,
    );

Map<String, dynamic> _$$_EndActivityPayloadToJson(
        _$_EndActivityPayload instance) =>
    <String, dynamic>{
      'activityStatus': instance.activityStatus,
      'gpsCoordinatesList': instance.gpsCoordinatesList,
      'lastModifiedByAppTimestamp': instance.lastModifiedByAppTimestamp,
      'ougAppActualVisitDuration': instance.ougAppActualVisitDuration,
      'ougAppEnd': instance.ougAppEnd,
      'ougAppVisit': instance.ougAppVisit,
      'typeMessage': instance.typeMessage,
      'shortenedVisit': instance.shortenedVisit,
    };
