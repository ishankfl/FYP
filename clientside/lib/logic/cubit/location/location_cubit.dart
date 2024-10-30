import 'package:bloc/bloc.dart';
import 'package:bookme/logic/cubit/location/location_state.dart';
import 'package:bookme/presentation/config/place_find_config.dart';
import 'package:bookme/presentation/screen/common/find_location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// part 'ExpectedHours_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationLoaded(location: "", lonlag: []));

  Future<String> showAddress() async {
    emit(LocationLoading());
    List lonlag = await LongitudeLatitude();
    String address = await PointFind(lonlag[0], lonlag[1]);

    emit(LocationLoaded(location: address, lonlag: lonlag));

    // print(state.expectedHours);
    return address;
  }

  Future<String> showAddressByPoint(double longitude, double latitude) async {
    emit(LocationLoading());
    String address = await PointFind(longitude, latitude);

    emit(LocationLoaded(location: address, lonlag: [longitude, latitude]));

    // print(state.expectedHours);
    return address;
  }

  // ignore: non_constant_identifier_names
  Future<List> LongitudeLatitude() async {
    Map location = await FindLocationn().getUserLocation();
    double longitude = location['longitude'];
    double latitude = location['latitude'];
    return [longitude, latitude];
  }

  // ignore: non_constant_identifier_names
  Future<String> PointFind(double longitude, double latitude) async {
    //  new
    String? country;
    String? locality;
    String? sunAdministrative;
    String? street;
    List place = [];
    try {
      place = await FindLocation.findaddress(longitude, latitude);
      country = (place[0][0].country);
      locality = (place[0][1].locality);
      sunAdministrative = (place[0][1].subAdministrativeArea);
      street = (place[0][2].street);


    } catch (e) {
      place = [];
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("Snacbar")));
    }
    emit(LocationLoaded(
        location: "$street $locality $sunAdministrative $country ",
        lonlag: [longitude, latitude]));
    return "$street $locality $sunAdministrative $country ";
  }
}
