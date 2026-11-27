import 'dart:async';

import 'package:flutter/material.dart';
import 'package:herafi_app/core/services/location_service.dart';

class LocationFailure {
  static void show({
    required BuildContext context,
    required CurrentLocationFailure failure,
    required LocationService locationService,
  }) {
    final String message;
    final Future<bool> Function()? settingsAction;

    switch (failure) {
      case CurrentLocationFailure.serviceDisabled:
        message = 'فعّل خدمة الموقع على جهازك ثم حاول مرة أخرى';
        settingsAction = locationService.openLocationSettings;
      case CurrentLocationFailure.permissionDenied:
        message = 'اسمح بالوصول للموقع لاستخدام موقعك الحالي';
        settingsAction = null;
      case CurrentLocationFailure.permissionPermanentlyDenied:
        message = 'إذن الموقع مرفوض. فعّله من إعدادات التطبيق';
        settingsAction = locationService.openAppSettings;
      case CurrentLocationFailure.timeout:
        message = 'انتهت مهلة تحديد موقعك. حاول مرة أخرى';
        settingsAction = null;
      case CurrentLocationFailure.unavailable:
        message = 'تعذر تحديد موقعك الحالي';
        settingsAction = null;
    }

    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          action: settingsAction == null
              ? null
              : SnackBarAction(
                  label: 'الإعدادات',
                  onPressed: () {
                    final action = settingsAction;
                    if (action != null) {
                      unawaited(action());
                    }
                  },
                ),
        ),
      );
  }
}
