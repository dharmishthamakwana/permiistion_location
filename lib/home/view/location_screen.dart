import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../conrtroller/location_controller.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Location App"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var status = Permission.location.status;
                    if (await status.isDenied) {
                      await Permission.location.request();
                    }
                  },
                  child: Text("Permission"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      Position pos = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);
                      locationController.lat.value = pos.latitude;
                      locationController.lon.value = pos.longitude;
                      print("${pos.latitude}******************");
                    },
                    child: Text("add")),
                // ElevatedButton(
                //   onPressed: () async {
                //     Position position = await Geolocator.getCurrentPosition(
                //         desiredAccuracy: LocationAccuracy.high);
                //     locationController.lat.value = position.latitude;
                //     print("${position.latitude}==============================");
                //     locationController.lon.value = position.longitude;
                //   },
                //   child: Text("Location"),
                //   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                // ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => Text("${locationController.lat}")),
                Obx(() => Text("${locationController.lon}")),
                SizedBox(
                  height: 20,
                ),
                // ElevatedButton(
                //     onPressed: () async {
                //       List<Placemark> place = await placemarkFromCoordinates(52.2165157, 6.9437819);
                //       locationController.placeList.value = place;
                //       print("=======================================================");
                //       print("${locationController.placeList[0]}    ${place[0]}**********");
                //     },
                //     child: Text("address")),
                ElevatedButton(
                  onPressed: () async {
                    var placemarks = await placemarkFromCoordinates(
                        locationController.lat.value,
                        locationController.lon.value);
                    print(placemarks);
                    // locationController.jenil.value = placemarks;
                  },
                  child: Text("Hellow"),
                ),
                Obx(() => locationController.jenil.isEmpty
                    ? CircularProgressIndicator()
                    : Text("${locationController.jenil[0]}")),
                // ElevatedButton(
                //   onPressed: () async {
                //     List<Placemark> placemarkList =
                //     await placemarkFromCoordinates(
                //       locationController.lat.value,
                //       locationController.lon.value
                //     );
                //     locationController.placeList.value = placemarkList;
                //     print("${placemarkList[0]}**********");
                //   },
                //   child: Text("Get"),
                //   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                // ),
                SizedBox(
                  height: 30,
                ),
                // Obx(
                //   () => Text(
                //       "${locationController.placeList[0]}"
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
