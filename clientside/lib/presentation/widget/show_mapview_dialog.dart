import 'package:bookme/presentation/screen/map/map_view_only.dart';
import 'package:flutter/material.dart';

void showMapViewDialog(BuildContext context) async {
  // ignore: use_build_context_synchronously
  showDialog(

      // barrierColor: ColorConstant.prmary_color_notdart(),
      // barrierLabel: ,
      context: context,
      builder: (BuildContext context) {
        return const MapViewOnly();
      });
}
