import 'dart:async';

import '../../helper_manager/platform_channel/platform_channel.dart';
import '../../util/app_common_stuffs/colors.dart';
import '../../ui/style/components/button_component.dart';
import '../../ui/style/style.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationHelperDemoScreen extends StatefulWidget {
  const LocationHelperDemoScreen({Key? key}) : super(key: key);

  @override
  State<LocationHelperDemoScreen> createState() =>
      _LocationHelperDemoScreenState();
}

class _LocationHelperDemoScreenState extends State<LocationHelperDemoScreen> {
  late StreamSubscription<Position> locationUpdateStream;

  late PlatformChannel platformChannel;

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
    initPlatformChannel();
  }

  void initPlatformChannel() {
    platformChannel = PlatformChannel();
  }

  void checkLocationPermission() async {
    if (await PlatformChannel().checkForPermission(Permission.location)) {
      Position position = await Geolocator.getCurrentPosition();
    } else {
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonComponent(
            context: context,
            backgroundColor: AppColors.accentColor,
            text: "Start",
            onPressed: () => platformChannel.startLocationService(),
          ),
          CommonStyle.verticalSpace(context, 0.02),
          ButtonComponent(
            context: context,
            backgroundColor: AppColors.accentColor,
            text: "Stop",
            onPressed: () => PlatformChannel().stopLocationService(),
          ),
        ],
      ),
    );
  }
}
