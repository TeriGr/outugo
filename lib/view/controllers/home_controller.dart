import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:outugo_flutter_mobile/core/models/freezed_models.dart';
import 'package:outugo_flutter_mobile/core/models/normal_models.dart';
import 'package:outugo_flutter_mobile/core/repositories/home_repository.dart';
import 'package:outugo_flutter_mobile/core/services/location_service.dart';
import 'package:outugo_flutter_mobile/shared/routes/app_routes.dart';
import 'package:outugo_flutter_mobile/utils/constants/asset_constants/image_constants.dart';
import 'package:outugo_flutter_mobile/utils/constants/data_constants/map_constants.dart';
import 'package:outugo_flutter_mobile/utils/enums.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/components/checklist_popup.dart';
import 'package:outugo_flutter_mobile/view/components/oug_dialog.dart';
import 'package:outugo_flutter_mobile/view/controllers/auth_controller.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController {
  HomeRepostiory homeRepostiory;
  // GoogleMapService googleMapService;
  LocationService locationService;
  HomeController(
      {required this.homeRepostiory,
      // required this.googleMapService,
      required this.locationService});

  AuthController authController = Get.find();

  final _status = RxStatus.empty().obs;
  RxStatus get status => _status.value;
  set status(RxStatus value) {
    _status.value = value;
  }

  late GoogleMapController mapController;
  LatLng currentLocation = kInitialPosition;
  Rx<Completer<GoogleMapController>> mapCompleter =
      Completer<GoogleMapController>().obs;
//markers
  final _markers = <Marker>{}.obs;
  Set<Marker> get markers => _markers.value;
  set markers(Set<Marker> value) => _markers.value = value;

  final _selectedMarker = <Marker>{}.obs;
  Set<Marker> get selectedMarker => _selectedMarker.value;
  set selectedMarker(Set<Marker> value) => _selectedMarker.value = value;

  final _currentLocationMarker = Marker(
    markerId: MarkerId(MarkerIds.user.value),
    position: kInitialPosition,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    infoWindow: InfoWindow(title: "Current Location"),
  ).obs;
  Marker get currentLocationMarker => _currentLocationMarker.value;
  set currentLocationMarker(Marker value) =>
      _currentLocationMarker.value = value;

//currently viewed polyline
  final _polylines = <Polyline>{}.obs;
  Set<Polyline>get polylines => _polylines.value;
  set polylines(Set<Polyline> value) => _polylines.value = value;

  final _activities = <Activity>[].obs;
  List<Activity> get activities => _activities.value;
  set activities(List<Activity> value) => _activities.value = value;

  final _activitiesToShow = <Activity>[].obs;
  List<Activity> get activitiesToShow => _activitiesToShow.value;
  set activitiesToShow(List<Activity> value) => _activitiesToShow.value = value;

  final _selectedActivity = Activity().obs;
  Activity get selectedActivity => _selectedActivity.value;
  set selectedActivity(Activity value) => _selectedActivity.value = value;

  final _inProgressActivities = <InProgressActivity>[].obs;
  List<InProgressActivity> get inProgressActivities =>
      _inProgressActivities.value;
  set inProgressActivities(List<InProgressActivity> value) =>
      _inProgressActivities.value = value;

  final _selectedInProgressActivity = InProgressActivity().obs;
  InProgressActivity get selectedInProgressActivity =>
      _selectedInProgressActivity.value;
  set selectedInProgressActivity(InProgressActivity value) =>
      _selectedInProgressActivity.value = value;

  final _selectedActivityStatus = InProgressActivityStatus.empty.obs;
  InProgressActivityStatus get selectedActivityStatus =>
      _selectedActivityStatus.value;
  set selectedActivityStatus(InProgressActivityStatus value) =>
      _selectedActivityStatus.value = value;

  final _selectedItemIndex = 0.obs;
  int get selectedItemIndex => _selectedItemIndex.value;
  set selectedItemIndex(int value) => _selectedItemIndex.value = value;
  final _customer = Customer().obs;
  Customer get customer => _customer.value;
  set customer(Customer value) => _customer.value = value;

  final _petDetails = <PetDetail>[].obs;
  List<PetDetail> get petDetails => _petDetails.value;
  set petDetails(List<PetDetail> value) => _petDetails.value = value;

  var _durationRemaining = Duration.zero.obs;
  Duration get durationRemaining => _durationRemaining.value;
  set durationRemaining(Duration value) => _durationRemaining.value = value;

  Uint8List screenshotImage = Uint8List(0);

  var minutesSpent = 0.obs;
  var selectedDate = DateTime.now().obs;
  var movedPoints = <LatLng>[].obs;
  var movedPoints2 = <LatLng>[].obs;
  var distanceTravelled = 0.0.obs;
  var _lastPoint = LatLng(0, 0);
  var reportCardSummary = "".obs;
  var files = <File>[].obs;
  var tempFiles = <File>[].obs;

  var houseCheckinTime = "-".obs;
  var houseLeftTime = "-".obs;

  final StreamController<LatLng> _pointsTravelledStreamController =
      StreamController<LatLng>.broadcast();
  Stream<LatLng> get pointsTravelledStream =>
      _pointsTravelledStreamController.stream;

  bool _continueCountdown = false;
  bool _continueElapsedTime = false;

  var completSwitchValue = false.obs;

  BitmapDescriptor visitorLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon =
      BitmapDescriptor.defaultMarkerWithHue(200);

  @override
  void onInit() {
    super.onInit();
    getActivities();
    _setPinIcons();
    locationService.getCurrentPosition().then(
        (value) => currentLocation = LatLng(value.latitude!, value.longitude!));
    selectedItemIndex = -1;
    getSession();
  }

  getActivities() async {
    status = RxStatus.loading();
    final response = await homeRepostiory.getActivities(
        selectedDate.value, authController.user.RecordID!);
    if (response != null) {
      activities = response;
      activitiesToShow = activities;
      inProgressActivities = activities
          .map((e) => InProgressActivity(
              activity: e, status: InProgressActivityStatus.empty))
          .toList();
      setallVisitMarkers();
      status = RxStatus.success();
    } else {
      status = RxStatus.error();
    }
  }

  filterCompleted() {
    if (completSwitchValue.value) {
      var temp = <Activity>[];
      inProgressActivities.forEach((element) {
        log(element.status.toString());
        if (element.status == InProgressActivityStatus.completed) {
          temp.add(element.activity!);
        }
      });
      activitiesToShow = temp;
    } else {
      var temp = <Activity>[];
      inProgressActivities.forEach((element) {
        log(element.status.toString());
        if (element.status != InProgressActivityStatus.completed) {
          temp.add(element.activity!);
        }
      });
      activitiesToShow = temp;
    }
  }

  setSelectedActivity(Activity activity) async {
    status = RxStatus.loading();
    // 2 - DogWalk , 3 - CatCare , 4 - CritterCare , 5 - PlantCare , 6 - PetTaxi, 8 - MeetAndGreet, 1 - HouseSitting , 7 - HouseSittingFinal , 10 - Exempt
    if (activity.VisitType_RecordID == "10") {
      Get.dialog(OUGDialog(
        type: AlertDialogType.ERROR,
        title: "Out-U-Go",
        content: "This visit type is not supported on mobile app.",
      ));
      return;
    }

    selectedActivity = activity;
    selectedInProgressActivity = inProgressActivities.firstWhere(
      (element) => element.activity!.RecordID == activity.RecordID,
    );

    selectedActivityStatus = InProgressActivityStatus.empty;

    status = RxStatus.success();
    selectedInProgressActivity.initialRouteDistanceInfo = RouteDistnaceInfo(
      distance: calculateDistance(
              currentLocation.latitude,
              currentLocation.longitude,
              double.parse(activity.CustomerLatitudeOUG!),
              double.parse(activity.CustomerLongitudeOUG!))
          .round(),
    );
    if (selectedActivity.VisitType_RecordID == "1" ||
        selectedActivity.VisitType_RecordID == "7") {
      startHouseActivity();
      return;
    }
    setCurrentVisitMarker();

    //if (activity.VisitType_RecordID == "1" ||
    // activity.VisitType_RecordID == "7")  //house sitting

    // if selected activity is completed, then show summary activity
    Get.toNamed(AppRoutes.visitDetailPage);
    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 17));
  }

  startHouseActivity() {
    log(selectedActivity.toJson().toString());
    if (selectedActivity.ActivityStatus_RecordID == "3") {
      selectedInProgressActivity.houseCheckInTime = getDateFromServerDate(
        selectedActivity.OUGAppStart!,
      );
      houseCheckinTime.value = DateFormat("hh:mm a").format(
        selectedInProgressActivity.houseCheckInTime!,
      );
      selectedInProgressActivity.houseLeftTime = getDateFromServerDate(
        selectedActivity.OUGAppEnd!,
      );
      houseLeftTime.value = DateFormat("hh:mm a").format(
        selectedInProgressActivity.houseLeftTime!,
      );
    }
    Get.toNamed(AppRoutes.homeDetailPage);
  }

  _startCountDown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (durationRemaining.inSeconds > 0 && _continueCountdown) {
        durationRemaining = durationRemaining - Duration(seconds: 1);
      } else {
        timer.cancel();
      }
    });
  }

  getPetParentData() async {
    status = RxStatus.loading();
    final response = await homeRepostiory.getPetParentData(
        customerId: selectedActivity.Entity_RecordID!,
        petId: selectedActivity.Entity_RecordID!);
    if (response != null) {
      customer = response.customer!;
      petDetails = response.petDetails!;
      status = RxStatus.success();
      Get.toNamed(AppRoutes.petParentPage);
    } else {
      status = RxStatus.error();
    }
  }

  startActivity() async {
    // if a visit is already started, then show error
    if (_checkOtherActivities()) {
      log("message");

      // if (_isClose()) {
      await _isClose().then(
        (value) {
          if (value.last) {
            _startVisit(value.first);
          }
        },
      );
      // } else {
      //   Get.dialog(OUGDialog(
      //     type: AlertDialogType.ERROR,
      //     title: "Out-U-Go",
      //     content: "You are not on time for this visit.",
      //     clickEvent: () => Get.back(),
      //   ));
      // }

    }
  }

  Future<Set<bool>> _isClose() async {
    await getCurrentLocation();
    log("messagew");
    bool isClose = false;
    bool continueCheck = false;
    var distance = calculateDistance(
        currentLocation.latitude,
        currentLocation.longitude,
        double.parse(selectedActivity.CustomerLatitudeOUG!),
        double.parse(selectedActivity.CustomerLongitudeOUG!));
    if (distance < 45.72) {
      isClose = true;
      continueCheck = true;
    } else {
      await Get.dialog(OUGDialog(
          type: AlertDialogType.CONFIRM,
          title: 'At the right address?',
          content:
              "It appears you're currently ${(distance * 3.28).round()} feet away from the Visit address. Proceed with Check In?",
          buttonLabel: 'Yes',
          clickEvent: () {
            selectedInProgressActivity.initialRouteDistanceInfo?.distance =
                distance.round();
            isClose = true;
            continueCheck = true;
          }));
    }
    selectedInProgressActivity.initialRouteDistanceInfo?.distance =
        distance.round();
    log("message$isClose");

    return {isClose, continueCheck};
  }

  _startVisit(bool isOnTime) async {
    log("message");

    int distance =
        selectedInProgressActivity.initialRouteDistanceInfo!.distance!;
    StartActivityModel startActivityModel = StartActivityModel(
      activityID: selectedActivity.RecordID!,
      isGPSCheckInException: distance > 45.72,
      gpsCheckInExceptionDistance: (distance * 3.28).round().toString(),
      isMissedVisitWindow: !isOnTime,
    );

    StartActivityPayload startActivityPayload = StartActivityPayload(
        customerEmail: selectedInProgressActivity.activity!.EntityEmail!,
        customerMobile: selectedInProgressActivity.activity!.EntityPhone!,
        customerName: selectedInProgressActivity.activity!.Entity!,
        dueDateStart: selectedInProgressActivity.activity!.DueDateStart!,
        dueDateEnd: selectedInProgressActivity.activity!.DueDateEnd!,
        entityRecordID: selectedInProgressActivity.activity!.Entity_RecordID!,
        gpsCheckInExceptionDistance: selectedInProgressActivity
            .initialRouteDistanceInfo!.distance!
            .toString(),
        gpscheckInException:
            selectedInProgressActivity.initialRouteDistanceInfo!.distance! >
                45.72,
        loggedUserName: authController.user.UserName!,
        ougAppStart: sendConvertedDateTimeToMiddleware(
            DateTime.now().millisecondsSinceEpoch),
        missedVisitWindow: !isOnTime,
        ougVisitLength: selectedInProgressActivity.activity!.OUGVisitLength!,
        petId: "",
        petNamesOUG: selectedInProgressActivity.activity!.PetNamesOUG!,
        recordID: selectedInProgressActivity.activity!.RecordID!,
        shipAddressAddr2:
            selectedInProgressActivity.activity!.ShipAddressAddr2!,
        shipAddressAddr3:
            selectedInProgressActivity.activity!.ShipAddressAddr3!,
        shipAddressCity: selectedInProgressActivity.activity!.ShipAddressCity!,
        shipAddressPostalCode:
            selectedInProgressActivity.activity!.ShipAddressPostalCode!,
        shipAddressState:
            selectedInProgressActivity.activity!.ShipAddressState!,
        visitType: selectedInProgressActivity.activity!.VisitType!,
        visitTypeRecordID:
            selectedInProgressActivity.activity!.VisitType_RecordID!);
    status = RxStatus.loading();
    await homeRepostiory
        .startVisit(startActivityModel, startActivityPayload)
        .then((value) {
      log("start visit response: $value");
      if (value != null) {
        selectedInProgressActivity.status = InProgressActivityStatus.started;
        selectedInProgressActivity.internalJobID = value['internalActivityId'];
        selectedInProgressActivity.uniqueId = value['uniqueId'];
        selectedInProgressActivity.startTime = DateTime.now();
        selectedActivityStatus = InProgressActivityStatus.started;
        startWalking();
        setOngoingActivityData();
        selectedItemIndex = activities.indexWhere((element) =>
            element.RecordID == selectedInProgressActivity.activity!.RecordID);
        filterCompleted();
        status = RxStatus.success();
      } else {
        status = RxStatus.error();
      }
    });
  }

  setOngoingActivityData() {
    var startTime = selectedInProgressActivity.startTime!;
    int minutes =
        int.parse(selectedInProgressActivity.activity!.OUGVisitLength!);
    var endTime = startTime.add(Duration(minutes: minutes));
    if (startTime.isBefore(DateTime.now()) && endTime.isAfter(DateTime.now())) {
      durationRemaining = endTime.difference(DateTime.now());
      selectedInProgressActivity.endTime = endTime;
      _continueCountdown = true;
      _continueElapsedTime = true;
      _calculateminutesLeft();
      _startCountDown();
    }
  }

  _calculateminutesLeft() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      if (_continueElapsedTime) {
        int minutes =
            int.parse(selectedInProgressActivity.activity!.OUGVisitLength!);
        selectedInProgressActivity.minutesSpent =
            minutes - durationRemaining.inMinutes;
        minutesSpent.value = selectedInProgressActivity.minutesSpent!;
      } else {
        timer.cancel();
      }
    });
  }

  startWalking() async {
    await locationService.enableBackgroundMode(true);
    await getCurrentLocation();
    _lastPoint = currentLocation;

    log("starting at ${currentLocation.latitude}, ${currentLocation.longitude}");
    onDistanceStream();
    distanceTravelled.value = 0;
    await locationService.changeSettings();
    locationService.getLiveLocation().listen((event) {
      currentLocation = LatLng(event.latitude!, event.longitude!);
      setCurrentLocationMarker();
      try {
        _pointsTravelledStreamController.add(currentLocation);
      } catch (e) {
        _pointsTravelledStreamController.close();
      }
    });
  }

  stopWalking() async {
    _pointsTravelledStreamController.close();
    await locationService.enableBackgroundMode(false);
  }

  onDistanceStream() {
    pointsTravelledStream.listen((event) {
      movedPoints2.add(event);
      homeRepostiory.savethis(movedPoints2);
      calculateWalkedDistance(event);
    });
  }

  calculateWalkedDistance(LatLng event) {
    var distance = calculateDistance(_lastPoint.latitude, _lastPoint.longitude,
        event.latitude, event.longitude);
    log("distance ${distance.toString()}");
    if (distance > 5) {
      _lastPoint = event;
      distanceTravelled.value += distance;
      movedPoints.add(event);
      polylines.clear();
      polylines.add(Polyline(
          polylineId: PolylineId("poly"),
          points: movedPoints,
          width: 5,
          color: Colors.blue));
      saveSession();
    }
    log("distance travelled: ${distanceTravelled.value.toString()}");
  }

  saveSession() async {
    await homeRepostiory.saveSession(SessionModel(
        inProgressActivity: inProgressActivities[0],
        distanceTraveled: distanceTravelled.value,
        routePoints: movedPoints));
  }

  getSession() {
    try {
      var temp = homeRepostiory.getSession();
      movedPoints2.value = homeRepostiory.getthis();
      log("moved points: ${movedPoints2.length}");
    } catch (e) {
      log(e.toString());
    }
  }

  bool _isOnTime() {
    return getDateFromServerDate(
          selectedInProgressActivity.activity!.OUGAppStart!,
        ).isBefore(DateTime.now()) &&
        getDateFromServerDate(
          selectedInProgressActivity.activity!.OUGAppEnd!,
        ).isAfter(DateTime.now());
  }

  bool _checkOtherActivities() {
    bool temp = false;
    String activeId = "";
    if (inProgressActivities.any((element) {
      activeId = element.activity!.RecordID!;
      return element.status == InProgressActivityStatus.started;
    })) {
      Get.dialog(OUGDialog(
          type: AlertDialogType.CONFIRM,
          title: "Out-U-Go",
          buttonLabel: 'Yes',
          content:
              "You have already started another visit. Do you want to continue?",
          clickEvent: () {
            inProgressActivities
                .where((element) => element.activity!.RecordID == activeId)
                .first
                .status = InProgressActivityStatus.empty;
            temp = true;
          }));
    } else {
      temp = true;
    }
    return temp;
  }

  completeActivity() async {
    if (await _checkImagesList()) {
      if (durationRemaining.inSeconds > 90) {
        await Get.dialog(OUGDialog(
          type: AlertDialogType.CONFIRM,
          title: "Out-U-Go",
          buttonLabel: 'Yes',
          content:
              "You have not reached the scheduled visit length yet. Proceed with visit check out anyway?",
          clickEvent: () {
            _showChecklistPopup();
          },
        ));
      } else {
        _showChecklistPopup();
      }
    }
  }

  void _showChecklistPopup() {
    Get.dialog(ChecklistPopup(
      title: 'Confirm: Did you lock up & leave?',
      buttonLabel: 'Yes, I\'ve Left',
      clickEvent: _finishVisit,
    ));
  }
  void _setMapFitToTour() {
    double minLat = polylines.first.points.first.latitude;
    double minLong = polylines.first.points.first.longitude;
    double maxLat = polylines.first.points.first.latitude;
    double maxLong = polylines.first.points.first.longitude;
    for (var poly in polylines) {
      for (var point in poly.points) {
        if(point.latitude < minLat) minLat = point.latitude;
        if(point.latitude > maxLat) maxLat = point.latitude;
        if(point.longitude < minLong) minLong = point.longitude;
        if(point.longitude > maxLong) maxLong = point.longitude;
      }
    }
    mapController.moveCamera(CameraUpdate.newLatLngBounds(LatLngBounds(
      southwest: LatLng(minLat, minLong),
      northeast: LatLng(maxLat,maxLong)
    ), 20));
  }

  Future<void> _finishVisit() async {
    stopWalking();
    _setMapFitToTour();
    await mapController.takeSnapshot().then((image) async {
      if (image != null) {
        screenshotImage = image;
      }
    });
    getCurrentLocation();
    log('asdfads');
    double distanceInMeters = calculateDistance(
      currentLocation.latitude,
      currentLocation.longitude,
      double.parse(selectedActivity.CustomerLatitudeOUG!),
      double.parse(selectedActivity.CustomerLongitudeOUG!),
    );
    int distance = (distanceInMeters * 3.281).round();
    selectedInProgressActivity.endTime = DateTime.now();
    bool isClose = distanceInMeters < 45.72;
    selectedInProgressActivity.finalRouteDistanceInfo =
        RouteDistnaceInfo(distance: distance);
    _continueCountdown = false;
    _continueElapsedTime = false;

    EndActivityModel endActivityModel = EndActivityModel(
        activityID: selectedActivity.RecordID!,
        dateTime: DateTime.now(),
        isGPSCheckInException: isClose,
        gpsCheckOutExceptionDistance: distance.toString(),
        isShortenedVisit: false,
        distanceTraveled: (distanceTravelled.value*0.000621371).toString(),
        visitDuration: minutesSpent.value);

    EndActivityPayload endActivityPayload = EndActivityPayload(
      activityStatus: selectedActivity.ActivityStatus_RecordID!,
      gpsCoordinatesList: [], //Expecting String Array
      lastModifiedByAppTimestamp: DateTime.now().millisecondsSinceEpoch,
      ougAppActualVisitDuration:
          selectedActivity.OUGVisitLength!, // should be in minutes
      ougAppEnd: sendConvertedDateTimeToMiddleware(
          selectedInProgressActivity.endTime!.millisecondsSinceEpoch),
      ougAppVisit: "",
      typeMessage: "",
      shortenedVisit: false,
    );

    status = RxStatus.loading();
    await homeRepostiory
        .endVisit(endActivityModel, endActivityPayload)
        .then((value) {
      log("end visit response: $value");
      if (value) {
        selectedInProgressActivity.status = InProgressActivityStatus.completed;
        selectedActivityStatus = InProgressActivityStatus.completed;
        selectedItemIndex = -1;
        filterCompleted();
        status = RxStatus.success();
        Get.toNamed(AppRoutes.summaryPage);
      } else {
        status = RxStatus.error();
      }
    });
  }

  _checkImagesList() async {
    if (selectedInProgressActivity.images == null ||
        (selectedInProgressActivity.images?.isEmpty ?? false)) {
      await Get.dialog(OUGDialog(
        type: AlertDialogType.ERROR,
        title: "Out-U-Go",
        content: "Please capture pet image before submitting.",
      ));
      return false;
    }
    return true;
  }

  setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<LatLng?> getCurrentLocation() async {
    log('asd');
    return await locationService.getCurrentPosition().then((value) {
      log("current location: ${value.latitude} ${value.longitude}");
      currentLocation = LatLng(value.latitude!, value.longitude!);
      return currentLocation;
    }).catchError((onError) {
      log(onError.toString());
    });
  }

  sendVisitSummary() async {
    // check if customer note is empty
    if (selectedInProgressActivity.noteForCustomer?.isEmpty ?? true) {
      await Get.dialog(OUGDialog(
        type: AlertDialogType.ERROR,
        title: 'Report Card Note is Empty', //OUGStrings.kAppName,
        content: "You must add a Report Card visit note before submitting",
      ));
      return;
    }
    // check if selected images length is 1
    if (selectedInProgressActivity.images!.length > 1) {
      await Get.dialog(OUGDialog(
          type: AlertDialogType.ERROR,
          title: 'Pet Image Amount', //OUGStrings.kAppName,
          content:
              "Please Upload only 1 image and discard additional images."));
      return;
    }

    status = RxStatus.loading();
    try {
      await homeRepostiory
          .uploadActivityImage(
        recordId: selectedInProgressActivity.internalJobID!,
        userId: authController.authRepository.getUser()!.userId!.toString(),
        body: selectedInProgressActivity.images!.first,
      )
          .then((value) {
        log('image uploaded $value');
      });
    } catch (e) {
      toast('Error', 'Error while uploading activity image');
      log(e.toString());
    }
    try {
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image.png').create();
      file.writeAsBytesSync(screenshotImage);
      await homeRepostiory.uploadActivityImage(
          recordId: selectedInProgressActivity.internalJobID!,
          userId: authController.authRepository.getUser()!.userId!.toString(),
          body: file,
          isMapImage: true);
    } catch (e) {
      toast('Error', 'Error while uploading map image');
      log(e.toString());
    }
    status = RxStatus.success();

    await homeRepostiory.sendSummary(selectedInProgressActivity).then((value) {
      log("value: $value");
      status = RxStatus.success();
      Get.dialog(OUGDialog(
        type: AlertDialogType.SUCCESS,
        title: "All Done!", //OUGStrings.kAppName,
        content: "Report Card Sent",
        clickEvent: () {
          Get.offAndToNamed(AppRoutes.homePage);
        },
      ));
    }).catchError((onError) {
      status = RxStatus.error();
      log(onError.toString());
    });
    // reportCardSummary.value = '';
  }

  @override
  void onClose() {
    super.onClose();
  }

  setCurrentLocationMarker() {
    _markers.removeWhere(
        (element) => element.markerId.value == MarkerIds.user.value);
    _selectedMarker.removeWhere(
        (element) => element.markerId.value == MarkerIds.user.value);
    _markers
        .add(currentLocationMarker.copyWith(positionParam: currentLocation));
    _selectedMarker
        .add(currentLocationMarker.copyWith(positionParam: currentLocation));
        mapController.animateCamera(CameraUpdate.newLatLng(currentLocation));
  }

  setallVisitMarkers() {
    _markers.clear();
    var tempMarkers = <Marker>{};
    activitiesToShow.forEach((e) {
      if (e.CustomerLatitudeOUG != null)
        // ignore: curly_braces_in_flow_control_structures
        tempMarkers.add(Marker(
          markerId: MarkerId(e.RecordID!),
          position: LatLng(double.parse(e.CustomerLatitudeOUG!),
              double.parse(e.CustomerLongitudeOUG!)),
          infoWindow: InfoWindow(),
          icon: visitorLocationIcon,
        ));
    });
    markers = tempMarkers;
    setCurrentLocationMarker();
  }

  setCurrentVisitMarker() {
    _selectedMarker.clear();
    var tempMarkers = <Marker>{};
    if (selectedActivity.CustomerLatitudeOUG != null) {
      tempMarkers.add(Marker(
        markerId: MarkerId(selectedActivity.RecordID!),
        position: LatLng(double.parse(selectedActivity.CustomerLatitudeOUG!),
            double.parse(selectedActivity.CustomerLongitudeOUG!)),
        infoWindow: InfoWindow(),
        icon: visitorLocationIcon,
      ));
    }
    selectedMarker = tempMarkers;
    setCurrentLocationMarker();
  }

  _setPinIcons() async {
    double width = Get.size.aspectRatio * 0.01;
    currentLocationIcon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset(ImageConstants.userIcon, (width / 500).round()),
        size: Size((width / 500), (width / 500)));
    visitorLocationIcon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset(ImageConstants.homeIcon, (width).round()));
    Marker myLocMarker = Marker(
      markerId: MarkerId(MarkerIds.user.value),
      icon: currentLocationIcon,
    );
    _currentLocationMarker.value = myLocMarker;
  }

  //house sitting

  houseSittingFinalContactPP() {
    selectedItemIndex = activities.indexWhere((element) =>
        element.RecordID == selectedInProgressActivity.activity!.RecordID);
    var distance = calculateDistance(
            currentLocation.latitude,
            currentLocation.longitude,
            double.parse(
                selectedInProgressActivity.activity!.CustomerLatitudeOUG!),
            double.parse(
                selectedInProgressActivity.activity!.CustomerLongitudeOUG!))
        .round();

    status = RxStatus.loading();
    homeRepostiory
        .sendHouseSittingFinalContactPP(selectedInProgressActivity, distance)
        .then((value) {
      if (value == true) {
        status = RxStatus.success();
        selectedInProgressActivity.houseCheckInTime = DateTime.now();
        houseCheckinTime.value = DateFormat('hh:mm a').format(DateTime.now());
        selectedInProgressActivity.status = InProgressActivityStatus.completed;
        selectedActivityStatus = InProgressActivityStatus.completed;

        selectedItemIndex = activities.indexWhere((element) =>
            element.RecordID == selectedInProgressActivity.activity!.RecordID);
        filterCompleted();
        Get.dialog(OUGDialog(
          type: AlertDialogType.SUCCESS,
          title: "All Done!", //OUGStrings.kAppName,
          content: "Report Card Sent",
        ));
      } else {
        status = RxStatus.error();
        Get.dialog(OUGDialog(
          type: AlertDialogType.ERROR,
          title: "Error", //OUGStrings.kAppName,
          content: "Error while sending report card",
        ));
      }
    });
  }

  houseSittingSendSummary() {
    var distance = calculateDistance(
            currentLocation.latitude,
            currentLocation.longitude,
            double.parse(
                selectedInProgressActivity.activity!.CustomerLatitudeOUG!),
            double.parse(
                selectedInProgressActivity.activity!.CustomerLongitudeOUG!))
        .round();

    status = RxStatus.loading();
    homeRepostiory
        .sendHouseSittingSummary(selectedInProgressActivity, distance)
        .then((value) {
      if (value == true) {
        selectedInProgressActivity.houseLeftTime = DateTime.now();
        selectedInProgressActivity.houseCheckInTime = DateTime.now();
        houseCheckinTime.value = DateFormat('hh:mm a').format(DateTime.now());
        houseLeftTime.value = DateFormat('hh:mm a').format(DateTime.now());
        selectedInProgressActivity.status = InProgressActivityStatus.completed;
        selectedActivityStatus = InProgressActivityStatus.completed;
        selectedItemIndex = -1;
        filterCompleted();
        status = RxStatus.success();
        Get.dialog(OUGDialog(
          type: AlertDialogType.SUCCESS,
          title: "All Done!", //OUGStrings.kAppName,
          content: "Report Card Sent",
        ));
      } else {
        status = RxStatus.error();
        Get.dialog(OUGDialog(
          type: AlertDialogType.ERROR,
          title: "Error", //OUGStrings.kAppName,
          content: "Error while sending report card",
        ));
      }
    });
  }

  houseSittingFinalSendSumary() async {
    var distance = calculateDistance(
            currentLocation.latitude,
            currentLocation.longitude,
            double.parse(
                selectedInProgressActivity.activity!.CustomerLatitudeOUG!),
            double.parse(
                selectedInProgressActivity.activity!.CustomerLongitudeOUG!))
        .round();
    status = RxStatus.loading();
    await homeRepostiory
        .sendHouseSittingFinalSummary(selectedInProgressActivity, distance)
        .then((value) {
      if (value == true) {
        status = RxStatus.success();
        selectedInProgressActivity.houseLeftTime = DateTime.now();
        houseLeftTime.value = DateFormat('hh:mm a').format(DateTime.now());
        selectedInProgressActivity.status = InProgressActivityStatus.completed;
        selectedActivityStatus = InProgressActivityStatus.completed;
        selectedItemIndex = -1;
        filterCompleted();
        Get.dialog(OUGDialog(
          type: AlertDialogType.SUCCESS,
          title: "All Done!", //OUGStrings.kAppName,
          content: "Report Card Sent",
          clickEvent: () {},
        ));
      } else {
        status = RxStatus.error();
        Get.dialog(OUGDialog(
          type: AlertDialogType.ERROR,
          title: "Error", //OUGStrings.kAppName,
          content: "Error while sending report card",
        ));
      }
    });
  }
}
