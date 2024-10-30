import 'package:bookme/constant/colors.dart';
import 'package:bookme/logic/cubit/location/location_cubit.dart';
import 'package:bookme/logic/cubit/location/location_state.dart';
import 'package:bookme/presentation/screen/map/map_view.dart';
import 'package:bookme/presentation/widget/add_bid_container_widget.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var widget = InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MapView()));
      },
      child: Container(
        alignment: Alignment.center,
        child: IgnorePointer(
          ignoring: true,
          child: Container(
            decoration: BoxDecoration(
              color: ColorConstant.secondary_color_blue(),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Icon(
                      Icons.home,
                      color: ColorConstant.primary_color_dark(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 5, bottom: 5),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFieldLabel(
                              text: 'Location',
                              padding: const EdgeInsets.all(0),
                              fontsize: 15),
                          BlocBuilder<LocationCubit, LocationState>(
                            builder: (context, state) {
                              if (state is LocationLoading) {
                                return Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator());
                              }
                              if (state is LocationLoaded) {
                                if (state.location.isEmpty) {
                                  // context.read<LocationCubit>().showAddress();
                                }
                                return TextFieldLabel(
                                    text: state.location + "Loading...",
                                    padding: EdgeInsets.all(0),
                                    fontsize: 15);
                              }
                              return Text("Failed");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                // direction: Axis.horizontal,
              ),
            ),
          ),
        ),
      ),
    );

    return CustomeContainerBid.CustomContainer(widget);
  }
}
