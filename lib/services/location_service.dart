import 'dart:async';
import 'package:location/location.dart';

class LocationService {
  static Location _location = Location();
  static bool _serviceEnabled = false;
  static PermissionStatus _permissionStatus = PermissionStatus.denied;

  LocationService() {
    try {
      _location = Location();
      _init();
    }
    catch (e) {
      print('Caught an exception at location_service.dart: $e');
      rethrow;
    }
  }

  _init() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        throw Exception('Location service is not enabled!');
      }
    }

    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        throw Exception('Location service permission has not been granted!');
      }
    }
  }

  static Future<LocationData> getLocationData() async {
    LocationData locationData = await _location.getLocation();
    if (locationData.latitude == null || locationData.longitude == null) {
      throw Exception('Could not get location data!');
    }

    return locationData;
  }

  static Location get location => _location;
}