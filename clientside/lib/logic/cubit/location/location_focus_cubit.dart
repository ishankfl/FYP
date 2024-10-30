import 'package:bookme/logic/cubit/location/choose_placestate.dart';
import 'package:bookme/logic/cubit/location/location_focus_state.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationFocusCubit extends Cubit<LocationFocusState> {
  // LatLng lonlag;
  LocationFocusCubit() : super(LocationFocusState(mapOption: MapOptions()));

  void change(
    MapOptions mapOption,
  ) {
    emit(LocationFocusState(mapOption: mapOption));
  }
}
