import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/location_controller.dart';
import '../../utils/common/app_bar.dart';

class LocationService extends StatefulWidget {
  const LocationService({Key? key}) : super(key: key);

  @override
  State<LocationService> createState() => _LocationServiceState();
}

class _LocationServiceState extends State<LocationService> {
  final _locationController = Get.put(LocationController());

  ///
  /// obx with google map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(toolbarText: 'Location Service'),
      body: Container(
        margin: EdgeInsets.all(Get.size.longestSide * 0.01),
        color: Colors.lightBlue,
        height: double.infinity,
        width: double.infinity,
        child: Obx(() => GoogleMap(
              myLocationEnabled: true,
              tiltGesturesEnabled: true,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              markers: _locationController.markers.values.toSet(),
              initialCameraPosition: CameraPosition(
                target: LatLng(_locationController.latitude.value,
                    _locationController.longitude.value),
                zoom: 14.4746,
              ),
              polylines: _locationController.polyLines.values.toSet(),
            )),
      ),
    );
  }
}
