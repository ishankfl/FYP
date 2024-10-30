// import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
// import 'package:nwe_app/find_the_location.dart';

class FindLocationn {
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  // This function will get user location
  Future<Map> getUserLocation() async {
    Location location = Location();
    // late bool _serviceEnabled;

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return {};
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return {};
        // return;
      }
    }

    final locationData = await location.getLocation();
    return {
      'longitude': locationData.longitude,
      'latitude': locationData.latitude,
      'accuracy': locationData.accuracy
    };

    // setState(() {
    //   _userLocation = locationData;
    // });
  }
}
