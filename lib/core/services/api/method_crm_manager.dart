import 'dart:async';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:outugo_flutter_mobile/core/models/normal_models.dart';
import 'package:outugo_flutter_mobile/core/services/api/api_client.dart';
import 'package:outugo_flutter_mobile/utils/constants/data_constants/api_constants.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:xml/xml.dart';

class MethodCRMManager {
  final ApiClient apiClient;
  MethodCRMManager({
    required this.apiClient,
  });
  Future<XMLUser?> getUserDetail({
    required String username,
  }) async {
    String tableName = 'Users';
    String fields =
        'EmployeeFirstName,Email,EmployeeIsOUGRestrictMobileAccess,EmployeePreferredName,EmployeeLastName,RecordID,IsActive,TenantID,TenantName,Phone,UserEmail,UserName,OUGVisitsAppURL';
    String whereClause = "(TenantID>0)AND(UserName='$username')";

    var params = _prepareGetParams(
      tableName: tableName,
      fields: fields,
      whereClause: whereClause,
    );
    try {
      return await apiClient.getCrm(params).then((value) {
        String parseResponse = parseHtmlString(value);
        var responseXML = XmlDocument.parse(parseResponse);
        return XMLUser.fromXML(responseXML.findAllElements('Record').first);
      });
    } catch (err) {
      log(err.toString());
      return null;
    }
  }

  Future<List<Activity>?> getAllActivitiesForDate({
    required DateTime date,
    bool showCompleted = false,
    required String recordID,
  }) async {
    String tableName = 'Activity';
    String fields =
        'EntityCompanyName,Entity,RecordID,DueDateStart,DueDateEnd,OUGVisitLength,PetNamesOUG,KeyTagOUG,VisitType,EntityEmail,EntityPhone,VisitType_RecordID,ShipAddressAddr2,ShipAddressAddr3,ShipAddressCity,ShipAddressState,ShipAddressPostalCode,Comments,WorkOrderInstructions,CustomerLatitudeOUG,CustomerLongitudeOUG, ActivityStatus, ActivityStatus_RecordID, Entity_RecordID,SortOrder,IsEntitySendVisitCompleteNotification,CustomerSendNotificationVia,OUGAppStart,OUGAppEnd,RefNumber';
    String whereClause;
    String orderBy = 'SortOrder';

    String userRecordID = recordID;
    var fromDateString = DateFormat('yyyy-MM-dd').format(date);
    fromDateString += "T06:59:00";

    DateTime toDate = date.add(Duration(days: 1, hours: 1));
    var toDateString = DateFormat('yyyy-MM-dd').format(toDate);
    toDateString += "T07:01:00";

    //TODO: Mohit - Save today's activities into DB
    //const isToday = isDateToday(fromDateString);

    if (showCompleted) {
      whereClause =
          "(TenantID>0)AND(AssignedTo_RecordID=$userRecordID)AND(DueDateStart>'$fromDateString') AND (DueDateStart < '$toDateString')"
          " AND (ActivityStatus_RecordID = 3) AND ActivityType_RecordID = 7"
          " AND (RecurrenceType != 'Series')";
    } else {
      whereClause =
          "(TenantID>0)AND(AssignedTo_RecordID=$userRecordID)AND(DueDateStart>'$fromDateString') AND (DueDateStart < '$toDateString')"
          " AND (ActivityStatus_RecordID = 11 OR ActivityStatus_RecordID = 2 OR ActivityStatus_RecordID = 14) AND ActivityType_RecordID = 7"
          " AND (RecurrenceType != 'Series')";
    }

    var params = _prepareGetParams(
      tableName: tableName,
      fields: fields,
      whereClause: whereClause,
      orderBy: orderBy,
    );
    try {
      return await apiClient.getCrm(params).then((value) {
        String parseResponse = parseHtmlString(value);
        var responseXML = XmlDocument.parse(parseResponse);
        var activities = responseXML.findAllElements('Record');
        List<Activity> activityList = [];
        activities.forEach((activity) {
          activityList.add(Activity.fromXML(activity));
        });
        return activityList;
      });
    } catch (err) {
      log(err.toString());
      return null;
    }
  }

  Future<Tenant?> getTenantDetail({
    required String tenantID,
  }) async {
    String tableName = 'Tenant';
    String fields =
        'RecordID,Name,DefaultEmailAddress,SitterSupportPhoneNumber,TimeZoneOffset';
    String whereClause = 'RecordID=$tenantID';

    var params = _prepareGetParams(
      tableName: tableName,
      fields: fields,
      whereClause: whereClause,
    );

    try {
      return await apiClient.getCrm(params).then((value) {
        String parseResponse = parseHtmlString(value);
        var responseXML = XmlDocument.parse(parseResponse);
        return Tenant.fromXML(responseXML.findAllElements('Record').first);
      });
    } catch (err) {
      return null;
    }
  }

  Future<Customer?> getCustomerDetail({
    required String customerID,
  }) async {
    String tableName = 'Customer';
    String fields =
        'OUGPetNames, OUGAlarmLocation, OUGAlarmDisarmCode, OUGAlarmArmCode, OUGEntryDoor, OUGLockInfo, OUGDirections, OUGParkingInstructions, OUGPetCardLocation, OUGCleaningSupplyLocation, OUGCleaningNotes, OUGMailLightsNotes, OUGPlantNotes, OUGHouseNotes';
    String whereClause = "(TenantID>0)AND(RecordID='$customerID')";

    var params = _prepareGetParams(
      tableName: tableName,
      fields: fields,
      whereClause: whereClause,
    );

    try {
      return await apiClient.getCrm(params).then((value) {
        String parseResponse = parseHtmlString(value);
        var responseXML = XmlDocument.parse(parseResponse);
        return Customer.fromXML(responseXML.findAllElements('Record').first);
      });
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<List<PetDetail>?> getPetDetail({
    required String petID,
  }) async {
    String tableName = 'OUGPet';
    String fields =
        'Name,Photo,OUGPetGender,Breed,OUGPetType,BirthDate,ColorMarking,IsSpecialNeeds,SpecialNeedsDesc,WalkRoutine,BehaviorDesc,HealthDesc,OUGPetLocation,PetLocationDesc,LeashLocation,LitterboxLocation,LitterboxNotes,IsOUGTreatsOK,TreatsLocation,FoodSchedule,FoodLocation,FoodBowlLocation,FoodServingSize,FoodNotes,IsMedicationAdministered,MedicationAmount,MedicationLocation,MedicationMethod';
    String whereClause = "(TenantID>0)AND(Customer_RecordID='$petID')";

    var params = _prepareGetParams(
      tableName: tableName,
      fields: fields,
      whereClause: whereClause,
    );

    try {
      return await apiClient.getCrm(params).then((value) {
        String parseResponse = parseHtmlString(value);
        var responseXML = XmlDocument.parse(parseResponse);
        var pets = responseXML.findAllElements('Record');
        List<PetDetail> petList = [];
        pets.forEach((pet) {
          petList.add(PetDetail.fromXML(pet));
        });
        return petList;
      });
    } catch (err) {
      print(err);
      return null;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<bool> updateIAmHereStatus(
      {required StartActivityModel payload}) async {
    DateTime currentDateTime = DateTime.now();

    // 1		Not Started		(Not Visible in Visit List)
    // 6		Cancelled		(Not Visible in Visit List)
    // 11		Sent to Sitter		(Visible on Visit List - No Shaded Background)
    // 2		In Progress		(Visible on Visit List - Light Blue Shaded Background)
    // 14		Pending Notification(Visible on Visit List - Light Red Shaded Background)
    // 3		Completed		(Visible on Completed Visit List - No Shaded Background)

    String tableName = 'Activity';
    List<String> fields = [
      "ActivityStatus_RecordID",
      "OUGAppStart",
      "IsGPSCheckInException",
      "GPSCheckInExceptionDistance",
      "isMissedVisitWindow",
      "LastModifiedByAppTimestamp",
    ];
    List values = [
      "2",
      _convertToMethodCRMDate(currentDateTime),
      payload.isGPSCheckInException,
      payload.gpsCheckInExceptionDistance,
      payload.isMissedVisitWindow,
      _convertToMethodCRMDate(currentDateTime),
    ];

    var params = _prepareUpdateParams(
      tableName: tableName,
      recordID: payload.activityID,
      fields: fields,
      values: values,
    );

    try {
      return await apiClient.updateCrm(params).then((value) {
        log(value.toString());
        return true;
      }).catchError((err) {
        log(err.toString());
        return false;
      });
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> updatedIAmDoneStatus({required EndActivityModel payload}) async {
    DateTime currentDateTime = DateTime.now();

    String tableName = 'Activity';
    List<String> fields = [
      "ActivityStatus_RecordID",
      "OUGAppEnd",
      "OUGAppActualVisitDuration",
      "IsGPSCheckInException",
      "GPSCheckOutDistance",
      "isShortenedVisit",
      "TotalDistanceTraveled",
      "LastModifiedByAppTimestamp",
      // "LastVisitCompletedDate"
    ];
    List values = [
      "14",
      _convertToMethodCRMDate(payload.dateTime),
      payload.visitDuration,
      payload.isGPSCheckInException,
      payload.gpsCheckOutExceptionDistance,
      payload.isShortenedVisit,
      payload.distanceTraveled,
      _convertToMethodCRMDate(currentDateTime),
      // _convertToMethodCRMDate(currentDateTime),
    ];

    var params = _prepareUpdateParams(
      tableName: tableName,
      recordID: payload.activityID,
      fields: fields,
      values: values,
    );

    try {
      return await apiClient.updateCrm(params).then((value) {
        log(value.toString());
        return true;
      }).catchError((err) {
        log(err.toString());
        return false;
      });
    } catch (err) {
      print(err);
      return false;
    }
  }

  /* Methods */

  Map<String, dynamic> _prepareGetParams({
    required String tableName,
    required String fields,
    String? whereClause,
    String? orderBy,
  }) {
    return {
      "strCompanyAccount": kMethodCRMCompanyAccount,
      "strLogin": kMethodCRMLogin,
      "strPassword": kMethodCRMPassword,
      "strSessionID": "",
      "strTable": tableName,
      "strFields": fields,
      "strWhereClause": whereClause ?? "",
      "strGroupByClause": "",
      "strHaving": "",
      "strOrderBy": orderBy ?? "",
    };
  }

  Map<String, dynamic> _prepareUpdateParams({
    required String tableName,
    required String recordID,
    required List<String> fields,
    required List values,
  }) {
    return {
      "strCompanyAccount": kMethodCRMCompanyAccount,
      "strLogin": kMethodCRMLogin,
      "strPassword": kMethodCRMPassword,
      "strSessionID": "",
      "strTable": tableName,
      "arrUpdateFieldsArray": fields,
      "arrUpdateValueArray": values,
      "intRecordID": recordID,
    };
  }

  String _prepareURL({
    required String baseURL,
    required dynamic params,
  }) {
    var url = baseURL + "?";
    params.forEach((key, value) {
      if (value is List) {
        value.forEach((element) {
          url += "&$key=$element";
        });
      } else {
        url += "&$key=$value";
      }
    });
    return url;
  }

  String _convertToMethodCRMDate(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy HH:mm:ss').format(dateTime.toUtc());
  }

  Future<bool> sendSummary({
    required String activityID,
    required String sitterComments,
    required String emailBody,
    required String hashCode,
    bool isConfirmed = false,
    //bool isMeetAndGreet = false,
  }) async {
    DateTime currentDateTime = DateTime.now();

    String updatedComment = sitterComments;
    String updatedEmailBody = emailBody;

    if (updatedComment != null && updatedComment.length > 0) {
      updatedComment = updatedComment.trim();
      updatedComment = updatedComment.replaceAll("#", "");
    }

    if (updatedEmailBody != null && updatedEmailBody.length > 0) {
      updatedEmailBody = updatedEmailBody.trim();
      updatedEmailBody = updatedEmailBody.replaceAll("#", "");
    }

    String tableName = 'Activity';
    List<String> fields = [
      "ActivityStatus_RecordID",
      "SitterComments",
      "EmailBody",
      "RefNumber",
      "IsConfirmed",
      "LastModifiedByAppTimestamp",
    ];
    List values = [
      "3",
      updatedComment,
      updatedEmailBody,
      hashCode,
      isConfirmed,
      _convertToMethodCRMDate(currentDateTime),
    ];

    var url = _prepareUpdateParams(
      tableName: tableName,
      recordID: activityID,
      fields: fields,
      values: values,
    );
    try {
      return await apiClient.updateCrm(url).then((value) {
        String parseResponse = parseHtmlString(value);
        var responseXML = XmlDocument.parse(parseResponse);
        var activities = responseXML.findAllElements('Record');
        List<Activity> activityList = [];
        activities.forEach((activity) {
          activityList.add(Activity.fromXML(activity));
        });
        return true;
      });
    } catch (err) {
      log(err.toString());
    }
    return false;
  }

  Future<bool> sendHouseSittingSummary({
    required String activityID,
    required DateTime dateTime,
    bool isGPSCheckInException = false,
    String gpsCheckInExceptionDistance = "0",
    bool isMissedVisitWindow = false,
    required String sitterComments,
    required String emailBody,
    required String hashCode,
    //bool isMeetAndGreet = false,
  }) async {
    DateTime currentDateTime = DateTime.now();

    String tableName = 'Activity';
    List<String> fields = [
      "ActivityStatus_RecordID",
      "OUGAppStart",
      "OUGAppEnd",
      "OUGAppActualVisitDuration",
      "IsGPSCheckInException",
      "GPSCheckInExceptionDistance",
      "isMissedVisitWindow",
      "SitterComments",
      "EmailBody",
      "RefNumber",
      "IsConfirmed",
      "LastModifiedByAppTimestamp",
    ];
    List values = [
      "3",
      _convertToMethodCRMDate(dateTime),
      _convertToMethodCRMDate(dateTime),
      "1",
      isGPSCheckInException,
      gpsCheckInExceptionDistance,
      isMissedVisitWindow,
      sitterComments,
      emailBody,
      hashCode,
      false,
      _convertToMethodCRMDate(currentDateTime),
    ];

    var params = _prepareUpdateParams(
      tableName: tableName,
      recordID: activityID,
      fields: fields,
      values: values,
    );

    try {
      return await apiClient.updateCrm(params).then((value) {
        String parseResponse = parseHtmlString(value);
        var responseXML = XmlDocument.parse(parseResponse);
        var activities = responseXML.findAllElements('Record');
        List<Activity> activityList = [];
        activities.forEach((activity) {
          activityList.add(Activity.fromXML(activity));
        });
        return true;
      });
    } catch (err) {
      log(err.toString());
      return false;
    }
  }

  Future<bool> sendHouseSittingFinalContactedPP({
    required String activityID,
    required DateTime dateTime,
    bool isGPSCheckInException = false,
    String gpsCheckInExceptionDistance = "0",
    bool isMissedVisitWindow = false,
    required String sitterComments,
    required String emailBody,
    required String hashCode,
    //bool isMeetAndGreet = false,
  }) async {
    DateTime currentDateTime = DateTime.now();

    String tableName = 'Activity';
    List<String> fields = [
      "OUGAppStart",
      "OUGAppActualVisitDuration",
      "IsGPSCheckInException",
      "GPSCheckInExceptionDistance",
      "LastModifiedByAppTimestamp",
    ];
    List values = [
      _convertToMethodCRMDate(dateTime),
      "1",
      isGPSCheckInException,
      gpsCheckInExceptionDistance,
      _convertToMethodCRMDate(currentDateTime),
    ];

    var params = _prepareUpdateParams(
      tableName: tableName,
      recordID: activityID,
      fields: fields,
      values: values,
    );

    try {
      return await apiClient.updateCrm(params).then((value) {
        String parseResponse = parseHtmlString(value);
        var responseXML = XmlDocument.parse(parseResponse);
        var activities = responseXML.findAllElements('Record');
        List<Activity> activityList = [];
        activities.forEach((activity) {
          activityList.add(Activity.fromXML(activity));
        });
        return true;
      });
    } catch (err) {
      log(err.toString());
      return false;
    }
  }

  Future<bool> sendHouseSittingFinalSummary({
    required String activityID,
    required DateTime dateTime,
    bool isGPSCheckInException = false,
    String gpsCheckInExceptionDistance = "0",
    bool isMissedVisitWindow = false,
    required String sitterComments,
    required String emailBody,
    required String hashCode,
    //bool isMeetAndGreet = false,
  }) async {
    DateTime currentDateTime = DateTime.now();

    String tableName = 'Activity';
    List<String> fields = [
      "ActivityStatus_RecordID",
      "OUGAppEnd",
      "IsGPSCheckInException",
      "GPSCheckOutDistance",
      "LastModifiedByAppTimestamp",
    ];
    List values = [
      "3",
      _convertToMethodCRMDate(dateTime),
      isGPSCheckInException,
      gpsCheckInExceptionDistance,
      _convertToMethodCRMDate(currentDateTime),
    ];

    var params = _prepareUpdateParams(
      tableName: tableName,
      recordID: activityID,
      fields: fields,
      values: values,
    );

    try {
      return await apiClient.updateCrm(params).then((value) {
        log(value.toString());
        return true;
      }).catchError((err) {
        log(err.toString());
        return false;
      });
    } catch (err) {
      print(err);
      return false;
    }
  }
}
