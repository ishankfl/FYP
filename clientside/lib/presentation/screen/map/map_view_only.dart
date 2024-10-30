import 'package:bookme/presentation/screen/map/map_view.dart';
import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:flutter/material.dart';

class MapViewOnly extends StatelessWidget {
  const MapViewOnly({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBtnAppbar("Map"),
      body: const OnlyMapView(),
    );
  }
}
