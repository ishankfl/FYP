// part of 'index_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:equatable/equatable.dart';

class ChoosePlaceState extends Equatable {
  final Marker lonlag;
  final LatLng point;
  final int zoom;
  const ChoosePlaceState(
      {required this.lonlag, required this.point, required this.zoom});

  @override
  List<Object> get props => [lonlag, point, zoom];
}

// class ChoosePlace extends Equatable {
//   final File path;
//   const FileChoosePlace({required this.path});

//   @override
//   List<Object> get props => [path];
// }
