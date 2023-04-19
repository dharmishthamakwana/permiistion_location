import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permiistion_location/home/view/location_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (p0) => LocationScreen(),
      },
    ),
  );
}
