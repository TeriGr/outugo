import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outugo_flutter_mobile/utils/constants/data_constants/map_constants.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';

class CustomMap extends StatefulWidget {
  CustomMap({Key? key, this.isDetail = false}) : super(key: key);

  bool isDetail;
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap>
    with SingleTickerProviderStateMixin {
  HomeController controller = Get.find();

  Completer<GoogleMapController> mapCompleter = Completer();
  late CameraPosition _initialCameraPosition;

  Set<Marker> currentLocationMarker = {};

  get kCameraZoom => 14.0;

  @override
  void initState() {
    super.initState();

    _setInitialCameraPosition();
  }

  _setInitialCameraPosition() {
    _initialCameraPosition = kInitialCamera;
  }

  _onMapCreated(GoogleMapController mpController) async {
    mapCompleter.complete(mpController);
    controller.mapController = mpController;
    if (!controller.mapCompleter.value.isCompleted) {
      controller.mapCompleter.value.complete(mpController);
    }
    controller.getCurrentLocation().then((currentLocation) async {
      controller.currentLocation =
          LatLng(currentLocation!.latitude, currentLocation.longitude);

      controller.mapController.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: controller.currentLocation,
          zoom: kCameraZoom,
        )),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => GoogleMap(
            padding: EdgeInsets.only(bottom:40 ),
                initialCameraPosition: _initialCameraPosition,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                compassEnabled: false,
                onMapCreated: (controller) => _onMapCreated(controller),
                markers: widget.isDetail
                    ? controller.selectedMarker
                    : controller.markers,
                polylines: controller.polylines,
              )),
        ],
      ),
    );
  }
}
