import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionStatus;
  late LocationData _locationData;

  init() async {
    location.enableBackgroundMode(enable: true);

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  LocationData get locationData => _locationData;
}