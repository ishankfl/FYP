import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';

class LocationFocusState extends Equatable {
  final MapOptions mapOption;
  // final LatLng point;
  // final int zoom;
  const LocationFocusState({required this.mapOption});

  @override
  List<Object> get props => [mapOption];
}
