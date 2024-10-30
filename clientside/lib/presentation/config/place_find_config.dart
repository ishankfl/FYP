import 'package:geocoding/geocoding.dart';

class FindLocation {
  static Future<List> findaddress(double longitude, double latitude) async {
    // List<Location> locations =
    //     await locationFromAddress("");
    try {
      print(longitude);
      print(latitude);
      print("In app");

      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      print(placemarks);

      return [placemarks];
    } catch (exception) {
      print(exception);
    }
    // print(placemarks);
    return [];
  }
}
