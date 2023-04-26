// import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:outugo_flutter_mobile/utils/constants/data_constants/map_constants.dart';

class LocationService {
  late Location location;

  LocationService() {
    location = Location();
    setCurrentLocation();
  }

  static late LocationData curentLocation;

  setCurrentLocation() async {
    await getCurrentPosition().then((value) => curentLocation = value);
  }

  Future<LocationData> getCurrentPosition() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }
    // LocationData temp = LocationData.fromMap({
    //   "latitude": kInitialPosition.latitude,
    //   "longitude": kInitialPosition.longitude,
    // });
    // return temp;

    return await location.getLocation();
  }

  Future<bool> enableBackgroundMode(bool value) =>
      location.enableBackgroundMode(enable: value);

  Future<void> changeSettings() async {
    await location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
      distanceFilter: 10,
    );
  }

  Stream<LocationData> getLiveLocation() {
    return location.onLocationChanged;
  }
  // Future<Position> getCurrentPosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services
  //     Get.dialog(ConfirmDialog(
  //       title: 'Enable location',
  //       content: 'Enable location info',
  //       actionText: 'Ok',
  //       actionCallback: () => Geolocator.openLocationSettings(),
  //     ));

  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   print(permission);
  //   if (permission != LocationPermission.always) {
  //     Get.dialog(ConfirmDialog(
  //       title: '"Out-U-Go" requires Location Services to work',
  //       content:
  //           'Go to Setting to allow "Out-U-Go" to determine your location, even on background. This will help us improve our services.',
  //       actionText: 'Ok',
  //       actionCallback: () => Geolocator.openLocationSettings(),
  //     ));
  //   }
  //   if (permission != LocationPermission.always) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission != LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error(
  //           'Location permissions is not allowed to run always');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition().then((value) {
  //     // Position temp = Position(
  //     //   latitude: kInitialPosition.latitude,
  //     //   longitude: kInitialPosition.longitude,
  //     //   timestamp: value.timestamp,
  //     //   accuracy: value.accuracy,
  //     //   altitude: value.altitude,
  //     //   heading: value.heading,
  //     //   speed: value.speed,
  //     //   speedAccuracy: value.speedAccuracy,
  //     // );
  //     // return temp;
  //     return value;
  //   });
  // }

  // Stream<Position> getLiveLocation() {
  //   return Geolocator.getPositionStream(
  //       locationSettings: const LocationSettings(
  //           distanceFilter: 1, accuracy: LocationAccuracy.best));
  // }
}
