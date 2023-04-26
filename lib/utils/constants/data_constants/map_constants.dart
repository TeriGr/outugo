import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outugo_flutter_mobile/core/services/location_service.dart';

const kInitialCamera = CameraPosition(
  target: kInitialPosition,
  zoom: 17,
);
const kInitialPosition = LatLng(40.98706212015144, -74.02647815505958);
