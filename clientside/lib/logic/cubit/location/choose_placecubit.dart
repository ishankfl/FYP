import 'package:bookme/logic/cubit/location/choose_placestate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoosePlaceCubit extends Cubit<ChoosePlaceState> {
  // LatLng lonlag;
  ChoosePlaceCubit()
      : super(ChoosePlaceState(
            zoom: 10,
            point: new LatLng(0, 0),
            lonlag: new Marker(point: LatLng(3, 4), child: Text(""))));

  void change(LatLng latloong, int zoom) {
    try {
      emit(ChoosePlaceState(
          zoom: zoom,
          point: latloong,
          lonlag: Marker(
              width: 30.0,
              height: 30.0,
              point: latloong,
              child: Container(
                child: const Icon(
                  Icons.add_location,
                  color: Colors.red,
                  size: 30,
                ),
              ))));
    } catch (err) {
      emit(ChoosePlaceState(
          zoom: zoom,
          point: LatLng(0, 0),
          lonlag: Marker(
              width: 30.0,
              height: 30.0,
              point: LatLng(0, 0),
              child: Container(
                child: const Icon(
                  Icons.add_location,
                  color: Colors.red,
                  size: 30,
                ),
              ))));
    }
  }
}
