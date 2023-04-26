import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:outugo_flutter_mobile/shared/routes/app_routes.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/utils/enums.dart';
import 'package:outugo_flutter_mobile/view/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildNotes(String title, String text, {bool haveHeader = true}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (haveHeader) ...[
          Text(title, style: AppTheme.title16black600()),
          SizedBox(height: 5),
        ],
        Text(text, style: AppTheme.detail14black400()),
        Divider(
          height: 1,
          color: AppTheme.grey,
        ),
      ],
    ),
  );
}

showCallPopup(BuildContext context) {
  String phoneNumber =
      Get.find<AuthController>().tenant.sitterSupportPhoneNumber!;
  String email = Get.find<AuthController>().tenant.defaultEmailAddress!;
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      title: Text("Out-U-Go Support"),
      message: Text('Name'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.of(context).pop();

            final url = 'tel:+1' + phoneNumber;
            Uri _phoneLaunchUri = Uri.parse(url);
            if (await canLaunchUrl(_phoneLaunchUri)) {
              await launchUrl(_phoneLaunchUri);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.phone),
              ),
              Text(
                phoneNumber,
                textAlign: TextAlign.left,
                style: AppTheme.titleStyle(),
              ),
            ],
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.of(context).pop();

            final Uri _emailLaunchUri = Uri(
                scheme: 'mailto',
                path: email,
                queryParameters: {'subject': 'Out-U-Go Support'});

            if (await canLaunchUrl(_emailLaunchUri)) {
              await launchUrl(_emailLaunchUri);
            } else {
              throw 'Could not launch $_emailLaunchUri';
            }
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.email),
              ),
              Text(
                email,
                textAlign: TextAlign.left,
                style: AppTheme.titleStyle(),
              ),
            ],
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
  );
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
//   if (permission == LocationPermission.deniedForever) {
//     Get.dialog(ConfirmDialog(
//       title: '"Out-U-Go" requires Location Services to work',
//       content:
//           'Go to Setting to allow "Out-U-Go" to determine your location. This will help us set your location and improve our services.',
//       actionText: 'Ok',
//       actionCallback: () => Geolocator.openLocationSettings(),
//     ));
//   }
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
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
//     Position temp = Position(
//       latitude: kInitialPosition.latitude,
//       longitude: kInitialPosition.longitude,
//       timestamp: value.timestamp,
//       accuracy: value.accuracy,
//       altitude: value.altitude,
//       heading: value.heading,
//       speed: value.speed,
//       speedAccuracy: value.speedAccuracy,
//     );
//     return temp;
//     return value;
//   });
// }

// Stream<Position> getLiveLocation() {
//   return Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(distanceFilter: 10));
// }

Future<String?> takePhoto(ImageSource source) async {
  ImagePicker imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(source: source);
  return pickedFile?.path;
}

void toast(
  String title,
  String message, {
  ToastTypes type = ToastTypes.normal,
  Color? color = AppTheme.grey,
}) {
  if (type == ToastTypes.normal) {
    color = AppTheme.grey;
  }
  if (type == ToastTypes.success || title == 'Success') {
    color = Colors.green;
  }
  if (type == ToastTypes.error || title == 'Error') {
    color = Colors.red;
  }
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color,
  );
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  return document.body!.text;
}

DateTime getDateFromServerDate(String serverDate) {
  int offset = int.parse(Get.find<AuthController>().tenant.timeZoneOffset!);
  //Server Date String format : 2020-10-19T15:00:00
  // if (serverDate == null || serverDate.trim().length == 0) return null;

  return DateFormat('yyyy-MM-ddTHH:mm:ss')
      .parseStrict(serverDate)
      .add(Duration(hours: offset));
}

DateTime getTimeFromServerDate(String serverDate) {
  //Server Date String format : 2020-10-19T15:00:00
  // if (serverDate == null || serverDate.trim().length == 0) return null;
  int offset = int.parse(Get.find<AuthController>().tenant.timeZoneOffset!);

  return DateFormat('HH:mm aaa')
      .parseStrict(serverDate)
      .add(Duration(hours: offset));
}

int sendConvertedDateTimeToMiddleware(int originalTimeInMillis) {
  //return originalTimeInMillis;

  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(originalTimeInMillis);
  DateTime convertedDateTime = dateTime.add(Duration(
      hours: int.parse(Get.find<AuthController>().tenant.timeZoneOffset!)));
  return convertedDateTime.millisecondsSinceEpoch;
}

getInitialRoute() {
  GetStorage box = GetStorage();
  if (box.hasData('user')) {
    return AppRoutes.homePage;
  } else {
    return AppRoutes.loginPage;
  }
}

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

// a function to calculate the distance between two points on the map in meters

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  print("calculateDistance: $lat1, $lon1, $lat2, $lon2");
  var p = 0.017453292519943295; // Math.PI / 180
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

  return (12742 * asin(sqrt(a))) * 1000; // 2 * R; R = 6371 km
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
