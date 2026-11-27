import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

enum CurrentLocationFailure {
  serviceDisabled,
  permissionDenied,
  permissionPermanentlyDenied,
  timeout,
  unavailable,
}

class CurrentLocationException implements Exception {
  const CurrentLocationException(this.failure);

  final CurrentLocationFailure failure;
}

class LocationService {
  Future<Position> getCurrentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw const CurrentLocationException(
          CurrentLocationFailure.serviceDisabled,
        );
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        throw const CurrentLocationException(
          CurrentLocationFailure.permissionPermanentlyDenied,
        );
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.unableToDetermine) {
        throw const CurrentLocationException(
          CurrentLocationFailure.permissionDenied,
        );
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
    } on CurrentLocationException {
      rethrow;
    } on TimeoutException {
      throw const CurrentLocationException(CurrentLocationFailure.timeout);
    } on LocationServiceDisabledException {
      throw const CurrentLocationException(
        CurrentLocationFailure.serviceDisabled,
      );
    } on PermissionDeniedException {
      throw const CurrentLocationException(
        CurrentLocationFailure.permissionDenied,
      );
    } on PlatformException {
      throw const CurrentLocationException(CurrentLocationFailure.unavailable);
    }
  }

  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();

  Future<bool> openAppSettings() => Geolocator.openAppSettings();
}
