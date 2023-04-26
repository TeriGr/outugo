import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:outugo_flutter_mobile/utils/enums.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/controllers/auth_controller.dart';
import 'package:xml/xml.dart';

class XMLUser {
  String? EmployeeFirstName;
  String? Email;
  String? EmployeeIsOUGRestrictMobileAccess;
  String? EmployeePreferredName;
  String? EmployeeLastName;
  String? RecordID;
  String? IsActive;
  String? TenantID;
  String? TenantName;
  String? Phone;
  String? UserEmail;
  String? UserName;
  String? OUGVisitsAppURL;

  XMLUser({
    this.EmployeeFirstName,
    this.Email,
    this.EmployeeIsOUGRestrictMobileAccess,
    this.EmployeePreferredName,
    this.EmployeeLastName,
    this.RecordID,
    this.IsActive,
    this.TenantID,
    this.TenantName,
    this.Phone,
    this.UserEmail,
    this.UserName,
    this.OUGVisitsAppURL,
  });

  XMLUser.fromJson(Map<String, dynamic> json) {
    EmployeeFirstName = json['EmployeeFirstName'];
    Email = json['Email'];
    EmployeeIsOUGRestrictMobileAccess =
        json['EmployeeIsOUGRestrictMobileAccess'];
    EmployeePreferredName = json['EmployeePreferredName'];
    EmployeeLastName = json['EmployeeLastName'];
    RecordID = json['RecordID'];
    IsActive = json['IsActive'];
    TenantID = json['TenantID'];
    TenantName = json['TenantName'];
    Phone = json['Phone'];
    UserEmail = json['UserEmail'];
    UserName = json['UserName'];
    OUGVisitsAppURL = json['OUGVisitsAppURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeFirstName'] = this.EmployeeFirstName;
    data['Email'] = this.Email;
    data['EmployeeIsOUGRestrictMobileAccess'] =
        this.EmployeeIsOUGRestrictMobileAccess;
    data['EmployeePreferredName'] = this.EmployeePreferredName;
    data['EmployeeLastName'] = this.EmployeeLastName;
    data['RecordID'] = this.RecordID;
    data['IsActive'] = this.IsActive;
    data['TenantID'] = this.TenantID;
    data['TenantName'] = this.TenantName;
    data['Phone'] = this.Phone;
    data['UserEmail'] = this.UserEmail;
    data['UserName'] = this.UserName;
    data['OUGVisitsAppURL'] = this.OUGVisitsAppURL;
    return data;
  }

  XMLUser.fromXML(XmlElement xml) {
    EmployeeFirstName = xml.getElement('EmployeeFirstName')?.text;
    Email = xml.getElement('Email')?.text;
    EmployeeIsOUGRestrictMobileAccess =
        xml.getElement('EmployeeIsOUGRestrictMobileAccess')?.text;
    EmployeePreferredName = xml.getElement('EmployeePreferredName')?.text;
    EmployeeLastName = xml.getElement('EmployeeLastName')?.text;
    RecordID = xml.getElement('RecordID')?.text;
    IsActive = xml.getElement('IsActive')?.text;
    TenantID = xml.getElement('TenantID')?.text;
    TenantName = xml.getElement('TenantName')?.text;
    Phone = xml.getElement('Phone')?.text;
    UserEmail = xml.getElement('UserEmail')?.text;
    UserName = xml.getElement('UserName')?.text;
    OUGVisitsAppURL = xml.getElement('OUGVisitsAppURL')?.text;
  }
}

class Activity {
  String? RecordID;
  String? EntityCompanyName;
  String? Entity;
  String? DueDateStart;
  String? DueDateEnd;
  String? OUGVisitLength;
  String? PetNamesOUG;
  String? KeyTagOUG;
  String? VisitType;
  String? EntityEmail;
  String? EntityPhone;
  String? VisitType_RecordID;
  String? ShipAddressAddr2;
  String? ShipAddressAddr3;
  String? ShipAddressCity;
  String? ShipAddressState;
  String? ShipAddressPostalCode;
  String? Comments;
  String? WorkOrderInstructions;
  String? CustomerLatitudeOUG;
  String? CustomerLongitudeOUG;
  String? ActivityStatus;
  String? ActivityStatus_RecordID;
  String? Entity_RecordID;
  String? SortOrder;
  String? IsEntitySendVisitCompleteNotification;
  String? CustomerSendNotificationVia;
  String? OUGAppStart;
  String? OUGAppEnd;
  String? RefNumber;

  Activity({
    this.EntityCompanyName,
    this.Entity,
    this.RecordID,
    this.DueDateStart,
    this.DueDateEnd,
    this.OUGVisitLength,
    this.PetNamesOUG,
    this.KeyTagOUG,
    this.VisitType,
    this.EntityEmail,
    this.EntityPhone,
    this.VisitType_RecordID,
    this.ShipAddressAddr2,
    this.ShipAddressAddr3,
    this.ShipAddressCity,
    this.ShipAddressState,
    this.ShipAddressPostalCode,
    this.Comments,
    this.WorkOrderInstructions,
    this.CustomerLatitudeOUG,
    this.CustomerLongitudeOUG,
    this.ActivityStatus,
    this.ActivityStatus_RecordID,
    this.Entity_RecordID,
    this.SortOrder,
    this.IsEntitySendVisitCompleteNotification,
    this.CustomerSendNotificationVia,
    this.OUGAppStart,
    this.OUGAppEnd,
    this.RefNumber,
  });

  factory Activity.fromXML(XmlElement xml) {
    return Activity(
      RecordID: xml.getElement('RecordID')?.text,
      EntityCompanyName: xml.getElement('EntityCompanyName')?.text,
      Entity: xml.getElement('Entity')?.text,
      DueDateStart: xml.getElement('DueDateStart')?.text,
      DueDateEnd: xml.getElement('DueDateEnd')?.text,
      OUGVisitLength: xml.getElement('OUGVisitLength')?.text,
      PetNamesOUG: xml.getElement('PetNamesOUG')?.text,
      KeyTagOUG: xml.getElement('KeyTagOUG')?.text,
      VisitType: xml.getElement('VisitType')?.text,
      EntityEmail: xml.getElement('EntityEmail')?.text,
      EntityPhone: xml.getElement('EntityPhone')?.text,
      VisitType_RecordID: xml.getElement('VisitType_RecordID')?.text,
      ShipAddressAddr2: xml.getElement('ShipAddressAddr2')?.text,
      ShipAddressAddr3: xml.getElement('ShipAddressAddr3')?.text,
      ShipAddressCity: xml.getElement('ShipAddressCity')?.text,
      ShipAddressState: xml.getElement('ShipAddressState')?.text,
      ShipAddressPostalCode: xml.getElement('ShipAddressPostalCode')?.text,
      Comments: xml.getElement('Comments')?.text,
      WorkOrderInstructions: xml.getElement('WorkOrderInstructions')?.text,
      CustomerLatitudeOUG: xml.getElement('CustomerLatitudeOUG')?.text,
      CustomerLongitudeOUG: xml.getElement('CustomerLongitudeOUG')?.text,
      ActivityStatus: xml.getElement('ActivityStatus')?.text,
      ActivityStatus_RecordID: xml.getElement('ActivityStatus_RecordID')?.text,
      Entity_RecordID: xml.getElement('Entity_RecordID')?.text,
      SortOrder: xml.getElement('SortOrder')?.text,
      IsEntitySendVisitCompleteNotification:
          xml.getElement('IsEntitySendVisitCompleteNotification')?.text,
      CustomerSendNotificationVia:
          xml.getElement('CustomerSendNotificationVia')?.text,
      OUGAppStart: xml.getElement('OUGAppStart')?.text,
      OUGAppEnd: xml.getElement('OUGAppEnd')?.text,
      RefNumber: xml.getElement('RefNumber')?.text,
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        'RecordID': RecordID,
        'EntityCompanyName': EntityCompanyName,
        'Entity': Entity,
        'DueDateStart': DueDateStart,
        'DueDateEnd': DueDateEnd,
        'OUGVisitLength': OUGVisitLength,
        'PetNamesOUG': PetNamesOUG,
        'KeyTagOUG': KeyTagOUG,
        'VisitType': VisitType,
        'EntityEmail': EntityEmail,
        'EntityPhone': EntityPhone,
        'VisitType_RecordID': VisitType_RecordID,
        'ShipAddressAddr2': ShipAddressAddr2,
        'ShipAddressAddr3': ShipAddressAddr3,
        'ShipAddressCity': ShipAddressCity,
        'ShipAddressState': ShipAddressState,
        'ShipAddressPostalCode': ShipAddressPostalCode,
        'Comments': Comments,
        'WorkOrderInstructions': WorkOrderInstructions,
        'CustomerLatitudeOUG': CustomerLatitudeOUG,
        'CustomerLongitudeOUG': CustomerLongitudeOUG,
        'ActivityStatus': ActivityStatus,
        'ActivityStatus_RecordID': ActivityStatus_RecordID,
        'Entity_RecordID': Entity_RecordID,
        'SortOrder': SortOrder,
        'IsEntitySendVisitCompleteNotification':
            IsEntitySendVisitCompleteNotification,
        'CustomerSendNotificationVia': CustomerSendNotificationVia,
        'OUGAppStart': OUGAppStart,
        'OUGAppEnd': OUGAppEnd,
        'RefNumber': RefNumber,
      };

  String getFormattedAddress() {
    List<String> components = [];
    if (ShipAddressAddr2 != null && ShipAddressAddr2!.length > 0)
      components.add(ShipAddressAddr2!);

    if (ShipAddressAddr3 != null && ShipAddressAddr3!.length > 0)
      components.add(ShipAddressAddr3!);

    if (ShipAddressCity != null && ShipAddressCity!.length > 0)
      components.add(ShipAddressCity!);

    if (ShipAddressState != null && ShipAddressState!.length > 0)
      components.add(ShipAddressState!);

//    if (ShipAddressPostalCode != null && ShipAddressPostalCode.length > 0)
//      components.add(ShipAddressPostalCode);

    return components.join(", ");
  }

  String getFormattedAddressForGeoCoding() {
    List<String> components = [];
    if (ShipAddressAddr2 != null && ShipAddressAddr2!.length > 0)
      components.add(ShipAddressAddr2!);

    // if (ShipAddressAddr3 != null && ShipAddressAddr3!.length > 0)
    //   components.add(ShipAddressAddr3!);

    if (ShipAddressCity != null && ShipAddressCity!.length > 0)
      components.add(ShipAddressCity!);

    if (ShipAddressState != null && ShipAddressState!.length > 0)
      components.add(ShipAddressState!);

    components.add('US');

//    if (ShipAddressPostalCode != null && ShipAddressPostalCode.length > 0)
//      components.add(ShipAddressPostalCode);

    return components.join(", ");
  }

  String getVisitTimeRange() {
    AuthController authController = Get.find();
    DateTime startDateTime = getDateFromServerDate(DueDateStart!);
    DateTime endDateTime = getDateFromServerDate(DueDateEnd!);

    var startDateTimeStr = DateFormat('h:mm a').format(startDateTime);
    var endDateTimeStr = DateFormat('h:mm a').format(endDateTime);

    return startDateTimeStr + " - " + endDateTimeStr;
  }
}

class Tenant {
  String? recordID;
  String? name;
  String? defaultEmailAddress;
  String? sitterSupportPhoneNumber;
  String? timeZoneOffset;

  Tenant({
    this.recordID,
    this.name,
    this.defaultEmailAddress,
    this.sitterSupportPhoneNumber,
    this.timeZoneOffset,
  });

  Map<String, dynamic> toJson() {
    return {
      'RecordID': recordID,
      'Name': name,
      'DefaultEmailAddress': defaultEmailAddress,
      'SitterSupportPhoneNumber': sitterSupportPhoneNumber,
      'TimeZoneOffset': timeZoneOffset,
    };
  }

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      recordID: json['RecordID'],
      name: json['Name'],
      defaultEmailAddress: json['DefaultEmailAddress'],
      sitterSupportPhoneNumber: json['SitterSupportPhoneNumber'],
      timeZoneOffset: json['TimeZoneOffset'],
    );
  }

  factory Tenant.fromXML(XmlElement xml) {
    return Tenant(
      recordID: xml.getElement('RecordID')?.text,
      name: xml.getElement('Name')?.text,
      defaultEmailAddress: xml.getElement('DefaultEmailAddress')?.text,
      sitterSupportPhoneNumber:
          xml.getElement('SitterSupportPhoneNumber')?.text,
      timeZoneOffset: xml.getElement('TimeZoneOffset')?.text,
    );
  }
}

class Customer {
  String? OUGPetNames;
  String? OUGAlarmLocation;
  String? OUGAlarmDisarmCode;
  String? OUGAlarmArmCode;
  String? OUGEntryDoor;
  String? OUGLockInfo;
  String? OUGDirections;
  String? OUGParkingInstructions;
  String? OUGPetCardLocation;
  String? OUGCleaningSupplyLocation;
  String? OUGCleaningNotes;
  String? OUGMailLightsNotes;
  String? OUGPlantNotes;
  String? OUGHouseNotes;

  Customer({
    this.OUGPetNames,
    this.OUGAlarmLocation,
    this.OUGAlarmDisarmCode,
    this.OUGAlarmArmCode,
    this.OUGEntryDoor,
    this.OUGLockInfo,
    this.OUGDirections,
    this.OUGParkingInstructions,
    this.OUGPetCardLocation,
    this.OUGCleaningSupplyLocation,
    this.OUGCleaningNotes,
    this.OUGMailLightsNotes,
    this.OUGPlantNotes,
    this.OUGHouseNotes,
  });

  factory Customer.fromXML(XmlElement xml) {
    return Customer(
      OUGPetNames: xml.getElement('OUGPetNames')?.text,
      OUGAlarmLocation: xml.getElement('OUGAlarmLocation')?.text,
      OUGAlarmDisarmCode: xml.getElement('OUGAlarmDisarmCode')?.text,
      OUGAlarmArmCode: xml.getElement('OUGAlarmArmCode')?.text,
      OUGEntryDoor: xml.getElement('OUGEntryDoor')?.text,
      OUGLockInfo: xml.getElement('OUGLockInfo')?.text,
      OUGDirections: xml.getElement('OUGDirections')?.text,
      OUGParkingInstructions: xml.getElement('OUGParkingInstructions')?.text,
      OUGPetCardLocation: xml.getElement('OUGPetCardLocation')?.text,
      OUGCleaningSupplyLocation:
          xml.getElement('OUGCleaningSupplyLocation')?.text,
      OUGCleaningNotes: xml.getElement('OUGCleaningNotes')?.text,
      OUGMailLightsNotes: xml.getElement('OUGMailLightsNotes')?.text,
      OUGPlantNotes: xml.getElement('OUGPlantNotes')?.text,
      OUGHouseNotes: xml.getElement('OUGHouseNotes')?.text,
    );
  }

  Map<String, String> getAlarmData() {
    Map<String, String> data = Map<String, String>();

    _addEntryIntoMap(
        key: "Alarm Location", value: this.OUGAlarmLocation, map: data);
    _addEntryIntoMap(
        key: "Disarm Code", value: this.OUGAlarmDisarmCode, map: data);
    _addEntryIntoMap(key: "Arm Code", value: this.OUGAlarmArmCode, map: data);

    return data;
  }

  Map<String, String> getDoorsData() {
    Map<String, String> data = Map<String, String>();

    _addEntryIntoMap(
        key: "Residence Entry Info", value: this.OUGEntryDoor, map: data);
    _addEntryIntoMap(
        key: "Door / Lock Info", value: this.OUGLockInfo, map: data);

    return data;
  }

  Map<String, String> getDirectionsParkingData() {
    Map<String, String> data = Map<String, String>();

    _addEntryIntoMap(key: "Directions", value: this.OUGDirections, map: data);
    _addEntryIntoMap(
        key: "Parking", value: this.OUGParkingInstructions, map: data);

    return data;
  }

  Map<String, String> getHomeCareData() {
    Map<String, String> data = Map<String, String>();

    _addEntryIntoMap(
        key: "Pet Card Location", value: this.OUGPetCardLocation, map: data);
    _addEntryIntoMap(
        key: "Cleaning Supply Location",
        value: this.OUGCleaningSupplyLocation,
        map: data);
    _addEntryIntoMap(
        key: "Cleaning Notes", value: this.OUGCleaningNotes, map: data);
    _addEntryIntoMap(
        key: "Mail & Lights", value: this.OUGMailLightsNotes, map: data);
    _addEntryIntoMap(key: "Plant Care", value: this.OUGPlantNotes, map: data);
    _addEntryIntoMap(key: "House Notes", value: this.OUGHouseNotes, map: data);

    return data;
  }

  void _addEntryIntoMap(
      {String? key, String? value, Map<String, String>? map}) {
    if (value != null && value.trim().length > 0) map![key!] = value;
  }
}

class PetDetail {
  String? Name;
  String? Photo;
  String? OUGPetGender;
  String? Breed;
  String? OUGPetType;
  String? BirthDate;
  String? ColorMarking;
  String? IsSpecialNeeds;
  String? SpecialNeedsDesc;
  String? WalkRoutine;
  String? BehaviorDesc;
  String? HealthDesc;
  String? OUGPetLocation;
  String? PetLocationDesc;
  String? LeashLocation;
  String? LitterboxLocation;
  String? LitterboxNotes;
  String? IsOUGTreatsOK;
  String? TreatsLocation;
  String? FoodSchedule;
  String? FoodLocation;
  String? FoodBowlLocation;
  String? FoodServingSize;
  String? FoodNotes;
  String? IsMedicationAdministered;
  String? MedicationAmount;
  String? MedicationLocation;
  String? MedicationMethod;
  MemoryImage? petPhoto;

  PetDetail({
    this.Name,
    this.Photo,
    this.OUGPetGender,
    this.Breed,
    this.OUGPetType,
    this.BirthDate,
    this.ColorMarking,
    this.IsSpecialNeeds,
    this.SpecialNeedsDesc,
    this.WalkRoutine,
    this.BehaviorDesc,
    this.HealthDesc,
    this.OUGPetLocation,
    this.PetLocationDesc,
    this.LeashLocation,
    this.LitterboxLocation,
    this.LitterboxNotes,
    this.IsOUGTreatsOK,
    this.TreatsLocation,
    this.FoodSchedule,
    this.FoodLocation,
    this.FoodBowlLocation,
    this.FoodServingSize,
    this.FoodNotes,
    this.IsMedicationAdministered,
    this.MedicationAmount,
    this.MedicationLocation,
    this.MedicationMethod,
  });

  factory PetDetail.fromXML(XmlElement xml) {
    return PetDetail(
      Name: xml.getElement('Name')?.text,
      Photo: xml.getElement('Photo')?.text,
      OUGPetGender: xml.getElement('OUGPetGender')?.text,
      Breed: xml.getElement('Breed')?.text,
      OUGPetType: xml.getElement('OUGPetType')?.text,
      BirthDate: xml.getElement('BirthDate')?.text,
      ColorMarking: xml.getElement('ColorMarking')?.text,
      IsSpecialNeeds: xml.getElement('IsSpecialNeeds')?.text,
      SpecialNeedsDesc: xml.getElement('SpecialNeedsDesc')?.text,
      WalkRoutine: xml.getElement('WalkRoutine')?.text,
      BehaviorDesc: xml.getElement('BehaviorDesc')?.text,
      HealthDesc: xml.getElement('HealthDesc')?.text,
      OUGPetLocation: xml.getElement('OUGPetLocation')?.text,
      PetLocationDesc: xml.getElement('PetLocationDesc')?.text,
      LeashLocation: xml.getElement('LeashLocation')?.text,
      LitterboxLocation: xml.getElement('LitterboxLocation')?.text,
      LitterboxNotes: xml.getElement('LitterboxNotes')?.text,
      IsOUGTreatsOK: xml.getElement('IsOUGTreatsOK')?.text,
      TreatsLocation: xml.getElement('TreatsLocation')?.text,
      FoodSchedule: xml.getElement('FoodSchedule')?.text,
      FoodLocation: xml.getElement('FoodLocation')?.text,
      FoodBowlLocation: xml.getElement('FoodBowlLocation')?.text,
      FoodServingSize: xml.getElement('FoodServingSize')?.text,
      FoodNotes: xml.getElement('FoodNotes')?.text,
      IsMedicationAdministered:
          xml.getElement('IsMedicationAdministered')?.text,
      MedicationAmount: xml.getElement('MedicationAmount')?.text,
      MedicationLocation: xml.getElement('MedicationLocation')?.text,
      MedicationMethod: xml.getElement('MedicationMethod')?.text,
    );
  }

  Map<String, String> getVisitSummaryData() {
    Map<String, String> data = Map<String, String>();

    _addEntryIntoMap(key: "", value: this.WalkRoutine, map: data);

    return data;
  }

  Map<String, String> getBehaviorData() {
    Map<String, String> data = Map<String, String>();

    _addEntryIntoMap(key: "Personality", value: this.BehaviorDesc, map: data);
    _addEntryIntoMap(
        key: "Health - Behavior", value: this.HealthDesc, map: data);

    return data;
  }

  Map<String, String> getVisitRoutineData() {
    Map<String, String> data = Map<String, String>();

    String petLocationStr = "";
    if (this.OUGPetLocation != null && this.OUGPetLocation!.trim().length > 0)
      petLocationStr += this.OUGPetLocation!;
    if (petLocationStr.length > 0) petLocationStr += "\n";
    if (this.PetLocationDesc != null && this.PetLocationDesc!.trim().length > 0)
      petLocationStr += this.PetLocationDesc!;

    if (petLocationStr.length > 0) data["Pet Location"] = petLocationStr;

    _addEntryIntoMap(
        key: "Leash & Collar", value: this.LeashLocation, map: data);
    _addEntryIntoMap(
        key: "Litterbox Location", value: this.LitterboxLocation, map: data);
    _addEntryIntoMap(
        key: "Litterbox Notes", value: this.LitterboxNotes, map: data);

    return data;
  }

  Map<String, String> getFoodTreatData() {
    Map<String, String> data = Map<String, String>();

    _addEntryIntoMap(
        key: "Is it OK to give OUG! supplied treats?",
        value: (this.IsOUGTreatsOK != null && this.IsOUGTreatsOK == "true")
            ? "Yes"
            : "No",
        map: data);
    _addEntryIntoMap(
        key: "Treat Location", value: this.TreatsLocation, map: data);
    _addEntryIntoMap(
        key: "Feeding Schedule", value: this.FoodSchedule, map: data);
    _addEntryIntoMap(key: "Food Location", value: this.FoodLocation, map: data);
    _addEntryIntoMap(
        key: "Food Bowl Location", value: this.FoodBowlLocation, map: data);
    _addEntryIntoMap(
        key: "Serving Instructions", value: this.FoodServingSize, map: data);
    _addEntryIntoMap(key: "Food Notes", value: this.FoodNotes, map: data);

    return data;
  }

  Map<String, String> getMedicationData() {
    Map<String, String> data = Map<String, String>();

    _addEntryIntoMap(
        key: "Medication?",
        value: (this.IsMedicationAdministered != null &&
                this.IsMedicationAdministered == "true")
            ? "Yes"
            : "No",
        map: data);
    _addEntryIntoMap(
        key: "Medication Schedule & Amount",
        value: this.MedicationAmount,
        map: data);
    _addEntryIntoMap(
        key: "Medication Location", value: this.MedicationLocation, map: data);
    _addEntryIntoMap(
        key: "Medication Administration",
        value: this.MedicationMethod,
        map: data);

    return data;
  }

  void _addEntryIntoMap(
      {String? key, String? value, Map<String, String>? map}) {
    if (value != null && value.trim().length > 0) map![key!] = value;
  }
}

class PetParentData {
  Customer? customer;
  List<PetDetail>? petDetails;

  PetParentData({this.customer, this.petDetails});
}

class InProgressActivity {
  Activity? activity;
  InProgressActivityStatus? status;
  RouteDistnaceInfo? initialRouteDistanceInfo;
  RouteDistnaceInfo? finalRouteDistanceInfo;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? houseLeftTime;
  DateTime? houseCheckInTime;
  String? noteForCustomer;
  String? noteForOffice;
  List<File>? images;
  int? minutesSpent;
  String? internalJobID;
  String? uniqueId;
  InProgressActivity(
      {this.activity,
      this.status,
      this.initialRouteDistanceInfo,
      this.finalRouteDistanceInfo,
      this.startTime,
      this.endTime,
      this.noteForCustomer,
      this.noteForOffice,
      this.images,
      this.minutesSpent,
      this.internalJobID,
      this.uniqueId});

// to json
  Map<String, dynamic> toJson() => {
        'activity': activity?.toJson(),
        'status': status!.value,
        'initialRouteDistanceInfo': initialRouteDistanceInfo!.toJson(),
        'finalRouteDistanceInfo': finalRouteDistanceInfo?.toJson(),
        'startTime': startTime?.toIso8601String(),
        'endTime': endTime?.toIso8601String(),
        'noteForCustomer': noteForCustomer,
        'noteForOffice': noteForOffice,
        'images': images,
        'minutesSpent': minutesSpent,
        'internalJobID': internalJobID,
        'uniqueId': uniqueId,
        'houseLeftTime': houseLeftTime?.toIso8601String(),
        'houseCheckInTime': houseCheckInTime?.toIso8601String(),
      };
}

class RouteDistnaceInfo {
  RouteDistnaceInfo({
    this.distance,
    this.duration,
    this.durationInTraffic,
  });

  int? distance;
  int? duration;
  int? durationInTraffic;

  //to json
  Map<String, dynamic> toJson() => {
        'distance': distance,
        'duration': duration,
        'durationInTraffic': durationInTraffic,
      };
}

class StartActivityModel {
  String activityID;
  bool isGPSCheckInException;
  String gpsCheckInExceptionDistance;
  bool isMissedVisitWindow;

  StartActivityModel({
    required this.activityID,
    required this.isGPSCheckInException,
    required this.gpsCheckInExceptionDistance,
    required this.isMissedVisitWindow,
  });
}

class EndActivityModel {
  String activityID;
  DateTime dateTime;
  int visitDuration;
  bool isGPSCheckInException;
  String gpsCheckOutExceptionDistance;
  String distanceTraveled;
  bool isShortenedVisit;

  EndActivityModel({
    required this.activityID,
    required this.dateTime,
    required this.visitDuration,
    required this.isGPSCheckInException,
    required this.gpsCheckOutExceptionDistance,
    required this.distanceTraveled,
    required this.isShortenedVisit,
  });
}

class SessionModel {
  InProgressActivity inProgressActivity;
  double distanceTraveled;
  List<LatLng> routePoints;

  SessionModel(
      {required this.inProgressActivity,
      required this.distanceTraveled,
      required this.routePoints});

  Map<String, dynamic> toJson() {
    return {
      "inProgressActivity": inProgressActivity.toJson(),
      "distanceTraveled": distanceTraveled,
      "routePoints": routePoints.map((e) => e.toJson()).toList(),
    };
  }
}
