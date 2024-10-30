import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/cubit/location/choose_placestate.dart';
import 'package:bookme/presentation/screen/common/find_location.dart';
import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class MapView extends StatefulWidget {
  const MapView({
    super.key,
  });
  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  static const _london = LatLng(51.5, -0.09);
  static const _paris = LatLng(48.8566, 2.3522);
  static const _dublin = LatLng(53.3498, -6.2603);

  @override
  State<MapView> createState() => _MapViewState();
}

MapController mapController = MapController();

class _MapViewState extends State<MapView> with TickerProviderStateMixin {
  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final camera = mapController.camera;
    final latTween = Tween<double>(
        begin: camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    // Note this method of encoding the target destination is a workaround.
    // When proper animated movement is supported (see #1263) we should be able
    // to detect an appropriate animated movement event which contains the
    // target zoom/center.
    final startIdWithTarget =
        '${MapView._startedId}#${destLocation.latitude},${destLocation.longitude},$destZoom';
    bool hasTriggeredMove = false;

    controller.addListener(() {
      final String id;
      if (animation.value == 1.0) {
        id = MapView._finishedId;
      } else if (!hasTriggeredMove) {
        id = startIdWithTarget;
      } else {
        id = MapView._inProgressId;
      }

      hasTriggeredMove |= mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
        id: id,
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBtnAppbar("Choose your location"),
      body: Column(
        children: [
          const Expanded(
            flex: 5,
            child: OnlyMapView(),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                      text: "Current",
                      width: 170,
                      onPressed: () async {
                        FindLocationn loc = FindLocationn();
                        Map currentLocation = await loc.getUserLocation();
                        LatLng userLocation = LatLng(
                          currentLocation['latitude'],
                          currentLocation['longitude'],
                        );
                        _animatedMapMove(userLocation, 10);
                        // ignore: use_build_context_synchronously
                        context.read<ChoosePlaceCubit>().change(
                              LatLng(
                                currentLocation['latitude'],
                                currentLocation['longitude'],
                              ),
                              20,
                            );
                        final bounds = LatLngBounds.fromPoints([
                          MapView._dublin,
                          MapView._paris,
                          MapView._london,
                        ]);
                        mapController
                            .fitCamera(CameraFit.bounds(bounds: bounds));
                        mapController.move(
                            LatLng(currentLocation['latitude'],
                                currentLocation['longitude']),
                            20);
                      }),
                  const Spacer(),
                  CustomElevatedButton(
                    text: "Select",
                    width: 170,
                    onPressed: () {
                      LatLng latlong =
                          (context.read<ChoosePlaceCubit>().state.point);

                      context
                          .read<LocationCubit>()
                          .PointFind(latlong.longitude, latlong.latitude);

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OnlyMapView extends StatelessWidget {
  const OnlyMapView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationLoaded) {
          print(state.lonlag);
          return FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  // ignore: deprecated_member_use
                  center: LatLng(state.lonlag[1], state.lonlag[0]),
                  initialZoom: 13,
                  onLongPress: (long, lat) {
                    // print(lat.);

                    context.read<ChoosePlaceCubit>().change(
                        // zoom:12,
                        LatLng(
                          lat.latitude,
                          lat.longitude,
                        ),
                        15);
                  }),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.bookme',
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(
                          Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ],
                ),
                BlocBuilder<ChoosePlaceCubit, ChoosePlaceState>(
                  builder: (context, state) {
                    return MarkerLayer(markers: [state.lonlag]);
                  },
                ),
              ]);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
